class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.2.jar"
  version "0.5.2"
  sha256 "ad75f153758e4dead31050868c4a15fbf98ced90572f8794ff9145c7eab2ecc0"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli-v0.5.2.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.2.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
