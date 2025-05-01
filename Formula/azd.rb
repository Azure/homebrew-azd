class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if Hardware::CPU.intel?
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.15.0/azd-darwin-amd64.zip"
    sha256 "b33630c06e707e482341827c7961b587a9d0a13bc939eec79addeae1ebc3c8aa"
  elsif Hardware::CPU.arm?
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.15.0/azd-darwin-arm64.zip"
    sha256 "4bb1e5d60f71798a7da365b72c02fa06819da2ce15dff00e9c9f8988375c8ade"
  end

  version "1.15.0"
  
  license "MIT"

  def install
    if Hardware::CPU.intel?
      bin.install "azd-darwin-amd64" => "azd"
    elsif Hardware::CPU.arm?
      bin.install "azd-darwin-arm64" => "azd"
    end

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
    caveat
  end

  test do
    version_output = shell_output "#{bin}/azd version"
    assert_equal 0, $CHILD_STATUS.exitstatus
    assert_match "azd version", version_output
  end
end

