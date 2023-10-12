class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if Hardware::CPU.intel?
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.4.2/azd-darwin-amd64.zip"
    sha256 "db34cd3b795b95f762e4255471eeb0a7b0e5c40df8b4020092353ae49a5d8322"
  elsif Hardware::CPU.arm?
    url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.4.2/azd-darwin-arm64.zip"
    sha256 "90910a6eda2f601aeaeed66fc032e90eaa143a888822abd8b3f6f19c93dbae87"
  end

  version "1.4.2"
  
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

