class SqrlCli < Formula
  desc "A SQRL compiler"
  homepage "https://datasqrl.com"
  version "0.5.5"
  url "https://sqrl-cmd.s3.us-west-2.amazonaws.com/sqrl-cli-v0.5.5.zip", using: :nounzip
  sha256 "8739c76e681f900923b900c9df0ef75cf421d39cabb54650c4b9ad19b6a76d85"
  license ""

  def install
    # Create the bin directory if it doesn't exist
    bin.mkpath

    # Write the sqrl script
    (bin/"sqrl").write <<~EOS
      #!/bin/bash

      # Check if Docker is installed
      if ! command -v docker &> /dev/null; then
        echo "Error: Docker is not installed or not in your PATH." >&2
        exit 1
      fi

      docker run -it -p 8888:8888 -p 8081:8081 -p 9092:9092 \\
      --rm -v "$PWD":/build datasqrl/cmd:v0.5.5 "$@"
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
