class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  version "0.5.10"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.10.jar", using: :nounzip
  sha256 "b4541165b773484bc006371731d427d878e053000e0000b15aeefefc3bd967ef"
  license ""

  depends_on "openjdk@11"

  def install
    # Create the bin directory if it doesn't exist
    bin.mkpath
    libexec.install "sqrl-cli-v0.5.10.jar" unless File.exist?("#{libexec}/sqrl-cli-v0.5.10.jar")

    # Verify that the necessary files are present
    unless File.exist?("#{libexec}/sqrl-cli-v0.5.10.jar")
      odie "Missing expected files"
    end

    # Write the sqrl script
    (bin/"sqrl").write <<~EOS
      #!/bin/bash

      # Check if Docker is installed
      if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed or not in your PATH." >&2
        exit 1
      fi

      if [[ -f "$HOME/.datasqrl/auth" ]]; then
        DATASQRL_TOKEN=$(cat "$HOME/.datasqrl/auth")
      fi
      if [[ "$1" == "login" || "$1" == "publish" ]]; then
        "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.10.jar" "$@"
      else
        # Check if Docker is installed
        if ! command -v docker &> /dev/null; then
          echo "Error: Docker is not installed or not in your PATH." >&2
          exit 1
        fi

        docker run -it -p 8888:8888 -p 8081:8081 -p 9092:9092 \\
        --rm -v "$PWD":/build -e DATASQRL_TOKEN="$DATASQRL_TOKEN" datasqrl/cmd:v0.5.10 "$@"
      fi
    EOS

    # Make the script executable
    chmod 0755, bin/"sqrl"
  end

  test do
    # Check that the script exists and is executable
    assert_predicate bin/"sqrl", :exist?
    assert_predicate bin/"sqrl", :executable?
  end
end
