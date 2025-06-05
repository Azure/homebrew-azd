class Azd < Formula
  desc "Azure Developer CLI"
  homepage "https://github.com/azure/azure-dev"
  
  if OS.mac?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.17.0/azd-darwin-amd64.zip"
      sha256 "0730c2fc09549d388a98be37673f6a2dee2c09b01cf2d5320b1fec908ddf2161"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.17.0/azd-darwin-arm64.zip"
      sha256 "01d505e82809f1d13c2103e4b6fb7e881aee5f301252563357acdec88fd909aa"
    end
  elsif OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.17.0/azd-linux-amd64.tar.gz"
      sha256 "84ae778f3bff3fd7e74f3c1a85a9c99edd95f12eb795fb1f774cd325b1f63797"
    elsif Hardware::CPU.arm?
      url "https://github.com/Azure/azure-dev/releases/download/azure-dev-cli_1.17.0/azd-linux-arm64.tar.gz"
      sha256 "aa613b9ad4c58ab347d7abea927c8f4277ba76b25ee22daddb87e7d58d21524b"
    end
  end

  version "1.17.0"
  
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

