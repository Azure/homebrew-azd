class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_0.9.0-beta.2/azd-darwin-amd64.zip"
  version "0.9.0-beta.2"
  sha256 "c8fdf2dcc4f276e90320e1e2d6fb2f5048ac15115858e93992adf72edda316a2"
  license "MIT"

  def install
    bin.install "azd-darwin-amd64" => "azd"
    (bin/".installed-by.txt").write "brew"
  end

  def caveats
    caveat = <<~EOS
      The #{desc} collects usage data and sends that usage data to Microsoft in order to help us improve your experience.
      You can opt-out of telemetry by setting the AZURE_DEV_COLLECT_TELEMETRY environment variable to 'no' in the shell you use.

      Read more about #{desc} telemetry: https://github.com/Azure/azure-dev#data-collection

      azd may download binaries to ~/.azd/bin and, depending on how azd was used on this machine,
      may download binaries to other users' home directories in their .azd/bin directory.
      These binaries will need to be removed manually upon uninstall.
      To remove such binaries from your home directory, run 'rm -rf ~/.azd/bin'.

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

  test do
    version_output = shell_output "#{bin}/azd version"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_match "azd version", version_output
  end
end

