Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 3/4] iio: adc: ti-adc081c: Include linux/of.h header
Date: Fri, 18 Oct 2013 17:34:56 +0530
Message-Id: <1382097897-12818-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
References: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'of_match_ptr' is defined in linux/of.h. Include it explicitly to
avoid build breakage in the future.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/ti-adc081c.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index ee5f72b..b3a82b4 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
-- 
1.7.9.5
