<%@ page import="servlets.SessionUtils" %>
<%@ page import="static servlets.SessionUtils.errorMsgXml" %>
<%@ page import="Users.UsersDataBase" %>
<%@ page import="Users.UserData" %>
<%@ page import="Repository.Repository" %>
<%@ page import="static servlets.SessionUtils.successMsg" %>
<%@ page import="static servlets.SessionUtils.*" %>
<%@ page import="Objects.Branch.Branch" %>
<%@ page import="Objects.Commit.Commit" %>
<%@ page import="java.io.File" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>M.A-GitHub</title>
        <script src="../../common/jquery-2.0.3.min.js"></script>
        <script src="UserPage.js"></script>
        <script src="main.js"></script>

        <link rel="stylesheet" href="css/sidebar.css">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- Bootstrap core CSS -->
        <link href="../../common/bootstrap.min.css" rel="stylesheet">

        <!-- Custom styles for this template -->
        <link href="css/modern-business.css" rel="stylesheet">
    </head>
    <body>
        <% String repoName = SessionUtils.getRepoName(request);
        String username = SessionUtils.getUsername(request);
        Repository repo=UsersDataBase.getRepo(repoName,username);
        String pressedCommitSha1 = SessionUtils.getCommit(request);
        Commit pressedCommit;
        if(pressedCommitSha1.equals(""))
            pressedCommit=repo.sha1ToCommit_ex3(repo.getHeadBranch().getSha1());
        else {
            pressedCommit=repo.sha1ToCommit_ex3(pressedCommitSha1);
        }
        Branch pressedBranch = repo.branchLambda_ex3(SessionUtils.getBranch(request));
        if(pressedBranch==null)
            pressedBranch=repo.getHeadBranch();
        %>
        <h1>Repository-<%=repoName%></h1>

        <form method="Post" action="MakeNewBranch">
            <label>
                <input type="text" name="newBranch">
            </label>
            <button type="submit">Make New Branch</button>
        </form>


        <h2>Branches</h2>
        <form method="Post" action="BranchServlet">
            <input type="hidden" name="branch" value="<%=repo.getHeadBranchName()%>">
            <button type="submit">Head Branch : <%=repo.getHeadBranchName()%></button>
        </form>
        <%for(Branch branch:repo.getBranches()) {
        %>
        <form method="Post" action="BranchServlet">
            <input type="hidden" name="branch" value="<%=branch.getName()%>">
            <button type="submit">Branch : <%=branch.getName()%></button>
        </form>
        <%}%>
        <div class="col-md-4">
            <div class="col-md-8">
                <form method="Post" action="WcServlet">
                    <button type="submit">WC</button>
                </form>
            </div>

            <h2>Commits</h2>
            <%for(Commit commit:repo.getBranchCommits(pressedBranch)) {
            %>
            <form method="Post" action="commitServlet">
                <input type="hidden" name="commitSha1" value="<%=commit.getSha1()%>">
                 <p>Sha1:   <%=commit.getSha1()%></p>
                <p>Date:   <%=commit.getDateAndTime().getDate()%></p>
                <p>Message: <%=commit.getCommitPurposeMSG()%></p>
                <p>Modifier: <%=commit.getNameOfModifier()%></p>
                <button type="submit">Show commit</button>
            </form>
            <%}%>
            <h2>Files of commit</h2>
            <ul>
            <%for(String fileDetails :repo.commitFileNames_ex3(pressedCommit)) {%>
                <li><%=fileDetails%></li>
            <%}%>
            </ul>

        </div>



    </body>
</html>
