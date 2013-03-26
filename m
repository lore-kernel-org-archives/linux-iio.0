Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	jic23@cam.ac.uk,
	ch.naveen@samsung.com,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 2/2] iio: exynos_adc: Fix a typo in Kconfig help text
Date: Tue, 26 Mar 2013 15:12:11 +0530
Message-Id: <1364290931-25772-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org>
References: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Fixes a trivial typo.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ab0767e6..718084f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -108,7 +108,7 @@ config EXYNOS_ADC
 	depends on OF
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
-	  of SoCs for drivers such as the touchscreen and hwmon to use to share
+	  of SoCs for drivers such as the touchscreen and hwmon to use and share
 	  this resource.
 
 config LP8788_ADC
-- 
1.7.4.1
