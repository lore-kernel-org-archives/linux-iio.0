Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-in-17.arcor-online.net ([151.189.21.57]:49383 "EHLO
	mail-in-17.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758590AbcG0V17 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 17:27:59 -0400
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mx.arcor.de (Postfix) with ESMTP id 3s07Pn22wZz4T4Q
	for <linux-iio@vger.kernel.org>; Wed, 27 Jul 2016 23:27:57 +0200 (CEST)
From: Giorgio <giorgio.nicole@arcor.de>
To: linux-iio@vger.kernel.org
Cc: Giorgio <giorgio.nicole@arcor.de>
Subject: [PATCH 1/1] iio:ti-ads1015: fix a wrong pointer definition.
Date: Wed, 27 Jul 2016 23:27:49 +0200
Message-Id: <20160727212749.21573-1-giorgio.nicole@arcor.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The call to i2c_get_clientdata(client) returns a struct iio_dev*, not
the needed struct ads1015_data*. We need here an intermediate step as
in the function: void ads1015_get_channels_config(struct i2c_client *client).
---
 drivers/iio/adc/ti-ads1015.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 73cbf0b..fe96af6 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -403,7 +403,8 @@ static const struct iio_info ads1015_info = {
 #ifdef CONFIG_OF
 static int ads1015_get_channels_config_of(struct i2c_client *client)
 {
-	struct ads1015_data *data = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device_node *node;
 
 	if (!client->dev.of_node ||
-- 
2.9.2

