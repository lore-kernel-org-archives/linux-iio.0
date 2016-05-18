Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:21472 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbcERPBq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 May 2016 11:01:46 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <ggao@invensense.com>, Peter Rosin <peda@axentia.se>,
	linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
	devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: [PATCH v2 3/7] iio: inv_mpu6050: Only toggle DATA_RDY_EN in inv_reset_fifo
Date: Wed, 18 May 2016 18:00:50 +0300
Message-Id: <37946b54fbedeb258f12413a09683c18a8825290.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c    | 13 ++++++++-----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  3 ++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 8455af0..3fc0b71 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -41,7 +41,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
 
 	/* disable interrupt */
-	result = regmap_write(st->map, st->reg->int_enable, 0);
+	result = regmap_update_bits(st->map, st->reg->int_enable,
+				    INV_MPU6050_BIT_DATA_RDY_EN, 0);
 	if (result) {
 		dev_err(regmap_get_device(st->map), "int_enable failed %d\n",
 			result);
@@ -68,8 +69,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
 	    st->chip_config.gyro_fifo_enable) {
-		result = regmap_write(st->map, st->reg->int_enable,
-				      INV_MPU6050_BIT_DATA_RDY_EN);
+		result = regmap_update_bits(st->map, st->reg->int_enable,
+					    INV_MPU6050_BIT_DATA_RDY_EN,
+					    INV_MPU6050_BIT_DATA_RDY_EN);
 		if (result)
 			return result;
 	}
@@ -92,8 +94,9 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 
 reset_fifo_fail:
 	dev_err(regmap_get_device(st->map), "reset fifo failed %d\n", result);
-	result = regmap_write(st->map, st->reg->int_enable,
-			      INV_MPU6050_BIT_DATA_RDY_EN);
+	result = regmap_update_bits(st->map, st->reg->int_enable,
+				    INV_MPU6050_BIT_DATA_RDY_EN,
+				    INV_MPU6050_BIT_DATA_RDY_EN);
 
 	return result;
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index e8818d4..1a6bad3 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -69,7 +69,8 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			return result;
 
-		result = regmap_write(st->map, st->reg->int_enable, 0);
+		result = regmap_update_bits(st->map, st->reg->int_enable,
+					INV_MPU6050_BIT_DATA_RDY_EN, 0);
 		if (result)
 			return result;
 
-- 
2.5.5

