# inspired by https://github.com/ajmalsiddiqui/dotfiles/blob/master/bootstrap.exclude.sh
link () {
  mkdir ~/.config
  for file in $( ls -A ./config | grep -vE '\.exclude*|\.git$|\.gitignore|\.gitmodules|.*.md' ) ; do
    # Silently ignore errors here because the files may already exist
    ln -sv "$PWD/config/$file" "$HOME/.config" || true
  done
  for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|\.gitmodules|.*.md' ) ; do
    # Silently ignore errors here because the files may already exist
    echo $file
    # ln -sv "$PWD/$file" "$HOME" || true
  done
}

link
