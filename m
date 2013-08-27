Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:45293 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab3H0L3x (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 07:29:53 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v3 3/6] iio: at91: Use different prescal, startup mask in MR for different IP
Date: Tue, 27 Aug 2013 19:28:49 +0800
Message-Id: <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

For at91 boards, there are different IPs for adc. Different IPs has different
STARTUP & PRESCAL mask in ADC_MR.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_adc.h |    7 +++++--
 drivers/iio/adc/at91_adc.c                 |   11 +++++++++--
 include/linux/platform_data/at91_adc.h     |    4 ++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_adc.h b/arch/arm/mach-at91/include/mach/at91_adc.h
index bea1a20..048a57f 100644
--- a/arch/arm/mach-at91/include/mach/at91_adc.h
+++ b/arch/arm/mach-at91/include/mach/at91_adc.h
@@ -28,9 +28,12 @@
 #define			AT91_ADC_TRGSEL_EXTERNAL	(6 << 1)
 #define		AT91_ADC_LOWRES		(1 << 4)	/* Low Resolution */
 #define		AT91_ADC_SLEEP		(1 << 5)	/* Sleep Mode */
-#define		AT91_ADC_PRESCAL	(0x3f << 8)	/* Prescalar Rate Selection */
+#define		AT91_ADC_PRESCAL_9260	(0x3f << 8)	/* Prescalar Rate Selection */
+#define		AT91_ADC_PRESCAL_9G45	(0xff << 8)
 #define			AT91_ADC_PRESCAL_(x)	((x) << 8)
-#define		AT91_ADC_STARTUP	(0x1f << 16)	/* Startup Up Time */
+#define		AT91_ADC_STARTUP_9260	(0x1f << 16)	/* Startup Up Time */
+#define		AT91_ADC_STARTUP_9G45	(0x7f << 16)
+#define		AT91_ADC_STARTUP_9X5	(0xf << 16)
 #define			AT91_ADC_STARTUP_(x)	((x) << 16)
 #define		AT91_ADC_SHTIM		(0xf  << 24)	/* Sample & Hold Time */
 #define			AT91_ADC_SHTIM_(x)	((x) << 24)
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 49dd751..bccc407 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -678,8 +678,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	shtim = round_up((st->sample_hold_time * adc_clk_khz /
 			  1000) - 1, 1);
 
-	reg = AT91_ADC_PRESCAL_(prsc) & AT91_ADC_PRESCAL;
-	reg |= AT91_ADC_STARTUP_(ticks) & AT91_ADC_STARTUP;
+	reg = AT91_ADC_PRESCAL_(prsc) & st->registers->mr_prescal_mask;
+	reg |= AT91_ADC_STARTUP_(ticks) & st->registers->mr_startup_mask;
 	if (st->low_res)
 		reg |= AT91_ADC_LOWRES;
 	if (st->sleep_mode)
@@ -756,6 +756,8 @@ static struct at91_adc_caps at91sam9260_caps = {
 		.drdy_mask = AT91_ADC_DRDY,
 		.status_register = AT91_ADC_SR,
 		.trigger_register = AT91_ADC_TRGR_9260,
+		.mr_prescal_mask = AT91_ADC_PRESCAL_9260,
+		.mr_startup_mask = AT91_ADC_STARTUP_9260,
 	},
 };
 
@@ -765,6 +767,8 @@ static struct at91_adc_caps at91sam9g45_caps = {
 		.drdy_mask = AT91_ADC_DRDY,
 		.status_register = AT91_ADC_SR,
 		.trigger_register = AT91_ADC_TRGR_9G45,
+		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
+		.mr_startup_mask = AT91_ADC_STARTUP_9G45,
 	},
 };
 
@@ -774,6 +778,9 @@ static struct at91_adc_caps at91sam9x5_caps = {
 		.drdy_mask = AT91_ADC_SR_DRDY_9X5,
 		.status_register = AT91_ADC_SR_9X5,
 		.trigger_register = AT91_ADC_TRGR_9X5,
+		/* prescal mask is same as 9G45 */
+		.mr_prescal_mask = AT91_ADC_PRESCAL_9G45,
+		.mr_startup_mask = AT91_ADC_STARTUP_9X5,
 	},
 };
 
diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
index e15745b..b3ca1e9 100644
--- a/include/linux/platform_data/at91_adc.h
+++ b/include/linux/platform_data/at91_adc.h
@@ -14,12 +14,16 @@
 			(Interruptions registers mostly)
  * @status_register:	Offset of the Interrupt Status Register
  * @trigger_register:	Offset of the Trigger setup register
+ * @mr_prescal_mask:	Mask of the PRESCAL field in the adc MR register
+ * @mr_startup_mask:	Mask of the STARTUP field in the adc MR register
  */
 struct at91_adc_reg_desc {
 	u8	channel_base;
 	u32	drdy_mask;
 	u8	status_register;
 	u8	trigger_register;
+	u32	mr_prescal_mask;
+	u32	mr_startup_mask;
 };
 
 /**
-- 
1.7.10

