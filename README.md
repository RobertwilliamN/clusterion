# 🚀 Clusterion Platform

**Clusterion** é uma plataforma DevOps baseada em **GitOps** que instala automaticamente um ecossistema completo de observabilidade e gerenciamento de aplicações em qualquer cluster Kubernetes.

A ideia do projeto é simples:

> **Um único comando instala toda a plataforma DevOps em um cluster Kubernetes.**

O Clusterion automatiza a instalação e configuração de ferramentas essenciais como:

* Argo CD — GitOps e gerenciamento de aplicações
* Prometheus — coleta de métricas
* Grafana — visualização de métricas
* Kubernetes — orquestração de containers

Tudo gerenciado através de **GitOps**, permitindo que o estado do cluster seja controlado por um repositório Git.

---

# 📦 O que o Clusterion instala automaticamente

Ao executar o bootstrap, o Clusterion provisiona:

### Plataforma GitOps

* Argo CD

### Observabilidade

* Prometheus
* Grafana

### Infraestrutura Kubernetes

* Ingress Controller
* CRDs necessários
* Aplicações GitOps

---

# 🧠 Arquitetura

O Clusterion segue o padrão **GitOps App-of-Apps** utilizando o Argo CD.

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

Todo o estado do cluster é definido no repositório **clusterion-platform**.

---

# ⚡ Instalação rápida

Execute apenas um comando:

```bash
curl -sSL https://raw.githubusercontent.com/RobertwilliamN/clusterion-platform/main/install.sh | bash
```

Esse comando irá:

1. Instalar dependências necessárias
2. Criar um cluster local Kubernetes com Kind (caso não exista)
3. Instalar Ingress Controller
4. Instalar ArgoCD
5. Inicializar o GitOps
6. Instalar Prometheus e Grafana automaticamente

---

# 🖥️ Acessando a plataforma

Após a instalação, acesse:

```
http://argocd.clusterion.local
```

Usuário:

```
admin
```

A senha será exibida no final do processo de instalação.

---

# 📊 Serviços disponíveis

Após a instalação, os seguintes endpoints estarão disponíveis:

| Serviço    | URL                                |
| ---------- | ---------------------------------- |
| ArgoCD     | http://argocd.clusterion.local     |
| Grafana    | http://grafana.clusterion.local    |
| Prometheus | http://prometheus.clusterion.local |

---

# 📁 Estrutura do projeto

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

# ☁️ Compatibilidade

O Clusterion pode ser instalado em qualquer cluster Kubernetes.

Funciona com:

* kind (cluster local)
* Amazon EKS
* Google Kubernetes Engine
* Azure Kubernetes Service

Caso já possua um cluster Kubernetes, basta garantir que o **kubectl esteja conectado ao cluster** antes de rodar o install.

---

# 🔧 Pré-requisitos

Para instalação local o script instalará automaticamente:

* Docker
* kubectl
* Kind
* ArgoCD CLI

Caso esteja utilizando um cluster remoto, apenas o **kubectl configurado** é necessário.

---

# 🔄 GitOps

Todas as aplicações são gerenciadas pelo **Argo CD**.

Isso significa que qualquer alteração feita no repositório será automaticamente sincronizada com o cluster.

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

# 🧩 Observabilidade

A stack de observabilidade instalada inclui:

### Prometheus

Responsável pela coleta de métricas do cluster.

### Grafana

Responsável por dashboards e visualização das métricas.

Os dashboards já vêm pré-configurados.

---

# 🚀 Roadmap

Próximas funcionalidades planejadas:

* Logs centralizados com Loki
* Certificados automáticos com Cert-Manager
* Deploy automático de aplicações
* Suporte multi-cluster
* Integração com pipelines CI/CD

---

# 🤝 Contribuição

Contribuições são bem-vindas.

1. Faça um fork do projeto
2. Crie uma branch
3. Envie um Pull Request

---

# 📄 Licença

MIT License

---

# 👨‍💻 Autor

Robert William

DevOps • Platform Engineering • Kubernetes • Observability

---

⭐ Se esse projeto te ajudou, considere dar uma estrela no repositório.
