class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cli.s3.amazonaws.com/sqrl-cli-v0.5.0-RC3.jar"
  version "0.5.0-RC3"
  sha256 "39deb3173414bc325f2a5ac36c9644f49e03466db66e43a3d95c84feef047be7"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli-v0.5.0-RC3.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.0-RC3.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
