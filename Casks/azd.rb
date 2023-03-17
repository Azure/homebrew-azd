cask "azd" do
    name "Azure Developer CLI"
    desc "Azure Developer CLI"
    homepage "https://github.com/azure/azure-dev"
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_0.7.0-beta.1/azd-darwin-amd64.zip"
    version "0.7.0-beta.1"
    sha256 "ff1736950c02d67d30a0a9b714843a6e0d5dd936c1e071320fdd6335d5b63666"

    binary "azd-darwin-amd64", target: "azd"

    caveats do
        requires_rosetta
        license "https://github.com/Azure/azure-dev/blob/main/LICENSE"
    end

    # def install
    #     bin.install "azd-darwin-amd64" => "azd"

    #     ohai "The Azure Developer CLI collects usage data and sends that usage data to Microsoft in order to help us improve your experience."
    #     ohai "You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use."
    #     ohai ""
    #     ohai "Read more about Azure Developer CLI telemetry: https://github.com/Azure/azure-dev#data-collection"
    # end

    # test do
    #     version_output = shell_output "#{bin}/azd version"
    #     assert_equal 0, $CHILD_STATUS.exitstatus
    #     assert_match "azd version", version_output
    # end
end

