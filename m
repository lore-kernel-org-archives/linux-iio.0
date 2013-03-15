Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:12845 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903Ab3COQ0C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Mar 2013 12:26:02 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, lars@metafoo.de
Subject: [PATCH 1/2] iio: adc: Kconfig: exynos_adc depends on CONFIG_OF
Date: Fri, 15 Mar 2013 21:53:40 +0530
Message-id: <1363364620-23597-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As the exynos_adc driver only supports device tree registration.
Making driver depend on CONFIG_OF solves possible errors during probe.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
Discussion thread for this patch can be found at
http://www.gossamer-threads.com/lists/linux/kernel/1693284?page=last

 drivers/iio/adc/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a40d3c2..9c45c0f 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -105,6 +105,7 @@ config AT91_ADC
 
 config EXYNOS_ADC
 	bool "Exynos ADC driver support"
+	depends on OF
 	help
 	  Core support for the ADC block found in the Samsung EXYNOS series
 	  of SoCs for drivers such as the touchscreen and hwmon to use to share
-- 
1.7.9.5

