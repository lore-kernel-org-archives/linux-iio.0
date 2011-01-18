Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56117 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267Ab1ARG7T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 18 Jan 2011 01:59:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0I6xGD8002455
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-iio@vger.kernel.org>; Tue, 18 Jan 2011 00:59:18 -0600
From: shubhrajyoti@ti.com
To: linux-iio@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH ] hmc5843: Trivial optimisation
Date: Tue, 18 Jan 2011 12:29:11 +0530
Message-Id: <1295333951-3793-2-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1295333951-3793-1-git-send-email-shubhrajyoti@ti.com>
References: <1295333951-3793-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>

Free the memory that is used only at init


Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index b1c26d8..9df66cd 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -529,7 +529,7 @@ static void hmc5843_init_client(struct i2c_client *client)
 	pr_info("HMC5843 initialized\n");
 }
 
-static int hmc5843_probe(struct i2c_client *client,
+static int __devinit hmc5843_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
 	struct hmc5843_data *data;
@@ -574,7 +574,7 @@ exit:
 	return err;
 }
 
-static int hmc5843_remove(struct i2c_client *client)
+static int __devexit hmc5843_remove(struct i2c_client *client)
 {
 	struct hmc5843_data *data = i2c_get_clientdata(client);
 	 /*  sleep mode to save power */
@@ -616,7 +616,7 @@ static struct i2c_driver hmc5843_driver = {
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
-	.remove		= hmc5843_remove,
+	.remove		=  __devexit_p(hmc5843_remove),
 	.detect		= hmc5843_detect,
 	.address_list	= normal_i2c,
 };
-- 
1.7.1

