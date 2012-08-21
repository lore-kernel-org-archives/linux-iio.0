Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:63323 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546Ab2HUO3m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Aug 2012 10:29:42 -0400
Received: by ghrr11 with SMTP id r11so5856819ghr.19
        for <linux-iio@vger.kernel.org>; Tue, 21 Aug 2012 07:29:42 -0700 (PDT)
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, device-drivers-devel@blackfin.uclinux.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH v3.6-rc2 V2 2/2] iio:ad5446: get rid of private header file
Date: Tue, 21 Aug 2012 10:28:58 -0400
Message-Id: <1345559338-19509-3-git-send-email-jeff.dagenais@gmail.com>
In-Reply-To: <1345559338-19509-1-git-send-email-jeff.dagenais@gmail.com>
References: <502E10A4.1080800@metafoo.de>
 <1345559338-19509-1-git-send-email-jeff.dagenais@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the defines in there were not even used, and the structs left are
private to the .c file. Makes the driver more in line with most of the
kernel drivers.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/iio/dac/ad5446.c | 35 +++++++++++++++++++++++++-
 drivers/iio/dac/ad5446.h | 64 ------------------------------------------------
 2 files changed, 34 insertions(+), 65 deletions(-)
 delete mode 100644 drivers/iio/dac/ad5446.h

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 241665b..7f11c1c 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -22,7 +22,40 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include "ad5446.h"
+#define MODE_PWRDWN_1k		0x1
+#define MODE_PWRDWN_100k	0x2
+#define MODE_PWRDWN_TRISTATE	0x3
+
+/**
+ * struct ad5446_state - driver instance specific data
+ * @spi:		spi_device
+ * @chip_info:		chip model specific constants, available modes etc
+ * @reg:		supply regulator
+ * @vref_mv:		actual reference voltage used
+ */
+
+struct ad5446_state {
+	struct device		*dev;
+	const struct ad5446_chip_info	*chip_info;
+	struct regulator		*reg;
+	unsigned short			vref_mv;
+	unsigned			cached_val;
+	unsigned			pwr_down_mode;
+	unsigned			pwr_down;
+};
+
+/**
+ * struct ad5446_chip_info - chip specific information
+ * @channel:		channel spec for the DAC
+ * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @write:		chip specific helper function to write to the register
+ */
+
+struct ad5446_chip_info {
+	struct iio_chan_spec	channel;
+	u16			int_vref_mv;
+	int			(*write)(struct ad5446_state *st, unsigned val);
+};
 
 static const char * const ad5446_powerdown_modes[] = {
 	"1kohm_to_gnd", "100kohm_to_gnd", "three_state"
diff --git a/drivers/iio/dac/ad5446.h b/drivers/iio/dac/ad5446.h
deleted file mode 100644
index 6b7a176..0000000
--- a/drivers/iio/dac/ad5446.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/*
- * AD5446 SPI DAC driver
- *
- * Copyright 2010 Analog Devices Inc.
- *
- * Licensed under the GPL-2 or later.
- */
-#ifndef IIO_DAC_AD5446_H_
-#define IIO_DAC_AD5446_H_
-
-/* DAC Control Bits */
-
-#define AD5446_LOAD		(0x0 << 14) /* Load and update */
-#define AD5446_SDO_DIS		(0x1 << 14) /* Disable SDO */
-#define AD5446_NOP		(0x2 << 14) /* No operation */
-#define AD5446_CLK_RISING	(0x3 << 14) /* Clock data on rising edge */
-
-#define AD5620_LOAD		(0x0 << 14) /* Load and update Norm Operation*/
-#define AD5620_PWRDWN_1k	(0x1 << 14) /* Power-down: 1kOhm to GND */
-#define AD5620_PWRDWN_100k	(0x2 << 14) /* Power-down: 100kOhm to GND */
-#define AD5620_PWRDWN_TRISTATE	(0x3 << 14) /* Power-down: Three-state */
-
-#define AD5660_LOAD		(0x0 << 16) /* Load and update Norm Operation*/
-#define AD5660_PWRDWN_1k	(0x1 << 16) /* Power-down: 1kOhm to GND */
-#define AD5660_PWRDWN_100k	(0x2 << 16) /* Power-down: 100kOhm to GND */
-#define AD5660_PWRDWN_TRISTATE	(0x3 << 16) /* Power-down: Three-state */
-
-#define MODE_PWRDWN_1k		0x1
-#define MODE_PWRDWN_100k	0x2
-#define MODE_PWRDWN_TRISTATE	0x3
-
-/**
- * struct ad5446_state - driver instance specific data
- * @spi:		spi_device
- * @chip_info:		chip model specific constants, available modes etc
- * @reg:		supply regulator
- * @vref_mv:		actual reference voltage used
- */
-
-struct ad5446_state {
-	struct device		*dev;
-	const struct ad5446_chip_info	*chip_info;
-	struct regulator		*reg;
-	unsigned short			vref_mv;
-	unsigned			cached_val;
-	unsigned			pwr_down_mode;
-	unsigned			pwr_down;
-};
-
-/**
- * struct ad5446_chip_info - chip specific information
- * @channel:		channel spec for the DAC
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
- * @write:		chip specific helper function to write to the register
- */
-
-struct ad5446_chip_info {
-	struct iio_chan_spec	channel;
-	u16			int_vref_mv;
-	int			(*write)(struct ad5446_state *st, unsigned val);
-};
-
-
-#endif /* IIO_DAC_AD5446_H_ */
-- 
1.7.11.3

