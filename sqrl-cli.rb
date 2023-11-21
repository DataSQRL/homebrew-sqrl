class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://datasqrl-public.s3.amazonaws.com/sqrl-cli.jar"
  version "0.3.0"
  sha256 "bc31396e88b54b0b3afed67a23128dedf091d51eb1284630823c648beb7125b1"
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
