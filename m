Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:45297 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755047Ab2EIJGu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 May 2012 05:06:50 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: thomas@free-electrons.com, patrice.vilchez@atmel.com,
	nicolas.ferre@atmel.com, plagnioj@jcrosoft.com
Subject: [PATCH 3/9] ARM: AT91: Add the ADC to the sam9g20ek board
Date: Wed,  9 May 2012 11:06:00 +0200
Message-Id: <1336554366-16957-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1336554366-16957-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds platform data for the AT91 ADC driver support for
the AT91SAM9G20-EK board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260.c         |    8 +++
 arch/arm/mach-at91/at91sam9260_devices.c |   89 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9g20ek.c     |   14 +++++
 3 files changed, 111 insertions(+)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 46f7742..63d4432 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -55,6 +55,13 @@ static struct clk adc_clk = {
 	.pmc_mask	= 1 << AT91SAM9260_ID_ADC,
 	.type		= CLK_TYPE_PERIPHERAL,
 };
+
+static struct clk adc_op_clk = {
+	.name		= "adc_op_clk",
+	.type		= CLK_TYPE_PERIPHERAL,
+	.rate_hz	= 5000000,
+};
+
 static struct clk usart0_clk = {
 	.name		= "usart0_clk",
 	.pmc_mask	= 1 << AT91SAM9260_ID_US0,
@@ -166,6 +173,7 @@ static struct clk *periph_clocks[] __initdata = {
 	&pioB_clk,
 	&pioC_clk,
 	&adc_clk,
+	&adc_op_clk,
 	&usart0_clk,
 	&usart1_clk,
 	&usart2_clk,
diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 5652dde..2125851 100644
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
@@ -1369,6 +1371,93 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 void __init at91_add_device_cf(struct at91_cf_data * data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  ADCs
+ * -------------------------------------------------------------------- */
+
+#if IS_ENABLED(CONFIG_AT91_ADC)
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
+static struct at91_adc_trigger at91_adc_triggers[] = {
+	[0] = {
+		.name = "timer-counter-0",
+		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
+	},
+	[1] = {
+		.name = "timer-counter-1",
+		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
+	},
+	[2] = {
+		.name = "timer-counter-2",
+		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
+	},
+	[3] = {
+		.name = "external",
+		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
+		.is_external = true,
+	},
+};
+
+static struct at91_adc_reg_desc at91_adc_register_g20 = {
+	.channel_base = AT91_ADC_CHR(0),
+	.drdy_mask = AT91_ADC_DRDY,
+	.status_register = AT91_ADC_SR,
+	.trigger_register = AT91_ADC_MR,
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
+	if (data->use_external_triggers)
+		at91_set_A_periph(AT91_PIN_PA22, 0);
+
+	data->num_channels = 4;
+	data->startup_time = 10;
+	data->registers = &at91_adc_register_g20;
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
 /* -------------------------------------------------------------------- */
 /*
  * These devices are always present and don't need any board-specific
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 8923ec9..291b0fe 100644
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
@@ -318,6 +320,16 @@ static void __init ek_add_device_buttons(void)
 static void __init ek_add_device_buttons(void) {}
 #endif
 
+/*
+ * ADCs
+ */
+
+static struct at91_adc_data ek_adc_data = {
+	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
+	.use_external_triggers = true,
+	.vref = 3300,
+};
+
 #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
 static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
 	REGULATOR_SUPPLY("AVDD", "0-001b"),
@@ -393,6 +405,8 @@ static void __init ek_board_init(void)
 	ek_add_device_gpio_leds();
 	/* Push Buttons */
 	ek_add_device_buttons();
+	/* ADCs */
+	at91_add_device_adc(&ek_adc_data);
 	/* PCK0 provides MCLK to the WM8731 */
 	at91_set_B_periph(AT91_PIN_PC1, 0);
 	/* SSC (for WM8731) */
-- 
1.7.9.5

