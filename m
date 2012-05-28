Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52595 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab2E1PMH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 May 2012 11:12:07 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4SFC52R014593
	for <linux-iio@vger.kernel.org>; Mon, 28 May 2012 10:12:06 -0500
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4SFC4CP017214
	for <linux-iio@vger.kernel.org>; Mon, 28 May 2012 20:42:04 +0530 (IST)
From: Shubhrajyoti D <shubhrajyoti@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 2/2] iio: ak8975: Make it behave better as modules
Date: Mon, 28 May 2012 20:42:01 +0530
Message-ID: <1338217921-23174-2-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com>
References: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The memory regions of the probe and remove are move
to __devinit and __devexit respectively.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
dont have hardware. Untested.

 drivers/staging/iio/magnetometer/ak8975.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 5834e4a..7562caf 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -471,7 +471,7 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
-static int ak8975_probe(struct i2c_client *client,
+static int __devinit ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ak8975_data *data;
@@ -545,7 +545,7 @@ exit:
 	return err;
 }
 
-static int ak8975_remove(struct i2c_client *client)
+static int __devexit ak8975_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ak8975_data *data = iio_priv(indio_dev);
-- 
1.7.5.4

