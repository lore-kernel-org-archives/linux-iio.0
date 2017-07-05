Return-Path: <SRS0=3XMF=6I=perches.com=joe@kernel.org>
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: pressure: zpa2326: Add newlines to logging macros
Date: Wed,  5 Jul 2017 03:25:58 -0700
Message-Id: <c8c4d3eeb69a38742eced35365a61db77be7c724.1499250024.git.joe@perches.com>
List-ID: <linux-iio@vger.kernel.org>

Add newlines to the macro definitions and use a more common style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/iio/pressure/zpa2326.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
index c92a95f9f52c..ebfb1de7377f 100644
--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -141,14 +141,14 @@ struct zpa2326_private {
 	struct regulator               *vdd;
 };
 
-#define zpa2326_err(_idev, _format, _arg...) \
-	dev_err(_idev->dev.parent, _format, ##_arg)
+#define zpa2326_err(idev, fmt, ...)					\
+	dev_err(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
 
-#define zpa2326_warn(_idev, _format, _arg...) \
-	dev_warn(_idev->dev.parent, _format, ##_arg)
+#define zpa2326_warn(idev, fmt, ...)					\
+	dev_warn(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
 
-#define zpa2326_dbg(_idev, _format, _arg...) \
-	dev_dbg(_idev->dev.parent, _format, ##_arg)
+#define zpa2326_dbg(idev, fmt, ...)					\
+	dev_dbg(idev->dev.parent, fmt "\n", ##__VA_ARGS__)
 
 bool zpa2326_isreg_writeable(struct device *dev, unsigned int reg)
 {
-- 
2.10.0.rc2.1.g053435c
