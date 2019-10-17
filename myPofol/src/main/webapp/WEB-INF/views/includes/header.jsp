<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>My Portfolio</title>

<!-- JQUERY -->	
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<!-- Bootstrap core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" type="text/css">

<!-- Custom styles for this template -->
<link href="/resources/css/small-business.css" rel="stylesheet"
	type="text/css">

<!-- My CSS -->
<link href="/resources/commons/mycss.css" rel="stylesheet"
	type="text/css">

<!-- https://kit.fontawesome.com/50f9917a32.js -->
<script src="https://kit.fontawesome.com/50f9917a32.js"></script>


</head>

<body>

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="/board/list">My Portfolio</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="/board/list">Board</a>
					</li>
					<sec:authorize access="isAnonymous()">
						<li class="nav-item"><a class="nav-link" href="/login">Login</a>
						</li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="nav-item"><a class="nav-link" href="/logout">Logout</a></li>
					</sec:authorize>
					<sec:authorize access="isAnonymous()">
						<li class="nav-item"><a class="nav-link" href="/join">Join</a>
						</li>
					</sec:authorize>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Page Content -->
	<div class="container">