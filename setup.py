import functools
import os
import shutil
import subprocess
import tempfile
import warnings
from pathlib import Path

from loguru import logger

REPO_HOME = Path(__file__).parent.resolve()
REPO_BIN = REPO_HOME / "bin"
REPO_HOME_CONFIG = REPO_HOME / "config"

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

def setup_starship():
    with tempfile.NamedTemporaryFile("w", suffix=".sh") as file:
        curl("-sS", "https://starship.rs/install.sh")
        sh(["bash", file.name])

    sh_name = get_shell_name()
    assert sh_name in {"zsh", "bash"}

    sh(f"eval $(starship init {sh_name})", shell=True)

def update_config_symlinks() -> None:
    logger.info("Update Config Symlinks")
    for repo_sub_config_path in REPO_HOME_CONFIG.iterdir():
        sub_config_name = str(repo_sub_config_path).rsplit("/", maxsplit=1)[-1]
        user_sub_config_path = USER_HOME_CONFIG / sub_config_name
        user_sub_config_path.unlink(missing_ok=True)
        user_sub_config_path.symlink_to(
            repo_sub_config_path,
            target_is_directory=repo_sub_config_path.is_dir(),
        )

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

#

if __name__ == "__main__":
    setup_pixi()
    setup_essentials()
    setup_starship()
    update_config_symlinks()
