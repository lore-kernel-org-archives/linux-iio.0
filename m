Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:53636 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978Ab1KCKLf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2011 06:11:35 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Date: Thu,  3 Nov 2011 11:11:08 +0100
Message-Id: <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
 <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/include/mach/board.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index ed544a0..b837da8 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -207,4 +207,26 @@ extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
+/* ADC */
+#define AT91_ADC_MAX_CHANNELS   16
+
+struct at91_adc_data {
+	/* ADC Clock as specified by the datasheet, in Hz. */
+	unsigned int adc_clock;
+	/*
+	 * Global number of channels available (to specify which channels are
+	 * indeed used on the board, see the channels_used array).
+	 */
+	u8 num_channels;
+	/* Channels in use on the board */
+	u8 channels_used[AT91_ADC_MAX_CHANNELS];
+	/* Number of channels in use */
+	u8 num_channels_used;
+	/* Startup time of the ADC, in microseconds. */
+	u8 startup_time;
+	/* Reference voltage for the ADC in millivolts */
+	unsigned short vref;
+};
+extern void __init at91_add_device_adc(struct at91_adc_data *data);
+
 #endif
-- 
1.7.4.1

