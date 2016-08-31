Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0110.outbound.protection.outlook.com ([104.47.2.110]:23872
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755315AbcHaIDA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Aug 2016 04:03:00 -0400
From: Peter Rosin <peda@axentia.se>
To: <linux-iio@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>,
        Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH] iio: imu: inv_mpu6050: inform the i2c mux core about how it is used
Date: Wed, 31 Aug 2016 10:02:40 +0200
Message-ID: <1472630560-4905-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The i2c mux core can then take appropriate action depending on if it is
used for an actual i2c mux, or for an arbitrator or gate. In this case
it is used as a gate.

This will make devicetree bindings simpler when they are eventually
added.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

So, this depends on the i2c-mux-dt-3 branch [1] that Jonathan
pulled to support the new mpu-3050 gyroscope driver. I had
planned to submit this post 4.9-rc1, but since the iio tree
got the prerequisite already, I'm sending it right away.

Cheers,
Peter

[1] https://github.com/peda-r/i2c-mux.git i2c-mux-dt-3

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 19580d1db597..2c3f8964a3ea 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -126,7 +126,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	st = iio_priv(dev_get_drvdata(&client->dev));
 	st->muxc = i2c_mux_alloc(client->adapter, &client->dev,
-				 1, 0, I2C_MUX_LOCKED,
+				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
 				 inv_mpu6050_select_bypass,
 				 inv_mpu6050_deselect_bypass);
 	if (!st->muxc) {
-- 
2.1.4

