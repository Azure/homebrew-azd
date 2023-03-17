class Azd < Formula
    desc "Azure Developer CLI"
    homepage "https://github.com/azure/azure-dev"
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_0.7.0-beta.1/azd-darwin-amd64.zip"
    version "0.7.0-beta.1"
    sha256 "ff1736950c02d67d30a0a9b714843a6e0d5dd936c1e071320fdd6335d5b63666"
    license "MIT"

    def caveats
        caveat = <<~EOS
            The #{desc} collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
            You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.
            
            Read more about #{desc} telemetry: https://github.com/Azure/azure-dev#data-collection
        EOS
        on_arm do
            caveat += <<~EOS


                The #{desc} is built for Intel macOS and so requires Rosetta 2 to be installed.
                You can install Rosetta 2 with:
                  softwareupdate --install-rosetta
                Note that it is very difficult to remove Rosetta 2 once it is installed.
            EOS
        end
        caveat
    end

    def install
        bin.install "azd-darwin-amd64" => "azd"
    end

    test do
        version_output = shell_output "#{bin}/azd version"
        assert_equal 0, $CHILD_STATUS.exitstatus
        assert_match "azd version", version_output
    end
end

