class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.4.zip"
  version "0.5.4"
  sha256 "f3069c0500454233ad81e213839497bcd253966fbb12480ae698a090c8ab445e"
  license ""

  depends_on "openjdk@11"

  def install
    libexec.mkpath
    system "unzip", cached_download, "-d", libexec

    # Verify that the necessary files are present
    unless File.exist?("#{libexec}/sqrl-cli.jar") && File.exist?("#{libexec}/sqrl-run.jar")
      odie "Missing expected files in the zip"
    end

    (bin/"sqrl").write <<~EOS
      #!/bin/bash

      JVM_OPTS="${JVM_OPTS:-}"

      "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli.jar" "$@"
      status=$?

      if [ "$1" = "run" ] && [ $status -eq 0 ]; then
          exec "#{Formula["openjdk@11"].opt_bin}/java" $JVM_OPTS -jar "#{libexec}/sqrl-run.jar" "${@:2}"
      fi
    EOS

    (bin/"sqrl").chmod 0755
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/sqrl --version")
  end
end
