Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50250 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733030AbeKLISl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Nov 2018 03:18:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id 124-v6so6736163wmw.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Nov 2018 14:28:44 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: do not use a fixed read len in read_oneshot
Date: Sun, 11 Nov 2018 23:28:28 +0100
Message-Id: <e0b8bcec785b02cf14aab34a524878df6ed4cd7a.1541975146.git.lorenzo.bianconi@redhat.com>
In-Reply-To: <cover.1541975146.git.lorenzo.bianconi@redhat.com>
References: <cover.1541975146.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Generalize st_lsm6dsx_shub_read_oneshot in order to not use a fixed
read length and take into account iio channel realbits for single
read operations

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 31 +++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index ee59b0cac84f..b908df0380b3 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -27,6 +27,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/bitfield.h>
+#include <linux/slab.h>
 
 #include "st_lsm6dsx.h"
 
@@ -432,31 +433,39 @@ st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 			     struct iio_chan_spec const *ch,
 			     int *val)
 {
-	int err, delay, len = ch->scan_type.realbits >> 3;
-	__le16 data;
+	int ret, delay, len = ch->scan_type.realbits >> 3;
+	u8 *data;
 
-	err = st_lsm6dsx_shub_set_enable(sensor, true);
-	if (err < 0)
-		return err;
+	ret = st_lsm6dsx_shub_set_enable(sensor, true);
+	if (ret < 0)
+		return ret;
+
+	data = kmalloc(len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	delay = 1000000 / sensor->odr;
 	usleep_range(delay, 2 * delay);
 
-	err = st_lsm6dsx_shub_read(sensor, ch->address, (u8 *)&data, len);
-	if (err < 0)
-		return err;
+	ret = st_lsm6dsx_shub_read(sensor, ch->address, data, len);
+	if (ret < 0)
+		goto out;
 
 	st_lsm6dsx_shub_set_enable(sensor, false);
 
 	switch (len) {
 	case 2:
-		*val = (s16)le16_to_cpu(data);
+		*val = (s16)le16_to_cpu(*((__le16 *)data));
+		ret = IIO_VAL_INT;
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
+		break;
 	}
 
-	return IIO_VAL_INT;
+out:
+	kfree(data);
+	return ret;
 }
 
 static int
-- 
2.19.1
