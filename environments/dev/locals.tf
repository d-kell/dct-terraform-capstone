# locals for user data. Set's it up as a webserver with python installed
locals {
  user_data = templatefile("${path.module}/user_data.tftpl", {
    packages = [
      { name = "nginx", version_cmd = "nginx -v" },
      { name = "python3", version_cmd = "python3 -V" },
      { name = "python3-pip", version_cmd = "pip3 -V" }
    ]
  })
}