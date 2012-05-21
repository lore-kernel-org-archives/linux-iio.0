Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1117 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752247Ab2EULk0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:26 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 16/18] staging:iio:dac:ad5504: Move private structs and defines from header to C file
Date: Mon, 21 May 2012 13:43:05 +0200
Message-Id: <1337600587-19848-16-git-send-email-lars@metafoo.de>
In-Reply-To: <1337600587-19848-1-git-send-email-lars@metafoo.de>
References: <1337600587-19848-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The header for this driver contains some private structs and defines, which do
not have to be shared between multiple source files, as well as the platform
data struct for this driver, which has to be shared with other source files.
Since there is no need to expose those private structs and defines move them to
the source file.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5504.c |   45 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/dac/ad5504.h |   45 --------------------------------------
 2 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5504.c b/drivers/staging/iio/dac/ad5504.c
index cd754d2..012c187 100644
--- a/drivers/staging/iio/dac/ad5504.c
+++ b/drivers/staging/iio/dac/ad5504.c
@@ -22,6 +22,51 @@
 
 #include "ad5504.h"
 
+#define AD5505_BITS			12
+#define AD5504_RES_MASK			((1 << (AD5505_BITS)) - 1)
+
+#define AD5504_CMD_READ			(1 << 15)
+#define AD5504_CMD_WRITE		(0 << 15)
+#define AD5504_ADDR(addr)		((addr) << 12)
+
+/* Registers */
+#define AD5504_ADDR_NOOP		0
+#define AD5504_ADDR_DAC(x)		((x) + 1)
+#define AD5504_ADDR_ALL_DAC		5
+#define AD5504_ADDR_CTRL		7
+
+/* Control Register */
+#define AD5504_DAC_PWR(ch)		((ch) << 2)
+#define AD5504_DAC_PWRDWN_MODE(mode)	((mode) << 6)
+#define AD5504_DAC_PWRDN_20K		0
+#define AD5504_DAC_PWRDN_3STATE		1
+
+/**
+ * struct ad5446_state - driver instance specific data
+ * @us:			spi_device
+ * @reg:		supply regulator
+ * @vref_mv:		actual reference voltage used
+ * @pwr_down_mask	power down mask
+ * @pwr_down_mode	current power down mode
+ */
+
+struct ad5504_state {
+	struct spi_device		*spi;
+	struct regulator		*reg;
+	unsigned short			vref_mv;
+	unsigned			pwr_down_mask;
+	unsigned			pwr_down_mode;
+};
+
+/**
+ * ad5504_supported_device_ids:
+ */
+
+enum ad5504_supported_device_ids {
+	ID_AD5504,
+	ID_AD5501,
+};
+
 static int ad5504_spi_write(struct spi_device *spi, u8 addr, u16 val)
 {
 	u16 tmp = cpu_to_be16(AD5504_CMD_WRITE |
diff --git a/drivers/staging/iio/dac/ad5504.h b/drivers/staging/iio/dac/ad5504.h
index afe0952..d4980bf 100644
--- a/drivers/staging/iio/dac/ad5504.h
+++ b/drivers/staging/iio/dac/ad5504.h
@@ -9,25 +9,6 @@
 #ifndef SPI_AD5504_H_
 #define SPI_AD5504_H_
 
-#define AD5505_BITS			12
-#define AD5504_RES_MASK			((1 << (AD5505_BITS)) - 1)
-
-#define AD5504_CMD_READ			(1 << 15)
-#define AD5504_CMD_WRITE		(0 << 15)
-#define AD5504_ADDR(addr)		((addr) << 12)
-
-/* Registers */
-#define AD5504_ADDR_NOOP		0
-#define AD5504_ADDR_DAC(x)		((x) + 1)
-#define AD5504_ADDR_ALL_DAC		5
-#define AD5504_ADDR_CTRL		7
-
-/* Control Register */
-#define AD5504_DAC_PWR(ch)		((ch) << 2)
-#define AD5504_DAC_PWRDWN_MODE(mode)	((mode) << 6)
-#define AD5504_DAC_PWRDN_20K		0
-#define AD5504_DAC_PWRDN_3STATE		1
-
 /*
  * TODO: struct ad5504_platform_data needs to go into include/linux/iio
  */
@@ -36,30 +17,4 @@ struct ad5504_platform_data {
 	u16				vref_mv;
 };
 
-/**
- * struct ad5446_state - driver instance specific data
- * @us:			spi_device
- * @reg:		supply regulator
- * @vref_mv:		actual reference voltage used
- * @pwr_down_mask	power down mask
- * @pwr_down_mode	current power down mode
- */
-
-struct ad5504_state {
-	struct spi_device		*spi;
-	struct regulator		*reg;
-	unsigned short			vref_mv;
-	unsigned			pwr_down_mask;
-	unsigned			pwr_down_mode;
-};
-
-/**
- * ad5504_supported_device_ids:
- */
-
-enum ad5504_supported_device_ids {
-	ID_AD5504,
-	ID_AD5501,
-};
-
 #endif /* SPI_AD5504_H_ */
-- 
1.7.10

