<#if Background.getData()?? && Background.getData() != "">
	<#assign background = Background.getData()>
<#else>
	<#assign background = ''>
</#if>

<div class="advertisement">
	<div class="row">
		<div class="col-md-offset-8 col-md-8 col-sm-offset-0 col-sm-12 col-xs-16">
			<div class="cmap-ad-content">
				<h6>${Title.getData()}</h6>
				<p>${Paragraph.getData()}</p>
				<a class="button" href="${ButtonLink.getFriendlyUrl()}">
					${ButtonText.getData()}
				</a>
			</div>
		</div>
	</div>
	<#if background != "">
		<img class="background" data-fileentryid="${Background.getAttribute("fileEntryId")}" alt="${Background.getAttribute("alt")}" src="${Background.getData()}" />
	<#else>
		<div class="placeholder-background"></div>
	</#if>
</div>

<script>
Liferay.on(
	'allPortletsReady',
	function() {
		function set_advertisement(){
			var $this = $(this);
			var height = $this.outerWidth() * 0.5;
			var min_height = $this.find('.cmap-ad-content').outerHeight();
			$this.css('height', height);
			$this.css('min-height', min_height);
		}
		function handle_resize(e){
			$('.advertisement').each(set_advertisement);
		}
		$(window).resize(_.throttle(handle_resize, 100));
		handle_resize();
	}
);
</script>