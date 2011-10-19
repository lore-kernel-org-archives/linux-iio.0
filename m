Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59438 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756580Ab1JSQTY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 12:19:24 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
Date: Wed, 19 Oct 2011 18:18:54 +0200
Message-Id: <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |   44 ++++++++++++++++++++++++++++++
 arch/arm/mach-at91/board-sam9g20ek.c     |   12 ++++++++
 2 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 39f81f4..4f5e0f9 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1312,6 +1312,50 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
 void __init at91_add_device_cf(struct at91_cf_data * data) {}
 #endif
 
+/* --------------------------------------------------------------------
+ *  ADCs
+ * -------------------------------------------------------------------- */
+
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
+	.name		= "at91adc",
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
+	at91_set_A_periph(AT91_PIN_PC0, 0);
+	at91_set_A_periph(AT91_PIN_PC1, 0);
+	at91_set_A_periph(AT91_PIN_PC2, 0);
+	at91_set_A_periph(AT91_PIN_PC3, 0);
+
+	adc_data = *data;
+	platform_device_register(&at91_adc_device);
+}
+
+
 /* -------------------------------------------------------------------- */
 /*
  * These devices are always present and don't need any board-specific
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 817f59d..fd373c3 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -314,6 +314,16 @@ static void __init ek_add_device_buttons(void)
 static void __init ek_add_device_buttons(void) {}
 #endif
 
+/*
+ * ADCs
+ */
+
+static struct at91_adc_data ek_adc_data = {
+	.channels = 4,
+	.adc_clock = 5000000,
+	.startup_time = 10,
+};
+
 #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
 static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
 	REGULATOR_SUPPLY("AVDD", "0-001b"),
@@ -389,6 +399,8 @@ static void __init ek_board_init(void)
 	ek_add_device_gpio_leds();
 	/* Push Buttons */
 	ek_add_device_buttons();
+	/* ADCs */
+	at91_add_device_adc(&ek_adc_data);
 	/* PCK0 provides MCLK to the WM8731 */
 	at91_set_B_periph(AT91_PIN_PC1, 0);
 	/* SSC (for WM8731) */
-- 
1.7.4.1

