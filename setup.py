import functools
import os
import shutil
import subprocess
import tempfile
import warnings
from pathlib import Path

REPO_HOME = Path(__file__).parent.resolve()
REPO_BIN = REPO_HOME / "bin"
REPO_HOME_CONFIG = REPO_HOME / "config"
REPO_HOME_TMUX = REPO_HOME / "tmux"

USER_HOME_CONFIG = Path.home() / ".config"

PIXI_HOME = Path.home().joinpath(".pixi").resolve()
PIXI_EXE = PIXI_HOME.joinpath("bin", "pixi")

# sh = subprocess.check_call
sh = functools.partial(subprocess.check_call)


# Main handlers
def setup_pixi() -> None:
    which_pixi = shutil.which("pixi")
    if which_pixi is None and not PIXI_EXE.exists():
        with tempfile.NamedTemporaryFile("w", suffix=".sh") as file:
            curl("-fsSL", "--output", file.name, "https://pixi.sh/install.sh")
            sh(["bash", file.name])
    else:
        warnings.warn(
            f"Existing pixi installation found at {which_pixi or PIXI_HOME}"
        )

def setup_essentials() -> None:
    pixi_install_packages(
        "fd-find",
        "ripgrep",
        "nvim",
        "htop",
        "bash-completion",
        "git",
        "rsync",
        "unzip",
        "starship",
        #
        # "xclip",
        # "coreutils",
        # "bat",
        # "lsdeluxe",
        # "zoxide",
    )

def setup_apps():
    setup_starship()
    pixi_install_packages("gitui")
    setup_tmux()

def setup_starship():
    with tempfile.NamedTemporaryFile("w", suffix=".sh") as file:
        curl("-sS", "https://starship.rs/install.sh")
        sh(["bash", file.name])

    sh_name = get_shell_name()
    assert sh_name in {"zsh", "bash"}

    sh(f"eval $(starship init {sh_name})", shell=True)

def setup_tmux() -> None:
    repo_tmux_config_path = REPO_HOME_TMUX / ".tmux.conf"
    user_tmux_config_path = Path.home() / ".tmux.conf"
    update_symlink(file_path=repo_tmux_config_path, symlink_path=user_tmux_config_path)

def update_config_symlinks() -> None:
    for repo_sub_config_path in REPO_HOME_CONFIG.iterdir():
        sub_config_name = str(repo_sub_config_path).rsplit("/", maxsplit=1)[-1]
        user_sub_config_path = USER_HOME_CONFIG / sub_config_name
        update_symlink(file_path=repo_sub_config_path, symlink_path=user_sub_config_path)

# Utils

def curl(*curl_args: str):
    curl_exe = shutil.which("curl")
    if curl_exe is None:
        raise RuntimeError("Cannot find curl")
    sh([str(curl_exe), *curl_args])

def pixi_install_packages(*packages: str) -> None:
    assert len(packages) != 0
    if not PIXI_EXE.exists():
        raise RuntimeError("pixi was not installed properly")
    sh([str(PIXI_EXE), "global", "install", "-q", *packages])

def get_shell_name() -> str:
    sh_exe = os.environ['SHELL']
    sh_name = sh_exe.rsplit("/", maxsplit=1)[-1]
    return sh_name

def update_symlink(*, file_path: Path, symlink_path: Path) -> None:
    symlink_path.unlink(missing_ok=True)
    symlink_path.symlink_to(
        file_path,
        target_is_directory=file_path.is_dir(),
    )
    

#

if __name__ == "__main__":
    setup_pixi()
    setup_essentials()
    setup_apps()
    update_config_symlinks()
