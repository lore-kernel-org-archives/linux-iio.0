Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59093 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab2DEQB7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Apr 2012 12:01:59 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 4/5] IIO: AT91: ADC: Add support for the AT91SAM9M10G45-EK board
Date: Thu,  5 Apr 2012 18:01:23 +0200
Message-Id: <1333641684-20325-5-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the necessary logic and the required platform_data to
support the ADC present in the AT91SAM9M10G45-EK board from Atmel. It
only supports software triggers for now.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45_devices.c |   61 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   11 +++++
 drivers/staging/iio/adc/at91_adc.c       |   12 ++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 698479f..7827139 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -19,6 +19,8 @@
 #include <linux/i2c-gpio.h>
 #include <linux/atmel-mci.h>
 
+#include <linux/platform_data/at91_adc.h>
+
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
@@ -1202,6 +1204,65 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
 
 
 /* --------------------------------------------------------------------
+ *  ADC
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91_ADC) || defined(CONFIG_AT91_ADC_MODULE)
+static struct at91_adc_data adc_data;
+
+static struct resource adc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9G45_BASE_TSC,
+		.end	= AT91SAM9G45_BASE_TSC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9G45_ID_TSC,
+		.end	= AT91SAM9G45_ID_TSC,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device at91_adc_device = {
+	.name		= "at91_adc",
+	.id		= -1,
+	.dev		= {
+				.platform_data	= &adc_data,
+	},
+	.resource	= adc_resources,
+	.num_resources	= ARRAY_SIZE(adc_resources),
+};
+
+void __init at91_add_device_adc(struct at91_adc_data *data)
+{
+	if (!data)
+		return;
+
+	if (test_bit(0, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD20, 0);
+	if (test_bit(1, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD21, 0);
+	if (test_bit(2, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD22, 0);
+	if (test_bit(3, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD23, 0);
+	if (test_bit(4, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD24, 0);
+	if (test_bit(5, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD25, 0);
+	if (test_bit(6, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD26, 0);
+	if (test_bit(7, &data->channels_used))
+		at91_set_gpio_input(AT91_PIN_PD27, 0);
+
+	adc_data = *data;
+	platform_device_register(&at91_adc_device);
+}
+#else
+void __init at91_add_device_adc(struct at91_adc_data *data) {}
+#endif
+
+/* --------------------------------------------------------------------
  *  RTT
  * -------------------------------------------------------------------- */
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index e1bea73..dca46c8 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -27,6 +27,8 @@
 #include <linux/atmel-mci.h>
 #include <linux/delay.h>
 
+#include <linux/platform_data/at91_adc.h>
+
 #include <mach/hardware.h>
 #include <video/atmel_lcdc.h>
 #include <media/soc_camera.h>
@@ -314,6 +316,13 @@ static struct at91_tsadcc_data ek_tsadcc_data = {
 	.ts_sample_hold_time	= 0x0a,
 };
 
+/*
+ * ADCs
+ */
+static struct at91_adc_data ek_adc_data = {
+	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
+	.vref = 3300,
+};
 
 /*
  * GPIO Buttons
@@ -479,6 +488,8 @@ static void __init ek_board_init(void)
 	at91_add_device_lcdc(&ek_lcdc_data);
 	/* Touch Screen */
 	at91_add_device_tsadcc(&ek_tsadcc_data);
+	/* ADC */
+	at91_add_device_adc(&ek_adc_data);
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* AC97 */
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
index c76516a..04bac43 100644
--- a/drivers/staging/iio/adc/at91_adc.c
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -56,6 +56,13 @@ struct at91_adc_state {
 	wait_queue_head_t	wq_data_avail;
 };
 
+static struct at91_adc_desc at91_adc_desc_sam9g45 = {
+	.clock = 13200000,
+	.clock_name = "tsc_clk",
+	.num_channels = 8,
+	.startup_time = 40,
+};
+
 static struct at91_adc_desc at91_adc_desc_sam9g20 = {
 	.clock = 5000000,
 	.clock_name = "adc_clk",
@@ -70,6 +77,11 @@ static int at91_adc_select_soc(struct at91_adc_state *st)
 		return 0;
 	}
 
+	if (cpu_is_at91sam9g45()) {
+		st->desc = &at91_adc_desc_sam9g45;
+		return 0;
+	}
+
 	return -ENODEV;
 }
 
-- 
1.7.5.4

