Return-Path: <SRS0=fWxU=2F=jmondi.org=jacopo+renesas@kernel.org>
From: Jacopo Mondi <jacopo+renesas@jmondi.org>
To: geert@linux-m68k.org,
	wsa+renesas@sang-engineering.com,
	magnus.damm@gmail.com,
	laurent.pinchart@ideasonboard.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	meerw@pmeerw.net,
	robh+dt@kernel.org,
	mark.rutland@arm.com
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] iio: adc: Add max9611/9612 ADC driver
Date: Fri, 24 Feb 2017 16:05:55 +0100
Message-Id: <1487948756-25172-4-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
List-ID: <linux-iio@vger.kernel.org>

Add iio driver for Maxim max9611/9612 current-sense amplifiers with
12-bits ADC.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/iio/adc/Kconfig   |  10 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/max961x.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 659 insertions(+)
 create mode 100644 drivers/iio/adc/max961x.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dedae7a..f86026a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -354,6 +354,16 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config	MAX961x
+	tristate "Maxim max9611/9612 ADC driver"
+	depends on I2C
+	help
+	  Say yes here to build support for Maxim max9611/9612 current sense
+	  amplifiers with 12-bits ADC interface.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max961x.
+
 config MCP320X
 	tristate "Microchip Technology MCP3x01/02/04/08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d001262..ff19250 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX961x) += max961x.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
diff --git a/drivers/iio/adc/max961x.c b/drivers/iio/adc/max961x.c
new file mode 100644
index 0000000..a544e69
--- /dev/null
+++ b/drivers/iio/adc/max961x.c
@@ -0,0 +1,648 @@
+/*
+ * iio/adc/max961x.c
+ *
+ * Maxim max9611/9612 high side current sense amplifier with
+ * 12-bit ADC interface.
+ *
+ * Copyright (C) 2017 Jacopo Mondi
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/*
+ * This driver supports input common-mode voltage, current-sense
+ * amplifier with programmable gains and die temperature reading from
+ * Maxim max9611/9612.
+ * Op-amp, analog comparator, and watchdog functionalities are not
+ * supported by this driver.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+
+#define DRIVER_NAME "max961x"
+
+/* max961x register addresses */
+#define REG_CSA_DATA			0x00
+#define REG_RS_DATA			0x02
+#define REG_TEMP_DATA			0x08
+#define REG_CTRL1			0x0a
+#define REG_CTRL2			0x0b
+
+/* max961x REG1 mux configuration options */
+#define MUX_MASK			0x07
+#define MUX_SENSE_1x			0x00
+#define MUX_SENSE_4x			0x01
+#define MUX_SENSE_8x			0x02
+#define MUX_INPUT_VOLTAGE		0x03
+#define MUX_TEMPERATURE			0x06
+
+/* max961x voltage (both sense and input) helper macros */
+#define MAX961x_VOLTAGE_SHIFT		0x04
+#define MAX961x_VOLTAGE_RAW(_r)		((_r) >> MAX961x_VOLTAGE_SHIFT)
+
+/*
+ * max961x current sense amplifier voltage output:
+ * LSB and offset values depends on selected gain (1x, 4x, 8x)
+ *
+ * GAIN		LSB (nV)	OFFSET (LSB steps)
+ * 1x		107500		1
+ * 4x		26880		1
+ * 8x		13440		3
+ *
+ * The complete formula to calculate current sense voltage is:
+ *     (((adc_read >> 4) - offset) / ((1 / LSB) * 10^-3)
+ */
+#define CSA_VOLT_1x_LSB_nV		107500
+#define CSA_VOLT_4x_LSB_nV		26880
+#define CSA_VOLT_8x_LSB_nV		13440
+#define CSA_VOLT_1x_LSB_DIV		9302
+#define CSA_VOLT_4x_LSB_DIV		37202
+#define CSA_VOLT_8x_LSB_DIV		74404
+
+#define CSA_VOLT_1x_OFFS_RAW		1
+#define CSA_VOLT_4x_OFFS_RAW		1
+#define CSA_VOLT_8x_OFFS_RAW		3
+#define CSA_VOLT_1x_OFFS_uV		100
+#define CSA_VOLT_4x_OFFS_uV		45
+#define CSA_VOLT_8x_OFFS_uV		45
+
+#define CSA_VOLT_IIO_RAW(_r, _offs)	\
+	((MAX961x_VOLTAGE_RAW(_r) - (_offs)) * 1000)
+
+/*
+ * max961x common input mode (CIM): LSB is 14mV, with 14mV offset at 25 C
+ *
+ * The complete formula to calculate input common voltage is:
+ *     (((adc_read >> 4) * 1000) - offset) / (1 / 14 * 1000)
+ */
+#define CIM_VOLTAGE_LSB_mV		14
+#define CIM_VOLTAGE_OFFSET_mV		14
+#define CIM_VOLTAGE_OFFSET_RAW		1
+
+/*
+ * max961x temperature reading: LSB is 0.48 degrees Celsius
+ *
+ * The complete formula to calculate temperature is:
+ *     ((adc_read >> 7) * 1000) / (1 / 0.48 * 1000)
+ */
+#define TEMP_SHIFT			0x07
+#define TEMP_MAX_RAW_POS		0x7f80
+#define TEMP_MAX_RAW_NEG		0xff80
+#define TEMP_MIN_RAW_NEG		0xd980
+#define TEMP_MASK			((1 << TEMP_SHIFT) - 1)
+#define TEMP_RAW(_r)			((_r) >> TEMP_SHIFT)
+#define TEMP_LSB_mC			480
+#define TEMP_SCALE_NUM			1000
+#define TEMP_SCALE_DIV			2083
+
+struct max961x_dev {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+	unsigned int shunt_resistor_uOhm;
+};
+
+enum max961x_conf_ids {
+	CONF_SENSE_1x,
+	CONF_SENSE_4x,
+	CONF_SENSE_8x,
+	CONF_IN_VOLT,
+	CONF_TEMP,
+};
+
+/**
+ * max961x_conf - associate ADC mux configuration with register address where
+ *		  data shall be read from
+ */
+static unsigned int max961x_conf[][2] = {
+	/* CONF_SENSE_1x */
+	{ MUX_SENSE_1x, REG_CSA_DATA },
+	/* CONF_SENSE_4x */
+	{ MUX_SENSE_4x, REG_CSA_DATA },
+	/* CONF_SENSE_8x */
+	{ MUX_SENSE_8x, REG_CSA_DATA },
+	/* CONF_IN_VOLT */
+	{ MUX_INPUT_VOLTAGE, REG_RS_DATA },
+	/* CONF_TEMP */
+	{ MUX_TEMPERATURE, REG_TEMP_DATA },
+};
+
+enum max961x_csa_gain {
+	CSA_GAIN_1x,
+	CSA_GAIN_4x,
+	CSA_GAIN_8x,
+};
+
+enum max961x_csa_gain_params {
+	CSA_GAIN_LSB_nV,
+	CSA_GAIN_LSB_DIV,
+	CSA_GAIN_OFFS_nV,
+	CSA_GAIN_OFFS_RAW,
+};
+
+/**
+ * max961x_csa_gain_conf - associate gain multiplier with LSB and
+ *			   offset values.
+ *
+ * Group together parameters associated with configurable gain
+ * on current sense amplifier path to ADC interface.
+ * Current sense read routine adjusts gain until it gets a meaningful
+ * value; use this structure to retrieve the correct LSB and offset values.
+ */
+static unsigned int max961x_gain_conf[][4] = {
+	{ /* [0] CSA_GAIN_1x */
+		CSA_VOLT_1x_LSB_nV,
+		CSA_VOLT_1x_LSB_DIV,
+		CSA_VOLT_1x_OFFS_uV,
+		CSA_VOLT_1x_OFFS_RAW,
+	},
+	{ /* [1] CSA_GAIN_4x */
+		CSA_VOLT_4x_LSB_nV,
+		CSA_VOLT_4x_LSB_DIV,
+		CSA_VOLT_4x_OFFS_uV,
+		CSA_VOLT_4x_OFFS_RAW,
+	},
+	{ /* [2] CSA_GAIN_8x */
+		CSA_VOLT_8x_LSB_nV,
+		CSA_VOLT_8x_LSB_DIV,
+		CSA_VOLT_8x_OFFS_uV,
+		CSA_VOLT_8x_OFFS_RAW,
+	},
+};
+
+/**
+ * max961x_chan_ids - Identify IIO channels
+ */
+enum max961x_chan_ids {
+	MAX961x_CHAN_VOLTAGE_INPUT,
+	MAX961x_CHAN_VOLTAGE_SENSE,
+	MAX961x_CHAN_TEMPERATURE,
+	MAX961x_CHAN_CURRENT_LOAD,
+	MAX961x_CHAN_POWER_LOAD,
+};
+
+static struct iio_chan_spec max961x_channels[] = {
+	{ /* [0] die temperature */
+	  .type			= IIO_TEMP,
+	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+				  BIT(IIO_CHAN_INFO_SCALE) |
+				  BIT(IIO_CHAN_INFO_PROCESSED),
+	  .address		= MAX961x_CHAN_TEMPERATURE,
+	},
+	{ /* [1] common voltage input */
+	  .type			= IIO_VOLTAGE,
+	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+				  BIT(IIO_CHAN_INFO_SCALE) |
+				  BIT(IIO_CHAN_INFO_OFFSET),
+	  .address		= MAX961x_CHAN_VOLTAGE_INPUT,
+	  .channel		= MAX961x_CHAN_VOLTAGE_INPUT,
+	  .indexed		= 1,
+	},
+	{ /* [2] current sense amplifier voltage output */
+	  .type			= IIO_VOLTAGE,
+	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+				  BIT(IIO_CHAN_INFO_SCALE) |
+				  BIT(IIO_CHAN_INFO_OFFSET),
+	  .address		= MAX961x_CHAN_VOLTAGE_SENSE,
+	  .channel		= MAX961x_CHAN_VOLTAGE_SENSE,
+	  .indexed		= 1,
+	},
+	{ /* [3] load current measurement */
+	  .type			= IIO_CURRENT,
+	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+				  BIT(IIO_CHAN_INFO_SCALE),
+	  .address		= MAX961x_CHAN_CURRENT_LOAD,
+	},
+	{ /* [4] load current measurement */
+	  .type			= IIO_POWER,
+	  .info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+				  BIT(IIO_CHAN_INFO_SCALE),
+	  .address		= MAX961x_CHAN_POWER_LOAD,
+	},
+};
+
+static int max961x_reg_read(struct max961x_dev *max961x, u8 reg, u16 *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_swapped(max961x->i2c_client, reg);
+	if (ret < 0) {
+		dev_err(max961x->dev, "i2c read word from 0x%2x failed\n",
+			reg);
+		return ret;
+	}
+
+	*val = ret;
+
+	return 0;
+}
+
+static int max961x_reg_write(struct max961x_dev *max961x, u8 reg, u8 val)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(max961x->i2c_client, reg, val);
+	if (ret) {
+		dev_err(max961x->dev, "i2c write byte failed: 0x%2x - 0x%2x\n",
+			reg, val);
+		return ret;
+	}
+
+	/* FIXME: need a delay here to make register configuration
+	 *	  stabilize. 1 msec at least, from empirical testing.
+	 */
+	usleep_range(1000, 2000);
+
+	return 0;
+}
+
+/**
+ * max961x_read_single() - read a single vale from ADC interface
+ *
+ * Data registers are 16 bit long, spread between two 8 bit registers
+ * with consecutive addresses.
+ * Configure ADC mux first, then read register at address "reg_addr".
+ * The smbus_read_word routine asks for 16 bits and the ADC is kind enough
+ * to return values from "reg_addr" and "reg_addr + 1" consecutively.
+ *
+ * @max961x: max961x device
+ * @selector: index for mux and register configuration
+ * @raw_val: the value returned from ADC
+ */
+static int max961x_read_single(struct max961x_dev *max961x,
+			       enum max961x_conf_ids selector,
+			       u16 *raw_val)
+{
+	int ret;
+
+	u8 mux_conf = max961x_conf[selector][0] & MUX_MASK;
+	u8 reg_addr = max961x_conf[selector][1];
+
+	ret = max961x_reg_write(max961x, REG_CTRL1, mux_conf);
+	if (ret)
+		return ret;
+
+	ret = max961x_reg_read(max961x, reg_addr, raw_val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * max961x_read_csa_voltage() - read current sense amplifier output voltage
+ *
+ * Current sense amplifier output voltage is read through a configurable
+ * 1x, 4x or 8x gain.
+ * Start with plain 1x gain, and adjust gain control properly until a
+ * meaningful value is read from ADC output.
+ *
+ * @max961x: max961x device
+ * @adc_raw: raw value read from ADC output
+ * @csa_gain: gain configuration option selector
+ */
+static int max961x_read_csa_voltage(struct max961x_dev *max961x,
+				    u16 *adc_raw,
+				    enum max961x_csa_gain *csa_gain)
+{
+	int ret;
+	unsigned int i;
+	enum max961x_conf_ids gain_selectors[] = {
+		CONF_SENSE_1x,
+		CONF_SENSE_4x,
+		CONF_SENSE_8x
+	};
+
+	for (i = 0; i < ARRAY_SIZE(gain_selectors); ++i) {
+		ret = max961x_read_single(max961x, gain_selectors[i], adc_raw);
+		if (ret)
+			return ret;
+
+		if (*adc_raw > 0) {
+			*csa_gain = gain_selectors[i];
+			return 0;
+		}
+	}
+
+	return -EIO;
+}
+
+static int max961x_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	int ret;
+	u16 adc_data;
+	enum max961x_csa_gain gain_selector;
+	unsigned int *csa_gain;
+	struct max961x_dev *dev = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->address) {
+		case MAX961x_CHAN_TEMPERATURE:
+			ret = max961x_read_single(dev, CONF_TEMP,
+						  &adc_data);
+			if (ret)
+				return ret;
+
+			*val = TEMP_RAW(adc_data);
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_VOLTAGE_INPUT:
+			ret = max961x_read_single(dev, CONF_IN_VOLT,
+						  &adc_data);
+			if (ret)
+				return ret;
+
+			*val = MAX961x_VOLTAGE_RAW(adc_data);
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_VOLTAGE_SENSE:
+			ret = max961x_read_csa_voltage(dev, &adc_data,
+						       &gain_selector);
+			if (ret)
+				return ret;
+
+			*val = MAX961x_VOLTAGE_RAW(adc_data);
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_CURRENT_LOAD:
+			/* raw (nV): raw * LSB (nV) */
+			ret = max961x_read_csa_voltage(dev, &adc_data,
+						       &gain_selector);
+			if (ret)
+				return ret;
+
+			csa_gain = max961x_gain_conf[gain_selector];
+
+			*val = MAX961x_VOLTAGE_RAW(adc_data) *
+			       csa_gain[CSA_GAIN_LSB_nV];
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_POWER_LOAD:
+			/* raw (mV): raw * LSB (mV) */
+			ret = max961x_read_single(dev, CONF_IN_VOLT,
+						  &adc_data);
+
+			*val = MAX961x_VOLTAGE_RAW(adc_data) *
+			       CIM_VOLTAGE_LSB_mV;
+
+			return IIO_VAL_INT;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+
+		case MAX961x_CHAN_TEMPERATURE:
+			/* processed (C): raw * scale (C) */
+			*val = TEMP_SCALE_NUM;
+			*val2 = TEMP_SCALE_DIV;
+
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX961x_CHAN_VOLTAGE_INPUT:
+			/* processed (mV): raw * scale_mV */
+			ret = max961x_read_single(dev, CONF_IN_VOLT,
+						  &adc_data);
+			if (ret)
+				return ret;
+
+			*val = CIM_VOLTAGE_LSB_mV;
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_VOLTAGE_SENSE:
+			/* processed (mV): raw (mV) * (scale (nV) / 10^6) */
+			ret = max961x_read_csa_voltage(dev, &adc_data,
+						       &gain_selector);
+			if (ret)
+				return ret;
+
+			csa_gain = max961x_gain_conf[gain_selector];
+
+			*val = csa_gain[CSA_GAIN_LSB_nV];
+			*val2 = 1000000;
+
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX961x_CHAN_CURRENT_LOAD:
+			/* processed (mA): raw (nV)  / scale (uOhm)  */
+			*val = 1;
+			*val2 = dev->shunt_resistor_uOhm;
+
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX961x_CHAN_POWER_LOAD:
+			/* processed (mW): raw (mV) * (scale (mA) / 1000) */
+			ret = max961x_read_csa_voltage(dev, &adc_data,
+						       &gain_selector);
+			if (ret)
+				return ret;
+
+			csa_gain = max961x_gain_conf[gain_selector];
+
+			/* val = (nV / uOhm) = mA */
+			*val = MAX961x_VOLTAGE_RAW(adc_data) *
+			       csa_gain[CSA_GAIN_LSB_nV];
+			*val /= dev->shunt_resistor_uOhm;
+
+			*val2 = 1000;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->address) {
+		case MAX961x_CHAN_VOLTAGE_INPUT:
+			*val = CIM_VOLTAGE_OFFSET_RAW;
+
+			return IIO_VAL_INT;
+
+		case MAX961x_CHAN_VOLTAGE_SENSE:
+			ret = max961x_read_csa_voltage(dev, &adc_data,
+						       &gain_selector);
+			if (ret)
+				return ret;
+
+			*val = max961x_gain_conf[gain_selector]
+						[CSA_GAIN_OFFS_RAW];
+			*val2 = 1000;
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
+	case IIO_CHAN_INFO_PROCESSED:
+		/* processed (mC): raw * LSB (mC) */
+		if (chan->address != MAX961x_CHAN_TEMPERATURE)
+			return -EINVAL;
+
+		ret = max961x_read_single(dev, CONF_TEMP,
+					  &adc_data);
+		if (ret)
+			return ret;
+
+		*val = TEMP_RAW(adc_data) * TEMP_LSB_mC;
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t max961x_shunt_resistor_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct max961x_dev *max961x = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", max961x->shunt_resistor_uOhm);
+}
+
+static IIO_DEVICE_ATTR(in_shunt_resistor, S_IRUGO,
+		       max961x_shunt_resistor_show, NULL, 0);
+
+static struct attribute *max961x_attributes[] = {
+	&iio_dev_attr_in_shunt_resistor.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group max961x_attribute_group = {
+	.attrs = max961x_attributes,
+};
+
+static const struct iio_info indio_info = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= max961x_read_raw,
+	.attrs		= &max961x_attribute_group,
+};
+
+static int max961x_init(struct max961x_dev *max961x)
+{
+	int ret;
+	u16 regval;
+	struct i2c_client *client = max961x->i2c_client;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_WRITE_BYTE	|
+				     I2C_FUNC_SMBUS_READ_WORD_DATA)) {
+		dev_err(max961x->dev,
+			"I2c adapter does not support smbus write_byte and "\
+			"read_word_data functionalities. Aborting probe.\n");
+		return -EINVAL;
+	}
+
+	max961x_reg_write(max961x, REG_CTRL1, MUX_TEMPERATURE);
+	max961x_reg_write(max961x, REG_CTRL2, 0);
+
+	/* Make sure die temperature is in range to test communications. */
+	regval = 0;
+	ret = max961x_reg_read(max961x, REG_TEMP_DATA, &regval);
+	if (ret)
+		return ret;
+
+	regval = regval & ~TEMP_MASK;
+	if ((regval > TEMP_MAX_RAW_POS &&
+	     regval < TEMP_MIN_RAW_NEG) ||
+	     regval > TEMP_MAX_RAW_NEG) {
+		dev_err(max961x->dev,
+			"In-valid value received from ADC 0x%4x: aborting\n",
+			regval);
+		return -EIO;
+	}
+
+	/* Mux shall be zeroed back before applying other configurations */
+	max961x_reg_write(max961x, REG_CTRL1, 0);
+
+	return 0;
+}
+
+static int max961x_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	int ret;
+	struct max961x_dev *max961x;
+	struct iio_dev *indio_dev;
+	struct device_node *of_node = client->dev.of_node;
+	unsigned int of_shunt;
+	const char * const shunt_res_prop = "shunt-resistor";
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max961x));
+	if (IS_ERR(indio_dev))
+		return PTR_ERR(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+
+	max961x		= iio_priv(indio_dev);
+	max961x->dev	= &client->dev;
+	max961x->i2c_client = client;
+
+	ret = of_property_read_u32(of_node, shunt_res_prop, &of_shunt);
+	if (ret) {
+		dev_err(&client->dev,
+			"Missing %s property for %s node\n",
+			shunt_res_prop, of_node->full_name);
+		return ret;
+	}
+	max961x->shunt_resistor_uOhm = of_shunt;
+
+	ret = max961x_init(max961x);
+	if (ret)
+		return ret;
+
+	indio_dev->dev.parent	= &client->dev;
+	indio_dev->dev.of_node	= client->dev.of_node;
+	indio_dev->name		= DRIVER_NAME;
+	indio_dev->modes	= INDIO_DIRECT_MODE;
+	indio_dev->info		= &indio_info;
+	indio_dev->channels	= max961x_channels;
+	indio_dev->num_channels	= ARRAY_SIZE(max961x_channels);
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret)
+		return ret;
+
+	dev_info(&client->dev, "%s: probed\n", DRIVER_NAME);
+
+	return 0;
+}
+
+static int max961x_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
+static const struct of_device_id max961x_of_table[] = {
+	{.compatible = "maxim,max961x"},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, max961x_of_table);
+
+static struct i2c_driver max961x_driver = {
+	.driver = {
+		   .name = DRIVER_NAME,
+		   .owner = THIS_MODULE,
+		   .of_match_table = max961x_of_table,
+	},
+	.probe = max961x_probe,
+	.remove = max961x_remove,
+};
+module_i2c_driver(max961x_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
+MODULE_DESCRIPTION("Maxim max9611/12 current sense amplifier with 12bit ADC");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
