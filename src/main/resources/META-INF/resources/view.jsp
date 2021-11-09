<%@ include file="/init.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<liferay-ui:success key="userAdded" message="user-added" />
<liferay-ui:error key="screennameDuplicated" message="screenname-duplicated"/>
<liferay-ui:error key="emailDuplicated" message="email-duplicated"/>

<%
	Calendar today = CalendarFactoryUtil.getCalendar();
%>

<portlet:actionURL name="<%= MVCCommandNames.ADD_USER%>" var="createUserURL" />

<aui:form action="<%= createUserURL%>" method="post" name="createUserForm">
	<aui:fieldset>
		<div class="row">
			<div class="col-md-6">
				<aui:input name="firstName" label="Nome">
					<aui:validator name="required" errorMessage="Nome é obrigatório"/>
				</aui:input>
			</div>

			<div class="col-md-6">
				<aui:input name="lastName" label="Sobrenome">
					<aui:validator name="required" errorMessage="Sobrenome é obrigatório"/>
				</aui:input>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6">
				<aui:input name="screenName" label="Nome de usuário">
					<aui:validator name="required" errorMessage="Nome de usuário é obrigatório"/>
				</aui:input>
			</div>

			<div class="col-md-6">
				<aui:input name="email" label="Endereço de Email">
					<aui:validator name="required" errorMessage="Endereço de Email é obrigatório"/>
				</aui:input>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6">
				<aui:select name="gender" label="Gênero">
					<aui:option label="Masculino" value="0"/>
					<aui:option label="Feminino" value="1"/>
					<aui:option label="Outro" value="2"/>
				</aui:select>
			</div>

			<div class="col-md-6">
				<liferay-ui:input-date name="birthday" dayParam="birthdayDay" monthParam="birthdayMonth" yearParam="birthdayYear"
						dayValue="<%= today.get(Calendar.DAY_OF_MONTH)%>" monthValue="<%= today.get(Calendar.MONTH)%>"
						yearValue="<%= today.get(Calendar.YEAR)%>" >
					<b>Data de nascimento</b>
				</liferay-ui:input-date>
			</div>
		</div>

		<div class="row">
			<div class="col-md-6">
				<aui:input name="cpf" id="cpf" label="CPF" maxlength="14" oninput="maskCPF(this)">
					<aui:validator name="required" errorMessage="CPF é obrigatório"/>
					<aui:validator name="custom" errorMessage="É necessário inserir um CPF válido">
						function(val) {
							return validateCPF(val);
						}
					</aui:validator>
				</aui:input>
			</div>

			<div class="col-md-6">
				<aui:select name="booksPerYear" label="Quantos livros você lê por mês">
					<aui:option label="0" value="0"/>
					<aui:option label="2" value="2"/>
					<aui:option label="4" value="4"/>
					<aui:option label="6" value="6"/>
					<aui:option label="8+" value="8+"/>
				</aui:select>
			</div>
		</div>
	</aui:fieldset>

	<aui:button type="submit" value="Criar" />
</aui:form>

<script>
	function validateCPF(cpf) {
		cpf = getOnlyDigits(cpf);
		let i;
		let sum = 0;
		let rest;
		if (cpf === "00000000000")
			return false;

		for (i = 1; i <= 9; i++)
			sum = sum + parseInt(cpf.substring(i - 1, i)) * (11 - i);
		rest = (sum * 10) % 11;

		if ((rest === 10) || (rest === 11))
			rest = 0;

		if (rest !== parseInt(cpf.substring(9, 10)) )
			return false;

		sum = 0;
		for (i = 1; i <= 10; i++)
			sum = sum + parseInt(cpf.substring(i - 1, i)) * (12 - i);
		rest = (sum * 10) % 11;

		if ((rest === 10) || (rest === 11))
			rest = 0;

		return rest === parseInt(cpf.substring(10, 11));
	}

	function getOnlyDigits(value) {
		return value.replace(/[^0-9]/g, '');
	}

	function maskCPF(element) {
		let cpf = element.value;
		cpf = cpf.replace(/\D/g,"")
		cpf = cpf.replace(/(\d{3})(\d)/,"$1.$2")
		cpf = cpf.replace(/(\d{3})(\d)/,"$1.$2")
		cpf = cpf.replace(/(\d{3})(\d{1,2})$/,"$1-$2")

		element.value = cpf;
	}
</script>