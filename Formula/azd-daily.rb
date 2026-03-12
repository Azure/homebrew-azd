class AzdDaily < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002441/azd-darwin-amd64.zip"
      sha256 "6d2d6b283a2b96c6630292a445e6340826720947a6d2b6b258354a5b61067922"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002441/azd-darwin-arm64.zip"
      sha256 "0479a0ae01190c492bce2b24b56763966ad9394569aa92c90a15487c7ca5ed96"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002441/azd-linux-amd64.tar.gz"
      sha256 "ec0612e172ae18c6d549cad570be85b8462d57998daa0d8bde69858543cc1315"
    elsif Hardware::CPU.arm?
      url "https://azuresdkartifacts.z5.web.core.windows.net/azd/standalone/daily/archive/1.24.0-beta.1-daily.6002441/azd-linux-arm64.tar.gz"
      sha256 "9aebe7fb1352d5e5000d50ab5016f296fc985f35bb3058038962efecf09d7a16"
    end
  end

  version "1.24.0-beta.1-daily.6002441"
  
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

