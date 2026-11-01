$ErrorActionPreference='Stop'
Add-Type -AssemblyName System.Drawing
$root=Split-Path -Parent $PSScriptRoot
foreach($size in @(180,192,512)) {
    $bitmap=New-Object Drawing.Bitmap($size,$size)
    $g=[Drawing.Graphics]::FromImage($bitmap)
    $g.SmoothingMode=[Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([Drawing.ColorTranslator]::FromHtml('#6056e8'))
    $g.ScaleTransform($size/192.0,$size/192.0)
    $white=[Drawing.Brushes]::White
    $points=[Drawing.PointF[]]@((New-Object Drawing.PointF(40,61)),(New-Object Drawing.PointF(67,58)),(New-Object Drawing.PointF(96,68)),(New-Object Drawing.PointF(125,58)),(New-Object Drawing.PointF(152,61)),(New-Object Drawing.PointF(152,136)),(New-Object Drawing.PointF(125,133)),(New-Object Drawing.PointF(96,143)),(New-Object Drawing.PointF(67,133)),(New-Object Drawing.PointF(40,136)))
    $g.FillPolygon($white,$points)
    $pen=New-Object Drawing.Pen([Drawing.ColorTranslator]::FromHtml('#b8b2ff'),5)
    $g.DrawLine($pen,96,68,96,143)
    $filename=if($size -eq 180){'apple-touch-icon.png'}else{"icon-$size.png"}
    $bitmap.Save((Join-Path $root "frontend/public/$filename"),[Drawing.Imaging.ImageFormat]::Png)
    $pen.Dispose();$g.Dispose();$bitmap.Dispose()
}
