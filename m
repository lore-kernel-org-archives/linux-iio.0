Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42751 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751385Ab3FWV23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:28:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Ge Gao <ggao@invensense.com>
Subject: [PATCH 2/5] iio: use I2C_FUNC_SMBUS_I2C_BLOCK macro
Date: Sun, 23 Jun 2013 23:28:17 +0200
Message-Id: <1372022900-18670-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I do not see why the driver requires I2C_FUNC_SMBUS_I2C_BLOCK,
actually only single bytes or words are transferred

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Ge Gao <ggao@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index fe4c61e..6a1ff80 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -663,8 +663,8 @@ static int inv_mpu_probe(struct i2c_client *client,
 	int result;
 
 	if (!i2c_check_functionality(client->adapter,
-					I2C_FUNC_SMBUS_READ_I2C_BLOCK |
-					I2C_FUNC_SMBUS_WRITE_I2C_BLOCK)) {
+		I2C_FUNC_SMBUS_I2C_BLOCK)) {
+
 		result = -ENOSYS;
 		goto out_no_free;
 	}
-- 
1.8.3.1

