based on https://gist.github.com/thetechnick/12b33e4edfc96e4ccc9800afef2be7c5
and https://vadosware.io/post/yet-another-cluster-reinstall-back-to-container-linux/

Update public key in `ignition.json`

```sh
# fetch the required modules
$ terraform init

# see what `terraform apply` will do
$ terraform plan

# execute it
$ terraform apply
```
