Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:6410 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbcERPB7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 May 2016 11:01:59 -0400
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
Subject: [RFC v2 7/7] iio: inv_mpu6050: Expose channels from slave sensors
Date: Wed, 18 May 2016 18:00:54 +0300
Message-Id: <fcfd42dc5de104d7535b4181171d9f931d820597.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This works by copying the iio_chan_specs from the slave device and
republishing them as if they belonged to the MPU itself. All
read/write_raw operations are forwarded to the other driver.

The original device is still registered with linux as a normal driver
and works normally and you can poke at it to configure stuff like sample
rates and scaling factors.

Buffer values are read from the MPU fifo, allowing a much higher
sampling rate.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    |  47 ++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 387 ++++++++++++++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  74 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |  65 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |   9 +
 5 files changed, 556 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index 778d076..07d572a 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -11,8 +11,8 @@ Optional properties:
  - mount-matrix: an optional 3x3 mounting rotation matrix
  - invensense,i2c-aux-master: operate aux i2c in "master" mode (default is bypass).
 
-The MPU has an auxiliary i2c bus for additional sensors. Devices attached this
-way can be described as for a regular linux i2c bus.
+It is possible to attach auxiliary sensors to the MPU and have them be handled
+by linux. Those auxiliary sensors are described as an i2c bus.
 
 It is possible to interact with aux devices in "bypass" or "master" mode. In
 "bypass" mode the auxiliary SDA/SCL lines are connected directly to the main i2c
@@ -25,7 +25,31 @@ In "master" mode aux devices are listed behind a "i2c@1" node with reg = <1>;
 The master and bypass modes are not supported at the same time. The
 "invensense,i2c-aux-master" property must be set to activate master mode.
 Bypass mode is generally faster but master mode also works when the MPU is
-connected via SPI.
+connected via SPI. Enabling master mode is required for automated external
+readings.
+
+
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
+This is specified in device tree as an "invensense,external-sensors" node with
+children indexed by slave ids 0 to 3. The child nodes identifying each external
+sensor reading have the following properties:
+ - reg: 0 to 3 slave index
+ - invensense,addr : the I2C address to read from
+ - invensense,reg : the I2C register to read from
+ - invensense,len : read length from the device
+ - invensense,external-channels : list of slaved channels specified by scan_index.
+
+The sum of storagebits for external channels must equal the read length. Only
+16bit channels are currently supported.
 
 Example:
 	mpu6050@68 {
@@ -65,7 +89,8 @@ Example describing mpu9150 (which includes an ak9875 on chip):
 		};
 	};
 
-Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
+Example describing a mpu6500 via SPI with an hmc5883l on aux i2c configured for
+automatic external readings as slave 0:
 	mpu6500@0 {
 		compatible = "invensense,mpu6500";
 		reg = <0x0>;
@@ -73,6 +98,8 @@ Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
 		interrupt-parent = <&gpio1>;
 		interrupts = <31 1>;
 
+		invensense,i2c-aux-master;
+
 		#address-cells = <1>;
 		#size-cells = <0>;
 		i2c@1 {
@@ -85,4 +112,16 @@ Example describing a mpu6500 via SPI with an hmc5883l on auxiliary i2c:
 				reg = <0x1e>;
 			};
 		};
+
+		invensense,external-sensors {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			hmc5833l@0 {
+				reg = <0>;
+				invensense,addr = <0x1e>;
+				invensense,reg = <3>;
+				invensense,len = <6>;
+				invensense,external-channels = <0 1 2>;
+			};
+		};
 	};
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 76683b8..715b2e4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -126,6 +126,9 @@ static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
 		return true;
 	if (reg >= INV_MPU6050_REG_RAW_GYRO && reg < INV_MPU6050_REG_RAW_GYRO + 6)
 		return true;
+	if (reg < INV_MPU6050_REG_EXT_SENS_DATA_00 + INV_MPU6050_CNT_EXT_SENS_DATA &&
+			reg >= INV_MPU6050_REG_EXT_SENS_DATA_00)
+		return true;
 	switch (reg) {
 	case INV_MPU6050_REG_TEMPERATURE:
 	case INV_MPU6050_REG_TEMPERATURE + 1:
@@ -335,8 +338,24 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 		     struct iio_chan_spec const *chan,
 		     int *val, int *val2, long mask)
 {
-	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	int ret = 0;
+	int chan_index;
+
+	if (chan > indio_dev->channels + indio_dev->num_channels ||
+			chan < indio_dev->channels)
+		return -EINVAL;
+	chan_index = chan - indio_dev->channels;
+	if (chan_index >= INV_MPU6050_NUM_INT_CHAN) {
+		struct inv_mpu_ext_chan_state *ext_chan_state =
+				&st->ext_chan[chan_index - INV_MPU6050_NUM_INT_CHAN];
+		struct inv_mpu_ext_sens_state *ext_sens_state =
+				&st->ext_sens[ext_chan_state->ext_sens_index];
+		struct iio_dev *orig_dev = ext_sens_state->orig_dev;
+		const struct iio_chan_spec *orig_chan =
+				&orig_dev->channels[ext_chan_state->orig_chan_index];
+		return orig_dev->info->read_raw(orig_dev, orig_chan, val, val2, mask);
+	}
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -518,9 +537,25 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
 				 struct iio_chan_spec const *chan,
 				 int val, int val2, long mask)
 {
-	struct inv_mpu6050_state  *st = iio_priv(indio_dev);
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	int chan_index;
 	int result;
 
+	if (chan > indio_dev->channels + indio_dev->num_channels ||
+			chan < indio_dev->channels)
+		return -EINVAL;
+	chan_index = chan - indio_dev->channels;
+	if (chan_index >= INV_MPU6050_NUM_INT_CHAN) {
+		struct inv_mpu_ext_chan_state *ext_chan_state =
+				&st->ext_chan[chan_index - INV_MPU6050_NUM_INT_CHAN];
+		struct inv_mpu_ext_sens_state *ext_sens_state =
+				&st->ext_sens[ext_chan_state->ext_sens_index];
+		struct iio_dev *orig_dev = ext_sens_state->orig_dev;
+		const struct iio_chan_spec *orig_chan =
+				&orig_dev->channels[ext_chan_state->orig_chan_index];
+		return orig_dev->info->write_raw(orig_dev, orig_chan, val, val2, mask);
+	}
+
 	mutex_lock(&indio_dev->mlock);
 	/*
 	 * we should only update scale when the chip is disabled, i.e.
@@ -809,6 +844,346 @@ static const struct iio_info mpu_info = {
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
+static int inv_mpu_slave_enable(struct inv_mpu6050_state *st, int index, bool state)
+{
+	return regmap_update_bits(st->map, INV_MPU6050_REG_I2C_SLV_CTRL(index),
+				  INV_MPU6050_BIT_I2C_SLV_EN,
+				  state ? INV_MPU6050_BIT_I2C_SLV_EN : 0);
+}
+
+/* Enable slaves based on scan mask */
+int inv_mpu_slave_enable_mask(struct inv_mpu6050_state *st,
+			      const unsigned long mask)
+{
+	int i, result;
+
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		long slave_mask = st->ext_sens[i].scan_mask;
+		result = inv_mpu_slave_enable(st, i, slave_mask & mask);
+		if (result)
+			return result;
+	}
+
+	return 0;
+}
+
+static int inv_mpu_parse_one_ext_sens(struct device *dev,
+				      struct device_node *np,
+				      struct inv_mpu_ext_sens_spec *spec)
+{
+	int result;
+	u32 addr, reg, len;
+
+	result = of_property_read_u32(np, "invensense,addr", &addr);
+	if (result)
+		return result;
+	result = of_property_read_u32(np, "invensense,reg", &reg);
+	if (result)
+		return result;
+	result = of_property_read_u32(np, "invensense,len", &len);
+	if (result)
+		return result;
+
+	spec->addr = addr;
+	spec->reg = reg;
+	spec->len = len;
+
+	result = of_property_count_u32_elems(np, "invensense,external-channels");
+	if (result < 0)
+		return result;
+	spec->num_ext_channels = result;
+	spec->ext_channels = devm_kmalloc(dev, spec->num_ext_channels * sizeof(*spec->ext_channels), GFP_KERNEL);
+	if (!spec->ext_channels)
+		return -ENOMEM;
+	result = of_property_read_u32_array(np, "invensense,external-channels",
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
+				  struct inv_mpu_ext_sens_spec *specs)
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
+	node = of_get_child_by_name(dev->of_node, "invensense,external-sensors");
+	if (node) {
+		result = inv_mpu_parse_ext_sens(dev, node, st->ext_sens_spec);
+		if (result)
+			dev_err(dev, "Failed to parsing external-sensors devicetree data\n");
+		return result;
+	}
+
+	return 0;
+}
+
+/* Struct used while enumerating devices and matching them */
+struct inv_mpu_handle_ext_sensor_fnarg
+{
+	struct iio_dev *indio_dev;
+
+	/* Current scan index */
+	int scan_index;
+	/* Current channel index */
+	int chan_index;
+	/* Non-const pointer to channels */
+	struct iio_chan_spec *channels;
+};
+
+/*
+ * Write initial configuration of a slave at probe time.
+ *
+ * This is mostly fixed except for enabling/disabling individual slaves.
+ */
+static int inv_mpu_config_external_read(struct inv_mpu6050_state *st, int index,
+					const struct inv_mpu_ext_sens_spec *spec)
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
+			      spec->len);
+	if (result)
+		return result;
+
+	return result;
+}
+
+/* Handle one device */
+static int inv_mpu_handle_slave_device(
+		struct inv_mpu_handle_ext_sensor_fnarg *fnarg,
+		int slave_index,
+		struct iio_dev *orig_dev)
+{
+	int i, j;
+	int data_offset;
+	struct iio_dev *indio_dev = fnarg->indio_dev;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct device *mydev = regmap_get_device(st->map);
+	struct inv_mpu_ext_sens_spec *ext_sens_spec =
+			&st->ext_sens_spec[slave_index];
+	struct inv_mpu_ext_sens_state *ext_sens_state =
+			&st->ext_sens[slave_index];
+
+	dev_info(mydev, "slave %d is device %s\n",
+			slave_index, orig_dev->name ?: dev_name(&orig_dev->dev));
+	ext_sens_state->orig_dev = orig_dev;
+	ext_sens_state->scan_mask = 0;
+	data_offset = 0;
+
+	/* handle channels: */
+	for (i = 0; i < ext_sens_spec->num_ext_channels; ++i) {
+		int orig_chan_index = -1;
+		const struct iio_chan_spec *orig_chan_spec;
+		struct iio_chan_spec *chan_spec;
+		struct inv_mpu_ext_chan_state *chan_state;
+
+		for (j = 0; j < orig_dev->num_channels; ++j)
+			if (orig_dev->channels[j].scan_index == ext_sens_spec->ext_channels[i]) {
+				orig_chan_index = j;
+				break;
+			}
+
+		if (orig_chan_index < 0) {
+			dev_err(mydev, "Could not find slave channel with scan_index %d\n",
+					ext_sens_spec->ext_channels[i]);
+		}
+
+		orig_chan_spec = &orig_dev->channels[orig_chan_index];
+		chan_spec = &fnarg->channels[INV_MPU6050_NUM_INT_CHAN + fnarg->chan_index];
+		chan_state = &st->ext_chan[fnarg->chan_index];
+
+		chan_state->ext_sens_index = slave_index;
+		chan_state->orig_chan_index = orig_chan_index;
+		chan_state->data_offset = data_offset;
+		memcpy(chan_spec, orig_chan_spec, sizeof(struct iio_chan_spec));
+		chan_spec->scan_index = fnarg->scan_index;
+		ext_sens_state->scan_mask |= (1 << chan_spec->scan_index);
+
+		fnarg->scan_index++;
+		fnarg->chan_index++;
+		data_offset += chan_spec->scan_type.storagebits / 8;
+		dev_info(mydev, "Reading external channel #%d scan_index %d data_offset %d"
+				" from original device %s chan #%d scan_index %d\n",
+				fnarg->chan_index, chan_spec->scan_index, chan_state->data_offset,
+				orig_dev->name ?: dev_name(&orig_dev->dev), orig_chan_index, orig_chan_spec->scan_index);
+	}
+	if (ext_sens_spec->len != data_offset) {
+		dev_err(mydev, "slave %d length mismatch between "
+				"i2c slave read length (%d) and "
+				"sum of channel sizes (%d)\n",
+				slave_index, ext_sens_spec->len, data_offset);
+		return -EINVAL;
+	}
+
+	return inv_mpu_config_external_read(st, slave_index, ext_sens_spec);
+}
+
+/* device_for_each_child enum function */
+static int inv_mpu_handle_ext_sensor_fn(struct device *dev, void *data)
+{
+	struct inv_mpu_handle_ext_sensor_fnarg *fnarg = data;
+	struct iio_dev *indio_dev = fnarg->indio_dev;
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
+	struct i2c_client *client;
+	struct iio_dev *orig_dev;
+	int i, result;
+
+	client = i2c_verify_client(dev);
+	if (!client)
+		return 0;
+	orig_dev = iio_device_from_i2c_client(client);
+	if (!orig_dev)
+		return 0;
+
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		if (st->ext_sens_spec[i].addr != client->addr)
+			continue;
+		if (st->ext_sens[i].orig_dev) {
+			dev_warn(&indio_dev->dev, "already found slave with at addr %d\n", client->addr);
+			continue;
+		}
+
+		result = inv_mpu_handle_slave_device(fnarg, i, orig_dev);
+		if (result)
+			return result;
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
+		.scan_index = INV_MPU6050_SCAN_TIMESTAMP,
+	};
+	int i, result;
+	int num_ext_chan = 0, sum_data_len = 0;
+	int num_scan_elements;
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
+	/* Allocate scan_offsets/scan_lengths */
+	num_scan_elements = INV_MPU6050_NUM_INT_SCAN_ELEMENTS + num_ext_chan;
+	st->scan_offsets = devm_kmalloc(dev, num_scan_elements * sizeof(int), GFP_KERNEL);
+	if (!st->scan_offsets)
+		return -ENOMEM;
+	st->scan_lengths = devm_kmalloc(dev, num_scan_elements * sizeof(int), GFP_KERNEL);
+	if (!st->scan_lengths)
+		return -ENOMEM;
+
+	/* Zero length means nothing to do, just publish internal channels */
+	if (!sum_data_len) {
+		indio_dev->channels = inv_mpu_channels;
+		indio_dev->num_channels = INV_MPU6050_NUM_INT_CHAN;
+		BUILD_BUG_ON(ARRAY_SIZE(inv_mpu_channels) != INV_MPU6050_NUM_INT_CHAN);
+		return 0;
+	}
+
+	indio_dev->num_channels = INV_MPU6050_NUM_INT_CHAN + num_ext_chan;
+	indio_dev->channels = fnarg.channels = devm_kmalloc(dev,
+			indio_dev->num_channels * sizeof(struct iio_chan_spec),
+			GFP_KERNEL);
+	if (!fnarg.channels)
+		return -ENOMEM;
+	memcpy(fnarg.channels, inv_mpu_channels, sizeof(inv_mpu_channels));
+	memset(fnarg.channels + INV_MPU6050_NUM_INT_CHAN, 0,
+	       num_ext_chan * sizeof(struct iio_chan_spec));
+
+	st->ext_chan = devm_kzalloc(dev, num_ext_chan * sizeof(*st->ext_chan), GFP_KERNEL);
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
+	return result;
+
+out_disable:
+	inv_mpu6050_set_power_itg(st, false);
+	return result;
+}
+
 /**
  *  inv_check_and_setup_chip() - check and setup chip.
  */
@@ -1140,8 +1515,6 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->name = name;
 	else
 		indio_dev->name = dev_name(dev);
-	indio_dev->channels = inv_mpu_channels;
-	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
 
 	indio_dev->info = &mpu_info;
 	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
@@ -1179,6 +1552,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
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
index ec1401d..56fd943 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -110,6 +110,45 @@ struct inv_mpu6050_hw {
 	const struct inv_mpu6050_chip_config *config;
 };
 
+/* Maximum external sensors */
+/* These are SLV0-3 in HW, SLV4 is reserved for i2c master */
+#define INV_MPU6050_MAX_EXT_SENSORS 4
+
+/* Number of internal channels */
+#define INV_MPU6050_NUM_INT_CHAN 8
+
+/* Number of internal scan elements (channels with scan_index >= 0) */
+#define INV_MPU6050_NUM_INT_SCAN_ELEMENTS 7
+
+/* Specification for an external sensor */
+struct inv_mpu_ext_sens_spec {
+	unsigned short addr;
+	u8 reg, len;
+
+	int num_ext_channels;
+	int *ext_channels;
+};
+
+/* Driver state for each external sensor */
+struct inv_mpu_ext_sens_state {
+	struct iio_dev *orig_dev;
+
+	/* Mask of all channels in this sensor */
+	unsigned long scan_mask;
+};
+
+/* Driver state for each external channel */
+struct inv_mpu_ext_chan_state {
+	/* Index inside state->ext_sens */
+	int ext_sens_index;
+
+	/* Index inside orig_dev->channels */
+	int orig_chan_index;
+
+	/* Relative to first offset for this slave */
+	int data_offset;
+};
+
 /*
  *  struct inv_mpu6050_state - Driver state variables.
  *  @TIMESTAMP_FIFO_SIZE: fifo size for timestamp.
@@ -153,10 +192,13 @@ struct inv_mpu6050_state {
 	u8 slv4_done_status;
 #endif
 
-#define INV_MPU6050_MAX_SCAN_ELEMENTS 7
-	unsigned int scan_offsets[INV_MPU6050_MAX_SCAN_ELEMENTS];
-	unsigned int scan_lengths[INV_MPU6050_MAX_SCAN_ELEMENTS];
+	unsigned int *scan_offsets;
+	unsigned int *scan_lengths;
 	bool realign_required;
+
+	struct inv_mpu_ext_sens_spec ext_sens_spec[INV_MPU6050_MAX_EXT_SENSORS];
+	struct inv_mpu_ext_sens_state ext_sens[INV_MPU6050_MAX_EXT_SENSORS];
+	struct inv_mpu_ext_chan_state *ext_chan;
 };
 
 /*register and associated bit definition*/
@@ -171,6 +213,24 @@ struct inv_mpu6050_state {
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
+#define INV_MPU6050_BIT_SLV3_FIFO_EN        0x20
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
@@ -247,8 +307,8 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
 
-/* 6 + 6 round up and plus 8 */
-#define INV_MPU6050_OUTPUT_DATA_SIZE         24
+/* max is 3*2 accel + 3*2 gyro + 24 external + 8 ts */
+#define INV_MPU6050_OUTPUT_DATA_SIZE         44
 
 #define INV_MPU6050_REG_INT_PIN_CFG	0x37
 #define INV_MPU6050_BIT_BYPASS_EN	0x2
@@ -261,6 +321,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_MIN_FIFO_RATE            4
 #define INV_MPU6050_ONE_K_HZ                 1000
 
+#define INV_MPU6050_REG_EXT_SENS_DATA_00	0x49
+#define INV_MPU6050_CNT_EXT_SENS_DATA		24
+
 #define INV_MPU6050_REG_WHOAMI			117
 
 #define INV_MPU6000_WHOAMI_VALUE		0x68
@@ -328,6 +391,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
 void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st);
 int inv_reset_fifo(struct iio_dev *indio_dev);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask);
+int inv_mpu_slave_enable_mask(struct inv_mpu6050_state *st, const unsigned long mask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
 int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
 int inv_mpu_acpi_create_mux_client(struct i2c_client *client);
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 49e503c..919148a 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -30,7 +30,9 @@ static void inv_mpu_get_scan_offsets(
 		const unsigned int masklen,
 		unsigned int *scan_offsets)
 {
+	struct inv_mpu6050_state *st = iio_priv(indio_dev);
 	unsigned int pos = 0;
+	int i, j;
 
 	if (*mask & INV_MPU6050_SCAN_MASK_ACCEL) {
 		scan_offsets[INV_MPU6050_SCAN_ACCL_X] = pos + 0;
@@ -44,6 +46,24 @@ static void inv_mpu_get_scan_offsets(
 		scan_offsets[INV_MPU6050_SCAN_GYRO_Z] = pos + 4;
 		pos += 6;
 	}
+	/* HW lays out channels in slave order */
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i) {
+		struct inv_mpu_ext_sens_spec *ext_sens_spec;
+		struct inv_mpu_ext_sens_state *ext_sens_state;
+		ext_sens_spec = &st->ext_sens_spec[i];
+		ext_sens_state = &st->ext_sens[i];
+
+		if (!(ext_sens_state->scan_mask & *mask))
+			continue;
+		for (j = 0; j + INV_MPU6050_NUM_INT_CHAN < indio_dev->num_channels; ++j) {
+			const struct iio_chan_spec *chan;
+			if (st->ext_chan[j].ext_sens_index != i)
+				continue;
+			chan = &indio_dev->channels[j + INV_MPU6050_NUM_INT_CHAN];
+			scan_offsets[chan->scan_index] = pos + st->ext_chan[j].data_offset;
+		}
+		pos += ext_sens_spec->len;
+	}
 }
 
 /* This is slowish but relatively common */
@@ -138,6 +158,10 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
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
@@ -155,14 +179,12 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
 	inv_clear_kfifo(st);
 
 	/* enable interrupt */
-	if (st->chip_config.accl_fifo_enable ||
-	    st->chip_config.gyro_fifo_enable) {
-		result = regmap_update_bits(st->map, st->reg->int_enable,
-					    INV_MPU6050_BIT_DATA_RDY_EN,
-					    INV_MPU6050_BIT_DATA_RDY_EN);
-		if (result)
-			return result;
-	}
+	result = regmap_update_bits(st->map, st->reg->int_enable,
+				    INV_MPU6050_BIT_DATA_RDY_EN,
+				    INV_MPU6050_BIT_DATA_RDY_EN);
+	if (result)
+		return result;
+
 	/* enable FIFO reading and I2C master interface*/
 	st->chip_config.user_ctrl |= INV_MPU6050_BIT_FIFO_EN;
 	result = regmap_write(st->map, st->reg->user_ctrl,
@@ -175,9 +197,22 @@ int inv_reset_fifo(struct iio_dev *indio_dev)
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
+	if (*indio_dev->active_scan_mask & st->ext_sens[3].scan_mask) {
+		result = regmap_update_bits(st->map, INV_MPU6050_REG_MST_CTRL,
+					    INV_MPU6050_BIT_SLV3_FIFO_EN,
+					    INV_MPU6050_BIT_SLV3_FIFO_EN);
+		if (result)
+			goto reset_fifo_fail;
+	}
 
 	/* check realign required */
 	inv_mpu_get_scan_offsets(indio_dev, mask, masklen, st->scan_offsets);
@@ -222,8 +257,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
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
@@ -236,15 +272,18 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	spi = i2c ? NULL: to_spi_device(regmap_dev);
 
 	mutex_lock(&indio_dev->mlock);
-	if (!(st->chip_config.accl_fifo_enable |
-		st->chip_config.gyro_fifo_enable))
-		goto end_session;
+
+	/* Sample length */
 	bytes_per_datum = 0;
 	if (st->chip_config.accl_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
-
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
+	for (i = 0; i < INV_MPU6050_MAX_EXT_SENSORS; ++i)
+		if (st->ext_sens[i].scan_mask & *indio_dev->active_scan_mask)
+			bytes_per_datum += st->ext_sens_spec[i].len;
+	if (!bytes_per_datum)
+		return 0;
 
 	/*
 	 * read fifo_count register to know how many bytes inside FIFO
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index a334ed9..39e791b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -61,6 +61,11 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 			if (result)
 				return result;
 		}
+
+		result = inv_mpu_slave_enable_mask(st, *indio_dev->active_scan_mask);
+		if (result)
+			return result;
+
 		result = inv_reset_fifo(indio_dev);
 		if (result)
 			return result;
@@ -80,6 +85,10 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 		if (result)
 			return result;
 
+		result = inv_mpu_slave_enable_mask(st, 0);
+		if (result)
+			return result;
+
 		result = inv_mpu6050_switch_engine(st, false,
 					INV_MPU6050_BIT_PWR_GYRO_STBY);
 		if (result)
-- 
2.5.5

