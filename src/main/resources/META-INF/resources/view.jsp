<%@ include file="/init.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<portlet:actionURL name="createUser" var="createUserURL" />

<aui:form action="<%= createUserURL%>" method="post" name="createUserForm">
	<div class="row">
		<div class="col-md-6">
			<aui:input name="name" label="Nome">
				<aui:validator name="required" errorMessage="Nome é obrigatório"/>
			</aui:input>
		</div>

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
	</div>

	<aui:select name="booksPerYear" label="Quantos livros você lê por mês">
		<aui:option label="0" value="0"/>
		<aui:option label="2" value="2"/>
		<aui:option label="4" value="4"/>
		<aui:option label="6" value="6"/>
		<aui:option label="8+" value="8+"/>
	</aui:select>

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