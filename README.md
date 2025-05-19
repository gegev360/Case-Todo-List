# TodoApp - Aplicativo de Lista de Tarefas

Este é um aplicativo de listas de tarefas desenvolvido com Ruby on Rails, onde os usuários podem criar múltiplas listas de tarefas e adicionar itens a cada lista.

## Funcionalidades

- Criar, editar e excluir listas de tarefas
- Adicionar, marcar como concluído e excluir itens dentro de cada lista
- Interface responsiva e amigável usando Bootstrap
- Persistência de dados utilizando PostgreSQL

## Tecnologias Utilizadas

- Ruby 3.4.4
- Ruby on Rails 8.0.2
- PostgreSQL para armazenamento de dados
- Bootstrap 5 para estilização
- Turbo e Stimulus para interatividade no frontend
- HTML, CSS e JavaScript puro para o frontend

## Modelagem de Dados

- **TodoList**: Representa uma lista de tarefas com título e descrição
- **Item**: Representa um item dentro de uma lista de tarefas, com descrição e status de conclusão

## Instalação e Configuração

### Pré-requisitos

- Ruby 3.4.4
- PostgreSQL
- Bundler

### Passos para Instalação

1. Clone o repositório:
```
git clone https://github.com/gegev360/Case-Todo-List
cd Todo
```

2. Instale as dependências:
```
bundle install
```

3. Configure o banco de dados:
```
bin/rails db:create
bin/rails db:migrate
```

4. Inicie o servidor:
```
bin/rails server
```

5. Acesse o aplicativo em seu navegador:
```
http://localhost:3000
```

## Estrutura do Projeto

- `app/models`: Contém os modelos de dados (TodoList e Item)
- `app/controllers`: Contém os controladores para gerenciar a lógica da aplicação
- `app/views`: Contém as visualizações da aplicação
- `config/routes.rb`: Define as rotas da aplicação
- `db/migrations`: Contém as migrações do banco de dados

## Possíveis Melhorias Futuras

- Adicionar autenticação de usuários
- Implementar categorias para as listas
- Adicionar datas de vencimento para os itens
- Implementar busca e filtragem
- Adicionar prioridades para os itens
- Implementar compartilhamento de listas entre usuários

## Contribuição

1. Faça um fork do projeto
2. Crie sua branch de feature (`git checkout -b feature/nova-funcionalidade`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova funcionalidade'`)
4. Push para a branch (`git push origin feature/nova-funcionalidade`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a licença MIT - veja o arquivo LICENSE para mais detalhes.
