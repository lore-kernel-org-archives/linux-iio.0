Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33282 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdBZWZH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Feb 2017 17:25:07 -0500
Received: by mail-wm0-f67.google.com with SMTP id v77so10876673wmv.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Feb 2017 14:25:06 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] staging: iio: ad9834: Moved contents of header file to source file
Date: Sun, 26 Feb 2017 23:59:21 +0200
Message-Id: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of the header file are used only by this single source file

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 100 ++++++++++++++++++++++++++++-
 drivers/staging/iio/frequency/ad9834.h | 111 ---------------------------------
 2 files changed, 99 insertions(+), 112 deletions(-)
 delete mode 100644 drivers/staging/iio/frequency/ad9834.h

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 19216af..931feb2 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -23,7 +23,105 @@
 #include <linux/iio/sysfs.h>
 #include "dds.h"
 
-#include "ad9834.h"
+/* Registers */
+
+#define AD9834_REG_CMD		0
+#define AD9834_REG_FREQ0	BIT(14)
+#define AD9834_REG_FREQ1	BIT(15)
+#define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
+#define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
+
+/* Command Control Bits */
+
+#define AD9834_B28		BIT(13)
+#define AD9834_HLB		BIT(12)
+#define AD9834_FSEL		BIT(11)
+#define AD9834_PSEL		BIT(10)
+#define AD9834_PIN_SW		BIT(9)
+#define AD9834_RESET		BIT(8)
+#define AD9834_SLEEP1		BIT(7)
+#define AD9834_SLEEP12		BIT(6)
+#define AD9834_OPBITEN		BIT(5)
+#define AD9834_SIGN_PIB		BIT(4)
+#define AD9834_DIV2		BIT(3)
+#define AD9834_MODE		BIT(1)
+
+#define AD9834_FREQ_BITS	28
+#define AD9834_PHASE_BITS	12
+
+#define RES_MASK(bits)	(BIT(bits) - 1)
+
+/**
+ * struct ad9834_state - driver instance specific data
+ * @spi:		spi_device
+ * @reg:		supply regulator
+ * @mclk:		external master clock
+ * @control:		cached control word
+ * @xfer:		default spi transfer
+ * @msg:		default spi message
+ * @freq_xfer:		tuning word spi transfer
+ * @freq_msg:		tuning word spi message
+ * @data:		spi transmit buffer
+ * @freq_data:		tuning word spi transmit buffer
+ */
+
+struct ad9834_state {
+	struct spi_device		*spi;
+	struct regulator		*reg;
+	unsigned int			mclk;
+	unsigned short			control;
+	unsigned short			devid;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	struct spi_transfer		freq_xfer[2];
+	struct spi_message		freq_msg;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	__be16				data ____cacheline_aligned;
+	__be16				freq_data[2];
+};
+
+/*
+ * TODO: struct ad7887_platform_data needs to go into include/linux/iio
+ */
+
+/**
+ * struct ad9834_platform_data - platform specific information
+ * @mclk:		master clock in Hz
+ * @freq0:		power up freq0 tuning word in Hz
+ * @freq1:		power up freq1 tuning word in Hz
+ * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
+ * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
+ * @en_div2:		digital output/2 is passed to the SIGN BIT OUT pin
+ * @en_signbit_msb_out:	the MSB (or MSB/2) of the DAC data is connected to the
+ *			SIGN BIT OUT pin. en_div2 controls whether it is the MSB
+ *			or MSB/2 that is output. if en_signbit_msb_out=false,
+ *			the on-board comparator is connected to SIGN BIT OUT
+ */
+
+struct ad9834_platform_data {
+	unsigned int		mclk;
+	unsigned int		freq0;
+	unsigned int		freq1;
+	unsigned short		phase0;
+	unsigned short		phase1;
+	bool			en_div2;
+	bool			en_signbit_msb_out;
+};
+
+/**
+ * ad9834_supported_device_ids:
+ */
+
+enum ad9834_supported_device_ids {
+	ID_AD9833,
+	ID_AD9834,
+	ID_AD9837,
+	ID_AD9838,
+};
 
 static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
deleted file mode 100644
index 40fdd5d..0000000
--- a/drivers/staging/iio/frequency/ad9834.h
+++ /dev/null
@@ -1,111 +0,0 @@
-/*
- * AD9833/AD9834/AD9837/AD9838 SPI DDS driver
- *
- * Copyright 2010-2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- */
-#ifndef IIO_DDS_AD9834_H_
-#define IIO_DDS_AD9834_H_
-
-/* Registers */
-
-#define AD9834_REG_CMD		0
-#define AD9834_REG_FREQ0	BIT(14)
-#define AD9834_REG_FREQ1	BIT(15)
-#define AD9834_REG_PHASE0	(BIT(15) | BIT(14))
-#define AD9834_REG_PHASE1	(BIT(15) | BIT(14) | BIT(13))
-
-/* Command Control Bits */
-
-#define AD9834_B28		BIT(13)
-#define AD9834_HLB		BIT(12)
-#define AD9834_FSEL		BIT(11)
-#define AD9834_PSEL		BIT(10)
-#define AD9834_PIN_SW		BIT(9)
-#define AD9834_RESET		BIT(8)
-#define AD9834_SLEEP1		BIT(7)
-#define AD9834_SLEEP12		BIT(6)
-#define AD9834_OPBITEN		BIT(5)
-#define AD9834_SIGN_PIB		BIT(4)
-#define AD9834_DIV2		BIT(3)
-#define AD9834_MODE		BIT(1)
-
-#define AD9834_FREQ_BITS	28
-#define AD9834_PHASE_BITS	12
-
-#define RES_MASK(bits)	(BIT(bits) - 1)
-
-/**
- * struct ad9834_state - driver instance specific data
- * @spi:		spi_device
- * @reg:		supply regulator
- * @mclk:		external master clock
- * @control:		cached control word
- * @xfer:		default spi transfer
- * @msg:		default spi message
- * @freq_xfer:		tuning word spi transfer
- * @freq_msg:		tuning word spi message
- * @data:		spi transmit buffer
- * @freq_data:		tuning word spi transmit buffer
- */
-
-struct ad9834_state {
-	struct spi_device		*spi;
-	struct regulator		*reg;
-	unsigned int			mclk;
-	unsigned short			control;
-	unsigned short			devid;
-	struct spi_transfer		xfer;
-	struct spi_message		msg;
-	struct spi_transfer		freq_xfer[2];
-	struct spi_message		freq_msg;
-
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 */
-	__be16				data ____cacheline_aligned;
-	__be16				freq_data[2];
-};
-
-/*
- * TODO: struct ad7887_platform_data needs to go into include/linux/iio
- */
-
-/**
- * struct ad9834_platform_data - platform specific information
- * @mclk:		master clock in Hz
- * @freq0:		power up freq0 tuning word in Hz
- * @freq1:		power up freq1 tuning word in Hz
- * @phase0:		power up phase0 value [0..4095] correlates with 0..2PI
- * @phase1:		power up phase1 value [0..4095] correlates with 0..2PI
- * @en_div2:		digital output/2 is passed to the SIGN BIT OUT pin
- * @en_signbit_msb_out:	the MSB (or MSB/2) of the DAC data is connected to the
- *			SIGN BIT OUT pin. en_div2 controls whether it is the MSB
- *			or MSB/2 that is output. if en_signbit_msb_out=false,
- *			the on-board comparator is connected to SIGN BIT OUT
- */
-
-struct ad9834_platform_data {
-	unsigned int		mclk;
-	unsigned int		freq0;
-	unsigned int		freq1;
-	unsigned short		phase0;
-	unsigned short		phase1;
-	bool			en_div2;
-	bool			en_signbit_msb_out;
-};
-
-/**
- * ad9834_supported_device_ids:
- */
-
-enum ad9834_supported_device_ids {
-	ID_AD9833,
-	ID_AD9834,
-	ID_AD9837,
-	ID_AD9838,
-};
-
-#endif /* IIO_DDS_AD9834_H_ */
-- 
1.9.1

