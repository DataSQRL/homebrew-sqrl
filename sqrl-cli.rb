class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cli.s3.amazonaws.com/sqrl-cli.jar"
  version "0.5.0-RC2"
  sha256 "5eb6e1410a287e8b1a7755279cc0e2d7a7c88b7122a9fdda54e0918caa5337e9"
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
