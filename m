Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:47155 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab2EINCk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 09:02:40 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	plagnioj@jcrosoft.com, grant.likely@secretlab.ca
Subject: [PATCH 4/9] AT91: ADC: Add support for the AT91SAM9M10G45-EK board
Date: Wed,  9 May 2012 15:02:03 +0200
Message-Id: <1336568528-29877-5-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336568528-29877-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds platform data for the AT91 ADC driver support for
the AT91SAM9M10G45-EK board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9g45.c         |    9 +++
 arch/arm/mach-at91/at91sam9g45_devices.c |  101 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9m10g45ek.c  |   12 ++++
 3 files changed, 122 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index d222f83..30865c6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -176,6 +176,12 @@ static struct clk vdec_clk = {
 	.type		= CLK_TYPE_PERIPHERAL,
 };
 
+static struct clk adc_op_clk = {
+	.name		= "adc_op_clk",
+	.type		= CLK_TYPE_PERIPHERAL,
+	.rate_hz	= 13200000,
+};
+
 static struct clk *periph_clocks[] __initdata = {
 	&pioA_clk,
 	&pioB_clk,
@@ -204,6 +210,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&isi_clk,
 	&udphs_clk,
 	&mmc1_clk,
+	&adc_op_clk,
 	// irq0
 };
 
@@ -242,6 +249,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
 	CLKDEV_CON_ID("pioC", &pioC_clk),
 	CLKDEV_CON_ID("pioD", &pioDE_clk),
 	CLKDEV_CON_ID("pioE", &pioDE_clk),
+	/* Fake adc clock */
+	CLKDEV_CON_ID("adc_clk", &tsc_clk),
 };
 
 static struct clk_lookup usart_clocks_lookups[] = {
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 6b008ae..0c6d9fe 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -19,9 +19,12 @@
 #include <linux/i2c-gpio.h>
 #include <linux/atmel-mci.h>
 
+#include <linux/platform_data/at91_adc.h>
+
 #include <linux/fb.h>
 #include <video/atmel_lcdc.h>
 
+#include <mach/at91_adc.h>
 #include <mach/board.h>
 #include <mach/at91sam9g45.h>
 #include <mach/at91sam9g45_matrix.h>
@@ -1207,6 +1210,104 @@ void __init at91_add_device_tsadcc(struct at91_tsadcc_data *data) {}
 
 
 /* --------------------------------------------------------------------
+ *  ADC
+ * -------------------------------------------------------------------- */
+
+#if IS_ENABLED(CONFIG_AT91_ADC)
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
+static struct at91_adc_trigger at91_adc_triggers[] = {
+	[0] = {
+		.name = "external-rising",
+		.value = 1,
+		.is_external = true,
+	},
+	[1] = {
+		.name = "external-falling",
+		.value = 2,
+		.is_external = true,
+	},
+	[2] = {
+		.name = "external-any",
+		.value = 3,
+		.is_external = true,
+	},
+	[3] = {
+		.name = "continuous",
+		.value = 6,
+		.is_external = false,
+	},
+};
+
+static struct at91_adc_reg_desc at91_adc_register_g45 = {
+	.channel_base = AT91_ADC_CHR(0),
+	.drdy_mask = AT91_ADC_DRDY,
+	.status_register = AT91_ADC_SR,
+	.trigger_register = 0x08,
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
+	if (data->use_external_triggers)
+		at91_set_A_periph(AT91_PIN_PD28, 0);
+
+	data->num_channels = 8;
+	data->startup_time = 40;
+	data->registers = &at91_adc_register_g45;
+	data->trigger_number = 4;
+	data->trigger_list = at91_adc_triggers;
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
index c88e908..337abd2 100644
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
@@ -315,6 +317,14 @@ static struct at91_tsadcc_data ek_tsadcc_data = {
 	.ts_sample_hold_time	= 0x0a,
 };
 
+/*
+ * ADCs
+ */
+static struct at91_adc_data ek_adc_data = {
+	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
+	.use_external_triggers = true,
+	.vref = 3300,
+};
 
 /*
  * GPIO Buttons
@@ -480,6 +490,8 @@ static void __init ek_board_init(void)
 	at91_add_device_lcdc(&ek_lcdc_data);
 	/* Touch Screen */
 	at91_add_device_tsadcc(&ek_tsadcc_data);
+	/* ADC */
+	at91_add_device_adc(&ek_adc_data);
 	/* Push Buttons */
 	ek_add_device_buttons();
 	/* AC97 */
-- 
1.7.9.5

