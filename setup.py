import functools
import os
import shutil
import subprocess
import tempfile
import warnings
from pathlib import Path

REPO_HOME = Path(__file__).parent.resolve()
REPO_CONFIG_HOME = REPO_HOME / "config"
REPO_STATIC_RC_ADDON_PATH = REPO_HOME.joinpath("static-rc-addon.sh")
REPO_GENERATED_RC_ADDON_PATH = REPO_HOME.joinpath("generated-rc-addon.sh")

XGD_CONFIG_HOME = Path(os.environ.get("XGD_CONFIG_HOME", Path.home() / ".config"))
if not XGD_CONFIG_HOME.is_dir():
    XGD_CONFIG_HOME.mkdir(parents=True)

PIXI_HOME = Path(os.environ.get("PIXI_HOME", Path.home().joinpath(".pixi"))).resolve()
PIXI_EXE = PIXI_HOME.joinpath("bin", "pixi")

sh = functools.partial(subprocess.run)


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
        "gitui",
        "tmux",
        "xclip",
    )

def setup_starship() -> None:
    with tempfile.NamedTemporaryFile("w", suffix=".sh") as file:
        curl("-sS", "https://starship.rs/install.sh")
        sh(["bash", file.name])

def update_config_symlinks() -> None:
    for repo_sub_config_path in REPO_CONFIG_HOME.iterdir():
        sub_config_name = str(repo_sub_config_path).rsplit("/", maxsplit=1)[-1]
        user_sub_config_path = XGD_CONFIG_HOME / sub_config_name
        update_symlink(file_path=repo_sub_config_path, symlink_path=user_sub_config_path)

def generate_rc_addon() -> None:
    with REPO_GENERATED_RC_ADDON_PATH.open("w") as file:
        file.write(
            "\n\n".join(
                [
                    f"export PIXI_HOME={PIXI_HOME}",
                    REPO_STATIC_RC_ADDON_PATH.read_text(),
                ]
            )
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
    setup_starship()
    update_config_symlinks()
    generate_rc_addon()
