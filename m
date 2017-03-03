Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34096 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdCCPiE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 10:38:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id s67so12985990pgb.1
        for <linux-iio@vger.kernel.org>; Fri, 03 Mar 2017 07:38:03 -0800 (PST)
Date: Fri, 3 Mar 2017 07:35:52 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] staging: iio: meter: ade7753: Move header content to
 implementation file
Message-ID: <20170303153551.GB29234@katie-Inspiron-5748>
References: <cover.1488553341.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1488553341.git.kdunne@mail.ccsf.edu>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The contents of ade7753.h are only used in ade7753.c. Move the header
contents to the implementation file and delete the header file.

Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
---
 drivers/staging/iio/meter/ade7753.c | 69 ++++++++++++++++++++++++++++++++++-
 drivers/staging/iio/meter/ade7753.h | 72 -------------------------------------
 2 files changed, 68 insertions(+), 73 deletions(-)
 delete mode 100644 drivers/staging/iio/meter/ade7753.h

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 671dc99..063ff27 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -21,7 +21,74 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include "meter.h"
-#include "ade7753.h"
+
+#define ADE7753_WAVEFORM   0x01
+#define ADE7753_AENERGY    0x02
+#define ADE7753_RAENERGY   0x03
+#define ADE7753_LAENERGY   0x04
+#define ADE7753_VAENERGY   0x05
+#define ADE7753_RVAENERGY  0x06
+#define ADE7753_LVAENERGY  0x07
+#define ADE7753_LVARENERGY 0x08
+#define ADE7753_MODE       0x09
+#define ADE7753_IRQEN      0x0A
+#define ADE7753_STATUS     0x0B
+#define ADE7753_RSTSTATUS  0x0C
+#define ADE7753_CH1OS      0x0D
+#define ADE7753_CH2OS      0x0E
+#define ADE7753_GAIN       0x0F
+#define ADE7753_PHCAL      0x10
+#define ADE7753_APOS       0x11
+#define ADE7753_WGAIN      0x12
+#define ADE7753_WDIV       0x13
+#define ADE7753_CFNUM      0x14
+#define ADE7753_CFDEN      0x15
+#define ADE7753_IRMS       0x16
+#define ADE7753_VRMS       0x17
+#define ADE7753_IRMSOS     0x18
+#define ADE7753_VRMSOS     0x19
+#define ADE7753_VAGAIN     0x1A
+#define ADE7753_VADIV      0x1B
+#define ADE7753_LINECYC    0x1C
+#define ADE7753_ZXTOUT     0x1D
+#define ADE7753_SAGCYC     0x1E
+#define ADE7753_SAGLVL     0x1F
+#define ADE7753_IPKLVL     0x20
+#define ADE7753_VPKLVL     0x21
+#define ADE7753_IPEAK      0x22
+#define ADE7753_RSTIPEAK   0x23
+#define ADE7753_VPEAK      0x24
+#define ADE7753_RSTVPEAK   0x25
+#define ADE7753_TEMP       0x26
+#define ADE7753_PERIOD     0x27
+#define ADE7753_TMODE      0x3D
+#define ADE7753_CHKSUM     0x3E
+#define ADE7753_DIEREV     0x3F
+
+#define ADE7753_READ_REG(a)    a
+#define ADE7753_WRITE_REG(a) ((a) | 0x80)
+
+#define ADE7753_MAX_TX    4
+#define ADE7753_MAX_RX    4
+#define ADE7753_STARTUP_DELAY 1000
+
+#define ADE7753_SPI_SLOW    (u32)(300 * 1000)
+#define ADE7753_SPI_BURST   (u32)(1000 * 1000)
+#define ADE7753_SPI_FAST    (u32)(2000 * 1000)
+
+/**
+ * struct ade7753_state - device instance specific data
+ * @us:         actual spi_device
+ * @tx:         transmit buffer
+ * @rx:         receive buffer
+ * @buf_lock:       mutex to protect tx and rx
+ **/
+struct ade7753_state {
+	    struct spi_device   *us;
+		    struct mutex        buf_lock;
+			    u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
+				    u8          rx[ADE7753_MAX_RX];
+};
 
 static int ade7753_spi_write_reg_8(struct device *dev,
 				   u8 reg_address,
diff --git a/drivers/staging/iio/meter/ade7753.h b/drivers/staging/iio/meter/ade7753.h
deleted file mode 100644
index bfe7491..0000000
--- a/drivers/staging/iio/meter/ade7753.h
+++ /dev/null
@@ -1,72 +0,0 @@
-#ifndef _ADE7753_H
-#define _ADE7753_H
-
-#define ADE7753_WAVEFORM   0x01
-#define ADE7753_AENERGY    0x02
-#define ADE7753_RAENERGY   0x03
-#define ADE7753_LAENERGY   0x04
-#define ADE7753_VAENERGY   0x05
-#define ADE7753_RVAENERGY  0x06
-#define ADE7753_LVAENERGY  0x07
-#define ADE7753_LVARENERGY 0x08
-#define ADE7753_MODE       0x09
-#define ADE7753_IRQEN      0x0A
-#define ADE7753_STATUS     0x0B
-#define ADE7753_RSTSTATUS  0x0C
-#define ADE7753_CH1OS      0x0D
-#define ADE7753_CH2OS      0x0E
-#define ADE7753_GAIN       0x0F
-#define ADE7753_PHCAL      0x10
-#define ADE7753_APOS       0x11
-#define ADE7753_WGAIN      0x12
-#define ADE7753_WDIV       0x13
-#define ADE7753_CFNUM      0x14
-#define ADE7753_CFDEN      0x15
-#define ADE7753_IRMS       0x16
-#define ADE7753_VRMS       0x17
-#define ADE7753_IRMSOS     0x18
-#define ADE7753_VRMSOS     0x19
-#define ADE7753_VAGAIN     0x1A
-#define ADE7753_VADIV      0x1B
-#define ADE7753_LINECYC    0x1C
-#define ADE7753_ZXTOUT     0x1D
-#define ADE7753_SAGCYC     0x1E
-#define ADE7753_SAGLVL     0x1F
-#define ADE7753_IPKLVL     0x20
-#define ADE7753_VPKLVL     0x21
-#define ADE7753_IPEAK      0x22
-#define ADE7753_RSTIPEAK   0x23
-#define ADE7753_VPEAK      0x24
-#define ADE7753_RSTVPEAK   0x25
-#define ADE7753_TEMP       0x26
-#define ADE7753_PERIOD     0x27
-#define ADE7753_TMODE      0x3D
-#define ADE7753_CHKSUM     0x3E
-#define ADE7753_DIEREV     0x3F
-
-#define ADE7753_READ_REG(a)    a
-#define ADE7753_WRITE_REG(a) ((a) | 0x80)
-
-#define ADE7753_MAX_TX    4
-#define ADE7753_MAX_RX    4
-#define ADE7753_STARTUP_DELAY 1000
-
-#define ADE7753_SPI_SLOW	(u32)(300 * 1000)
-#define ADE7753_SPI_BURST	(u32)(1000 * 1000)
-#define ADE7753_SPI_FAST	(u32)(2000 * 1000)
-
-/**
- * struct ade7753_state - device instance specific data
- * @us:			actual spi_device
- * @tx:			transmit buffer
- * @rx:			receive buffer
- * @buf_lock:		mutex to protect tx and rx
- **/
-struct ade7753_state {
-	struct spi_device	*us;
-	struct mutex		buf_lock;
-	u8			tx[ADE7753_MAX_TX] ____cacheline_aligned;
-	u8			rx[ADE7753_MAX_RX];
-};
-
-#endif
-- 
2.7.4

