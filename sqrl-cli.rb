class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  version "0.5.5"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.5.jar", using: :nounzip
  sha256 "d69512dcb7ec5b71b07aecfc09414db7ad5f9f4ea7021ffa33939eb0fcbe7527"
  license ""

  depends_on "openjdk@11"

  def install
    # Create the bin directory if it doesn't exist
    bin.mkpath
    libexec.install "sqrl-cli-v0.5.5.jar" unless File.exist?("#{libexec}/sqrl-cli-v0.5.5.jar")

    # Verify that the necessary files are present
    unless File.exist?("#{libexec}/sqrl-cli-v0.5.5.jar")
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

      if [[ "$1" == "login" ]]; then
        "#{Formula["openjdk@11"].opt_bin}/java" -jar "#{libexec}/sqrl-cli-v0.5.5.jar" "$@"
      else
        # Check if Docker is installed
        if ! command -v docker &> /dev/null; then
          echo "Error: Docker is not installed or not in your PATH." >&2
          exit 1
        fi

        docker run -it -p 8888:8888 -p 8081:8081 -p 9092:9092 \\
        --rm -v "$PWD":/build datasqrl/cmd:v0.5.5 "$@"
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
