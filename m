Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35120 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdB0RgW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 12:36:22 -0500
Received: by mail-wr0-f196.google.com with SMTP id q39so11258046wrb.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 09:35:28 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v3] staging: iio: ad9832: Moved contents of the header to the source file
Date: Mon, 27 Feb 2017 19:28:16 +0200
Message-Id: <1488216496-16969-1-git-send-email-narcisaanamaria12@gmail.com>
In-Reply-To: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
In-Reply-To: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488145439-32728-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Moved the contents of the header(ad9832.h) into the corresponding source file
with the exception of the platform data struct which is supposed to be
used from somewhere else other than the driver.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Changes in v3:
   -The changes are now made against the original code
---
 drivers/staging/iio/frequency/ad9832.c | 92 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/frequency/ad9832.h | 92 ----------------------------------
 2 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index a5b2f06..8d40c8e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -22,6 +22,98 @@
 
 #include "ad9832.h"
 
+/* Registers */
+
+#define AD9832_FREQ0LL		0x0
+#define AD9832_FREQ0HL		0x1
+#define AD9832_FREQ0LM		0x2
+#define AD9832_FREQ0HM		0x3
+#define AD9832_FREQ1LL		0x4
+#define AD9832_FREQ1HL		0x5
+#define AD9832_FREQ1LM		0x6
+#define AD9832_FREQ1HM		0x7
+#define AD9832_PHASE0L		0x8
+#define AD9832_PHASE0H		0x9
+#define AD9832_PHASE1L		0xA
+#define AD9832_PHASE1H		0xB
+#define AD9832_PHASE2L		0xC
+#define AD9832_PHASE2H		0xD
+#define AD9832_PHASE3L		0xE
+#define AD9832_PHASE3H		0xF
+
+#define AD9832_PHASE_SYM	0x10
+#define AD9832_FREQ_SYM		0x11
+#define AD9832_PINCTRL_EN	0x12
+#define AD9832_OUTPUT_EN	0x13
+
+/* Command Control Bits */
+
+#define AD9832_CMD_PHA8BITSW	0x1
+#define AD9832_CMD_PHA16BITSW	0x0
+#define AD9832_CMD_FRE8BITSW	0x3
+#define AD9832_CMD_FRE16BITSW	0x2
+#define AD9832_CMD_FPSELECT	0x6
+#define AD9832_CMD_SYNCSELSRC	0x8
+#define AD9832_CMD_SLEEPRESCLR	0xC
+
+#define AD9832_FREQ		BIT(11)
+#define AD9832_PHASE(x)		(((x) & 3) << 9)
+#define AD9832_SYNC		BIT(13)
+#define AD9832_SELSRC		BIT(12)
+#define AD9832_SLEEP		BIT(13)
+#define AD9832_RESET		BIT(12)
+#define AD9832_CLR		BIT(11)
+#define CMD_SHIFT		12
+#define ADD_SHIFT		8
+#define AD9832_FREQ_BITS	32
+#define AD9832_PHASE_BITS	12
+#define RES_MASK(bits)		((1 << (bits)) - 1)
+
+/**
+ * struct ad9832_state - driver instance specific data
+ * @spi:		spi_device
+ * @avdd:		supply regulator for the analog section
+ * @dvdd:		supply regulator for the digital section
+ * @mclk:		external master clock
+ * @ctrl_fp:		cached frequency/phase control word
+ * @ctrl_ss:		cached sync/selsrc control word
+ * @ctrl_src:		cached sleep/reset/clr word
+ * @xfer:		default spi transfer
+ * @msg:		default spi message
+ * @freq_xfer:		tuning word spi transfer
+ * @freq_msg:		tuning word spi message
+ * @phase_xfer:		tuning word spi transfer
+ * @phase_msg:		tuning word spi message
+ * @data:		spi transmit buffer
+ * @phase_data:		tuning word spi transmit buffer
+ * @freq_data:		tuning word spi transmit buffer
+ */
+
+struct ad9832_state {
+	struct spi_device		*spi;
+	struct regulator		*avdd;
+	struct regulator		*dvdd;
+	unsigned long			mclk;
+	unsigned short			ctrl_fp;
+	unsigned short			ctrl_ss;
+	unsigned short			ctrl_src;
+	struct spi_transfer		xfer;
+	struct spi_message		msg;
+	struct spi_transfer		freq_xfer[4];
+	struct spi_message		freq_msg;
+	struct spi_transfer		phase_xfer[2];
+	struct spi_message		phase_msg;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	union {
+		__be16			freq_data[4]____cacheline_aligned;
+		__be16			phase_data[2];
+		__be16			data;
+	};
+};
+
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
diff --git a/drivers/staging/iio/frequency/ad9832.h b/drivers/staging/iio/frequency/ad9832.h
index 1b08b04..39d326c 100644
--- a/drivers/staging/iio/frequency/ad9832.h
+++ b/drivers/staging/iio/frequency/ad9832.h
@@ -8,98 +8,6 @@
 #ifndef IIO_DDS_AD9832_H_
 #define IIO_DDS_AD9832_H_
 
-/* Registers */
-
-#define AD9832_FREQ0LL		0x0
-#define AD9832_FREQ0HL		0x1
-#define AD9832_FREQ0LM		0x2
-#define AD9832_FREQ0HM		0x3
-#define AD9832_FREQ1LL		0x4
-#define AD9832_FREQ1HL		0x5
-#define AD9832_FREQ1LM		0x6
-#define AD9832_FREQ1HM		0x7
-#define AD9832_PHASE0L		0x8
-#define AD9832_PHASE0H		0x9
-#define AD9832_PHASE1L		0xA
-#define AD9832_PHASE1H		0xB
-#define AD9832_PHASE2L		0xC
-#define AD9832_PHASE2H		0xD
-#define AD9832_PHASE3L		0xE
-#define AD9832_PHASE3H		0xF
-
-#define AD9832_PHASE_SYM	0x10
-#define AD9832_FREQ_SYM		0x11
-#define AD9832_PINCTRL_EN	0x12
-#define AD9832_OUTPUT_EN	0x13
-
-/* Command Control Bits */
-
-#define AD9832_CMD_PHA8BITSW	0x1
-#define AD9832_CMD_PHA16BITSW	0x0
-#define AD9832_CMD_FRE8BITSW	0x3
-#define AD9832_CMD_FRE16BITSW	0x2
-#define AD9832_CMD_FPSELECT	0x6
-#define AD9832_CMD_SYNCSELSRC	0x8
-#define AD9832_CMD_SLEEPRESCLR	0xC
-
-#define AD9832_FREQ		BIT(11)
-#define AD9832_PHASE(x)		(((x) & 3) << 9)
-#define AD9832_SYNC		BIT(13)
-#define AD9832_SELSRC		BIT(12)
-#define AD9832_SLEEP		BIT(13)
-#define AD9832_RESET		BIT(12)
-#define AD9832_CLR		BIT(11)
-#define CMD_SHIFT		12
-#define ADD_SHIFT		8
-#define AD9832_FREQ_BITS	32
-#define AD9832_PHASE_BITS	12
-#define RES_MASK(bits)		((1 << (bits)) - 1)
-
-/**
- * struct ad9832_state - driver instance specific data
- * @spi:		spi_device
- * @avdd:		supply regulator for the analog section
- * @dvdd:		supply regulator for the digital section
- * @mclk:		external master clock
- * @ctrl_fp:		cached frequency/phase control word
- * @ctrl_ss:		cached sync/selsrc control word
- * @ctrl_src:		cached sleep/reset/clr word
- * @xfer:		default spi transfer
- * @msg:		default spi message
- * @freq_xfer:		tuning word spi transfer
- * @freq_msg:		tuning word spi message
- * @phase_xfer:		tuning word spi transfer
- * @phase_msg:		tuning word spi message
- * @data:		spi transmit buffer
- * @phase_data:		tuning word spi transmit buffer
- * @freq_data:		tuning word spi transmit buffer
- */
-
-struct ad9832_state {
-	struct spi_device		*spi;
-	struct regulator		*avdd;
-	struct regulator		*dvdd;
-	unsigned long			mclk;
-	unsigned short			ctrl_fp;
-	unsigned short			ctrl_ss;
-	unsigned short			ctrl_src;
-	struct spi_transfer		xfer;
-	struct spi_message		msg;
-	struct spi_transfer		freq_xfer[4];
-	struct spi_message		freq_msg;
-	struct spi_transfer		phase_xfer[2];
-	struct spi_message		phase_msg;
-	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 */
-	union {
-		__be16			freq_data[4]____cacheline_aligned;
-		__be16			phase_data[2];
-		__be16			data;
-	};
-};
-
 /*
  * TODO: struct ad9832_platform_data needs to go into include/linux/iio
  */
-- 
1.9.1

