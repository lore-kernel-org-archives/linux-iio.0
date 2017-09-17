Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:60078
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751631AbdIQPBG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 11:01:06 -0400
Date: Sun, 17 Sep 2017 17:01:04 +0200
Message-Id: <7bab949c05f3fb70014bda990d7217ac98b08cbd.1505660069.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 7/8] iio: accel: kxcjk1013: remove unused platform data
 struct
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

kxcjk1013's platform data has no in-kernel users. Remove it.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c       | 14 +-------------
 include/linux/iio/accel/kxcjk_1013.h | 22 ----------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 8892dc5d2422..7c010892945c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -29,7 +29,6 @@
 #include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/iio/accel/kxcjk_1013.h>
 
 #define KXCJK1013_DRV_NAME "kxcjk1013"
 #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
@@ -144,7 +143,6 @@ struct kxcjk1013_data {
 	u8 range;
 	int wake_thres;
 	int wake_dur;
-	bool active_high_intr;
 	bool dready_trigger_on;
 	int ev_enable_state;
 	bool motion_trigger_on;
@@ -402,10 +400,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 		return ret;
 	}
 
-	if (data->active_high_intr)
-		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
-	else
-		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEA;
+	ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
 
 	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
 					ret);
@@ -1264,7 +1259,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 {
 	struct kxcjk1013_data *data;
 	struct iio_dev *indio_dev;
-	struct kxcjk_1013_platform_data *pdata;
 	const char *name;
 	int ret;
 
@@ -1276,12 +1270,6 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
 
-	pdata = dev_get_platdata(&client->dev);
-	if (pdata)
-		data->active_high_intr = pdata->active_high_intr;
-	else
-		data->active_high_intr = true; /* default polarity */
-
 	if (id) {
 		data->chipset = (enum kx_chipset)(id->driver_data);
 		name = id->name;
diff --git a/include/linux/iio/accel/kxcjk_1013.h b/include/linux/iio/accel/kxcjk_1013.h
deleted file mode 100644
index fd1d540ea62d..000000000000
--- a/include/linux/iio/accel/kxcjk_1013.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * KXCJK-1013 3-axis accelerometer Interface
- * Copyright (c) 2014, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#ifndef __IIO_KXCJK_1013_H__
-#define __IIO_KXCJK_1013_H__
-
-struct kxcjk_1013_platform_data {
-	bool active_high_intr;
-};
-
-#endif
-- 
2.11.0

