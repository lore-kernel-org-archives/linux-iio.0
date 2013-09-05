Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	sachin.kamat@linaro.org,
	jic23@kernel.org,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 12/12] staging: iio: hmc5843: Fix a trivial typo
Date: Thu,  5 Sep 2013 14:59:57 +0530
Message-Id: <1378373397-22919-12-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Add a missing closing brace.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d2748c3..67c1ce7 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -730,6 +730,6 @@ static struct i2c_driver hmc5843_driver = {
 };
 module_i2c_driver(hmc5843_driver);
 
-MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com");
+MODULE_AUTHOR("Shubhrajyoti Datta <shubhrajyoti@ti.com>");
 MODULE_DESCRIPTION("HMC5843/5883/5883L driver");
 MODULE_LICENSE("GPL");
-- 
1.7.9.5
