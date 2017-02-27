Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36785 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbdB1BH3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Feb 2017 20:07:29 -0500
Received: by mail-wr0-f193.google.com with SMTP id l37so3442312wrc.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Feb 2017 17:07:22 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH v2] staging: iio: ad9834: Moved contents of the header to the source file
Date: Tue, 28 Feb 2017 00:15:11 +0200
Message-Id: <1488233711-28721-1-git-send-email-narcisaanamaria12@gmail.com>
In-Reply-To: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
References: <1488146361-14383-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Moved the contents of the header(ad9834.h) into the corresponding source
file with the exception of the platform data struct which is supposed to be
used from somewhere else other than the driver.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
Changes to v2:
    -Removed the platform data structure from the source file
    and inserted it back into the header file(ad9834.h).
---
 drivers/staging/iio/frequency/ad9834.c | 72 ++++++++++++++++++++++++++++++++++
 drivers/staging/iio/frequency/ad9834.h | 72 ----------------------------------
 2 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 19216af..f92ff7f 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -25,6 +25,78 @@
 
 #include "ad9834.h"
 
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
+
 static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index 40fdd5d..ae620f3 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -8,67 +8,6 @@
 #ifndef IIO_DDS_AD9834_H_
 #define IIO_DDS_AD9834_H_
 
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
 /*
  * TODO: struct ad7887_platform_data needs to go into include/linux/iio
  */
@@ -97,15 +36,4 @@ struct ad9834_platform_data {
 	bool			en_signbit_msb_out;
 };
 
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
 #endif /* IIO_DDS_AD9834_H_ */
-- 
1.9.1

