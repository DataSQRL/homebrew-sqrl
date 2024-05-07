class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cli.s3.amazonaws.com/sqrl-cli.jar"
  version "0.5.0-RC2"
  sha256 "5aa5cfb8a3ba1f4a52b91dc36999f7e5f54bc4208dd0a1c8021e380a9549a64d"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
