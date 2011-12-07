Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41950 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab1LGS0G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 7 Dec 2011 13:26:06 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/6] ARM: AT91: Add platform data for the ADCs
Date: Wed,  7 Dec 2011 19:25:35 +0100
Message-Id: <1323282340-24475-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/platform_data/at91_adc.h |   36 ++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/at91_adc.h

diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
new file mode 100644
index 0000000..1e1813d
--- /dev/null
+++ b/include/linux/platform_data/at91_adc.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright (C) 2011 Free Electrons
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _AT91_ADC_H_
+#define _AT91_ADC_H_
+
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
+
+extern void __init at91_add_device_adc(struct at91_adc_data *data);
+
+#endif
-- 
1.7.4.1

