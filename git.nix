{ a }: {
  enable = true;
  userName = "${a.user}";
  userEmail = "${a.email}";
  extraConfig = { init.defaultBranch = "master"; };
  aliases = {
    c = "commit -am";
    s = "status";
    a = "add .";
    i = "init";
    d = "diff";
    p = "push origin master";
  };
}
