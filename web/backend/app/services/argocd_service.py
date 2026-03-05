import subprocess
from app.core.logger import get_logger

logger = get_logger()

def install_argocd():
    logger.info("Creating argocd namespace...")

    subprocess.run(
        ["kubectl", "create", "namespace", "argocd"],
        check=False
    )

    logger.info("Applying ArgoCD manifests...")

    subprocess.run(
        [
            "kubectl",
            "apply",
            "-n",
            "argocd",
            "-f",
            "https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml",
        ],
        check=True,
    )

    return {"message": "ArgoCD installation started"}