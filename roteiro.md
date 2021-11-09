# Como criar um usuário customizado através de formulário no Liferay

## Criar os campos na UI

## Criar um MVC Portlet

## Criar a view

1. Verificar build gradle
2. Adicionar as novas tags de front end no init
3. Criar o formulário com os campos personalizados
4. Setar UTF-8
5. Criar validators
   http://www.receita.fazenda.gov.br/aplicacoes/atcta/cpf/funcoes.js

## Criar a action

1. Criar MVCCommandName
2. Criar package action
3. Criar classe AddUserMVCActionCommand
4. Anotação de componente pra ele
   @Component(
   immediate = true,
   property = {
   "javax.portlet.name=" + UserCustomFieldsManagementPortletKeys.USERCUSTOMFIELDSMANAGEMENT,
   "mvc.command.name=" + MVCCommandNames.ADD_USER
   },
   service = MVCActionCommand.class
   )
   e extender BaseMVCActionCommand
5. Override a doProcessAction
6. Pegar os campos e printar
7. Criar usuario com os campos

### Criar mensagens de erros

1. Criar language keys na language.properties
2. Adicionar as mensagens de erro nas actions SessionMessages e SessionErrors
3. Reportar esses erros na JSP
