class AzdATDaily < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6001542/azd-darwin-amd64.zip"
      sha256 "fbd990fb77b39ff1957e5b779806970970b8cccd916a89290db2c2dcccf36c09"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6001542/azd-darwin-arm64.zip"
      sha256 "6e06f31ad9489e4bd00fa86c486397ade3643aaae5cf882c10d282d81dd54b5f"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6001542/azd-linux-amd64.tar.gz"
      sha256 "01f8c9a6dbf9a9986a7054e8bc1e987ecb2055c409caf7a185434dbcf1dc616d"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6001542/azd-linux-arm64.tar.gz"
      sha256 "5a5ce8d2b76898c4a69f56bca01803f1c40eec059bed1c2a0f78853850092425"
    end
  end

  version "1.24.0-beta.1-daily.6001542"
  
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

