Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.netline.ch ([148.251.143.178]:50071 "EHLO
	netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbcHQKzX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2016 06:55:23 -0400
From: Marc Andre <marc.andre@netline.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	Marc Andre <marc.andre@netline.ch>
Subject: [PATCH] iio: adc: ti-ads1015: Fix invalid private data reference
Date: Wed, 17 Aug 2016 12:46:30 +0200
Message-Id: <1471430790-110450-1-git-send-email-marc.andre@netline.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In ads1015_get_channels_config_of() the private data of
i2c_client was wrongly taken directly as the ads1015_data. In
fact this private data is a reference to iio_dev. The correct
ads1015_data is taken from the private data of the iio_dev.

Fixed this.

Signed-off-by: Marc Andre <marc.andre@netline.ch>
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
1.9.1

