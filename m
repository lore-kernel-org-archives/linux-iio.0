Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57390 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802Ab2E1PMH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 May 2012 11:12:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4SFC50u001050
	for <linux-iio@vger.kernel.org>; Mon, 28 May 2012 10:12:05 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4SFC4pR017210
	for <linux-iio@vger.kernel.org>; Mon, 28 May 2012 20:42:04 +0530 (IST)
From: Shubhrajyoti D <shubhrajyoti@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 1/2] iio: hmc5843: Make it behave better as modules
Date: Mon, 28 May 2012 20:42:00 +0530
Message-ID: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The memory regions of the probe and remove are move
to __devinit and __devexit respectively.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index c1fa09f..6c3e50f 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -665,7 +665,7 @@ static const struct iio_info hmc5843_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int hmc5843_probe(struct i2c_client *client,
+static int __devinit hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct hmc5843_data *data;
@@ -704,7 +704,7 @@ exit:
 	return err;
 }
 
-static int hmc5843_remove(struct i2c_client *client)
+static int __devexit hmc5843_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 
@@ -755,7 +755,7 @@ static struct i2c_driver hmc5843_driver = {
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
-	.remove		= hmc5843_remove,
+	.remove		= __devexit_p(hmc5843_remove),
 	.detect		= hmc5843_detect,
 	.address_list	= normal_i2c,
 };
-- 
1.7.5.4

