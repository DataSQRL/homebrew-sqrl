class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://datasqrl-public.s3.amazonaws.com/sqrl-cli-0.5.0-RC2.jar"
  version "0.5.0-RC2"
  sha256 "2e0f96ec1b3a5bf52d3c8e8bb9f41a8600ebd4764fc324afe935cb4c9a7fd3bf"
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
