class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cli.s3.amazonaws.com/sqrl-cli-v0.5.0-RC4.jar"
  version "0.5.0-rc.4"
  sha256 "9abe062cd41b0693d90b7657c217a23b9ecd86b9b5c323c563ddedae649a4674"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli-v0.5.0-RC4.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.0-RC4.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
