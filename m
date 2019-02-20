Return-Path: <SRS0=QBqV=Q3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BBAC43381
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7672086A
	for <linux-iio@archiver.kernel.org>; Wed, 20 Feb 2019 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbfBTPU5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:20:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:55853 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfBTPU5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 20 Feb 2019 10:20:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2019 07:20:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,391,1544515200"; 
   d="scan'208";a="119429462"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Feb 2019 07:20:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3567A159; Wed, 20 Feb 2019 17:20:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] iio: Allow to read mount matrix from ACPI
Date:   Wed, 20 Feb 2019 18:20:52 +0300
Message-Id: <20190220152052.31901-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Currently mount matrix is allowed in Device Tree, though there is
no technical issue to extend it to support ACPI.

Convert the function to use device_property_read_string_array() and
thus allow to read mount matrix from ACPI if available.

At the same time drop the "of" prefix from its name and
convert current users.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/accel/kxsd9.c                  |  2 +-
 drivers/iio/gyro/mpu3050-core.c            |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 +-
 drivers/iio/industrialio-core.c            | 46 +++++++++-------------
 drivers/iio/magnetometer/ak8974.c          |  2 +-
 drivers/iio/magnetometer/ak8975.c          |  2 +-
 include/linux/iio/iio.h                    |  4 +-
 7 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 0c0df4fce420..f73404ca715e 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -420,7 +420,7 @@ int kxsd9_common_probe(struct device *dev,
 	indio_dev->available_scan_masks = kxsd9_scan_masks;
 
 	/* Read the mounting matrix, if present */
-	ret = of_iio_read_mount_matrix(dev,
+	ret = iio_read_mount_matrix(dev,
 				       "mount-matrix",
 				       &st->orientation);
 	if (ret)
diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 77fac81a3adc..0a7d0dde020e 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1149,7 +1149,7 @@ int mpu3050_common_probe(struct device *dev,
 	mpu3050->divisor = 99;
 
 	/* Read the mounting matrix, if present */
-	ret = of_iio_read_mount_matrix(dev, "mount-matrix",
+	ret = iio_read_mount_matrix(dev, "mount-matrix",
 				       &mpu3050->orientation);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 1e428c196a82..e2c8e8ca324a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -990,7 +990,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	pdata = dev_get_platdata(dev);
 	if (!pdata) {
-		result = of_iio_read_mount_matrix(dev, "mount-matrix",
+		result = iio_read_mount_matrix(dev, "mount-matrix",
 						  &st->orientation);
 		if (result) {
 			dev_err(dev, "Failed to retrieve mounting matrix %d\n",
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 4f5cd9f60870..3baede140d69 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -19,6 +19,7 @@
 #include <linux/device.h>
 #include <linux/fs.h>
 #include <linux/poll.h>
+#include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/cdev.h>
@@ -525,8 +526,8 @@ ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
 EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
 
 /**
- * of_iio_read_mount_matrix() - retrieve iio device mounting matrix from
- *                              device-tree "mount-matrix" property
+ * iio_read_mount_matrix() - retrieve iio device mounting matrix from
+ *                           device "mount-matrix" property
  * @dev:	device the mounting matrix property is assigned to
  * @propname:	device specific mounting matrix property name
  * @matrix:	where to store retrieved matrix
@@ -536,40 +537,29 @@ EXPORT_SYMBOL_GPL(iio_show_mount_matrix);
  *
  * Return: 0 if success, or a negative error code on failure.
  */
-#ifdef CONFIG_OF
-int of_iio_read_mount_matrix(const struct device *dev,
-			     const char *propname,
-			     struct iio_mount_matrix *matrix)
+int iio_read_mount_matrix(struct device *dev, const char *propname,
+			  struct iio_mount_matrix *matrix)
 {
-	if (dev->of_node) {
-		int err = of_property_read_string_array(dev->of_node,
-				propname, matrix->rotation,
-				ARRAY_SIZE(iio_mount_idmatrix.rotation));
+	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation); 
+	int err;
 
-		if (err == ARRAY_SIZE(iio_mount_idmatrix.rotation))
-			return 0;
+	err = device_property_read_string_array(dev, propname,
+						matrix->rotation, len);
+	if (err == len)
+		return 0;
 
-		if (err >= 0)
-			/* Invalid number of matrix entries. */
-			return -EINVAL;
+	if (err >= 0)
+		/* Invalid number of matrix entries. */
+		return -EINVAL;
 
-		if (err != -EINVAL)
-			/* Invalid matrix declaration format. */
-			return err;
-	}
+	if (err != -EINVAL)
+		/* Invalid matrix declaration format. */
+		return err;
 
 	/* Matrix was not declared at all: fallback to identity. */
 	return iio_setup_mount_idmatrix(dev, matrix);
 }
-#else
-int of_iio_read_mount_matrix(const struct device *dev,
-			     const char *propname,
-			     struct iio_mount_matrix *matrix)
-{
-	return iio_setup_mount_idmatrix(dev, matrix);
-}
-#endif
-EXPORT_SYMBOL(of_iio_read_mount_matrix);
+EXPORT_SYMBOL(iio_read_mount_matrix);
 
 static ssize_t __iio_format_value(char *buf, size_t len, unsigned int type,
 				  int size, const int *vals)
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 93be1f4c0f27..9bf21e5fe3fc 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -733,7 +733,7 @@ static int ak8974_probe(struct i2c_client *i2c,
 	ak8974->i2c = i2c;
 	mutex_init(&ak8974->lock);
 
-	ret = of_iio_read_mount_matrix(&i2c->dev,
+	ret = iio_read_mount_matrix(&i2c->dev,
 				       "mount-matrix",
 				       &ak8974->orientation);
 	if (ret)
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d430b80808ef..dca20df1310e 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -911,7 +911,7 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_irq = 0;
 
 	if (!pdata) {
-		err = of_iio_read_mount_matrix(&client->dev,
+		err = iio_read_mount_matrix(&client->dev,
 					       "mount-matrix",
 					       &data->orientation);
 		if (err)
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a74cb177dc6f..bb10c1bee301 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -130,8 +130,8 @@ struct iio_mount_matrix {
 
 ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
 			      const struct iio_chan_spec *chan, char *buf);
-int of_iio_read_mount_matrix(const struct device *dev, const char *propname,
-			     struct iio_mount_matrix *matrix);
+int iio_read_mount_matrix(struct device *dev, const char *propname,
+			  struct iio_mount_matrix *matrix);
 
 typedef const struct iio_mount_matrix *
 	(iio_get_mount_matrix_t)(const struct iio_dev *indio_dev,
-- 
2.20.1

