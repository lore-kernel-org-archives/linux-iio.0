Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:36696 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752820AbcHPSnt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 14:43:49 -0400
From: Giorgio Dal Molin <giorgio.nicole@arcor.de>
To: linux-iio@vger.kernel.org
Cc: Giorgio Dal Molin <giorgio.nicole@arcor.de>,
	jic23@jic23.retrosnub.co.uk
Subject: [PATCH 1/1] iio:ti-ads1015: fix a wrong pointer definition.
Date: Tue, 16 Aug 2016 20:43:37 +0200
Message-Id: <20160816184337.17059-1-giorgio.nicole@arcor.de>
In-Reply-To: <CAKzfze9e3U5MjgbwQYn7_APnvDMJpX8ORrstsASrrbN6bp5UOg@mail.gmail.com>
References: <CAKzfze9e3U5MjgbwQYn7_APnvDMJpX8ORrstsASrrbN6bp5UOg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The call to i2c_get_clientdata(client) returns a struct iio_dev*, not
the needed struct ads1015_data*. We need here an intermediate step as
in the function: void ads1015_get_channels_config(struct i2c_client *client).

Signed-off-by: Giorgio Dal Molin <giorgio.nicole@arcor.de>
---
 drivers/iio/adc/ti-ads1015.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 1ef39877..066abaf 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -489,7 +489,8 @@ static struct iio_info ads1115_info = {
 #ifdef CONFIG_OF
 static int ads1015_get_channels_config_of(struct i2c_client *client)
 {
-	struct ads1015_data *data = i2c_get_clientdata(client);
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads1015_data *data = iio_priv(indio_dev);
 	struct device_node *node;
 
 	if (!client->dev.of_node ||
-- 
2.9.3

