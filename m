Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: rachna@ti.com,
	jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 2/2] iio: adc: Update ti_am335x_adc Kconfig entry
Date: Tue, 23 Jul 2013 14:16:52 +0530
Message-Id: <1374569212-26143-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1374569212-26143-1-git-send-email-sachin.kamat@linaro.org>
References: <1374569212-26143-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Make the string more readable to distinguish it from other TI ADCs.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dd6bd1b..f725b45 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -165,7 +165,7 @@ config TI_ADC081C
 	  called ti-adc081c.
 
 config TI_AM335X_ADC
-	tristate "TI's ADC driver"
+	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC
 	help
 	  Say yes here to build support for Texas Instruments ADC
-- 
1.7.9.5
