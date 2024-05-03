class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cli.s3.amazonaws.com/sqrl-cli.jar"
  version "0.5.0-RC2"
  sha256 "203b03b3a7ee0f5dfbafc45019601eabeea6e93449fbf308272eea63c5a46bfc"
  license ""

  depends_on "pgvector"
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
