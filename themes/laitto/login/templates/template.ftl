<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayWide=false>
<!DOCTYPE html>
<html lang="${locale}" class="laitto">
<head>
    <meta charset="UTF-8">
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("loginTitle",(realm.displayName!'Laitto'))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.svg" type="image/svg+xml" />
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
        </#list>
    </#if>
</head>
<body>

<div class="l-page">
    <div class="l-card">

        <#-- Brand header -->
        <div class="l-brand">
            <div class="l-mark">L</div>
            <div>
                <div class="l-brand-name">Laitto</div>
                <div class="l-brand-sub">Cloud brewhouse control</div>
            </div>
        </div>

        <#-- Alert messages (errors, warnings, info) -->
        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="l-alert l-alert--${message.type}">
                ${kcSanitize(message.summary)?no_esc}
            </div>
        </#if>

        <#-- Main form content -->
        <#nested "form">

        <#-- Secondary info (register link etc.) -->
        <#if displayInfo>
            <div class="l-info">
                <#nested "info">
            </div>
        </#if>

    </div>
</div>

<#-- Keycloak scripts (TOTP, WebAuthn etc.) -->
<#if scripts??>
    <#list scripts as script>
        <script src="${script}" type="text/javascript"></script>
    </#list>
</#if>

</body>
</html>
</#macro>
