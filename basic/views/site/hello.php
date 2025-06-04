<!DOCTYPE html>
<html>
<head>
    <title>Hello</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container text-center" style="margin-top: 50px;">
    <div class="card" style="max-width: 400px; margin: 0 auto;">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Hello!</h4>
        </div>
        <div class="card-body">
            <p class="lead">You are visiting this page from:</p>
            <h5><span class="badge bg-secondary"><?= htmlspecialchars($hostname) ?></span></h5>
        </div>
    </div>
</div>
</body>
</html>
