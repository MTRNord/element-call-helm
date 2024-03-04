## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

  helm repo add element-call https://mtrnord.github.io/element-call-helm

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
element-call` to see the charts.

To install the element-call-helm chart:

    helm install my-element-call element-call/element-call

To uninstall the chart:

    helm delete my-element-call
