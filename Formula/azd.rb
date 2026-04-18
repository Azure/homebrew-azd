class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.24.1/azd-darwin-amd64.zip"
      sha256 "904caee1cf19498d73ab7f97962fd7495d8f1e92ebc54f49e2628dfaceb4915c"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.24.1/azd-darwin-arm64.zip"
      sha256 "04874582c3e75e392d0a889d97425ed71327e9108bac3b9e2d41ddea1a493b9a"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.24.1/azd-linux-amd64.tar.gz"
      sha256 "363cdb926858d8132d8668b61c6e8948c529e081d56254ed8ea02e3e3a341a3e"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.24.1/azd-linux-arm64.tar.gz"
      sha256 "8ece20a6e12f582092ea1114cc683f9829e74a0da392bd33596ef262ae2f8974"
    end
  end

  version "1.24.1"
  
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

