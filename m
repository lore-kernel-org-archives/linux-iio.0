Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:37139 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756728Ab2APVgj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2012 16:36:39 -0500
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
Date: Mon, 16 Jan 2012 22:36:24 +0100
Message-Id: <1326749786-13035-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1326749786-13035-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)
 create mode 100644 include/linux/platform_data/at91_adc.h

diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
new file mode 100644
index 0000000..c27b502
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
+ * @channels_use:	channels in use on the board as a bitmask
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

