class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.1.jar"
  version "0.5.1"
  sha256 "4a99c1f5fa34cb6033a3c2f9a25e49bdcb24f3613ed0e411180e6ad5bf680aed"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli-v0.5.1.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.1.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
