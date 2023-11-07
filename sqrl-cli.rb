class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://datasqrl-public.s3.amazonaws.com/sqrl-cli.jar"
  version "1"
  sha256 "abf34e6ef7b7788ecd3e57c175f677b1575e67d55eb6e8983a79de88cd47901e"
  license ""

  depends_on "postgresql"
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
