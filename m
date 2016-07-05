Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37778 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755028AbcGEKX2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 06:23:28 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: light: vcnl4000: Mention and check support for VCNL4010 and VCNL4020
Date: Tue,  5 Jul 2016 12:23:18 +0200
Message-Id: <1467714201-11429-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
References: <1467714201-11429-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

VCNL4000, VCNL4010 and VCNL4020 chips are fairly compatible from a software
point of view, added features are not yet supported by the driver

patch adds a check for the product ID and demotes the corresponding
dev_info() to dev_dbg()

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/light/Kconfig    |    6 +++---
 drivers/iio/light/vcnl4000.c |   19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 7c566f5..2821747 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -333,11 +333,11 @@ config US5182D
 	 will be called us5182d.
 
 config VCNL4000
-	tristate "VCNL4000 combined ALS and proximity sensor"
+	tristate "VCNL4000/4010/4020 combined ALS and proximity sensor"
 	depends on I2C
 	help
-	 Say Y here if you want to build a driver for the Vishay VCNL4000
-	 combined ambient light and proximity sensor.
+	 Say Y here if you want to build a driver for the Vishay VCNL4000,
+	 VCNL4010, VCNL4020 combined ambient light and proximity sensor.
 
 	 To compile this driver as a module, choose M here: the
 	 module will be called vcnl4000.
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index c9d85bb..071ff97 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1,6 +1,6 @@
 /*
- * vcnl4000.c - Support for Vishay VCNL4000 combined ambient light and
- * proximity sensor
+ * vcnl4000.c - Support for Vishay VCNL4000/4010/4020 combined ambient
+ * light and proximity sensor
  *
  * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
  *
@@ -13,6 +13,8 @@
  * TODO:
  *   allow to adjust IR current
  *   proximity threshold and event handling
+ *   periodic ALS/proximity measurement (VCNL4010/20)
+ *   interrupts (VCNL4010/20)
  */
 
 #include <linux/module.h>
@@ -24,6 +26,8 @@
 #include <linux/iio/sysfs.h>
 
 #define VCNL4000_DRV_NAME "vcnl4000"
+#define VCNL4000_ID		0x01
+#define VCNL4010_ID		0x02 /* for VCNL4020, VCNL4010 */
 
 #define VCNL4000_COMMAND	0x80 /* Command register */
 #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
@@ -155,7 +159,7 @@ static int vcnl4000_probe(struct i2c_client *client,
 {
 	struct vcnl4000_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, prod_id;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -169,8 +173,13 @@ static int vcnl4000_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
-	dev_info(&client->dev, "VCNL4000 Ambient light/proximity sensor, Prod %02x, Rev: %02x\n",
-		ret >> 4, ret & 0xf);
+	prod_id = ret >> 4;
+	if (prod_id != VCNL4010_ID && prod_id != VCNL4000_ID)
+		return -ENODEV;
+
+	dev_dbg(&client->dev, "%s Ambient light/proximity sensor, Rev: %02x\n",
+		(prod_id == VCNL4010_ID) ? "VCNL4010/4020" : "VCNL4000",
+		ret & 0xf);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &vcnl4000_info;
-- 
1.7.10.4

