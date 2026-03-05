from fastapi import APIRouter
from app.services.argocd_service import install_argocd

router = APIRouter(prefix="/bootstrap", tags=["Bootstrap"])

@router.post("/argocd")
def bootstrap_argocd():
    return install_argocd()