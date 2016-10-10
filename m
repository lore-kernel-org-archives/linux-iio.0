Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org
Subject: [PATCH v2 6/8] staging: iio: isl29018: rename description in Kconfig for consistency
Date: Mon, 10 Oct 2016 03:20:00 -0400
Message-Id: <1476084002-29683-7-git-send-email-masneyb@onstation.org>
In-Reply-To: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Rename description from "ISL 29018" to "Intersil 29018" in Kconfig for
consistency with other drivers in mainline.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig
index ca8d6e6..5e4e77e 100644
--- a/drivers/staging/iio/light/Kconfig
+++ b/drivers/staging/iio/light/Kconfig
@@ -4,7 +4,7 @@
 menu "Light sensors"
 
 config SENSORS_ISL29018
-	tristate "ISL 29018 light and proximity sensor"
+	tristate "Intersil 29018 light and proximity sensor"
 	depends on I2C
 	select REGMAP_I2C
 	default n
-- 
2.5.5
