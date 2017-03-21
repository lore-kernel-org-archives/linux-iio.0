Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34801 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757386AbdCUNbH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 09:31:07 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH 2/2] staging: iio: ade7759: Move header content to implementation file
Date: Tue, 21 Mar 2017 19:00:21 +0530
Message-Id: <20170321133021.6737-5-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of ade7759.h are only used in ade7759.c.
Move the header contents to the implemtation file,
and delete the header file.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 52 ++++++++++++++++++++++++++++++++++-
 drivers/staging/iio/meter/ade7759.h | 54 -------------------------------------
 2 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1d1e0b33021f..86ac103dffe5 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -21,7 +21,57 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include "meter.h"
-#include "ade7759.h"
+
+#define ADE7759_WAVEFORM  0x01
+#define ADE7759_AENERGY   0x02
+#define ADE7759_RSTENERGY 0x03
+#define ADE7759_STATUS    0x04
+#define ADE7759_RSTSTATUS 0x05
+#define ADE7759_MODE      0x06
+#define ADE7759_CFDEN     0x07
+#define ADE7759_CH1OS     0x08
+#define ADE7759_CH2OS     0x09
+#define ADE7759_GAIN      0x0A
+#define ADE7759_APGAIN    0x0B
+#define ADE7759_PHCAL     0x0C
+#define ADE7759_APOS      0x0D
+#define ADE7759_ZXTOUT    0x0E
+#define ADE7759_SAGCYC    0x0F
+#define ADE7759_IRQEN     0x10
+#define ADE7759_SAGLVL    0x11
+#define ADE7759_TEMP      0x12
+#define ADE7759_LINECYC   0x13
+#define ADE7759_LENERGY   0x14
+#define ADE7759_CFNUM     0x15
+#define ADE7759_CHKSUM    0x1E
+#define ADE7759_DIEREV    0x1F
+
+#define ADE7759_READ_REG(a)    a
+#define ADE7759_WRITE_REG(a) ((a) | 0x80)
+
+#define ADE7759_MAX_TX    6
+#define ADE7759_MAX_RX    6
+#define ADE7759_STARTUP_DELAY 1000
+
+#define ADE7759_SPI_SLOW        (u32)(300 * 1000)
+#define ADE7759_SPI_BURST       (u32)(1000 * 1000)
+#define ADE7759_SPI_FAST        (u32)(2000 * 1000)
+
+/**
+ * struct ade7759_state - device instance specific data
+ * @us:			actual spi_device
+ * @buf_lock:		mutex to protect tx and rx
+ * @tx:			transmit buffer
+ * @rx:			receive buffer
+ * @lock		protect sensor state
+ **/
+
+struct ade7759_state {
+	struct spi_device	*us;
+	struct mutex		buf_lock; /* protect tx and rx */
+	u8			tx[ADE7759_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADE7759_MAX_RX];
+};
 
 static int ade7759_spi_write_reg_8(struct device *dev,
 		u8 reg_address,
diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
index 4f69bb93cc45..e69de29bb2d1 100644
--- a/drivers/staging/iio/meter/ade7759.h
+++ b/drivers/staging/iio/meter/ade7759.h
@@ -1,54 +0,0 @@
-#ifndef _ADE7759_H
-#define _ADE7759_H
-
-#define ADE7759_WAVEFORM  0x01
-#define ADE7759_AENERGY   0x02
-#define ADE7759_RSTENERGY 0x03
-#define ADE7759_STATUS    0x04
-#define ADE7759_RSTSTATUS 0x05
-#define ADE7759_MODE      0x06
-#define ADE7759_CFDEN     0x07
-#define ADE7759_CH1OS     0x08
-#define ADE7759_CH2OS     0x09
-#define ADE7759_GAIN      0x0A
-#define ADE7759_APGAIN    0x0B
-#define ADE7759_PHCAL     0x0C
-#define ADE7759_APOS      0x0D
-#define ADE7759_ZXTOUT    0x0E
-#define ADE7759_SAGCYC    0x0F
-#define ADE7759_IRQEN     0x10
-#define ADE7759_SAGLVL    0x11
-#define ADE7759_TEMP      0x12
-#define ADE7759_LINECYC   0x13
-#define ADE7759_LENERGY   0x14
-#define ADE7759_CFNUM     0x15
-#define ADE7759_CHKSUM    0x1E
-#define ADE7759_DIEREV    0x1F
-
-#define ADE7759_READ_REG(a)    a
-#define ADE7759_WRITE_REG(a) ((a) | 0x80)
-
-#define ADE7759_MAX_TX    6
-#define ADE7759_MAX_RX    6
-#define ADE7759_STARTUP_DELAY 1000
-
-#define ADE7759_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7759_SPI_BURST	(u32)(1000 * 1000)
-#define ADE7759_SPI_FAST	(u32)(2000 * 1000)
-
-/**
- * struct ade7759_state - device instance specific data
- * @us:			actual spi_device
- * @buf_lock:		mutex to protect tx and rx
- * @tx:			transmit buffer
- * @rx:			receive buffer
- * @lock		protect sensor state
- **/
-struct ade7759_state {
-	struct spi_device	*us;
-	struct mutex		buf_lock;
-	u8			tx[ADE7759_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7759_MAX_RX];
-};
-
-#endif
-- 
2.11.0

