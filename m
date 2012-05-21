Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-046.synserver.de ([212.40.185.46]:1113 "EHLO
	smtp-out-044.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753020Ab2EULk1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2012 07:40:27 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 17/18] staging:iio:dac:ad5791: Move private structs and defines from header to C file
Date: Mon, 21 May 2012 13:43:06 +0200
Message-Id: <1337600587-19848-17-git-send-email-lars@metafoo.de>
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
 drivers/staging/iio/dac/ad5791.c |   83 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/iio/dac/ad5791.h |   83 --------------------------------------
 2 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
index 82b51a7..5de28c2 100644
--- a/drivers/staging/iio/dac/ad5791.c
+++ b/drivers/staging/iio/dac/ad5791.c
@@ -22,6 +22,89 @@
 
 #include "ad5791.h"
 
+#define AD5791_RES_MASK(x)		((1 << (x)) - 1)
+#define AD5791_DAC_MASK			AD5791_RES_MASK(20)
+#define AD5791_DAC_MSB			(1 << 19)
+
+#define AD5791_CMD_READ			(1 << 23)
+#define AD5791_CMD_WRITE		(0 << 23)
+#define AD5791_ADDR(addr)		((addr) << 20)
+
+/* Registers */
+#define AD5791_ADDR_NOOP		0
+#define AD5791_ADDR_DAC0		1
+#define AD5791_ADDR_CTRL		2
+#define AD5791_ADDR_CLRCODE		3
+#define AD5791_ADDR_SW_CTRL		4
+
+/* Control Register */
+#define AD5791_CTRL_RBUF		(1 << 1)
+#define AD5791_CTRL_OPGND		(1 << 2)
+#define AD5791_CTRL_DACTRI		(1 << 3)
+#define AD5791_CTRL_BIN2SC		(1 << 4)
+#define AD5791_CTRL_SDODIS		(1 << 5)
+#define AD5761_CTRL_LINCOMP(x)		((x) << 6)
+
+#define AD5791_LINCOMP_0_10		0
+#define AD5791_LINCOMP_10_12		1
+#define AD5791_LINCOMP_12_16		2
+#define AD5791_LINCOMP_16_19		3
+#define AD5791_LINCOMP_19_20		12
+
+#define AD5780_LINCOMP_0_10		0
+#define AD5780_LINCOMP_10_20		12
+
+/* Software Control Register */
+#define AD5791_SWCTRL_LDAC		(1 << 0)
+#define AD5791_SWCTRL_CLR		(1 << 1)
+#define AD5791_SWCTRL_RESET		(1 << 2)
+
+#define AD5791_DAC_PWRDN_6K		0
+#define AD5791_DAC_PWRDN_3STATE		1
+
+/**
+ * struct ad5791_chip_info - chip specific information
+ * @get_lin_comp:	function pointer to the device specific function
+ */
+
+struct ad5791_chip_info {
+	int (*get_lin_comp)	(unsigned int span);
+};
+
+/**
+ * struct ad5791_state - driver instance specific data
+ * @us:			spi_device
+ * @reg_vdd:		positive supply regulator
+ * @reg_vss:		negative supply regulator
+ * @chip_info:		chip model specific constants
+ * @vref_mv:		actual reference voltage used
+ * @vref_neg_mv:	voltage of the negative supply
+ * @pwr_down_mode	current power down mode
+ */
+
+struct ad5791_state {
+	struct spi_device		*spi;
+	struct regulator		*reg_vdd;
+	struct regulator		*reg_vss;
+	const struct ad5791_chip_info	*chip_info;
+	unsigned short			vref_mv;
+	unsigned int			vref_neg_mv;
+	unsigned			ctrl;
+	unsigned			pwr_down_mode;
+	bool				pwr_down;
+};
+
+/**
+ * ad5791_supported_device_ids:
+ */
+
+enum ad5791_supported_device_ids {
+	ID_AD5760,
+	ID_AD5780,
+	ID_AD5781,
+	ID_AD5791,
+};
+
 static int ad5791_spi_write(struct spi_device *spi, u8 addr, u32 val)
 {
 	union {
diff --git a/drivers/staging/iio/dac/ad5791.h b/drivers/staging/iio/dac/ad5791.h
index fd7edbd..87a6c92 100644
--- a/drivers/staging/iio/dac/ad5791.h
+++ b/drivers/staging/iio/dac/ad5791.h
@@ -9,46 +9,6 @@
 #ifndef SPI_AD5791_H_
 #define SPI_AD5791_H_
 
-#define AD5791_RES_MASK(x)		((1 << (x)) - 1)
-#define AD5791_DAC_MASK			AD5791_RES_MASK(20)
-#define AD5791_DAC_MSB			(1 << 19)
-
-#define AD5791_CMD_READ			(1 << 23)
-#define AD5791_CMD_WRITE		(0 << 23)
-#define AD5791_ADDR(addr)		((addr) << 20)
-
-/* Registers */
-#define AD5791_ADDR_NOOP		0
-#define AD5791_ADDR_DAC0		1
-#define AD5791_ADDR_CTRL		2
-#define AD5791_ADDR_CLRCODE		3
-#define AD5791_ADDR_SW_CTRL		4
-
-/* Control Register */
-#define AD5791_CTRL_RBUF		(1 << 1)
-#define AD5791_CTRL_OPGND		(1 << 2)
-#define AD5791_CTRL_DACTRI		(1 << 3)
-#define AD5791_CTRL_BIN2SC		(1 << 4)
-#define AD5791_CTRL_SDODIS		(1 << 5)
-#define AD5761_CTRL_LINCOMP(x)		((x) << 6)
-
-#define AD5791_LINCOMP_0_10		0
-#define AD5791_LINCOMP_10_12		1
-#define AD5791_LINCOMP_12_16		2
-#define AD5791_LINCOMP_16_19		3
-#define AD5791_LINCOMP_19_20		12
-
-#define AD5780_LINCOMP_0_10		0
-#define AD5780_LINCOMP_10_20		12
-
-/* Software Control Register */
-#define AD5791_SWCTRL_LDAC		(1 << 0)
-#define AD5791_SWCTRL_CLR		(1 << 1)
-#define AD5791_SWCTRL_RESET		(1 << 2)
-
-#define AD5791_DAC_PWRDN_6K		0
-#define AD5791_DAC_PWRDN_3STATE		1
-
 /*
  * TODO: struct ad5791_platform_data needs to go into include/linux/iio
  */
@@ -66,47 +26,4 @@ struct ad5791_platform_data {
 	bool				use_rbuf_gain2;
 };
 
-/**
- * struct ad5791_chip_info - chip specific information
- * @get_lin_comp:	function pointer to the device specific function
- */
-
-struct ad5791_chip_info {
-	int (*get_lin_comp)	(unsigned int span);
-};
-
-/**
- * struct ad5791_state - driver instance specific data
- * @us:			spi_device
- * @reg_vdd:		positive supply regulator
- * @reg_vss:		negative supply regulator
- * @chip_info:		chip model specific constants
- * @vref_mv:		actual reference voltage used
- * @vref_neg_mv:	voltage of the negative supply
- * @pwr_down_mode	current power down mode
- */
-
-struct ad5791_state {
-	struct spi_device		*spi;
-	struct regulator		*reg_vdd;
-	struct regulator		*reg_vss;
-	const struct ad5791_chip_info	*chip_info;
-	unsigned short			vref_mv;
-	unsigned int			vref_neg_mv;
-	unsigned			ctrl;
-	unsigned			pwr_down_mode;
-	bool				pwr_down;
-};
-
-/**
- * ad5791_supported_device_ids:
- */
-
-enum ad5791_supported_device_ids {
-	ID_AD5760,
-	ID_AD5780,
-	ID_AD5781,
-	ID_AD5791,
-};
-
 #endif /* SPI_AD5791_H_ */
-- 
1.7.10

