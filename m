Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33888 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751147AbcG1Wkl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jul 2016 18:40:41 -0400
Received: by mail-pa0-f68.google.com with SMTP id hh10so4185255pac.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jul 2016 15:40:41 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: giorgio.nicole@arcor.de, Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH] iio: adc: ti-ads1015: fix incorrect referencing of ads1015_data pointer
Date: Thu, 28 Jul 2016 15:40:37 -0700
Message-Id: <1469745637-998-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reported-by: Giorgio <giorgio.nicole@arcor.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 73cbf0b54e54..fe96af6059d5 100644
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
2.7.4

