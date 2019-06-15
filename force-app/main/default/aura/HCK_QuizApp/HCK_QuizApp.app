<aura:application extends="force:slds" controller="LoginController">
    <aura:attribute name="username" type="string"/>
    <aura:attribute name="password" type="string"/>
    <aura:attribute name="contactValue" type="string"/>
    <aura:attribute name="showError" type="boolean" default="false"/>
    <aura:attribute name="displayScreen" type="boolean" default="true"/>
    
    <!--c:HCK_QuizSummary candidateId="0034P00002UxQt5" QuizId="a024P00000m4vv9"/-->
    <aura:if isTrue="{!v.displayScreen}">
     
<aura:if isTrue="{!v.showError}">
        <!-- Show the message to ui -->
        <div class="slds-notify slds-notify_toast slds-theme_error">
            <span class="slds-assistive-text">error</span>
            <div class="slds-notify__content">
                <h5 class="slds-text-heading_small slds-align_absolute-center">Error Message </h5>
                <br/>
                <p class="slds-align_absolute-center">Invalid username or password</p>                
            </div>
        </div>
    </aura:if>  
 
	<lightning:layout>
        <lightning:layoutItem padding="around-small">
    <lightning:input type="text" name="UserName" label="UserName" required="true" value="{!v.username}" />
    <br/>
    <lightning:input type="text" name="Password" label="Password" required="true" value="{!v.password}" />
    <br/>
    <lightning:button variant="brand" label="Login" onclick="{!c.handleLogin}"/>
        </lightning:layoutItem>
        </lightning:layout>   
        <aura:set attribute="else">
	<c:HCK_QuizSelection contactId="{!v.contactValue}"></c:HCK_QuizSelection>
            </aura:set>
        </aura:if>
</aura:application>