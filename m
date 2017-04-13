Return-Path: <SRS0=SLc5=3V=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: light: apds9960: add system-wide suspend
Date: Wed, 12 Apr 2017 19:16:57 -0700
Message-Id: <20170413021657.30434-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

APDS9960 can safefully force runtime suspend if the system wants
to enter system-wide suspend

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/light/apds9960.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a4304edc3e0f..67da1287e987 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1112,6 +1112,8 @@ static int apds9960_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops apds9960_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(apds9960_runtime_suspend,
 			   apds9960_runtime_resume, NULL)
 };
-- 
2.11.0
