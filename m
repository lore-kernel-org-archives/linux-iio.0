Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org,
	wsa@the-dreams.de
Cc: linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] iio: imu: inv_mpu6050: Add i2c mux for by pass
Date: Thu,  4 Dec 2014 15:10:25 -0800
Message-Id: <1417734625-13739-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1417734625-13739-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

This chip allows some limited number of sensors connected to it as
slaves, which can be directly accessed by register interface of this
driver.But the current upstream driver doesn't support such mode.
To attach such slaves to main processor i2c bus, chip has to be set
up in bypass mode. This change adds i2c mux, which will enable/disable
this mode for transaction to/from such slave devices.
This was discussed for a while in mailing list, this was the outcome:
Reference:
http://www.spinics.net/lists/linux-iio/msg12126.html
http://comments.gmane.org/gmane.linux.kernel.iio/11470

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/imu/inv_mpu6050/Kconfig        |   1 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 135 +++++++++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |   6 ++
 3 files changed, 136 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
index 2d0608b..48fbc0b 100644
--- a/drivers/iio/imu/inv_mpu6050/Kconfig
+++ b/drivers/iio/imu/inv_mpu6050/Kconfig
@@ -7,6 +7,7 @@ config INV_MPU6050_IIO
 	depends on I2C && SYSFS
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select I2C_MUX
 	help
 	  This driver supports the Invensense MPU6050 devices.
 	  This driver can also support MPU6500 in MPU6050 compatibility mode
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index b75519d..d3ad772 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -23,6 +23,7 @@
 #include <linux/kfifo.h>
 #include <linux/spinlock.h>
 #include <linux/iio/iio.h>
+#include <linux/i2c-mux.h>
 #include "inv_mpu_iio.h"
 
 /*
@@ -52,6 +53,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
 	.int_enable             = INV_MPU6050_REG_INT_ENABLE,
 	.pwr_mgmt_1             = INV_MPU6050_REG_PWR_MGMT_1,
 	.pwr_mgmt_2             = INV_MPU6050_REG_PWR_MGMT_2,
+	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
 };
 
 static const struct inv_mpu6050_chip_config chip_config_6050 = {
@@ -77,6 +79,110 @@ int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 d)
 	return i2c_smbus_write_i2c_block_data(st->client, reg, 1, &d);
 }
 
+/*
+ * The i2c read/write needs to happen in unlocked mode. As the parent
+ * adapter is common. If we use locked versions, it will fail as
+ * the mux adapter will lock the parent i2c adapter, while calling
+ * select/deselect functions.
+ */
+static int inv_mpu6050_write_reg_unlocked(struct inv_mpu6050_state *st,
+					  u8 reg, u8 d)
+{
+	int ret;
+	u8 buf[2];
+	struct i2c_msg msg[1] = {
+		{
+			.addr = st->client->addr,
+			.flags = 0,
+			.len = sizeof(buf),
+			.buf = buf,
+		}
+	};
+
+	buf[0] = reg;
+	buf[1] = d;
+	ret = __i2c_transfer(st->client->adapter, msg, 1);
+	if (ret != 1)
+		return ret;
+
+	return 0;
+}
+
+static int inv_mpu6050_select_bypass(struct i2c_adapter *adap, void *mux_priv,
+				     u32 chan_id)
+{
+	struct iio_dev *indio_dev = mux_priv;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	/* Use the same mutex which was used everywhere to protect power-op */
+	mutex_lock(&indio_dev->mlock);
+	if (!st->powerup_count) {
+		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
+						     0);
+		if (ret)
+			goto write_error;
+
+		msleep(INV_MPU6050_REG_UP_TIME);
+	}
+	if (!ret) {
+		st->powerup_count++;
+		ret = inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
+						     st->client->irq |
+						     INV_MPU6050_BIT_BYPASS_EN);
+	}
+write_error:
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+static int inv_mpu6050_deselect_bypass(struct i2c_adapter *adap,
+				       void *mux_priv, u32 chan_id)
+{
+	struct iio_dev *indio_dev = mux_priv;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	/* It doesn't really mattter, if any of the calls fails */
+	inv_mpu6050_write_reg_unlocked(st, st->reg->int_pin_cfg,
+				       st->client->irq);
+	st->powerup_count--;
+	if (!st->powerup_count)
+		inv_mpu6050_write_reg_unlocked(st, st->reg->pwr_mgmt_1,
+					       INV_MPU6050_BIT_SLEEP);
+	mutex_unlock(&indio_dev->mlock);
+
+	return 0;
+}
+
+static int inv_mpu6050_create_mux(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct i2c_client *client = st->client;
+
+	st->mux_adapter = i2c_add_mux_adapter(client->adapter,
+					      &client->dev,
+					      indio_dev,
+					      0, 0, 0,
+					      inv_mpu6050_select_bypass,
+					      inv_mpu6050_deselect_bypass);
+	if (st->mux_adapter == NULL) {
+		dev_err(&st->client->dev, "Mux create Failed\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void inv_mpu6050_destroy_mux(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *mpu_st = iio_priv(indio_dev);
+
+	if (mpu_st->mux_adapter)
+		i2c_del_mux_adapter(mpu_st->mux_adapter);
+}
+
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 {
 	u8 d, mgmt_1;
@@ -133,13 +239,22 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
 
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on)
 {
-	int result;
+	int result = 0;
+
+	if (power_on) {
+		/* Already under indio-dev->mlock mutex */
+		if (!st->powerup_count)
+			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
+						       0);
+		if (!result)
+			st->powerup_count++;
+	} else {
+		st->powerup_count--;
+		if (!st->powerup_count)
+			result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
+						       INV_MPU6050_BIT_SLEEP);
+	}
 
-	if (power_on)
-		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1, 0);
-	else
-		result = inv_mpu6050_write_reg(st, st->reg->pwr_mgmt_1,
-						INV_MPU6050_BIT_SLEEP);
 	if (result)
 		return result;
 
@@ -673,6 +788,7 @@ static int inv_mpu_probe(struct i2c_client *client,
 
 	st = iio_priv(indio_dev);
 	st->client = client;
+	st->powerup_count = 0;
 	pdata = dev_get_platdata(&client->dev);
 	if (pdata)
 		st->plat_data = *pdata;
@@ -720,8 +836,14 @@ static int inv_mpu_probe(struct i2c_client *client,
 		goto out_remove_trigger;
 	}
 
+	result = inv_mpu6050_create_mux(indio_dev);
+	if (result)
+		goto out_unreg_device;
+
 	return 0;
 
+out_unreg_device:
+	iio_device_unregister(indio_dev);
 out_remove_trigger:
 	inv_mpu6050_remove_trigger(st);
 out_unreg_ring:
@@ -734,6 +856,7 @@ static int inv_mpu_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
+	inv_mpu6050_destroy_mux(indio_dev);
 	iio_device_unregister(indio_dev);
 	inv_mpu6050_remove_trigger(st);
 	iio_triggered_buffer_cleanup(indio_dev);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e779931..aa837de 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -54,6 +54,7 @@ struct inv_mpu6050_reg_map {
 	u8 int_enable;
 	u8 pwr_mgmt_1;
 	u8 pwr_mgmt_2;
+	u8 int_pin_cfg;
 };
 
 /*device enum */
@@ -119,6 +120,8 @@ struct inv_mpu6050_state {
 	enum   inv_devices chip_type;
 	spinlock_t time_stamp_lock;
 	struct i2c_client *client;
+	struct i2c_adapter *mux_adapter;
+	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 };
@@ -179,6 +182,9 @@ struct inv_mpu6050_state {
 /* 6 + 6 round up and plus 8 */
 #define INV_MPU6050_OUTPUT_DATA_SIZE         24
 
+#define INV_MPU6050_REG_INT_PIN_CFG	0x37
+#define INV_MPU6050_BIT_BYPASS_EN	0x2
+
 /* init parameters */
 #define INV_MPU6050_INIT_FIFO_RATE           50
 #define INV_MPU6050_TIME_STAMP_TOR           5
-- 
1.9.3
