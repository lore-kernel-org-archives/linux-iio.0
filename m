Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: [PATCH 11/12] staging: iio: tsl2x7x_core: Fix sparse warning
Date: Thu,  5 Sep 2013 14:59:56 +0530
Message-Id: <1378373397-22919-11-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Silences the following warning:
drivers/staging/iio/light/tsl2x7x_core.c:553:70:
warning: Using plain integer as NULL pointer

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: J. August Brenner <jbrenner@taosinc.com>
---
 drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index aa86725..3439d37 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -550,7 +550,7 @@ prox_poll_err:
 static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
 {
 	/* If Operational settings defined elsewhere.. */
-	if (chip->pdata && chip->pdata->platform_default_settings != 0)
+	if (chip->pdata && chip->pdata->platform_default_settings)
 		memcpy(&(chip->tsl2x7x_settings),
 			chip->pdata->platform_default_settings,
 			sizeof(tsl2x7x_default_settings));
-- 
1.7.9.5
