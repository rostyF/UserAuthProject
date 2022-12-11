<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Prog.kiev.ua</title>
    <script src="https://code.jquery.com/jquery-3.2.1.min.js"
            integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
            crossorigin="anonymous"></script>
</head>
<body>
<div align="center">
    <h1>Secret page for admins only!</h1>

    <p>Click to go back: <a href="/">back</a></p>

    <c:url value="/logout" var="logoutUrl" />
    <p>Click to logout: <a href="${logoutUrl}">LOGOUT</a></p>

    <button type="button" id="add_user">Add</button>
    <button type="button" id="delete_user">Delete</button>


    <table border="1">
        <c:forEach items="${users}" var="user">
            <tr>
                <form action="/updatebyadmin" method="POST">
                <td><input type="checkbox" name="toDelete" value="${user.id}" id="check_${user.id}"></td>
                <!--    <td><c:out value="${user.login}"/></td> -->
                <!--   <td><c:out value="${user.role}"/></td> -->
                <td><input type="text" name="login" value="${user.login}" /> </td>
                    <!--     <td><input type="text" name="userrole" value="${user.role}" /> </td>-->
                    <td><select name="role"><option value="${user.role}"><c:out value="${user.role}"/></option>
                        <c:choose>
                            <c:when test="${user.role ne userrole}">
                                <option value="${userrole}">USER</option>
                            </c:when>
                            <c:when test="${user.role ne adminrole}">
                                <option value="${adminrole}">ADMIN</option>
                            </c:when>
                        </c:choose>
                    </select></td>
                <td><input type="text" name="email" placeholder="Email" value="${user.email}" /> </td>
                <td><input type="text" name="phone" placeholder="Phone" value="${user.phone}" /> </td>
                <td><input type="text" name="address" placeholder="Address" value="${user.address}" /> </td>
                    <td><input type="submit" value="Update" /></td>
                </form>
            </tr>
        </c:forEach>
    </table>

</div>

<script>
    $('#add_user').click(function(){
        window.location.href = "/register";
    });

    $('#delete_user').click(function(){
        var data = { 'toDelete' : []};
        $(":checked").each(function() {
            data['toDelete'].push($(this).val());
        });
        $.post("/delete", data, function(data, status) {
            window.location.reload();
        });
    });



</script>

</body>
</html>
