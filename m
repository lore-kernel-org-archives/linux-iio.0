Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:34013 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdFQVA1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Jun 2017 17:00:27 -0400
Received: by mail-vk0-f68.google.com with SMTP id 191so4859977vko.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Jun 2017 14:00:27 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] iio: adc: Kconfig: Append vendor name for IMX7D_ADC
Date: Sat, 17 Jun 2017 18:00:16 -0300
Message-Id: <1497733216-14848-1-git-send-email-festevam@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

To keep IMX7D_ADC text consistent with other iio/adc entries, add
the vendor name to the driver menu text.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/iio/adc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 614fa41..b56c4a1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -322,7 +322,7 @@ config INA2XX_ADC
 	  This driver is mutually exclusive with the HWMON version.
 
 config IMX7D_ADC
-	tristate "IMX7D ADC driver"
+	tristate "Freescale IMX7D ADC driver"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on HAS_IOMEM
 	help
-- 
2.7.4

