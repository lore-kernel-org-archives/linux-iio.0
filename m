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
	Ge Gao <GGao@invensense.com>
Subject: [RFC 7/7] iio: inv_mpu6050: Add support for external sensors
Date: Fri, 29 Apr 2016 22:02:36 +0300
Message-Id: <c2631025b2405ad01c92964ed185d73647593f17.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1461953982.git.leonard.crestez@intel.com>
References: <cover.1461953982.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This works by copying their channels at probe time.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  37 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 420 ++++++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  63 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  48 ++-
 4 files changed, 555 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index aaf12b4..79b8326 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -23,6 +23,28 @@ Devices connected in "bypass" mode must be listed behind i2c@0 with the address
 
 Devices connected in "master" mode must be listed behind i2c@1 with the address 1
 
+It is possible to configure the MPU to automatically fetch reading for
+devices connected on the auxiliary i2c bus without CPU intervention. When this
+is done the driver will present the channels of the slaved devices as if they
+belong to the MPU device itself.
+
+Reads and write to config values (like scaling factors) are forwarded to the
+other driver while data reads are handled from MPU registers. The channels are
+also available through the MPU's iio triggered buffer mechanism. This feature
+can allow sampling up to 24 bytes from 4 slaves at a much higher rate.
+
+This is be specified in device tree as an "inv,external-sensors" node which
+have children indexed by slave ids 0 to 3. The child node identifying each
+external sensor reading has the following properties:
+ - reg: 0 to 3 slave index
+ - inv,addr : the I2C address to read from
+ - inv,reg : the I2C register to read from
+ - inv,len : read length from the device
+ - inv,external-channels : list of slaved channels specified by config index.
+
+The sum of storagebits for external channels must equal the read length. Only
+16bit channels are currently supported.
+
 Example:
 	mpu6050@68 {
 		compatible = "invensense,mpu6050";
@@ -61,7 +83,8 @@ Example describing mpu9150 (which includes an ak9875 on chip):
 		};
 	};
 
-Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
+Example describing a mpu6500 via SPI with an hmc5883l on aux i2c configured for
+automatic external readings as slave 0:
 	mpu6500@0 {
 		compatible = "inv,mpu6500";
 		reg = <0x0>;
@@ -80,4 +103,16 @@ Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
 				reg = <0x1e>;
 			};
 		};
+
+		inv,external-sensors {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hmc5833l@0 {
+				reg = <0>;
+				inv,addr = <0x1e>;
+				inv,reg = <3>;
+				inv,len = <6>;
+				inv,external-channels = <0 1 2>;
+			};
+		};
 	};
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 712e901..224be3c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -41,6 +41,8 @@ static const int gyro_scale_6050[] = {133090, 266181, 532362, 1064724};
  */
 static const int accel_scale[] = {598, 1196, 2392, 4785};
 
+#define INV_MPU6050_NUM_INT_CHAN 8
+
 static const struct inv_mpu6050_reg_map reg_set_6500 = {
 	.sample_rate_div	= INV_MPU6050_REG_SAMPLE_RATE_DIV,
 	.lpf                    = INV_MPU6050_REG_CONFIG,
@@ -136,6 +138,9 @@ static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 	if (reg >= INV_MPU6050_REG_RAW_GYRO && reg < INV_MPU6050_REG_RAW_GYRO + 6)
 		return true;
+	if (reg < INV_MPU6050_REG_EXT_SENS_DATA_00 + INV_MPU6050_CNT_EXT_SENS_DATA &&
+			reg >= INV_MPU6050_REG_EXT_SENS_DATA_00)
+		return true;
 	switch (reg) {
 	case INV_MPU6050_REG_TEMPERATURE:
 	case INV_MPU6050_REG_TEMPERATURE + 1:
@@ -340,13 +345,115 @@ static int inv_mpu6050_sensor_show(struct inv_mpu6050_state  *st, int reg,
 	return IIO_VAL_INT;
 }
 
+static bool iio_chan_needs_swab(const struct iio_chan_spec *chan)
+{
+#if defined(__LITTLE_ENDIAN)
+	return chan->scan_type.endianness == IIO_BE;
+#elif defined(__BIG_ENDIAN)
+	return chan->scan_type.endianness == IIO_LE;
+#else
+	#error undefined endianness
+#endif
+}
+
+/* Convert iio buffer format to IIO_CHAN_INFO_RAW value */
+static int iio_bufval_to_rawval(const struct iio_chan_spec *chan, void *buf, int *val)
+{
+	switch (chan->scan_type.storagebits) {
+	case 8: *val = *((u8*)buf); break;
+	case 16: *val = *(u16*)buf; break;
+	case 32: *val = *(u32*)buf; break;
+	default: return -EINVAL;
+	}
+
+	*val >>= chan->scan_type.shift;
+	*val &= (1 << chan->scan_type.realbits) - 1;
+	if (iio_chan_needs_swab(chan)) {
+		if (chan->scan_type.storagebits == 16)
+			*val = swab16(*val);
+		else if (chan->scan_type.storagebits == 32)
+			*val = swab32(*val);
+	}
+	if (chan->scan_type.sign == 's')
+		*val = sign_extend32(*val, chan->scan_type.storagebits - 1);
+
+	return 0;
+}
+
+static int
+inv_mpu6050_read_raw_external(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int *val, int *val2, long mask)
+{
+	int result;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int chan_index = chan - indio_dev->channels;
+	struct inv_mpu6050_ext_chan_state *ext_chan_state =
+			&st->ext_chan[chan_index - INV_MPU6050_NUM_INT_CHAN];
+	struct inv_mpu6050_ext_sens_state *ext_sens_state =
+			&st->ext_sens[ext_chan_state->ext_sens_index];
+	struct iio_dev *orig_dev = ext_sens_state->orig_dev;
+	const struct iio_chan_spec *orig_chan = &orig_dev->channels[ext_chan_state->orig_chan_index];
+	int data_offset;
+	int data_length;
+	u8 buf[4];
+
+	/* Everything but raw data reads is forwarded. */
+	if (mask != IIO_CHAN_INFO_RAW)
+		return orig_dev->info->read_raw(orig_dev, orig_chan, val, val2, mask);
+
+	/* Raw reads are handled directly. */
+	data_offset = INV_MPU6050_REG_EXT_SENS_DATA_00 + ext_chan_state->data_offset;
+	data_length = chan->scan_type.storagebits / 8;
+	if (data_length > sizeof(buf)) {
+		return -EINVAL;
+	}
+
+	mutex_lock(&indio_dev->mlock);
+	if (!st->chip_config.enable) {
+		result = inv_mpu6050_set_power_itg(st, true);
+		if (result)
+			goto error_unlock;
+	}
+	result = regmap_bulk_read(st->map, data_offset, buf, data_length);
+	if (result)
+		goto error_unpower;
+	if (!st->chip_config.enable) {
+		result = inv_mpu6050_set_power_itg(st, false);
+		if (result)
+			goto error_unlock;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	/* Convert buf to val and return success */
+	result = iio_bufval_to_rawval(chan, buf, val);
+	if (result)
+		return result;
+	return IIO_VAL_INT;
+
+error_unpower:
+	if (!st->chip_config.enable)
+		inv_mpu6050_set_power_itg(st, false);
+error_unlock:
+	mutex_unlock(&indio_dev->mlock);
+	return result;
+}
+
 static int
 inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		     struct iio_chan_spec const *chan,
 		     int *val, int *val2, long mask)
 {
-	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int ret = 0;
+	int chan_index;
+
+	if (chan < indio_dev->channels || chan > indio_dev->channels + indio_dev->num_channels) {
+		return -EINVAL;
+	}
+	chan_index = chan - indio_dev->channels;
+	if (chan_index >= INV_MPU6050_NUM_INT_CHAN)
+		return inv_mpu6050_read_raw_external(indio_dev, chan, val, val2, mask);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -819,6 +926,309 @@ static const struct iio_info mpu_info = {
 	.validate_trigger = inv_mpu6050_validate_trigger,
 };
 
+extern struct device_type iio_device_type;
+
+static int iio_device_from_i2c_client_match(struct device *dev, void *data)
+{
+	return dev->type == &iio_device_type;
+}
+
+static struct iio_dev* iio_device_from_i2c_client(struct i2c_client* i2c)
+{
+	struct device *child;
+
+	child = device_find_child(&i2c->dev, NULL, iio_device_from_i2c_client_match);
+
+	return (child ? dev_to_iio_dev(child) : NULL);
+}
+
+static int inv_mpu_set_external_reads_enabled(struct inv_mpu6050_state *st, bool en)
+{
+	int i, result, error = 0;
+
+	/* Even if there are errors try to disable all slaves. */
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		result = regmap_update_bits(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(i),
+					    INV_MPU6050_BIT_I2C_SLV_EN,
+					    en ?  INV_MPU6050_BIT_I2C_SLV_EN : 0);
+		if (result) {
+			error = result;
+		}
+	}
+
+	return error;
+}
+
+static int inv_mpu_parse_one_ext_sens(struct device *dev,
+				      struct device_node *np,
+				      struct inv_mpu6050_ext_sens_spec *spec)
+{
+	int result;
+	u32 addr, reg, len;
+
+	result = of_property_read_u32(np, "inv,addr", &addr);
+	if (result)
+		return result;
+	result = of_property_read_u32(np, "inv,reg", &reg);
+	if (result)
+		return result;
+	result = of_property_read_u32(np, "inv,len", &len);
+	if (result)
+		return result;
+
+	spec->addr = addr;
+	spec->reg = reg;
+	spec->len = len;
+
+	result = of_property_count_u32_elems(np, "inv,external-channels");
+	if (result < 0)
+		return result;
+	spec->num_ext_channels = result;
+	spec->ext_channels = devm_kmalloc(dev, spec->num_ext_channels * sizeof(*spec->ext_channels), GFP_KERNEL);
+	if (!spec->ext_channels)
+		return -ENOMEM;
+	result = of_property_read_u32_array(np, "inv,external-channels",
+					    spec->ext_channels,
+					    spec->num_ext_channels);
+	if (result)
+		return result;
+
+	return 0;
+}
+
+static int inv_mpu_parse_ext_sens(struct device *dev,
+				  struct device_node *node,
+				  struct inv_mpu6050_ext_sens_spec *specs)
+{
+	struct device_node *child;
+	int result;
+	u32 reg;
+
+	for_each_available_child_of_node(node, child) {
+		result = of_property_read_u32(child, "reg", &reg);
+		if (result)
+			return result;
+		if (reg > INV_MPU6050_MAX_EXT_SENSORS) {
+			dev_err(dev, "External sensor index %u out of range, max %d\n",
+				reg, INV_MPU6050_MAX_EXT_SENSORS);
+			return -EINVAL;
+		}
+		result = inv_mpu_parse_one_ext_sens(dev, child, &specs[reg]);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
+static int inv_mpu_get_ext_sens_spec(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct device_node *node;
+	int result;
+
+	node = of_get_child_by_name(dev->of_node, "inv,external-sensors");
+	if (node) {
+		result = inv_mpu_parse_ext_sens(dev, node, st->ext_sens_spec);
+		if (result)
+			dev_err(dev, "Failed to parsing external-sensors devicetree data\n");
+		return result;
+	}
+
+	/* Maybe some other way to deal with this? */
+
+	return 0;
+}
+
+/* Struct used while enumerating devices and matching them */
+struct inv_mpu_handle_ext_sensor_fnarg
+{
+	struct iio_dev *indio_dev;
+
+	/* Next scan index */
+	int scan_index;
+	/* Index among external channels */
+	int chan_index;
+	/* Offset in EXTDATA */
+	int data_offset;
+	struct iio_chan_spec *channels;
+};
+
+static int inv_mpu_config_external_read(struct inv_mpu6050_state *st, int index,
+					const struct inv_mpu6050_ext_sens_spec *spec)
+{
+	int result;
+
+	result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_ADDR(index),
+			      INV_MPU6050_BIT_I2C_SLV_RW | spec->addr);
+	if (result)
+		return result;
+	result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_REG(index), spec->reg);
+	if (result)
+		return result;
+	result = regmap_write(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(index),
+			      INV_MPU6050_BIT_I2C_SLV_EN | spec->len);
+
+	return result;
+}
+
+static int inv_mpu_handle_ext_sensor_fn(struct device *dev, void *data)
+{
+	struct inv_mpu_handle_ext_sensor_fnarg *fnarg = data;
+	struct iio_dev *indio_dev = fnarg->indio_dev;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *mydev = regmap_get_device(st->map);
+	struct i2c_client *client;
+	struct iio_dev *orig_dev;
+	int i, j;
+
+	client = i2c_verify_client(dev);
+	if (!client)
+		return 0;
+	orig_dev = iio_device_from_i2c_client(client);
+	if (!orig_dev)
+		return 0;
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		int start_data_offset;
+		struct inv_mpu6050_ext_sens_spec *ext_sens_spec = &st->ext_sens_spec[i];
+		struct inv_mpu6050_ext_sens_state *ext_sens_state = &st->ext_sens[i];
+
+		if (ext_sens_spec->addr != client->addr)
+			continue;
+		if (ext_sens_state->orig_dev) {
+			dev_warn(&indio_dev->dev, "already found slave with at addr %d\n", client->addr);
+			continue;
+		}
+		dev_info(mydev, "external sensor %d is device %s\n",
+				i, orig_dev->name ?: dev_name(&orig_dev->dev));
+		ext_sens_state->orig_dev = orig_dev;
+		ext_sens_state->scan_mask = 0;
+		ext_sens_state->data_len = ext_sens_spec->len;
+		start_data_offset = fnarg->data_offset;
+
+		/* Matched the device (by address). Now process channels: */
+		for (j = 0; j < ext_sens_spec->num_ext_channels; ++j) {
+			int orig_chan_index;
+			const struct iio_chan_spec *orig_chan_spec;
+			struct iio_chan_spec *chan_spec;
+			struct inv_mpu6050_ext_chan_state *chan_state;
+
+			orig_chan_index = ext_sens_spec->ext_channels[j];
+			orig_chan_spec = &orig_dev->channels[orig_chan_index];
+			chan_spec = &fnarg->channels[INV_MPU6050_NUM_INT_CHAN + fnarg->chan_index];
+			chan_state = &st->ext_chan[fnarg->chan_index];
+
+			chan_state->ext_sens_index = i;
+			chan_state->orig_chan_index = orig_chan_index;
+			chan_state->data_offset = fnarg->data_offset;
+			memcpy(chan_spec, orig_chan_spec, sizeof(struct iio_chan_spec));
+			chan_spec->scan_index = fnarg->scan_index;
+			ext_sens_state->scan_mask |= (1 << chan_spec->scan_index);
+			if (orig_chan_spec->scan_type.storagebits != 16) {
+				/*
+				 * Supporting other channels sizes would require data read from the
+				 * hardware fifo to comply with iio alignment.
+				 */
+				dev_err(&indio_dev->dev, "All external channels must have 16 storage bits\n");
+				return -EINVAL;
+			}
+
+			fnarg->scan_index++;
+			fnarg->chan_index++;
+			fnarg->data_offset += chan_spec->scan_type.storagebits / 8;
+			dev_info(mydev, "Reading external channel #%d scan_index %d data_offset %d"
+					" from original device %s chan #%d scan_index %d\n",
+					fnarg->chan_index, chan_spec->scan_index, chan_state->data_offset,
+					orig_dev->name ?: dev_name(&orig_dev->dev), orig_chan_index, orig_chan_spec->scan_index);
+		}
+		if (start_data_offset + ext_sens_spec->len != fnarg->data_offset) {
+			dev_warn(mydev, "length mismatch between i2c slave read length and slave channel spec\n");
+			return -EINVAL;
+		}
+
+		return inv_mpu_config_external_read(st, i, ext_sens_spec);
+	}
+	return 0;
+}
+
+static int inv_mpu6050_handle_ext_sensors(struct iio_dev *indio_dev)
+{
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_mpu_handle_ext_sensor_fnarg fnarg = {
+		.indio_dev = indio_dev,
+		.chan_index = 0,
+		.data_offset = 0,
+		.scan_index = INV_MPU6050_SCAN_TIMESTAMP,
+	};
+	int i, result;
+	int num_ext_chan = 0, sum_data_len = 0;
+
+	inv_mpu_get_ext_sens_spec(indio_dev);
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		num_ext_chan += st->ext_sens_spec[i].num_ext_channels;
+		sum_data_len += st->ext_sens_spec[i].len;
+	}
+	if (sum_data_len > INV_MPU6050_CNT_EXT_SENS_DATA) {
+		dev_err(dev, "Too many bytes from external sensors:"
+			      " requested=%d max=%d\n",
+			      sum_data_len, INV_MPU6050_CNT_EXT_SENS_DATA);
+		return -EINVAL;
+	}
+
+	/* Zero length means nothing to do */
+	if (!sum_data_len) {
+		indio_dev->channels = inv_mpu_channels;
+		indio_dev->num_channels = INV_MPU6050_NUM_INT_CHAN;
+		BUILD_BUG_ON(ARRAY_SIZE(inv_mpu_channels) != INV_MPU6050_NUM_INT_CHAN);
+		return 0;
+	}
+
+	fnarg.channels = devm_kmalloc(indio_dev->dev.parent,
+				      (num_ext_chan + INV_MPU6050_NUM_INT_CHAN) *
+				      sizeof(struct iio_chan_spec),
+				      GFP_KERNEL);
+	if (!fnarg.channels)
+		return -ENOMEM;
+	memcpy(fnarg.channels, inv_mpu_channels, sizeof(inv_mpu_channels));
+	memset(fnarg.channels + INV_MPU6050_NUM_INT_CHAN, 0,
+	       num_ext_chan * sizeof(struct iio_chan_spec));
+
+	st->ext_chan = devm_kzalloc(indio_dev->dev.parent,
+			(num_ext_chan) * sizeof(*st->ext_chan),
+			GFP_KERNEL);
+	if (!st->ext_chan)
+		return -ENOMEM;
+
+	result = inv_mpu6050_set_power_itg(st, true);
+	if (result < 0)
+		return result;
+
+	result = device_for_each_child(&st->aux_master_adapter.dev, &fnarg,
+				       inv_mpu_handle_ext_sensor_fn);
+	if (result)
+		goto out_disable;
+	/* Timestamp channel has index 0 and last scan_index */
+	fnarg.channels[0].scan_index = fnarg.scan_index;
+
+	if (fnarg.chan_index != num_ext_chan) {
+		dev_err(&indio_dev->dev, "Failed to match all external channels!\n");
+		result = -EINVAL;
+		goto out_disable;
+	}
+
+	result = inv_mpu6050_set_power_itg(st, false);
+	indio_dev->channels = fnarg.channels;
+	indio_dev->num_channels = INV_MPU6050_NUM_INT_CHAN + num_ext_chan;
+	return result;
+
+out_disable:
+	inv_mpu6050_set_power_itg(st, false);
+	inv_mpu_set_external_reads_enabled(st, false);
+	return result;
+}
+
 /**
  *  inv_check_and_setup_chip() - check and setup chip.
  */
@@ -1121,8 +1531,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->name = name;
 	else
 		indio_dev->name = dev_name(dev);
-	indio_dev->channels = inv_mpu_channels;
-	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 
 	indio_dev->info = &mpu_info;
 	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
@@ -1160,6 +1568,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	}
 #endif
 
+	result = inv_mpu6050_handle_ext_sensors(indio_dev);
+	if (result < 0) {
+		dev_err(dev, "failed to configure channels %d\n", result);
+		goto out_remove_trigger;
+	}
+
 	INIT_KFIFO(st->timestamps);
 	spin_lock_init(&st->time_stamp_lock);
 	result = iio_device_register(indio_dev);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 9d406df..007fe75 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -124,6 +124,40 @@ struct inv_mpu6050_hw {
 	const struct inv_mpu6050_chip_config *config;
 };
 
+#define INV_MPU6050_MAX_EXT_SENSORS 4
+
+/* Specification for an external sensor */
+struct inv_mpu6050_ext_sens_spec {
+	unsigned short addr;
+	u8 reg, len;
+
+	int num_ext_channels;
+	int *ext_channels;
+};
+
+/* Driver state for each external sensor */
+struct inv_mpu6050_ext_sens_state {
+	struct iio_dev *orig_dev;
+
+	/* Mask of all channels in this sensor */
+	unsigned long scan_mask;
+
+	/* Length of reading. */
+	int data_len;
+};
+
+/* Driver state for each external channel */
+struct inv_mpu6050_ext_chan_state {
+	/* Index inside state->ext_sens */
+	int ext_sens_index;
+
+	/* Index inside orig_dev->channels */
+	int orig_chan_index;
+
+	/* Relative to EXT_SENS_DATA_00 */
+	int data_offset;
+};
+
 /*
  *  struct inv_mpu6050_state - Driver state variables.
  *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
@@ -164,6 +198,10 @@ struct inv_mpu6050_state {
 	struct i2c_adapter aux_master_adapter;
 	struct completion slv4_done;
 #endif
+
+	struct inv_mpu6050_ext_sens_spec ext_sens_spec[INV_MPU6050_MAX_EXT_SENSORS];
+	struct inv_mpu6050_ext_sens_state ext_sens[INV_MPU6050_MAX_EXT_SENSORS];
+	struct inv_mpu6050_ext_chan_state *ext_chan;
 };
 
 /*register and associated bit definition*/
@@ -178,6 +216,24 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_REG_FIFO_EN             0x23
 #define INV_MPU6050_BIT_ACCEL_OUT           0x08
 #define INV_MPU6050_BITS_GYRO_OUT           0x70
+#define INV_MPU6050_BIT_SLV0_FIFO_EN        0x01
+#define INV_MPU6050_BIT_SLV1_FIFO_EN        0x02
+#define INV_MPU6050_BIT_SLV2_FIFO_EN        0x04
+#define INV_MPU6050_BIT_SLV2_FIFO_EN        0x04
+
+/* SLV3 fifo enabling is not in REG_FIFO_EN */
+#define INV_MPU6050_REG_MST_CTRL	    0x24
+#define INV_MPU6050_BIT_SLV3_FIFO_EN        0x10
+
+/* For slaves 0-3 */
+#define INV_MPU6050_REG_I2C_SLV_ADDR(i)     (0x25 + 3 * (i))
+#define INV_MPU6050_REG_I2C_SLV_REG(i)      (0x26 + 3 * (i))
+#define INV_MPU6050_REG_I2C_SLV_CTRL(i)     (0x27 + 3 * (i))
+#define INV_MPU6050_BIT_I2C_SLV_RW          0x80
+#define INV_MPU6050_BIT_I2C_SLV_EN          0x80
+#define INV_MPU6050_BIT_I2C_SLV_BYTE_SW     0x40
+#define INV_MPU6050_BIT_I2C_SLV_REG_DIS     0x20
+#define INV_MPU6050_BIT_I2C_SLV_REG_GRP     0x10
 
 #define INV_MPU6050_REG_I2C_SLV4_ADDR       0x31
 #define INV_MPU6050_BIT_I2C_SLV4_R          0x80
@@ -252,8 +308,8 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
 
-/* 6 + 6 round up and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         24
+/* max is 3*2 accel + 3*2 gyro + 24 external + 8 ts */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         44
 
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_BIT_BYPASS_EN	0x2
@@ -266,6 +322,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_MIN_FIFO_RATE            4
 #define INV_MPU6050_ONE_K_HZ                 1000
 
+#define INV_MPU6050_REG_EXT_SENS_DATA_00	0x49
+#define INV_MPU6050_CNT_EXT_SENS_DATA		24
+
 #define INV_MPU6050_REG_WHOAMI			117
 
 #define INV_MPU6000_WHOAMI_VALUE		0x68
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index e8bda7f..8fa5c3d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -52,6 +52,10 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	result = regmap_write(st->map, st->reg->fifo_en, 0);
 	if (result)
 		goto reset_fifo_fail;
+	result = regmap_update_bits(st->map, INV_MPU6050_REG_MST_CTRL,
+				    INV_MPU6050_BIT_SLV3_FIFO_EN, 0);
+	if (result)
+		goto reset_fifo_fail;
 	/* disable fifo reading */
 	st->chip_config.user_ctrl &= ~INV_MPU6050_BIT_FIFO_EN;
 	result = regmap_write(st->map, st->reg->user_ctrl,
@@ -70,7 +74,8 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 
 	/* enable interrupt */
 	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable) {
+	    st->chip_config.gyro_fifo_enable ||
+	    true) {
 		result = regmap_update_bits(st->map, st->reg->int_enable,
 					    INV_MPU6050_BIT_DATA_RDY_EN,
 					    INV_MPU6050_BIT_DATA_RDY_EN);
@@ -89,10 +94,23 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 		d |= INV_MPU6050_BITS_GYRO_OUT;
 	if (st->chip_config.accl_fifo_enable)
 		d |= INV_MPU6050_BIT_ACCEL_OUT;
+	if (*indio_dev->active_scan_mask & st->ext_sens[0].scan_mask)
+		d |= INV_MPU6050_BIT_SLV0_FIFO_EN;
+	if (*indio_dev->active_scan_mask & st->ext_sens[1].scan_mask)
+		d |= INV_MPU6050_BIT_SLV1_FIFO_EN;
+	if (*indio_dev->active_scan_mask & st->ext_sens[2].scan_mask)
+		d |= INV_MPU6050_BIT_SLV2_FIFO_EN;
 	result = regmap_write(st->map, st->reg->fifo_en, d);
 	if (result)
 		goto reset_fifo_fail;
-
+	if (*indio_dev->active_scan_mask & st->ext_sens[3].scan_mask)
+	{
+		result = regmap_update_bits(st->map, INV_MPU6050_REG_MST_CTRL,
+					    INV_MPU6050_BIT_SLV3_FIFO_EN,
+					    INV_MPU6050_BIT_SLV3_FIFO_EN);
+		if (result)
+			goto reset_fifo_fail;
+	}
 	return 0;
 
 reset_fifo_fail:
@@ -129,8 +147,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
-	size_t bytes_per_datum;
+	size_t bytes_per_datum = 0;
 	int result;
+	int i;
 	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
 	u16 fifo_count;
 	s64 timestamp;
@@ -143,15 +162,18 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	spi = i2c ? NULL: to_spi_device(regmap_dev);
 
 	mutex_lock(&indio_dev->mlock);
-	if (!(st->chip_config.accl_fifo_enable |
-		st->chip_config.gyro_fifo_enable))
-		goto end_session;
+
+	/* Compute bytes_per_datum */
 	bytes_per_datum = 0;
 	if (st->chip_config.accl_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
-
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i)
+		if (st->ext_sens[i].scan_mask & *indio_dev->active_scan_mask)
+			bytes_per_datum += st->ext_sens[i].data_len;
+	if (!bytes_per_datum)
+		return 0;
 
 	/*
 	 * read fifo_count register to know how many bytes inside FIFO
@@ -228,6 +250,7 @@ static int inv_mpu_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	unsigned long mask = *indio_dev->active_scan_mask;
+	int i;
 
 	if ((mask & INV_MPU6050_SCAN_MASK_GYRO) &&
 	    (mask & INV_MPU6050_SCAN_MASK_GYRO) != INV_MPU6050_SCAN_MASK_GYRO)
@@ -245,6 +268,17 @@ static int inv_mpu_buffer_preenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		if ((mask & st->ext_sens[i].scan_mask) &&
+		    (mask & st->ext_sens[i].scan_mask) != st->ext_sens[i].scan_mask)
+		{
+			dev_warn(regmap_get_device(st->map),
+				 "External channels from the same reading "
+				 "can only be enabled together\n");
+			return -EINVAL;
+		}
+	}
+
 	return 0;
 }
 
-- 
2.5.5
