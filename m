Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Ge Gao <ggao@invensense.com>
Subject: [PATCH] iio: inv_mpu6050: Do burst reads using spi/i2c directly
Date: Thu, 28 Apr 2016 13:24:10 +0300
Message-Id: <8c9aceb55d87ad4e77489bc8eca5e04259f4edff.1461838654.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Using regmap_read_bulk is wrong because it assumes that a range of
registers is being read. In our case reading from the fifo register will return
multiple values but this is *not* auto-increment.

This currently works by accident.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---

There is a need to determine if the underlying device is I2C or SPI here and
the current solution is not terribly pretty. Perhaps the i2c_client/spi_device
should be stored in inv_mpu6050_state instead?

I ran into this issue while attempting to enable regmap caching but perhaps it
could also be exposed by unusual i2c adapter capabilities?

 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 33 ++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index d070062..8455af0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kfifo.h>
 #include <linux/poll.h>
+#include <linux/spi/spi.h>
 #include "inv_mpu_iio.h"
 
 static void inv_clear_kfifo(struct inv_mpu6050_state *st)
@@ -128,6 +129,13 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	u16 fifo_count;
 	s64 timestamp;
 
+	struct device *regmap_dev = regmap_get_device(st->map);
+	struct i2c_client *i2c;
+	struct spi_device *spi = NULL;
+
+	i2c = i2c_verify_client(regmap_dev);
+	spi = i2c ? NULL: to_spi_device(regmap_dev);
+
 	mutex_lock(&indio_dev->mlock);
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable))
@@ -160,10 +168,27 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
 		goto flush_fifo;
 	while (fifo_count >= bytes_per_datum) {
-		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
-					  data, bytes_per_datum);
-		if (result)
-			goto flush_fifo;
+		/*
+		 * We need to do a large burst read from a single register.
+		 *
+		 * regmap_read_bulk assumes that multiple registers are
+		 * involved but in our case st->reg->fifo_r_w + 1 is something
+		 * completely unrelated.
+		 */
+		if (spi) {
+			u8 cmd = st->reg->fifo_r_w | 0x80;
+			result = spi_write_then_read(spi,
+					&cmd, 1,
+					data, bytes_per_datum);
+			if (result)
+				goto flush_fifo;
+		} else {
+			result = i2c_smbus_read_i2c_block_data(i2c,
+					st->reg->fifo_r_w,
+					bytes_per_datum, data);
+			if (result != bytes_per_datum)
+				goto flush_fifo;
+		}
 
 		result = kfifo_out(&st->timestamps, &timestamp, 1);
 		/* when there is no timestamp, put timestamp as 0 */
-- 
2.5.5
