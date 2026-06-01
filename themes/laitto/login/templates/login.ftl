<#import "template.ftl" as layout>
<@layout.registrationLayout
    displayMessage=!messagesPerField.existsError('username','password')
    displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??;
    section>

    <#if section = "form">

    <form id="kc-form-login" class="l-form" action="${url.loginAction}" method="post">

        <#-- Username / email -->
        <div class="l-field">
            <label class="l-label" for="username">${msg("email")}</label>
            <input
                type="email"
                id="username"
                name="username"
                value="${(login.username!'')}"
                autofocus
                autocomplete="email"
                spellcheck="false"
                placeholder="you@brewery.com"
                class="l-input<#if messagesPerField.existsError('username')> l-input--error</#if>"
            />
            <#if messagesPerField.existsError('username')>
                <div class="l-field-error">${kcSanitize(messagesPerField.get('username'))?no_esc}</div>
            </#if>
        </div>

        <#-- Password -->
        <div class="l-field">
            <div class="l-field-row">
                <label class="l-label" for="password">${msg("password")}</label>
                <#if realm.resetPasswordAllowed>
                    <a href="${url.loginResetCredentialsUrl}" class="l-link l-link--sm">
                        ${msg("doForgotPassword")}
                    </a>
                </#if>
            </div>
            <input
                type="password"
                id="password"
                name="password"
                autocomplete="current-password"
                placeholder="••••••••"
                class="l-input<#if messagesPerField.existsError('password')> l-input--error</#if>"
            />
            <#if messagesPerField.existsError('password')>
                <div class="l-field-error">${kcSanitize(messagesPerField.get('password'))?no_esc}</div>
            </#if>
        </div>

        <#-- Remember me -->
        <#if realm.rememberMe && !usernameEditDisabled??>
        <label class="l-checkbox-label">
            <input
                type="checkbox"
                id="rememberMe"
                name="rememberMe"
                class="l-checkbox-input"
                <#if login.rememberMe??>checked</#if>
            />
            <span class="l-checkbox-box"></span>
            <span class="l-checkbox-text">${msg("rememberMe")}</span>
        </label>
        </#if>

        <#-- Submit -->
        <button type="submit" id="kc-login" class="l-btn-primary">
            ${msg("doLogIn")}
        </button>

    </form>

    <#elseif section = "info">

        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <span class="l-info-text">${msg("noAccount")}</span>
            <a href="${url.registrationUrl}" class="l-link">${msg("doRegister")}</a>
        </#if>

    </#if>

</@layout.registrationLayout>
