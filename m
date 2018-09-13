Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44187 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeIMI72 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Sep 2018 04:59:28 -0400
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang.1304521@gmail.com>
Subject: [PATCH] iio: proximity: lidar-v2: replace i2c block access method with the one already implemented.
Date: Thu, 13 Sep 2018 11:51:45 +0800
Message-Id: <20180913035145.28056-1-songqiang.1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This driver tries to access a block of data on a i2c bus and it tries
to manually make a device command frame and a consecutively read frame,
then uses i2c_transfer() to read data. But this has already been
implemented in i2c_smbus_read_i2c_block_data().
Sorry for not having this device by my hand, which is a little expansive
for me, but I have another i2c device and tested with both i2c_transfer()
and i2c_smbus_read_i2c_block_data() and they all ends the same.
I'm not familiar with the SMBus, don't know if the lidar_smbus_xfer()
function is the same as i2c_smbus_read_block_data()? The original code
is commented with something I'm not sure, but I think if it's a standard
SMBus, it should be able to use in here.
Hoping for someone to explain.

Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
---
 .../iio/proximity/pulsedlight-lidar-lite-v2.c  | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 47af54f14756..ca880ba8e820 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -63,23 +63,7 @@ static const struct iio_chan_spec lidar_channels[] = {
 
 static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
 {
-	struct i2c_client *client = data->client;
-	struct i2c_msg msg[2];
-	int ret;
-
-	msg[0].addr = client->addr;
-	msg[0].flags = client->flags | I2C_M_STOP;
-	msg[0].len = 1;
-	msg[0].buf  = (char *) &reg;
-
-	msg[1].addr = client->addr;
-	msg[1].flags = client->flags | I2C_M_RD;
-	msg[1].len = len;
-	msg[1].buf = (char *) val;
-
-	ret = i2c_transfer(client->adapter, msg, 2);
-
-	return (ret == 2) ? 0 : -EIO;
+	return i2c_smbus_read_i2c_block_data(data->client, reg, len, val);
 }
 
 static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
-- 
2.17.1
