package common

import (
	"context"
	"os"
	"strings"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/privatedns/armprivatedns"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/lib/azure/configure"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

const terraformDir string = "../../examples/dns_zone_records"
const varFile string = "test.tfvars"

var (
	privatednsClientFactory *armprivatedns.ClientFactory
	dnsZoneRecordSetsClient *armprivatedns.RecordSetsClient
)

func TestDnsZoneRecords(t *testing.T, ctx types.TestContext) {
	subscriptionID := os.Getenv("ARM_SUBSCRIPTION_ID")
	if subscriptionID == "" {
		t.Fatalf("ARM_SUBSCRIPTION_ID must be set for acceptance tests")
	}
	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Error getting credentials: %e\n", err)
	}

	privatednsClientFactory, err = armprivatedns.NewClientFactory(subscriptionID, credential, nil)
	if err != nil {
		t.Fatalf("Error getting privatedns factory: %e\n", err)
	}

	dnsZoneRecordSetsClient = privatednsClientFactory.NewRecordSetsClient()

	terraformOptions := configure.ConfigureTerraform(terraformDir, []string{terraformDir + "/" + varFile})

	t.Run("dnsZoneRecords", func(t *testing.T) {
		checkDNSZoneRecordSets(t, dnsZoneRecordSetsClient, terraformOptions)
	})
}

func checkDNSZoneRecordSets(t *testing.T, dnsZoneRecordSetsClient *armprivatedns.RecordSetsClient, terraformOptions *terraform.Options) {
	checkRecord(t, dnsZoneRecordSetsClient, terraformOptions, "a_record_ids", "a_record_fqdns", armprivatedns.RecordTypeA)
	checkRecord(t, dnsZoneRecordSetsClient, terraformOptions, "cname_record_ids", "cname_record_fqdns", armprivatedns.RecordTypeCNAME)
	checkRecord(t, dnsZoneRecordSetsClient, terraformOptions, "txt_record_ids", "txt_record_fqdns", armprivatedns.RecordTypeTXT)
}

func checkRecord(t *testing.T, dnsZoneRecordSetsClient *armprivatedns.RecordSetsClient, terraformOptions *terraform.Options, recordSetIdsKey string, recordSetFQDNsKey string, recordType armprivatedns.RecordType) {
	resourceGroupName := terraform.Output(t, terraformOptions, "resource_group_name")
	zoneName := terraform.Output(t, terraformOptions, "private_dns_zone_name")
	recordSetIds := terraform.OutputMap(t, terraformOptions, recordSetIdsKey)
	recordSetFQDNs := terraform.OutputMap(t, terraformOptions, recordSetFQDNsKey)
	options := armprivatedns.RecordSetsClientGetOptions{}

	for key, recordSetId := range recordSetIds {
		relativeRecordSetName := getSubdomain(recordSetFQDNs[key])

		dnsZoneRecordSets, err := dnsZoneRecordSetsClient.Get(context.Background(), resourceGroupName, zoneName, recordType, relativeRecordSetName, &options)
		if err != nil {
			t.Fatalf("Error getting DNS Zone: %v", err)
		}

		assert.Equal(t, strings.ToLower(recordSetId), strings.ToLower(*dnsZoneRecordSets.ID))
		assert.Equal(t, strings.ToLower(relativeRecordSetName), strings.ToLower(*dnsZoneRecordSets.Name))
		assert.Equal(t, strings.ToLower((string(recordType))), getRecordType(strings.ToLower(*dnsZoneRecordSets.Type)))
		assert.NotEmpty(t, dnsZoneRecordSets.Properties)
	}
}

func getSubdomain(domain string) string {
	parts := strings.Split(domain, ".")
	return parts[0]
}

func getRecordType(input string) string {
	parts := strings.Split(input, "/")
	return parts[len(parts)-1]
}
