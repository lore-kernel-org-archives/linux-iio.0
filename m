Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0058.outbound.protection.outlook.com ([104.47.33.58]:3746
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750893AbdE2J7r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 May 2017 05:59:47 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH v2] iio: imu: inv_mpu6050: add accel lpf setting for chip >=
 MPU6500
Date: Mon, 29 May 2017 09:59:40 +0000
Message-ID: <BLUPR12MB065724FCF3F5B2401A52B2D9C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Starting from MPU6500, accelerometer dlpf is set in a separate
register named ACCEL_CONFIG_2.
Add this new register in the map and set it for the corresponding
chips.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 39 ++++++++++++++++++++++++++=
+---
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  3 +++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 96dabbd..88a7c5d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -41,6 +41,7 @@
 static const struct inv_mpu6050_reg_map reg_set_6500 =3D {
 	.sample_rate_div	=3D INV_MPU6050_REG_SAMPLE_RATE_DIV,
 	.lpf                    =3D INV_MPU6050_REG_CONFIG,
+	.accel_lpf              =3D INV_MPU6500_REG_ACCEL_CONFIG_2,
 	.user_ctrl              =3D INV_MPU6050_REG_USER_CTRL,
 	.fifo_en                =3D INV_MPU6050_REG_FIFO_EN,
 	.gyro_config            =3D INV_MPU6050_REG_GYRO_CONFIG,
@@ -211,6 +212,37 @@ int inv_mpu6050_set_power_itg(struct inv_mpu6050_state=
 *st, bool power_on)
 EXPORT_SYMBOL_GPL(inv_mpu6050_set_power_itg);
=20
 /**
+ *  inv_mpu6050_set_lpf_regs() - set low pass filter registers, chip depen=
dent
+ *
+ *  MPU60xx/MPU9150 use only 1 register for accelerometer + gyroscope
+ *  MPU6500 and above have a dedicated register for accelerometer
+ */
+static int inv_mpu6050_set_lpf_regs(struct inv_mpu6050_state *st,
+				    enum inv_mpu6050_filter_e val)
+{
+	int result;
+
+	result =3D regmap_write(st->map, st->reg->lpf, val);
+	if (result)
+		return result;
+
+	switch (st->chip_type) {
+	case INV_MPU6050:
+	case INV_MPU6000:
+	case INV_MPU9150:
+		/* old chips, nothing to do */
+		result =3D 0;
+		break;
+	default:
+		/* set accel lpf */
+		result =3D regmap_write(st->map, st->reg->accel_lpf, val);
+		break;
+	}
+
+	return result;
+}
+
+/**
  *  inv_mpu6050_init_config() - Initialize hardware, disable FIFO.
  *
  *  Initial configuration:
@@ -233,8 +265,7 @@ static int inv_mpu6050_init_config(struct iio_dev *indi=
o_dev)
 	if (result)
 		return result;
=20
-	d =3D INV_MPU6050_FILTER_20HZ;
-	result =3D regmap_write(st->map, st->reg->lpf, d);
+	result =3D inv_mpu6050_set_lpf_regs(st, INV_MPU6050_FILTER_20HZ);
 	if (result)
 		return result;
=20
@@ -537,6 +568,8 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_=
dev,
  *                  would be alising. This function basically search for t=
he
  *                  correct low pass parameters based on the fifo rate, e.=
g,
  *                  sampling frequency.
+ *
+ *  lpf is set automatically when setting sampling rate to avoid any alias=
es.
  */
 static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
 {
@@ -552,7 +585,7 @@ static int inv_mpu6050_set_lpf(struct inv_mpu6050_state=
 *st, int rate)
 	while ((h < hz[i]) && (i < ARRAY_SIZE(d) - 1))
 		i++;
 	data =3D d[i];
-	result =3D regmap_write(st->map, st->reg->lpf, data);
+	result =3D inv_mpu6050_set_lpf_regs(st, data);
 	if (result)
 		return result;
 	st->chip_config.lpf =3D data;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index ef13de7..953a0c0 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -28,6 +28,7 @@
  *  struct inv_mpu6050_reg_map - Notable registers.
  *  @sample_rate_div:	Divider applied to gyro output rate.
  *  @lpf:		Configures internal low pass filter.
+ *  @accel_lpf:		Configures accelerometer low pass filter.
  *  @user_ctrl:		Enables/resets the FIFO.
  *  @fifo_en:		Determines which data will appear in FIFO.
  *  @gyro_config:	gyro config register.
@@ -47,6 +48,7 @@
 struct inv_mpu6050_reg_map {
 	u8 sample_rate_div;
 	u8 lpf;
+	u8 accel_lpf;
 	u8 user_ctrl;
 	u8 fifo_en;
 	u8 gyro_config;
@@ -188,6 +190,7 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_FIFO_THRESHOLD           500
=20
 /* mpu6500 registers */
+#define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
=20
 /* delay time in milliseconds */
--=20
1.9.1
