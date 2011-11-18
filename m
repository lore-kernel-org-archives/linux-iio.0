Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:33283 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752188Ab1KRKMw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2011 05:12:52 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Date: Fri, 18 Nov 2011 11:12:38 +0100
Message-Id: <1321611160-3685-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1321611160-3685-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/board.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index ed544a0..4f27797 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -207,4 +207,22 @@ extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
+/* ADC */
+struct at91_adc_data {
+	/* ADC Clock as specified by the datasheet, in Hz. */
+	unsigned int adc_clock;
+	/*
+	 * Global number of channels available (to specify which channels are
+	 * indeed used on the board, see the channels_used bitmask).
+	 */
+	u8 num_channels;
+	/* Channels in use on the board as a bitmask */
+	unsigned long channels_used;
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

