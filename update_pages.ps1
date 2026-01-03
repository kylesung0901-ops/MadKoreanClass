$files = @(
    "price.html",
    "location.html",
    "event-schedule.html",
    "online-class.html",
    "topik-lecture.html",
    "inquiry-registration.html",
    "partnership.html",
    "goods.html"
)

$headerContent = @"
    <header class="header-area">
        <div class="header-top">
            <div class="container">
                <div class="header-top-wrapper d-flex flex-wrap justify-content-sm-between">
                    <div class="header-top-left mt-10">
                        <ul class="header-meta">
                            <li><a href="mailto://infoedumate@example.com">infoedumate@example.com</a></li>
                        </ul>
                    </div>
                    <div class="header-top-right mt-10">
                        <div class="header-link">
                            <a class="notice" href="notice.html" data-translate="Notice">Notice</a>
                            <a class="login" href="login.html" data-translate="Login">Login</a>
                            <a class="register" href="register.html" data-translate="Register">Register</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="navigation" class="navigation navigation-landscape">
            <div class="container position-relative">
                <div class="row align-items-center">
                    <div class="col-lg-1">
                        <div class="header-logo">
                            <a href="index.html"><img src="assets/images/logo.png"
                                    style="max-height: 80px; width: auto;" alt="MadKoreanClass Logo"></a>
                        </div>
                    </div>
                    <div class="col-lg-9 position-static">
                        <div class="nav-toggle"></div>
                        <nav class="nav-menus-wrapper">
                            <ul class="nav-menu">
                                <li><a href="price.html" data-translate="Price">Price</a></li>
                                <li><a href="location.html" data-translate="Location">Location</a></li>
                                <li><a href="event-schedule.html" data-translate="Event Schedule">Event Schedule</a></li>
                                <li><a href="online-class.html" data-translate="Online Class">Online Class</a></li>
                                <li><a href="topik-lecture.html" data-translate="TOPIK Online Lecture">TOPIK Online Lecture</a></li>
                                <li><a href="inquiry-registration.html" data-translate="Inquiry & Registration">Inquiry & Registration</a></li>
                                <li><a href="partnership.html" data-translate="Partnership Business">Partnership Business</a></li>
                                <li><a href="goods.html" data-translate="Goods Sale">Goods Sale</a></li>
                            </ul>
                        </nav>
                    </div>
                    <div class="col-lg-2 d-flex align-items-center justify-content-end" style="gap: 10px;">
                        <div class="language-toggle">
                            <button id="langToggle" onclick="toggleLanguage()"
                                style="background: #667eea; color: white; border: none; padding: 8px 16px; border-radius: 5px; font-weight: 600; cursor: pointer; transition: all 0.3s; font-size: 14px;">
                                <span id="currentLang">EN</span>
                            </button>
                        </div>
                        <div class="header-search">
                            <form action="#" style="display: flex; align-items: center;">
                                <input type="text" placeholder="Search" data-translate="Search"
                                    style="padding: 8px 12px; border: 1px solid #ddd; border-radius: 5px 0 0 5px; outline: none; width: 120px;">
                                <button
                                    style="padding: 8px 12px; background: #667eea; color: white; border: none; border-radius: 0 5px 5px 0; cursor: pointer;"><i
                                        class="fas fa-search"></i></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>
"@

$cssLink = '    <link rel="stylesheet" href="assets/css/custom-nav.css">'
$jsScript = '    <script src="assets/js/translation.js"></script>'

foreach ($file in $files) {
    $path = "c:\vibecoding_work\madkoreanclass\$file"
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        
        # Inject CSS if not already present
        if ($content -notmatch "custom-nav.css") {
             $content = $content -replace '</head>', "$cssLink`n</head>"
        }

        
        # Replace Header
        $startMarker = '<!--====== Header Start ======-->'
        $endMarker = '<!--====== Header Ends ======-->'
        
        $startIndex = $content.IndexOf($startMarker)
        $endIndex = $content.IndexOf($endMarker, $startIndex)
        
        if ($startIndex -ge 0 -and $endIndex -ge 0) {
            $endIndex += $endMarker.Length
            $before = $content.Substring(0, $startIndex)
            $after = $content.Substring($endIndex)
            $content = $before + "$startMarker`n$headerContent`n$endMarker" + $after
        }
        
        # Inject JS if not already present
        if ($content -notmatch "translation.js") {
            $content = $content -replace '</body>', "$jsScript`n</body>"
        }
        
        Set-Content -Path $path -Value $content -Encoding UTF8
        Write-Host "Updated $file"
    } else {
        Write-Host "File not found: $file"
    }
}
