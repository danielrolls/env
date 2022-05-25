nix flake update
git add flake.lock
git commit --message "updating $(hostname)"
if [ $? = 0 ]; then
  nixos-rebuild build --flake .
  msg=$(git log -1 --pretty=%B ; nix store diff-closures /run/current-system ./result)
  git commit --amend --message="$msg"
fi

