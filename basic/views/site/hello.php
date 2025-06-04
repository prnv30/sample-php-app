<?php
/** @var string $hostname */

$this->title = 'Hello';
?>
<div class="site-hello text-center" style="margin-top: 50px;">
    <div class="card" style="max-width: 400px; margin: 0 auto; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Hello!</h4>
        </div>
        <div class="card-body">
            <p class="lead">You are visiting this page from:</p>
            <h5><span class="badge bg-secondary"><?= htmlspecialchars($hostname) ?></span></h5>
        </div>
    </div>
</div>
