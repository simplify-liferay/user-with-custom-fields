package com.liferay.simplify.user.customfields.management.portlet.action;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.UserEmailAddressException;
import com.liferay.portal.kernel.exception.UserScreenNameException;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCActionCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.simplify.user.customfields.management.constants.MVCCommandNames;
import com.liferay.simplify.user.customfields.management.constants.UserCustomFieldsManagementPortletKeys;
import org.osgi.service.component.annotations.Component;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

@Component(
        immediate = true,
        property = {
                "javax.portlet.name=" + UserCustomFieldsManagementPortletKeys.USERCUSTOMFIELDSMANAGEMENT,
                "mvc.command.name=" + MVCCommandNames.ADD_USER
        },
        service = MVCActionCommand.class
)
public class AddUserMVCActionCommand extends BaseMVCActionCommand {

    @Override
    protected void doProcessAction(ActionRequest actionRequest, ActionResponse actionResponse) throws PortalException {
        String firstName = ParamUtil.getString(actionRequest, "firstName");
        String lastName = ParamUtil.getString(actionRequest, "lastName");
        String screenName = ParamUtil.getString(actionRequest, "screenName");
        String email = ParamUtil.getString(actionRequest, "email");
        boolean gender = ParamUtil.getInteger(actionRequest, "gender") == 1;
        int birthdayDay = ParamUtil.getInteger(actionRequest, "birthdayDay");
        int birthdayMonth = ParamUtil.getInteger(actionRequest, "birthdayMonth");
        int birthdayYear = ParamUtil.getInteger(actionRequest, "birthdayYear");

        Map<String, Serializable> expandoBridgeAttributes = new HashMap<>();
        String cpf = ParamUtil.getString(actionRequest, "cpf");
        String booksPerYear = ParamUtil.getString(actionRequest, "booksPerYear");
        expandoBridgeAttributes.put("cpf", cpf);
        expandoBridgeAttributes.put("booksPerYear", booksPerYear);

        ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
        long userId = themeDisplay.getUserId();

        ServiceContext serviceContext = ServiceContextFactory.getInstance(actionRequest);
        serviceContext.setExpandoBridgeAttributes(expandoBridgeAttributes);

        try {
            UserLocalServiceUtil.addUser(userId, themeDisplay.getCompanyId(), true, "",
                    "", false, screenName, email, Locale.getDefault(), firstName,
                    "", lastName, 0, 0, gender, birthdayMonth, birthdayDay, birthdayYear,
                    "", null, null, null, null, false, serviceContext);
            SessionMessages.add(actionRequest, "userAdded");
        } catch (UserScreenNameException e) {
            SessionErrors.add(actionRequest, "screennameDuplicated", e.getClass().getName());
        } catch (UserEmailAddressException e) {
            SessionErrors.add(actionRequest, "emailDuplicated", e.getClass().getName());
        }
    }
}
