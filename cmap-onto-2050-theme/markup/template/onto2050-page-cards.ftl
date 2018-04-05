<div class="page-cards">
  <h4>${Title.getData()}</h4>
  <#if getterUtil.getBoolean(IsFullWidth.getData())>
      Full Width
  </#if>
  ${Anchor.getData()}
  <div class="row">
  <#if Card.getSiblings()?has_content>
    <#list Card.getSiblings() as cur_Card>
      <div class="col-md-8 col-xs-16">
        <#if cur_Card.Asset.getData()?? && cur_Card.Asset.getData() != "">
        <div class="top">
          <#if cur_Card.PageLink?? && cur_Card.PageLink.getData() != "" >
            <a href="${cur_Card.PageLink.getFriendlyUrl()}">
              <img data-fileentryid="${cur_Card.Asset.getAttribute("fileEntryId")}" alt="${cur_Card.Asset.getAttribute("alt")}" src="${cur_Card.Asset.getData()}" />
            </a>
          <#else>
            <img data-fileentryid="${cur_Card.Asset.getAttribute("fileEntryId")}" alt="${cur_Card.Asset.getAttribute("alt")}" src="${cur_Card.Asset.getData()}" />
          </#if>
        </div>
        </#if>
        <div class="bottom">
          <#if cur_Card.Title1?? && cur_Card.Title1.getData() != "" >
            <h4>
            <#if cur_Card.PageLink?? && cur_Card.PageLink.getData() != "" >
              <a href="${cur_Card.PageLink.getFriendlyUrl()}">
                ${cur_Card.Title1.getData()}
              </a>
            <#else>
              ${cur_Card.Title1.getData()}
            </#if>
            </h4>
          </#if>
        </div>
      </div>
    </#list>
  </#if>
  </div>
</div>
