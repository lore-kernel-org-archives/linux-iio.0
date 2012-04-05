Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:59051 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2DEQBr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 5 Apr 2012 12:01:47 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 1/5] ARM: AT91: Add platform data for the AT91 ADCs
Date: Thu,  5 Apr 2012 18:01:20 +0200
Message-Id: <1333641684-20325-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The AT91 SoCs often embeds an ADC. This patch adds the needed
platform data to specify the informations required by the driver
to work properly.

For now, we only need the reference voltage and which channels
are available on the board.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/at91_adc.h

diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
new file mode 100644
index 0000000..1f71510
--- /dev/null
+++ b/include/linux/platform_data/at91_adc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2011 Free Electrons
+ *
+ * Licensed under the GPLv2 or later.
+ *
+ */
+
+#ifndef _AT91_ADC_H_
+#define _AT91_ADC_H_
+
+/**
+ * struct at91_adc_data - platform data for ADC driver
+ * @channels_used:	channels in use on the board as a bitmask
+ * @vref:		Reference voltage for the ADC in millivolts
+ */
+struct at91_adc_data {
+	unsigned long	channels_used;
+	u16		vref;
+};
+
+extern void __init at91_add_device_adc(struct at91_adc_data *data);
+
+#endif
-- 
1.7.5.4

