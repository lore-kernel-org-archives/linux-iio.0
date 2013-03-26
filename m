Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1060 "EHLO
	smtp-out-226.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932364Ab3CZSlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2013 14:41:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/6] staging:iio:ad799x: Use i2c_smbus_{read,write}_word_data_swapped
Date: Tue, 26 Mar 2013 19:43:01 +0100
Message-Id: <1364323384-30863-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1364323384-30863-1-git-send-email-lars@metafoo.de>
References: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use i2c_smbus_{read,write}_word_data_swapped instead of open-coding it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index d12a4b2..8d2012c 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -48,13 +48,13 @@ static int ad799x_i2c_read16(struct ad799x_state *st, u8 reg, u16 *data)
 	struct i2c_client *client = st->client;
 	int ret = 0;
 
-	ret = i2c_smbus_read_word_data(client, reg);
+	ret = i2c_smbus_read_word_swapped(client, reg);
 	if (ret < 0) {
 		dev_err(&client->dev, "I2C read error\n");
 		return ret;
 	}
 
-	*data = swab16((u16)ret);
+	*data = (u16)ret;
 
 	return 0;
 }
@@ -80,7 +80,7 @@ static int ad799x_i2c_write16(struct ad799x_state *st, u8 reg, u16 data)
 	struct i2c_client *client = st->client;
 	int ret = 0;
 
-	ret = i2c_smbus_write_word_data(client, reg, swab16(data));
+	ret = i2c_smbus_write_word_swapped(client, reg, data);
 	if (ret < 0)
 		dev_err(&client->dev, "I2C write error\n");
 
-- 
1.8.0

