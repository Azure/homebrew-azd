class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.37.3/azd-darwin-amd64.zip"
      sha256 "3b8f5db4a0b4bfc92faa3e0041da77a4ee7da1fcc9183b187b65945b5cfb05c9"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.37.3/azd-darwin-arm64.zip"
      sha256 "2ac43e590f6238cd80cc1215a55567a8b51de921f9d17806ca3ae7ce07e26cee"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.37.3/azd-linux-amd64.tar.gz"
      sha256 "8bf3e7e86f1d5a9bc1ae6f014c792697660cce04f6333a8091c6e08b7f8c7786"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.37.3/azd-linux-arm64.tar.gz"
      sha256 "a9f96fd5f9779238ed1675cdbcf8e2d8686b4031a5673ff4958c1e4de6e728e5"
    end
  end

  version "1.37.3"
  
  license "MIT"

  def install
    if OS.mac?
      if Hardware::CPU.intel?
        bin.install "azd-darwin-amd64" => "azd"
      elsif Hardware::CPU.arm?
        bin.install "azd-darwin-arm64" => "azd"
      end
    elsif OS.linux?
      if Hardware::CPU.intel?
        bin.install "azd-linux-amd64" => "azd"
      elsif Hardware::CPU.arm?
        bin.install "azd-linux-arm64" => "azd"
      end
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

