Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44825 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab2DRNeS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:34:18 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 3/6] ARM: AT91: Add the ADC to the sam9g20ek board
Date: Wed, 18 Apr 2012 15:33:53 +0200
Message-Id: <1334756036-15944-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds platform data for the AT91 ADC driver support for
the AT91SAM9G20-EK board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |   53 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9g20ek.c     |   13 +++++++
 drivers/staging/iio/adc/at91_adc.c       |    1 -
 3 files changed, 66 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 5652dde..758c629 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -17,6 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/i2c-gpio.h>
 
+#include <linux/platform_data/at91_adc.h>
+
 #include <mach/board.h>
 #include <mach/cpu.h>
 #include <mach/at91sam9260.h>
@@ -1369,6 +1371,57 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 void __init at91_add_device_cf(struct at91_cf_data * data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  ADCs
+ * -------------------------------------------------------------------- */
+
+#if defined(CONFIG_AT91_ADC) || defined(CONFIG_AT91_ADC_MODULE)
+static struct at91_adc_data adc_data;
+
+static struct resource adc_resources[] = {
+	[0] = {
+		.start	= AT91SAM9260_BASE_ADC,
+		.end	= AT91SAM9260_BASE_ADC + SZ_16K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AT91SAM9260_ID_ADC,
+		.end	= AT91SAM9260_ID_ADC,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device at91_adc_device = {
+	.name		= "at91_adc",
+	.id		= -1,
+	.dev		= {
+				.platform_data		= &adc_data,
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
+		at91_set_A_periph(AT91_PIN_PC0, 0);
+	if (test_bit(1, &data->channels_used))
+		at91_set_A_periph(AT91_PIN_PC1, 0);
+	if (test_bit(2, &data->channels_used))
+		at91_set_A_periph(AT91_PIN_PC2, 0);
+	if (test_bit(3, &data->channels_used))
+		at91_set_A_periph(AT91_PIN_PC3, 0);
+
+	adc_data = *data;
+	platform_device_register(&at91_adc_device);
+}
+#else
+void __init at91_add_device_adc(struct at91_adc_data *data) {}
+#endif
+
 /* -------------------------------------------------------------------- */
 /*
  * These devices are always present and don't need any board-specific
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 8923ec9..2ce4e26 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -32,6 +32,8 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/platform_data/at91_adc.h>
+
 #include <mach/hardware.h>
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -318,6 +320,15 @@ static void __init ek_add_device_buttons(void)
 static void __init ek_add_device_buttons(void) {}
 #endif
 
+/*
+ * ADCs
+ */
+
+static struct at91_adc_data ek_adc_data = {
+	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
+	.vref = 3300,
+};
+
 #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
 static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
 	REGULATOR_SUPPLY("AVDD", "0-001b"),
@@ -393,6 +404,8 @@ static void __init ek_board_init(void)
 	ek_add_device_gpio_leds();
 	/* Push Buttons */
 	ek_add_device_buttons();
+	/* ADCs */
+	at91_add_device_adc(&ek_adc_data);
 	/* PCK0 provides MCLK to the WM8731 */
 	at91_set_B_periph(AT91_PIN_PC1, 0);
 	/* SSC (for WM8731) */
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
index 6d14277..9af036a 100644
--- a/drivers/staging/iio/adc/at91_adc.c
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -56,7 +56,6 @@ struct at91_adc_state {
 
 static struct at91_adc_desc at91_adc_desc_sam9g20 = {
 	.clock = 5000000,
-	.clock_name = "adc_clk",
 	.num_channels = 4,
 	.startup_time = 10,
 };
-- 
1.7.5.4

