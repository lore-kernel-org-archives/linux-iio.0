Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6410 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932567AbcERPBv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 May 2016 11:01:51 -0400
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
Subject: [RFC v2 5/7] iio: inv_mpu6050: Add support for auxiliary I2C master
Date: Wed, 18 May 2016 18:00:52 +0300
Message-Id: <2aa92f6390bdb58362755ce9d61f3260f4d77e64.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The MPU has an auxiliary I2C bus for connecting external
sensors. This bus has two operating modes:
* bypasss: which connects the primary and auxiliary busses
together. This is already supported via an i2c mux.
* master: where the MPU acts as a master to any external
connected sensors. This is implemented by this patch.

This I2C master mode also works when the MPU itself is connected via
SPI.

I2C master supports up to 5 slaves. Slaves 0-3 have a common operating
mode while slave 4 is different. This patch implements an i2c adapter
using slave 4.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  66 +++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 258 ++++++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  36 +++
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   8 -
 4 files changed, 355 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index a9fc11e..778d076 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -1,16 +1,31 @@
 InvenSense MPU-6050 Six-Axis (Gyro + Accelerometer) MEMS MotionTracking Device
 
-http://www.invensense.com/mems/gyro/mpu6050.html
-
 Required properties:
- - compatible : should be "invensense,mpu6050"
- - reg : the I2C address of the sensor
+ - compatible : one of "invensense,mpu6000", "invensense,mpu6050",
+	"invensense,mpu6000" or "invensense,mpu9150"
+ - reg : the I2C or SPI address of the sensor
  - interrupt-parent : should be the phandle for the interrupt controller
  - interrupts : interrupt mapping for GPIO IRQ
 
 Optional properties:
  - mount-matrix: an optional 3x3 mounting rotation matrix
+ - invensense,i2c-aux-master: operate aux i2c in "master" mode (default is bypass).
+
+The MPU has an auxiliary i2c bus for additional sensors. Devices attached this
+way can be described as for a regular linux i2c bus.
+
+It is possible to interact with aux devices in "bypass" or "master" mode. In
+"bypass" mode the auxiliary SDA/SCL lines are connected directly to the main i2c
+interface. In "master" mode access to aux devices is done by instructing the
+MPU to read or write i2c bytes.
+
+In "bypass" mode aux devices are listed behind a "i2c@0" node with reg = <0>;
+In "master" mode aux devices are listed behind a "i2c@1" node with reg = <1>;
 
+The master and bypass modes are not supported at the same time. The
+"invensense,i2c-aux-master" property must be set to activate master mode.
+Bypass mode is generally faster but master mode also works when the MPU is
+connected via SPI.
 
 Example:
 	mpu6050@68 {
@@ -28,3 +43,46 @@ Example:
 		               "0",                   /* y2 */
 		               "0.984807753012208";   /* z2 */
 	};
+
+Example describing mpu9150 (which includes an ak9875 on chip):
+	mpu9150@68 {
+		compatible = "invensense,mpu9150";
+		reg = <0x68>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			ak8975@0c {
+				compatible = "ak,ak8975";
+				reg = <0x0c>;
+			};
+		};
+	};
+
+Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
+	mpu6500@0 {
+		compatible = "invensense,mpu6500";
+		reg = <0x0>;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <31 1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+		i2c@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hmc5883l@1e {
+				compatible = "honeywell,hmc5883l";
+				reg = <0x1e>;
+			};
+		};
+	};
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5918c23..76683b8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -25,6 +25,8 @@
 #include <linux/iio/iio.h>
 #include <linux/i2c-mux.h>
 #include <linux/acpi.h>
+#include <linux/completion.h>
+
 #include "inv_mpu_iio.h"
 
 /*
@@ -57,6 +59,7 @@ static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
 	.accl_offset		= INV_MPU6500_REG_ACCEL_OFFSET,
 	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
+	.mst_status		= INV_MPU6050_REG_I2C_MST_STATUS,
 };
 
 static const struct inv_mpu6050_reg_map reg_set_6050 = {
@@ -77,6 +80,7 @@ static const struct inv_mpu6050_reg_map reg_set_6050 = {
 	.int_pin_cfg		= INV_MPU6050_REG_INT_PIN_CFG,
 	.accl_offset		= INV_MPU6050_REG_ACCEL_OFFSET,
 	.gyro_offset		= INV_MPU6050_REG_GYRO_OFFSET,
+	.mst_status		= INV_MPU6050_REG_I2C_MST_STATUS,
 };
 
 static const struct inv_mpu6050_chip_config chip_config_6050 = {
@@ -130,6 +134,10 @@ static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
 	case INV_MPU6050_REG_FIFO_COUNT_H:
 	case INV_MPU6050_REG_FIFO_COUNT_H + 1:
 	case INV_MPU6050_REG_FIFO_R_W:
+	case INV_MPU6050_REG_I2C_MST_STATUS:
+	case INV_MPU6050_REG_INT_STATUS:
+	case INV_MPU6050_REG_I2C_SLV4_CTRL:
+	case INV_MPU6050_REG_I2C_SLV4_DI:
 		return true;
 	default:
 		return false;
@@ -140,6 +148,8 @@ static bool inv_mpu6050_precious_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case INV_MPU6050_REG_FIFO_R_W:
+	case INV_MPU6050_REG_I2C_MST_STATUS:
+	case INV_MPU6050_REG_INT_STATUS:
 		return true;
 	default:
 		return false;
@@ -852,6 +862,225 @@ static int inv_check_and_setup_chip(struct inv_mpu6050_state *st)
 	return 0;
 }
 
+static irqreturn_t inv_mpu_irq_handler(int irq, void *private)
+{
+	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
+
+	iio_trigger_poll(st->trig);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t inv_mpu_irq_thread_handler(int irq, void *private)
+{
+	struct inv_mpu6050_state *st = (struct inv_mpu6050_state *)private;
+	int ret, val;
+
+	ret = regmap_read(st->map, st->reg->mst_status, &val);
+	if (ret < 0)
+		return ret;
+
+#ifdef CONFIG_I2C
+	if (val & INV_MPU6050_BIT_I2C_SLV4_DONE) {
+		st->slv4_done_status = val;
+		complete(&st->slv4_done);
+	}
+#endif
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_I2C
+static u32 inv_mpu_i2c_functionality(struct i2c_adapter *adap)
+{
+	return I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_BYTE;
+}
+
+static int inv_mpu_i2c_smbus_xfer_real(struct i2c_adapter *adap, u16 addr,
+				       unsigned short flags, char read_write,
+				       u8 command, int size,
+				       union i2c_smbus_data *data)
+{
+	struct inv_mpu6050_state *st = i2c_get_adapdata(adap);
+	unsigned long time_left;
+	unsigned int val;
+	u8 ctrl, status;
+	int result;
+
+	if (read_write == I2C_SMBUS_WRITE)
+		addr |= INV_MPU6050_BIT_I2C_SLV4_W;
+	else
+		addr |= INV_MPU6050_BIT_I2C_SLV4_R;
+
+	/*
+	 * Consecutive operations with the same address are very common.
+	 * Read the old addr from the regmap cache and try to avoid extra
+	 * transfers.
+	 */
+	result = regmap_read(st->map, INV_MPU6050_REG_I2C_SLV4_ADDR, &val);
+	if (result < 0)
+		return result;
+	if (addr != val) {
+		result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_ADDR, addr);
+		if (result < 0)
+			return result;
+	}
+
+	if (size == I2C_SMBUS_BYTE_DATA) {
+		result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_REG, command);
+		if (result < 0)
+			return result;
+	}
+
+	if (read_write == I2C_SMBUS_WRITE) {
+		result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_DO, data->byte);
+		if (result < 0)
+			return result;
+	}
+
+	ctrl = INV_MPU6050_BIT_SLV4_EN | INV_MPU6050_BIT_SLV4_INT_EN;
+	if (size == I2C_SMBUS_BYTE)
+		ctrl |= INV_MPU6050_BIT_SLV4_REG_DIS;
+	result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV4_CTRL, ctrl);
+	if (result < 0)
+		return result;
+
+	/* Wait for completion for both reads and writes */
+	time_left = wait_for_completion_timeout(&st->slv4_done, HZ);
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	/* Check status for transfer errors */
+	status = st->slv4_done_status;
+	if (status & INV_MPU6050_BIT_I2C_SLV4_NACK)
+		return -EIO;
+	if (status & INV_MPU6050_BIT_I2C_LOST_ARB)
+		return -EIO;
+
+	if (read_write == I2C_SMBUS_READ) {
+		result = regmap_read(st->map, INV_MPU6050_REG_I2C_SLV4_DI, &val);
+		if (result < 0)
+			return result;
+		data->byte = val;
+	}
+
+	return 0;
+}
+
+static int inv_mpu_i2c_smbus_xfer(struct i2c_adapter *adap, u16 addr,
+				  unsigned short flags, char read_write,
+				  u8 command, int size,
+				  union i2c_smbus_data *data)
+{
+	struct inv_mpu6050_state *st = i2c_get_adapdata(adap);
+	struct iio_dev *indio_dev = iio_priv_to_dev(st);
+	int result, power_result;
+
+	/*
+	 * The i2c adapter we implement is extremely limited.
+	 * Check for callers that don't check functionality bits.
+	 *
+	 * If we don't check we might succesfully return incorrect data.
+	 */
+	if (size != I2C_SMBUS_BYTE_DATA && size != I2C_SMBUS_BYTE) {
+		dev_err(&adap->dev, "unsupported xfer rw=%d size=%d\n",
+			read_write, size);
+		return -EINVAL;
+	}
+
+	mutex_lock(&indio_dev->mlock);
+	power_result = inv_mpu6050_set_power_itg(st, true);
+	mutex_unlock(&indio_dev->mlock);
+	if (power_result < 0)
+		return power_result;
+
+	result = inv_mpu_i2c_smbus_xfer_real(adap, addr, flags, read_write, command, size, data);
+
+	mutex_lock(&indio_dev->mlock);
+	power_result = inv_mpu6050_set_power_itg(st, false);
+	mutex_unlock(&indio_dev->mlock);
+	if (power_result < 0)
+		return power_result;
+
+	return result;
+}
+
+static const struct i2c_algorithm inv_mpu_i2c_algo = {
+	.smbus_xfer	=	inv_mpu_i2c_smbus_xfer,
+	.functionality	=	inv_mpu_i2c_functionality,
+};
+
+static struct device_node *inv_mpu_get_aux_i2c_ofnode(struct device_node *parent)
+{
+	struct device_node *child;
+	int result;
+	u32 reg;
+
+	if (!parent)
+		return NULL;
+	for_each_child_of_node(parent, child) {
+		result = of_property_read_u32(child, "reg", &reg);
+		if (result)
+			continue;
+		if (reg == 1 && !strcmp(child->name, "i2c"))
+			return child;
+	}
+
+	return NULL;
+}
+
+static int inv_mpu_probe_aux_master(struct iio_dev* indio_dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	int result;
+
+	/* First check i2c-aux-master property */
+	st->i2c_aux_master_mode = of_property_read_bool(dev->of_node,
+							"invensense,i2c-aux-master");
+	if (!st->i2c_aux_master_mode)
+		return 0;
+	dev_info(dev, "Configuring aux i2c in master mode\n");
+
+	result = inv_mpu6050_set_power_itg(st, true);
+	if (result < 0)
+		return result;
+
+	/* enable master */
+	st->chip_config.user_ctrl |= INV_MPU6050_BIT_I2C_MST_EN;
+	result = regmap_write(st->map, st->reg->user_ctrl, st->chip_config.user_ctrl);
+	if (result < 0)
+		return result;
+
+	result = regmap_update_bits(st->map, st->reg->int_enable,
+				 INV_MPU6050_BIT_MST_INT_EN,
+				 INV_MPU6050_BIT_MST_INT_EN);
+	if (result < 0)
+		return result;
+
+	result = inv_mpu6050_set_power_itg(st, false);
+	if (result < 0)
+		return result;
+
+	init_completion(&st->slv4_done);
+	st->aux_master_adapter.owner = THIS_MODULE;
+	st->aux_master_adapter.algo = &inv_mpu_i2c_algo;
+	st->aux_master_adapter.dev.parent = dev;
+	snprintf(st->aux_master_adapter.name, sizeof(st->aux_master_adapter.name),
+			"aux-master-%s", indio_dev->name);
+	st->aux_master_adapter.dev.of_node = inv_mpu_get_aux_i2c_ofnode(dev->of_node);
+	i2c_set_adapdata(&st->aux_master_adapter, st);
+	/* This will also probe aux devices so transfers must work now */
+	result = i2c_add_adapter(&st->aux_master_adapter);
+	if (result < 0) {
+		dev_err(dev, "i2x aux master register fail %d\n", result);
+		return result;
+	}
+
+	return 0;
+}
+#endif
+
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -931,16 +1160,39 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		goto out_unreg_ring;
 	}
 
+	/* Request interrupt for trigger and i2c master adapter */
+	result = devm_request_threaded_irq(&indio_dev->dev, st->irq,
+					   &inv_mpu_irq_handler,
+					   &inv_mpu_irq_thread_handler,
+					   IRQF_TRIGGER_RISING, "inv_mpu",
+					   st);
+	if (result) {
+		dev_err(dev, "request irq fail %d\n", result);
+		goto out_remove_trigger;
+	}
+
+#ifdef CONFIG_I2C
+	result = inv_mpu_probe_aux_master(indio_dev);
+	if (result < 0) {
+		dev_err(dev, "i2c aux master probe fail %d\n", result);
+		goto out_remove_trigger;
+	}
+#endif
+
 	INIT_KFIFO(st->timestamps);
 	spin_lock_init(&st->time_stamp_lock);
 	result = iio_device_register(indio_dev);
 	if (result) {
 		dev_err(dev, "IIO register fail %d\n", result);
-		goto out_remove_trigger;
+		goto out_del_adapter;
 	}
 
 	return 0;
 
+out_del_adapter:
+#ifdef CONFIG_I2C
+	i2c_del_adapter(&st->aux_master_adapter);
+#endif
 out_remove_trigger:
 	inv_mpu6050_remove_trigger(st);
 out_unreg_ring:
@@ -952,10 +1204,14 @@ EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
 int inv_mpu_core_remove(struct device  *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
 	iio_triggered_buffer_cleanup(indio_dev);
+#ifdef CONFIG_I2C
+	i2c_del_adapter(&st->aux_master_adapter);
+#endif
 
 	return 0;
 }
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index bd2c0fd..85f9b50 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -42,6 +42,7 @@
  *  @int_pin_cfg;	Controls interrupt pin configuration.
  *  @accl_offset:	Controls the accelerometer calibration offset.
  *  @gyro_offset:	Controls the gyroscope calibration offset.
+ *  @mst_status:	secondary I2C master interrupt source status
  */
 struct inv_mpu6050_reg_map {
 	u8 sample_rate_div;
@@ -61,6 +62,7 @@ struct inv_mpu6050_reg_map {
 	u8 int_pin_cfg;
 	u8 accl_offset;
 	u8 gyro_offset;
+	u8 mst_status;
 };
 
 /*device enum */
@@ -139,6 +141,17 @@ struct inv_mpu6050_state {
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 	struct regmap *map;
 	int irq;
+
+	/* if the MPU connects to aux devices as a master */
+	bool i2c_aux_master_mode;
+
+#ifdef CONFIG_I2C
+	/* I2C adapter for talking to aux sensors in "master" mode */
+	struct i2c_adapter aux_master_adapter;
+	struct completion slv4_done;
+	/* Value of I2C_MST_STATUS after slv4_done */
+	u8 slv4_done_status;
+#endif
 };
 
 /*register and associated bit definition*/
@@ -154,9 +167,32 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BIT_ACCEL_OUT           0x08
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
 
+#define INV_MPU6050_REG_I2C_SLV4_ADDR       0x31
+#define INV_MPU6050_BIT_I2C_SLV4_R          0x80
+#define INV_MPU6050_BIT_I2C_SLV4_W          0x00
+
+#define INV_MPU6050_REG_I2C_SLV4_REG        0x32
+#define INV_MPU6050_REG_I2C_SLV4_DO         0x33
+#define INV_MPU6050_REG_I2C_SLV4_CTRL       0x34
+
+#define INV_MPU6050_BIT_SLV4_EN             0x80
+#define INV_MPU6050_BIT_SLV4_INT_EN         0x40
+#define INV_MPU6050_BIT_SLV4_REG_DIS        0x20
+
+#define INV_MPU6050_REG_I2C_SLV4_DI         0x35
+
+#define INV_MPU6050_REG_I2C_MST_STATUS      0x36
+#define INV_MPU6050_BIT_I2C_SLV4_DONE       0x40
+#define INV_MPU6050_BIT_I2C_LOST_ARB        0x20
+#define INV_MPU6050_BIT_I2C_SLV4_NACK       0x10
+
 #define INV_MPU6050_REG_INT_ENABLE          0x38
 #define INV_MPU6050_BIT_DATA_RDY_EN         0x01
 #define INV_MPU6050_BIT_DMP_INT_EN          0x02
+#define INV_MPU6050_BIT_MST_INT_EN          0x08
+
+#define INV_MPU6050_REG_INT_STATUS          0x3A
+#define INV_MPU6050_BIT_MST_INT             0x08
 
 #define INV_MPU6050_REG_RAW_ACCEL           0x3B
 #define INV_MPU6050_REG_TEMPERATURE         0x41
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index fc55923..a334ed9 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -126,14 +126,6 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
 
-	ret = devm_request_irq(&indio_dev->dev, st->irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_TRIGGER_RISING,
-			       "inv_mpu",
-			       st->trig);
-	if (ret)
-		return ret;
-
 	st->trig->dev.parent = regmap_get_device(st->map);
 	st->trig->ops = &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
-- 
2.5.5

