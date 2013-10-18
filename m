Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	sachin.kamat@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/4] iio: adc: nau7802: Include linux/of.h header
Date: Fri, 18 Oct 2013 17:34:55 +0530
Message-Id: <1382097897-12818-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
References: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

'of_match_ptr' is defined in linux/of.h. Include it explicitly to
avoid build breakage in the future.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/nau7802.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index bdf0346..adff9cb 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/wait.h>
 #include <linux/log2.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
1.7.9.5
