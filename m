Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40108 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757724Ab2EaCZW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 30 May 2012 22:25:22 -0400
Received: from dlelxv30.itg.ti.com ([172.17.2.17])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id q4V2PLmS029832
	for <linux-iio@vger.kernel.org>; Wed, 30 May 2012 21:25:21 -0500
Received: from DFLE70.ent.ti.com (dfle70.ent.ti.com [128.247.5.40])
	by dlelxv30.itg.ti.com (8.13.8/8.13.8) with ESMTP id q4V2PL7L021453
	for <linux-iio@vger.kernel.org>; Wed, 30 May 2012 21:25:21 -0500
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Leed Aguilar <leed.aguilar@ti.com>
Subject: [PATCH] staging:iio:magnetometer:ak8975: use gpio_request_one api
Date: Wed, 30 May 2012 21:20:45 -0400
Message-ID: <1338427245-15335-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use gpio_request_one api, it looks cleaner.

Change-Id: I0c31a9662d6f4db95117fba89faf3b4a6ee09f6f
Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
---
 drivers/staging/iio/magnetometer/ak8975.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index ebc2d08..52833cd 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -487,21 +487,13 @@ static int ak8975_probe(struct i2c_client *client,
 	/* We may not have a GPIO based IRQ to scan, that is fine, we will
 	   poll if so */
 	if (gpio_is_valid(eoc_gpio)) {
-		err = gpio_request(eoc_gpio, "ak_8975");
+		err = gpio_request_one(eoc_gpio, GPIOF_IN, "ak_8975");
 		if (err < 0) {
 			dev_err(&client->dev,
 				"failed to request GPIO %d, error %d\n",
 							eoc_gpio, err);
 			goto exit;
 		}
-
-		err = gpio_direction_input(eoc_gpio);
-		if (err < 0) {
-			dev_err(&client->dev,
-				"Failed to configure input direction for GPIO %d, error %d\n",
-						eoc_gpio, err);
-			goto exit_gpio;
-		}
 	}
 
 	/* Register with IIO */
-- 
1.7.1

