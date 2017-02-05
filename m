Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36185 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdBEMeK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2017 07:34:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>, Stefan Roese <sr@denx.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:adc:spear Move out of staging.
Date: Sun,  5 Feb 2017 12:34:00 +0000
Message-Id: <20170205123400.10958-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are some unanswered questions due to disagreements between the code
and various datasheets (including between different datasheets for the same
part).

I don't think that is necessarily a reason to keep it in staging however.
I'm partly posting this patch inorder to reignite debate and with a bit
of luck find someone who has one of these to test!

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig                   | 11 +++++++++++
 drivers/iio/adc/Makefile                  |  1 +
 drivers/{staging => }/iio/adc/spear_adc.c |  0
 drivers/staging/iio/adc/Kconfig           | 10 ----------
 drivers/staging/iio/adc/Makefile          |  1 -
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dedae7adbce9..789a5fb7c0be 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -494,6 +494,17 @@ config ROCKCHIP_SARADC
 	  To compile this driver as a module, choose M here: the
 	  module will be called rockchip_saradc.
 
+config SPEAR_ADC
+	tristate "ST SPEAr ADC"
+	depends on PLAT_SPEAR || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Say yes here to build support for the integrated ADC inside the
+	  ST SPEAr SoC. Provides direct access via sysfs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called spear_adc.
+
 config STM32_ADC_CORE
 	tristate "STMicroelectronics STM32 adc core"
 	depends on ARCH_STM32 || COMPILE_TEST
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d0012620cd1c..19e48af43b97 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -46,6 +46,7 @@ obj-$(CONFIG_QCOM_SPMI_IADC) += qcom-spmi-iadc.o
 obj-$(CONFIG_QCOM_SPMI_VADC) += qcom-spmi-vadc.o
 obj-$(CONFIG_RCAR_GYRO_ADC) += rcar-gyroadc.o
 obj-$(CONFIG_ROCKCHIP_SARADC) += rockchip_saradc.o
+obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
 obj-$(CONFIG_STX104) += stx104.o
 obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
 obj-$(CONFIG_STM32_ADC) += stm32-adc.o
diff --git a/drivers/staging/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
similarity index 100%
rename from drivers/staging/iio/adc/spear_adc.c
rename to drivers/iio/adc/spear_adc.c
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index deff89973d53..0ad5c44042b2 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -92,14 +92,4 @@ config LPC32XX_ADC
 	  activate only one via device tree selection.  Provides direct access
 	  via sysfs.
 
-config SPEAR_ADC
-	tristate "ST SPEAr ADC"
-	depends on PLAT_SPEAR || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Say yes here to build support for the integrated ADC inside the
-	  ST SPEAr SoC. Provides direct access via sysfs.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called spear_adc.
 endmenu
diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
index ac09485923b6..e7098dedeb75 100644
--- a/drivers/staging/iio/adc/Makefile
+++ b/drivers/staging/iio/adc/Makefile
@@ -11,4 +11,3 @@ obj-$(CONFIG_AD7816) += ad7816.o
 obj-$(CONFIG_AD7192) += ad7192.o
 obj-$(CONFIG_AD7280) += ad7280a.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
-obj-$(CONFIG_SPEAR_ADC) += spear_adc.o
-- 
2.11.1

