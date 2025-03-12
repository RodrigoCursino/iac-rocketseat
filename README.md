# Desafio Rockeseat IAC

## Descrição
Este desafio tem o objetivo de consolidar os conhecimentos adquiridos durante o curso de IAC, nele devemos configurar uma infraestrutura distribuída em três ambientes (prod, staging e dev) usando o Terraform. Cada ambiente requer configurações específicas, como diferentes tamanhos de instâncias, variáveis de ambiente e configurações de rede.

---

## Documentação
Adicione aqui links para a documentação oficial ou arquivos relevantes.

---

## Configuração do Ambiente

### 1. Login na AWS
Para iniciar, faça login na AWS utilizando o seguinte comando:

```sh
aws sso login --profile=<seu-profile>
```

### 2. Criar o arquivo `providers.tf`
Na raiz do projeto, crie um arquivo chamado **`providers.tf`** e insira as configurações do provider com a região e o perfil correto. Exemplo:

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.88.0"
    }
  }
}

provider "aws" {
  region  = "<regiao>"
  profile = "<profile>"
}
```

### 3. Inicializar o Terraform
Após configurar o provider, execute o seguinte comando para inicializar o Terraform:

```sh
terraform init
```
> Este comando inicializa o repositório do Terraform e gera o estado da infraestrutura.

### 4. Configurar Workspaces
Crie os workspaces para diferentes ambientes (prod, dev e staging) com o comando:

```sh
terraform workspace new <nome-do-workspace>
```

### 5. Estrutura do Diretório
Crie uma pasta chamada **`modules`**, onde ficarão os módulos do projeto. A separação proposta é:

#### **Módulo: Network**
- VPN
- API Gateway
- Route Table
- Duas Subnets
- Table Association
- Dois Security Groups

#### **Módulo: Load Balancer**
- Um Load Balancer
- Um Load Balancer Listener
- Um Target Group
- Dois Target Group Attachments

#### **Módulo: EC2**
- Duas instâncias EC2

---

## Como Contribuir
1. Faça um fork do repositório.
2. Crie uma nova branch com sua feature ou correção.
3. Faça o commit das suas alterações.
4. Envie um pull request.

---

## Autor(es)
- [Seu Nome] - *Descrição breve do seu papel no projeto*

