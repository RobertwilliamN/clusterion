Aqui vai uma versão mais natural, com linguagem mais próxima de quem realmente escreveu no dia a dia, sem aquele tom “robótico”:

---

# Clusterion Platform

O **Clusterion** é uma plataforma DevOps baseada em GitOps pensada para simplificar a criação de um ambiente completo em Kubernetes.

A proposta é direta: evitar todo o trabalho manual de instalar e configurar várias ferramentas essenciais.

> Com um único comando, você sobe uma base DevOps pronta dentro de um cluster Kubernetes.

A ideia é centralizar tudo em GitOps, deixando o estado do cluster totalmente controlado por um repositório.

---

# O que o Clusterion instala automaticamente

Ao executar o bootstrap, a plataforma cuida de toda a configuração inicial para você.

## GitOps

* Argo CD

## Observabilidade

* Prometheus
* Grafana

## Infraestrutura Kubernetes

* Ingress Controller
* CRDs necessários
* Estrutura inicial de aplicações via GitOps

---

# Arquitetura

O Clusterion segue o padrão App-of-Apps utilizando o Argo CD.

Na prática, funciona assim:

```
Git Repository
      │
      ▼
ArgoCD Root Application
      │
      ├── Observability
      │     ├── Prometheus
      │     └── Grafana
      │
      ├── Infrastructure
      │
      └── Applications
```

Todo o estado do cluster fica definido no repositório **clusterion-platform**, e o Argo CD garante que o ambiente reflita exatamente o que está versionado ali.

---

# Instalação

Para iniciar, basta rodar um único comando:

```bash
curl -sSL https://raw.githubusercontent.com/RobertwilliamN/clusterion/main/install.sh | bash
```

Esse processo automatiza:

1. Instalação das dependências
2. Criação de um cluster local com Kind (caso não exista)
3. Configuração do Ingress Controller
4. Instalação do Argo CD
5. Inicialização do fluxo GitOps
6. Deploy do Prometheus e Grafana

---

# Acesso à plataforma

Depois que a instalação termina, o Argo CD estará disponível em:

```
http://argocd.clusterion.local
```

Usuário:

```
admin
```

A senha é exibida ao final da instalação.

---

# Serviços disponíveis

Após o setup, você terá acesso aos seguintes serviços:

| Serviço    | URL                                                                      |
| ---------- | ------------------------------------------------------------------------ |
| ArgoCD     | [http://argocd.clusterion.local](http://argocd.clusterion.local)         |
| Grafana    | [http://grafana.clusterion.local](http://grafana.clusterion.local)       |
| Prometheus | [http://prometheus.clusterion.local](http://prometheus.clusterion.local) |

---

# Estrutura do projeto

```
clusterion-platform
│
├── install.sh
├── bootstrap
│   ├── clusterion-project.yaml
│   └── clusterion-root-app.yaml
│
├── apps
│   ├── prometheus.yaml
│   └── grafana.yaml
│
└── scripts
```

---

# Compatibilidade

O Clusterion pode ser utilizado em qualquer cluster Kubernetes.

Funciona com:

* kind (local)
* Amazon EKS
* Google Kubernetes Engine
* Azure Kubernetes Service

Se você já tiver um cluster configurado, basta garantir que o `kubectl` esteja apontando corretamente antes de rodar a instalação.

---

# Pré-requisitos

No ambiente local, o script já instala automaticamente:

* Docker
* kubectl
* Kind
* ArgoCD CLI

Para clusters remotos, basta ter o `kubectl` configurado.

---

# GitOps

Todas as aplicações são gerenciadas pelo Argo CD.

Na prática, isso significa que qualquer alteração no repositório é aplicada automaticamente no cluster.

Fluxo:

```
git push
   │
   ▼
ArgoCD detecta mudança
   │
   ▼
Cluster atualizado automaticamente
```

---

# Observabilidade

A stack já inclui ferramentas básicas para monitoramento.

## Prometheus

Responsável pela coleta de métricas do cluster.

## Grafana

Utilizado para visualizar essas métricas através de dashboards.

Os dashboards já vêm configurados por padrão.

---

# Roadmap

Algumas melhorias planejadas:

* Logs centralizados com Loki
* Certificados automáticos com Cert-Manager
* Deploy automatizado de aplicações
* Suporte a múltiplos clusters
* Integração com pipelines de CI/CD

---

# Contribuição

Se quiser contribuir:

1. Faça um fork
2. Crie uma branch
3. Abra um Pull Request

---

# Licença

MIT License

---

# Autor

Robert William

DevOps • Platform Engineering • Kubernetes • Observability

---

Se o projeto for útil para você, considere deixar uma estrela no repositório.
