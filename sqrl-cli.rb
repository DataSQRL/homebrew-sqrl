class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.0.jar"
  version "0.5.0"
  sha256 "8e41d8544e32c58c8613e1309b6fa5242054d6d2f54991c589dbfe0b7c1dfb0d"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.install "sqrl-cli-v0.5.0.jar"
    (bin/"sqrl").write <<~EOS
      #!/bin/bash
      exec "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.0.jar" "$@"
    EOS
    (bin/"sqrl").chmod 0755
  end
#
#   test do
#     system false
#   end
end
