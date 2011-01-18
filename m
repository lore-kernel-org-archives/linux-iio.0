Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50638 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab1ARG6k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 18 Jan 2011 01:58:40 -0500
From: shubhrajyoti@ti.com
To: linux-iio@vger.kernel.org
Cc: achew@nvidia.com, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH] [RFC] ak8975: Trivial optimisations
Date: Tue, 18 Jan 2011 12:28:31 +0530
Message-Id: <1295333911-3762-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>

The probe memory could be freed after init.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
Compile tested only.
 drivers/staging/iio/magnetometer/ak8975.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 420f206..694da1e 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -431,7 +431,7 @@ static struct attribute_group ak8975_attr_group = {
 	.attrs = ak8975_attr,
 };
 
-static int ak8975_probe(struct i2c_client *client,
+static int __devinit ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ak8975_data *data;
@@ -510,7 +510,7 @@ exit:
 	return err;
 }
 
-static int ak8975_remove(struct i2c_client *client)
+static int  __devexit ak8975_remove(struct i2c_client *client)
 {
 	struct ak8975_data *data = i2c_get_clientdata(client);
 
-- 
1.7.1

