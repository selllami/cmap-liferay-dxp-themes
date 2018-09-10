<#assign glossary = []>
<#assign initials = []>

<style>
.glossary header {
	margin-bottom: 30px;
	font-size: 12px;
	font-weight: bold;
}
.glossary .field-label-container {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}
.glossary label {
	margin: 0 10px 0 0;
}
.glossary .select-wrapper {
	flex: 2;
	border-radius: 35px;
	background-color: #E4EAEE;
	overflow: hidden;
}
.glossary select {
	height: 30px;
	width: 100%;
	border: 0;
	outline: 0;
	padding: 0 15px;
	background-color: #E4EAEE;
	background-image: url('data:image/svg+xml;charset=utf8,%3Csvg%20width%3D%2720%27%20height%3D%2720%27%20viewBox%3D%270%200%201792%201792%27%20xmlns%3D%27http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%27%3E%3Cpath%20d%3D%27M1395%20736q0%2013-10%2023l-466%20466q-10%2010-23%2010t-23-10l-466-466q-10-10-10-23t10-23l50-50q10-10%2023-10t23%2010l393%20393%20393-393q10-10%2023-10t23%2010l50%2050q10%2010%2010%2023z%27%2F%3E%3C%2Fsvg%3E');
	background-position: right 10px center;
	background-repeat: no-repeat;
	appearance: none;
	-webkit-appearance: none;
	-moz-appearance: none;
	-o-appearance: none;
}
.glossary select::-ms-expand {
	display: none;
}
.glossary input[type=text],
.glossary input[type=url],
.glossary input[type=email],
.glossary input[type=number]{
	flex: 2;
	height: 30px;
	border: 1px solid #E4EAEE;
	border-radius: 35px;
	padding: 0 15px;
	background-color: #E4EAEE;
	outline: 0;
}
::placeholder {
	color: #475C66;
	opacity: 1;
}
.glossary #glossary_search {
	padding-left: 40px;
	background-image: url('data:image/svg+xml;charset=utf8,%3Csvg%20version%3D%221.1%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2216%22%20height%3D%2216%22%20viewBox%3D%220%200%20483.083%20483.083%22%3E%3Cg%20fill%3D%22%2523475c66%22%3E%3Cpath%20d%3D%22M332.74%2C315.35c30.883-33.433%2C50.15-78.2%2C50.15-127.5C382.89%2C84.433%2C298.74%2C0%2C195.04%2C0S7.19%2C84.433%2C7.19%2C187.85%20S91.34%2C375.7%2C195.04%2C375.7c42.217%2C0%2C81.033-13.883%2C112.483-37.4l139.683%2C139.683c3.4%2C3.4%2C7.65%2C5.1%2C11.9%2C5.1s8.783-1.7%2C11.9-5.1%20c6.517-6.517%2C6.517-17.283%2C0-24.083L332.74%2C315.35z%20M41.19%2C187.85C41.19%2C103.133%2C110.04%2C34%2C195.04%2C34%20c84.717%2C0%2C153.85%2C68.85%2C153.85%2C153.85S280.04%2C341.7%2C195.04%2C341.7S41.19%2C272.567%2C41.19%2C187.85z%22%2F%3E%3C%2Fg%3E%3C%2Fsvg%3E');
	background-position: left 15px center;
	background-repeat: no-repeat;
}
.character-group {
	margin-top: 5px;
}
.glossary h3 {
	padding: 10px 20px;
	background-color: #89A0B1;
	font-size: 15px;
	color: #FFF !important;
}
.glossary .term-wrapper {
	padding: 15px 0;
	border-bottom: 1px solid #91A6B6;
	font-size: 13px;
	color: #095181;
}
.glossary .term-wrapper:last-child {
	border-bottom: none;
}
.glossary .term-wrapper dt {
	margin-bottom: 10px;
}
</style>

<#if Term.getSiblings()?has_content>
	<#list Term.getSiblings() as cur_Term>
	
		<#if cur_Term?has_content >
		<#assign term = cur_Term.getData()>
		<#assign definition = cur_Term.Definition.getData()>
		<#assign anchor = term?lower_case?replace('[^a-z]', '-', 'ri')>
		<#assign initial = term?upper_case[0]>
		<#-- generate array of unique first letters for  jump list -->
		<#assign initialIndex = initials?seq_index_of(initial)>
		<#if initialIndex == -1>
			<#assign initials = initials + [initial]>
		</#if>

		<#assign glossary = glossary + [{
			"term" : term,
			"anchor" : anchor,
			"initial" : initial, 
			"definition" : definition
		}]>
		</#if>
	</#list>

	<div class="glossary">
		<header>
			<div clas="row">
				<div class="col-xs-16 col-md-8">
					<div class="field-label-container">
						<label for="jump">Jump to</label>
						<div class="select-wrapper">
							<select name="jump" id="glossary_jump">
								<option value=""></option>
								<#list initials as i>
									<option value="${i}">${i}</option>
								</#list>
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-16 col-md-8">
					<div class="field-label-container">
						<input type="text" id="glossary_search" placeholder="Find by term">
					</div>
				</div>
			</div>
			<div class="row"></div>
		</header>
		<div class="row">
			<div class="col-xs-16">
				<dl>
							<div class="character-group">
					<#assign separators = []>
					<#list glossary?sort_by("term") as g>
						<#assign separatorIndex = separators?seq_index_of(g.initial)>
						<#if separatorIndex == -1>
							<#assign separators = separators + [g.initial]>
							</div>
							<div class="character-group">
								<div class="row">
									<a id="${g.initial}"></a>
									<h3>${g.initial}</h3>
								</div>
						</#if>
								<div data-term="${g.term?lower_case}" class="row term-wrapper">
									<a id="${g.anchor}"></a>
									<dt class="col-xs-16 col-sm-4">${g.term}</dt>
									<dd class="col-xs-16 col-sm-12">${g.definition}</dd>
								</div>
					</#list>
							</div>
				</dl>
			</div>
		</div>
	</div>

</#if>

<script>

AUI().ready(

  function () {
  
	$('#glossary_jump').val('').on('change', function () {
	  var initial = $(this).val();
	  var hashless = window.location.href.replace(window.location.hash, '');
	  if (initial !== '') {
		window.location.href = hashless + '#' + initial;
	  } else {
		window.location.href = hashless;
	  }
	});

	$('#glossary_search').val('').on('input', function () {
	  var term = $(this).val().toLowerCase();
	  if ($.trim(term) === '') {
		$("dl").find('div.term-wrapper').show();
	  } else {
		$("dl").find('div.term-wrapper').hide();
		$("dl").find('div.term-wrapper[data-term*="' + term + '"]').show();
	  }
	});

  }
);

</script>