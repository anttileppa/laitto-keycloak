<#--
    Overrides keycloak.v2's password-validation.ftl, copied verbatim from Keycloak 26.7.2 with a
    single change: see the comment inside the script macro.

    This is the ONLY template this theme overrides - everything else inherits from keycloak.v2 on
    purpose, so new login sub-pages stay styled without us tracking them. Re-check this file on a
    Keycloak upgrade: a copied template cannot learn about a newly added password policy, and this
    override should be deleted outright once upstream guards the lookup itself.
-->
<#macro templates>
    <template id="errorTemplate">
        <div class="${properties.kcFormHelperTextClass}" aria-live="polite">
            <div class="${properties.kcInputHelperTextClass}">
                <div class="${properties.kcInputHelperTextItemClass} ${properties.kcError}">
                    <ul class="${properties.kcInputErrorMessageClass}">
                    </ul>
                </div>
            </div>
        </div>
    </template>
    <template id="errorItemTemplate">
        <li></li>
    </template>
</#macro>

<#macro script field="">
    <script type="module">
        <#outputformat "JavaScript">
        import { validatePassword } from "${url.resourcesPath}/js/password-policy.js";

        const activePolicies = [
            { name: "length", policy: { value: ${passwordPolicies.length!-1}, error: ${msg('invalidPasswordMinLengthMessage')?c} } },
            { name: "maxLength", policy: { value: ${passwordPolicies.maxLength!-1}, error: ${msg('invalidPasswordMaxLengthMessage')?c} } },
            { name: "lowerCase", policy: { value: ${passwordPolicies.lowerCase!-1}, error: ${msg('invalidPasswordMinLowerCaseCharsMessage')?c} } },
            { name: "upperCase", policy: { value: ${passwordPolicies.upperCase!-1}, error: ${msg('invalidPasswordMinUpperCaseCharsMessage')?c} } },
            { name: "digits", policy: { value: ${passwordPolicies.digits!-1}, error: ${msg('invalidPasswordMinDigitsMessage')?c} } },
            { name: "specialChars", policy: { value: ${passwordPolicies.specialChars!-1}, error: ${msg('invalidPasswordMinSpecialCharsMessage')?c} } }
        ].filter(p => p.policy.value !== -1);

        <#-- Optional chaining, and nothing else, is the fix. register.ftl emits this script
             unconditionally but only renders the password inputs when `passwordRequired` is set,
             and Keycloak clears that when the realm requires email verification (credentials are
             created from the emailed link instead). Without the `?.` that lookup returns null and
             every load of the register page throws. Where the field does exist - notably
             login-update-password.ftl, field "password-new" - behaviour is unchanged. -->
        document.getElementById("${field}")?.addEventListener("change", (event) => {

            const errorContainer = document.getElementById("input-error-container-${field}");
            const template = document.querySelector("#errorTemplate").content.cloneNode(true);
            const errors = validatePassword(event.target.value, activePolicies);

            if (errors.length === 0) {
                errorContainer.replaceChildren();
                return;
            }

            const errorList = template.querySelector("ul");
            const htmlErrors = errors.forEach((e) => {
                const row = document.querySelector("#errorItemTemplate").content.cloneNode(true);
                const li = row.querySelector("li");
                li.textContent = e;
                errorList.appendChild(li);
            });
            errorContainer.replaceChildren(template);
        });
    </#outputformat>
    </script>
</#macro>