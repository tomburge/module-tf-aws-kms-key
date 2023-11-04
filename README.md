# module-tf-aws-kms-key

## What does this module do?

-   Creates KMS Key
-   Creates KMS Key Alias
-   Creates KMS Key Policy customized by target_type and target_arn

## Configuration Options:

-   custom_policy (data source JSON)
-   key_arn (string)
-   key_config (object):
    -   delete_days (number): (Default) 7 | 7-30
    -   description (string)
    -   enable (bool): (Default) true | false
    -   key_spec (string): (Default) SYMMETRIC_DEFAULT | RSA_2048 | RSA_3072 | RSA_4096 | HMAC_256 | ECC_NIST_P256 | ECC_NIST_P384 | ECC_NIST_P521 | ECC_SECG_P256K1
    -   multi_region (bool): true | (Default) false
    -   rotation (bool): true | (Default) false
    -   usage (string): (Default) ENCRYPT_DECRYPT | SIGN_VERIFY | GENERATE_VERIFY_MAC
-   name (string)
-   targets (list(object)):
    -   target_arn (string): default | arn of resource
    -   target_type (string): default | cw_loggroup

## Example Module Configuration:

```
module  "kms_key" {
	source  =  "github.com/tomburge/module-tf-aws-kms-key?ref=main"
	name =  var.name
	key_config = {
		delete_days = 30
		description = "KMS key"
		enable = true
		key_spec = "SYMMETRIC_DEFAULT"
		multi_region = false
		rotation = true
		usage = "ENCRYPT_DECRYPT"
	}
	targets = [
		{
			target_arn = "resource_arn"
			target_type = "cw_loggroup"
		}
	]
}
```
