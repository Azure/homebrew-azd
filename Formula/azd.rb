class Azd < Formula
    desc "Azure Developer CLI"
    homepage "https://github.com/azure/azure-dev"
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_0.6.0-beta.1/azd-darwin-amd64.zip"
    version "0.6.0-beta.1"
    sha256 "1e959594131cdb03db74ea1be74c21b8e9eb3d1c3148e084545dc7f42e6c861e%"
    license "MIT"

    def install
        bin.install "azd-darwin-amd64" => "azd"

        ohai "The Azure Developer CLI collects usage data and sends that usage data to Microsoft in order to help us improve your experience."
        ohai "You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use."
        ohai ""
        ohai "Read more about Azure Developer CLI telemetry: https://github.com/Azure/azure-dev#data-collection"
    end

    test do
        version_output = shell_output "#{bin}/azd version"
        assert_equal 0, $CHILD_STATUS.exitstatus
        assert_match "azd version", version_output
    end
end

