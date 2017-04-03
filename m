Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34876 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbdDCR1u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Apr 2017 13:27:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id p52so35489951wrc.2
        for <linux-iio@vger.kernel.org>; Mon, 03 Apr 2017 10:27:49 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: use i2c/spi device name for iio_dev name
Date: Mon,  3 Apr 2017 19:27:39 +0200
Message-Id: <20170403172739.7291-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the correct chip name (e.g. lsm6dsm) as suffix for iio_dev name
instead of a generic one (lsm6dsx)

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  4 +++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 +++++++++-----
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 6a9849e..4839db7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -71,6 +71,7 @@ enum st_lsm6dsx_fifo_mode {
 
 /**
  * struct st_lsm6dsx_sensor - ST IMU sensor instance
+ * @name: Sensor name.
  * @id: Sensor identifier.
  * @hw: Pointer to instance of struct st_lsm6dsx_hw.
  * @gain: Configured sensor sensitivity.
@@ -83,6 +84,7 @@ enum st_lsm6dsx_fifo_mode {
  * @ts: Latest timestamp from the interrupt handler.
  */
 struct st_lsm6dsx_sensor {
+	char name[32];
 	enum st_lsm6dsx_sensor_id id;
 	struct st_lsm6dsx_hw *hw;
 
@@ -133,7 +135,7 @@ struct st_lsm6dsx_hw {
 #endif /* CONFIG_SPI_MASTER */
 };
 
-int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
+int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		     const struct st_lsm6dsx_transfer_function *tf_ops);
 int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
 int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index f80a3d4..98b51d7 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -642,7 +642,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 }
 
 static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
-					       enum st_lsm6dsx_sensor_id id)
+					       enum st_lsm6dsx_sensor_id id,
+					       const char *name)
 {
 	struct st_lsm6dsx_sensor *sensor;
 	struct iio_dev *iio_dev;
@@ -666,27 +667,30 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
 	case ST_LSM6DSX_ID_ACC:
 		iio_dev->channels = st_lsm6dsx_acc_channels;
 		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
-		iio_dev->name = "lsm6dsx_accel";
 		iio_dev->info = &st_lsm6dsx_acc_info;
 
 		sensor->decimator_mask = ST_LSM6DSX_REG_ACC_DEC_MASK;
+		scnprintf(sensor->name, sizeof(sensor->name), "%s_accel",
+			  name);
 		break;
 	case ST_LSM6DSX_ID_GYRO:
 		iio_dev->channels = st_lsm6dsx_gyro_channels;
 		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
-		iio_dev->name = "lsm6dsx_gyro";
 		iio_dev->info = &st_lsm6dsx_gyro_info;
 
 		sensor->decimator_mask = ST_LSM6DSX_REG_GYRO_DEC_MASK;
+		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
+			  name);
 		break;
 	default:
 		return NULL;
 	}
+	iio_dev->name = sensor->name;
 
 	return iio_dev;
 }
 
-int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
+int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 		     const struct st_lsm6dsx_transfer_function *tf_ops)
 {
 	struct st_lsm6dsx_hw *hw;
@@ -710,7 +714,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 		return err;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
-		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i);
+		hw->iio_devs[i] = st_lsm6dsx_alloc_iiodev(hw, i, name);
 		if (!hw->iio_devs[i])
 			return -ENOMEM;
 	}
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
index 2e4ed26..09a51cf 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
@@ -61,7 +61,7 @@ static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
 	return st_lsm6dsx_probe(&client->dev, client->irq,
-				(int)id->driver_data,
+				(int)id->driver_data, id->name,
 				&st_lsm6dsx_transfer_fn);
 }
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
index 1bf4a58..f765a50 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
@@ -78,7 +78,7 @@ static int st_lsm6dsx_spi_probe(struct spi_device *spi)
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	return st_lsm6dsx_probe(&spi->dev, spi->irq,
-				(int)id->driver_data,
+				(int)id->driver_data, id->name,
 				&st_lsm6dsx_transfer_fn);
 }
 
-- 
2.9.3

