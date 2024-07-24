function Get-UserCommits {
    param (
        [string]$Username,
        [string]$Token,
        [int]$DaysBack
    )

    if (-not $Username) {
        Write-Host "Error: Username parameter is required."
        return
    }
    if (-not $Token) {
        Write-Host "Error: Token parameter is required."
        return
    }
    if ($DaysBack -le 0) {
        Write-Host "Error: DaysBack parameter must be a positive integer."
        return
    }

    $sinceDate = (Get-Date).AddDays(-$DaysBack).ToString("yyyy-MM-ddTHH:mm:ssZ")
    $reposApiUrl = "https://api.github.com/users/$Username/repos"
    $headers = @{
        "User-Agent" = "Github Powershell"
        "Authorization" = "token $Token"
    }

    try {
        $reposResponse = Invoke-RestMethod -Uri $reposApiUrl -Headers $headers -Method Get
    }
    catch {
        Write-Host "Error: Unable to retrieve repositories. Check your token and network connection."
        return
    }

    if ($reposResponse.Count -eq 0) {
        Write-Host "No repositories found for user $Username."
        return
    }

    $totalCommits = 0
    foreach ($repo in $reposResponse) {
        $repoName = $repo.name
        $repoCommitsUrl = "https://api.github.com/repos/$Username/$repoName/commits?author=$Username&since=$sinceDate"
        try {
            $commitsResponse = Invoke-RestMethod -Uri $repoCommitsUrl -Headers $headers -Method Get
            $commitCount = $commitsResponse.Count
        }
        catch {
            Write-Host "Error: Unable to retrieve commits for repository $repoName."
            $commitCount = 0
        }
        $totalCommits += $commitCount
    }
    Write-Host "$Username has made $totalCommits commits in the last $DaysBack days across their repositories." -ForegroundColor Green
}