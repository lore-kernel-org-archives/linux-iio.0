Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965772AbeF1NtV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Jun 2018 09:49:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id u18-v6so9179152wmc.1
        for <linux-iio@vger.kernel.org>; Thu, 28 Jun 2018 06:49:20 -0700 (PDT)
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: linux-iio@vger.kernel.org, jonathan.cameron@huawei.com,
        pmeerw@pmeerw.net
Cc: pierre-moana.levesque@parrot.com,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 2/2] iio: light: isl29501: Add support for the ISL29501 ToF sensor.
Date: Thu, 28 Jun 2018 15:49:12 +0200
Message-Id: <1530193752-13171-2-git-send-email-m.othacehe@gmail.com>
In-Reply-To: <1530193752-13171-1-git-send-email-m.othacehe@gmail.com>
References: <1530193752-13171-1-git-send-email-m.othacehe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the ISL29501 Time of Flight sensor.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-isl29501   |   47 +
 .../devicetree/bindings/iio/light/isl29501.txt     |   13 +
 drivers/iio/light/Kconfig                          |   13 +
 drivers/iio/light/Makefile                         |    1 +
 drivers/iio/light/isl29501.c                       | 1150 ++++++++++++++++++++
 5 files changed, 1224 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501
 create mode 100644 Documentation/devicetree/bindings/iio/light/isl29501.txt
 create mode 100644 drivers/iio/light/isl29501.c

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-isl29501 b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
new file mode 100644
index 0000000..39f004b3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
@@ -0,0 +1,47 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_agc_gain
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_agc_gain_bias
+KernelVersion:	4.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This sensor has an automatic gain control (agc) loop
+		which sets the analog signal levels at an optimum
+		level by controlling programmable gain amplifiers. The
+		criteria for optimal gain is determined by the sensor.
+
+		Return the actual gain value as an integer in [0; 65536]
+		range when read from.
+
+		The agc gain read when measuring crosstalk shall be
+		written into in_proximity0_agc_gain_bias.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_temp_a
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_temp_b
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_light_a
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_phase_light_b
+KernelVersion:	4.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The sensor is able to perform correction of distance
+		measurements due to changing temperature and ambient
+		light conditions. It can be programmed to correct for
+		a second order error polynomial.
+
+		Phase data has to be collected when temperature and
+		ambient light are modulated independently.
+
+		Then a least squares curve fit to a second order
+		polynomial has to be generated from the data. The
+		resultant curves have the form ax^2 + bx + c.
+
+		From those two curves, a and b coefficients shall be
+		stored in in_proximity0_calib_phase_temp_a and
+		in_proximity0_calib_phase_temp_b for temperature and
+		in in_proximity0_calib_phase_light_a and
+		in_proximity0_calib_phase_light_b for ambient light.
+
+		Those values must be integer in [0; 8355840] range.
+
+		Finally, the c constant is set by the sensor
+		internally.
+
+		The value stored in sensor is displayed when read from.
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/iio/light/isl29501.txt b/Documentation/devicetree/bindings/iio/light/isl29501.txt
new file mode 100644
index 0000000..4695799
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/isl29501.txt
@@ -0,0 +1,13 @@
+* ISL29501 Time-of-flight sensor.
+
+Required properties:
+
+  - compatible : should be "renesas,isl29501"
+  - reg : the I2C address of the sensor
+
+Example:
+
+isl29501@57 {
+	compatible = "renesas,isl29501";
+	reg = <0x57>;
+};
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 074e506..661a828 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -194,6 +194,19 @@ config ISL29125
 	  To compile this driver as a module, choose M here: the module will be
 	  called isl29125.
 
+config ISL29501
+	tristate "Intersil ISL29501 Time Of Flight sensor"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select IIO_KFIFO_BUF
+	help
+	  Say Y here if you want to build a driver for the Intersil ISL29501
+	  Time of Flight sensor.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called isl29501.
+
 config HID_SENSOR_ALS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f177703..7c3f71f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_HID_SENSOR_PROX)	+= hid-sensor-prox.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
+obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
diff --git a/drivers/iio/light/isl29501.c b/drivers/iio/light/isl29501.c
new file mode 100644
index 0000000..1be6ea8
--- /dev/null
+++ b/drivers/iio/light/isl29501.c
@@ -0,0 +1,1150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * isl29501.c: ISL29501 Time of Flight sensor driver.
+ *
+ * Copyright (C) 2018
+ * Author: Mathieu Othacehe <m.othacehe@gmail.com>
+ *
+ * 7-bit I2C slave address: 0x57
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/of_device.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* Control, setting and status registers */
+#define ISL29501_DEVICE_ID			0x00
+#define ISL29501_ID				0x0A
+
+/* Sampling control registers */
+#define ISL29501_INTEGRATION_PERIOD		0x10
+#define ISL29501_SAMPLE_PERIOD			0x11
+
+/* Closed loop calibration registers */
+#define ISL29501_CROSSTALK_I_MSB		0x24
+#define ISL29501_CROSSTALK_I_LSB		0x25
+#define ISL29501_CROSSTALK_I_EXPONENT		0x26
+#define ISL29501_CROSSTALK_Q_MSB		0x27
+#define ISL29501_CROSSTALK_Q_LSB		0x28
+#define ISL29501_CROSSTALK_Q_EXPONENT		0x29
+#define ISL29501_CROSSTALK_GAIN_MSB		0x2A
+#define ISL29501_CROSSTALK_GAIN_LSB		0x2B
+#define ISL29501_MAGNITUDE_REF_EXP		0x2C
+#define ISL29501_MAGNITUDE_REF_MSB		0x2D
+#define ISL29501_MAGNITUDE_REF_LSB		0x2E
+#define ISL29501_PHASE_OFFSET_MSB		0x2F
+#define ISL29501_PHASE_OFFSET_LSB		0x30
+
+/* Analog control registers */
+#define ISL29501_DRIVER_RANGE			0x90
+#define ISL29501_EMITTER_DAC			0x91
+
+#define ISL29501_COMMAND_REGISTER		0xB0
+
+/* Commands */
+#define ISL29501_EMUL_SAMPLE_START_PIN		0x49
+#define ISL29501_RESET_ALL_REGISTERS		0xD7
+#define ISL29501_RESET_INT_SM			0xD1
+
+/* Ambiant light and temperature corrections */
+#define ISL29501_TEMP_REFERENCE			0x31
+#define ISL29501_PHASE_EXPONENT			0x33
+#define ISL29501_TEMP_COEFF_A			0x34
+#define ISL29501_TEMP_COEFF_B			0x39
+#define ISL29501_AMBIANT_COEFF_A		0x36
+#define ISL29501_AMBIANT_COEFF_B		0x3B
+
+/* Data output registers */
+#define ISL29501_DISTANCE_MSB_DATA		0xD1
+#define ISL29501_DISTANCE_LSB_DATA		0xD2
+#define ISL29501_PRECISION_MSB			0xD3
+#define ISL29501_PRECISION_LSB			0xD4
+#define ISL29501_MAGNITUDE_EXPONENT		0xD5
+#define ISL29501_MAGNITUDE_MSB			0xD6
+#define ISL29501_MAGNITUDE_LSB			0xD7
+#define ISL29501_PHASE_MSB			0xD8
+#define ISL29501_PHASE_LSB			0xD9
+#define ISL29501_I_RAW_EXPONENT			0xDA
+#define ISL29501_I_RAW_MSB			0xDB
+#define ISL29501_I_RAW_LSB			0xDC
+#define ISL29501_Q_RAW_EXPONENT			0xDD
+#define ISL29501_Q_RAW_MSB			0xDE
+#define ISL29501_Q_RAW_LSB			0xDF
+#define ISL29501_DIE_TEMPERATURE		0xE2
+#define ISL29501_AMBIENT_LIGHT			0xE3
+#define ISL29501_GAIN_MSB			0xE6
+#define ISL29501_GAIN_LSB			0xE7
+
+#define ISL29501_MAX_EXP_VAL 15
+
+#define ISL29501_INT_TIME_AVAILABLE \
+	"0.00007 0.00014 0.00028 0.00057 0.00114 " \
+	"0.00228 0.00455 0.00910 0.01820 0.03640 " \
+	"0.07281 0.14561"
+
+#define ISL29501_CURRENT_SCALE_AVAILABLE \
+	"0.0039 0.0078 0.0118 0.0157 0.0196 " \
+	"0.0235 0.0275 0.0314 0.0352 0.0392 " \
+	"0.0431 0.0471 0.0510 0.0549 0.0588"
+
+enum isl29501_correction_coeff {
+	COEFF_TEMP_A,
+	COEFF_TEMP_B,
+	COEFF_LIGHT_A,
+	COEFF_LIGHT_B,
+	COEFF_MAX,
+};
+
+struct isl29501_private {
+	struct i2c_client *client;
+	struct mutex lock;
+	/* Exact representation of correction coefficients. */
+	unsigned int shadow_coeffs[COEFF_MAX];
+};
+
+enum isl29501_register_name {
+	REG_DISTANCE,
+	REG_AMPLITUDE,
+	REG_PHASE,
+	REG_I_RAW,
+	REG_Q_RAW,
+	REG_TEMPERATURE,
+	REG_AMBIENT_LIGHT,
+	REG_GAIN,
+	REG_I_BIAS,
+	REG_Q_BIAS,
+	REG_GAIN_BIAS,
+	REG_AMPL_BIAS,
+	REG_PHASE_EXP,
+	REG_CALIB_PHASE_TEMP_A,
+	REG_CALIB_PHASE_TEMP_B,
+	REG_CALIB_PHASE_LIGHT_A,
+	REG_CALIB_PHASE_LIGHT_B,
+	REG_DISTANCE_BIAS,
+	REG_TEMPERATURE_BIAS,
+	REG_INT_TIME,
+	REG_SAMPLE_TIME,
+	REG_DRIVER_RANGE,
+	REG_EMITTER_DAC,
+};
+
+struct isl29501_register_desc {
+	u8 msb;
+	u8 lsb;
+	u8 exp;
+};
+
+static const struct isl29501_register_desc isl29501_registers[] = {
+	[REG_DISTANCE] = {
+		.msb = ISL29501_DISTANCE_MSB_DATA,
+		.lsb = ISL29501_DISTANCE_LSB_DATA,
+	},
+	[REG_AMPLITUDE] = {
+		.msb = ISL29501_MAGNITUDE_MSB,
+		.lsb = ISL29501_MAGNITUDE_LSB,
+		.exp = ISL29501_MAGNITUDE_EXPONENT,
+	},
+	[REG_PHASE] = {
+		.msb = ISL29501_PHASE_MSB,
+		.lsb = ISL29501_PHASE_LSB,
+	},
+	[REG_I_RAW] = {
+		.msb = ISL29501_I_RAW_MSB,
+		.lsb = ISL29501_I_RAW_LSB,
+		.exp = ISL29501_I_RAW_EXPONENT,
+	},
+	[REG_Q_RAW] = {
+		.msb = ISL29501_Q_RAW_MSB,
+		.lsb = ISL29501_Q_RAW_LSB,
+		.exp = ISL29501_Q_RAW_EXPONENT,
+	},
+	[REG_TEMPERATURE] = {
+		.lsb = ISL29501_DIE_TEMPERATURE,
+	},
+	[REG_AMBIENT_LIGHT] = {
+		.lsb = ISL29501_AMBIENT_LIGHT,
+	},
+	[REG_GAIN] = {
+		.msb = ISL29501_GAIN_MSB,
+		.lsb = ISL29501_GAIN_LSB,
+	},
+	[REG_I_BIAS] = {
+		.msb = ISL29501_CROSSTALK_I_MSB,
+		.lsb = ISL29501_CROSSTALK_I_LSB,
+		.exp = ISL29501_CROSSTALK_I_EXPONENT,
+	},
+	[REG_Q_BIAS] = {
+		.msb = ISL29501_CROSSTALK_Q_MSB,
+		.lsb = ISL29501_CROSSTALK_Q_LSB,
+		.exp = ISL29501_CROSSTALK_Q_EXPONENT,
+	},
+	[REG_GAIN_BIAS] = {
+		.msb = ISL29501_CROSSTALK_GAIN_MSB,
+		.lsb = ISL29501_CROSSTALK_GAIN_LSB,
+	},
+	[REG_AMPL_BIAS] = {
+		.msb = ISL29501_MAGNITUDE_REF_MSB,
+		.lsb = ISL29501_MAGNITUDE_REF_LSB,
+		.exp = ISL29501_MAGNITUDE_REF_EXP,
+	},
+	[REG_PHASE_EXP] = {
+		.lsb = ISL29501_PHASE_EXPONENT,
+	},
+	[REG_CALIB_PHASE_TEMP_A] = {
+		.lsb = ISL29501_TEMP_COEFF_A,
+	},
+	[REG_CALIB_PHASE_TEMP_B] = {
+		.lsb = ISL29501_TEMP_COEFF_B,
+	},
+	[REG_CALIB_PHASE_LIGHT_A] = {
+		.lsb = ISL29501_AMBIANT_COEFF_A,
+	},
+	[REG_CALIB_PHASE_LIGHT_B] = {
+		.lsb = ISL29501_AMBIANT_COEFF_B,
+	},
+	[REG_DISTANCE_BIAS] = {
+		.msb = ISL29501_PHASE_OFFSET_MSB,
+		.lsb = ISL29501_PHASE_OFFSET_LSB,
+	},
+	[REG_TEMPERATURE_BIAS] = {
+		.lsb = ISL29501_TEMP_REFERENCE,
+	},
+	[REG_INT_TIME] = {
+		.lsb = ISL29501_INTEGRATION_PERIOD,
+	},
+	[REG_SAMPLE_TIME] = {
+		.lsb = ISL29501_SAMPLE_PERIOD,
+	},
+	[REG_DRIVER_RANGE] = {
+		.lsb = ISL29501_DRIVER_RANGE,
+	},
+	[REG_EMITTER_DAC] = {
+		.lsb = ISL29501_EMITTER_DAC,
+	},
+};
+
+static int isl29501_register_read(struct isl29501_private *isl29501,
+				  enum isl29501_register_name name,
+				  u32 *val)
+{
+	const struct isl29501_register_desc *reg = &isl29501_registers[name];
+	u8 msb = 0, lsb = 0, exp = 0;
+	s32 ret;
+
+	mutex_lock(&isl29501->lock);
+	if (reg->msb) {
+		ret = i2c_smbus_read_byte_data(isl29501->client, reg->msb);
+		if (ret < 0)
+			goto err;
+		msb = ret;
+	}
+
+	if (reg->lsb) {
+		ret = i2c_smbus_read_byte_data(isl29501->client, reg->lsb);
+		if (ret < 0)
+			goto err;
+		lsb = ret;
+	}
+
+	if (reg->exp) {
+		ret = i2c_smbus_read_byte_data(isl29501->client, reg->exp);
+		if (ret < 0)
+			goto err;
+		exp = ret;
+	}
+	mutex_unlock(&isl29501->lock);
+
+	*val = ((msb << 8) + lsb) << exp;
+
+	return 0;
+err:
+	mutex_unlock(&isl29501->lock);
+	return ret;
+}
+
+static u32 isl29501_register_write(struct isl29501_private *isl29501,
+				   enum isl29501_register_name name,
+				   u32 value)
+{
+	const struct isl29501_register_desc *reg = &isl29501_registers[name];
+	u8 msb, lsb;
+	int ret;
+
+	if (!reg->msb && value > U8_MAX)
+		return -ERANGE;
+
+	if (!reg->exp && value > U16_MAX)
+		return -ERANGE;
+
+	if (reg->exp) {
+		/* TODO: Implement float write */
+		return -EINVAL;
+	}
+
+	if (!reg->msb) {
+		lsb = value & 0xFF;
+	} else {
+		msb = (value >> 8) & 0xFF;
+		lsb = value & 0xFF;
+	}
+
+	mutex_lock(&isl29501->lock);
+	if (reg->msb) {
+		ret = i2c_smbus_write_byte_data(isl29501->client,
+						reg->msb, msb);
+		if (ret < 0)
+			goto err;
+	}
+
+	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
+	if (ret < 0)
+		goto err;
+	mutex_unlock(&isl29501->lock);
+
+	return 0;
+err:
+	mutex_unlock(&isl29501->lock);
+	return ret;
+}
+
+static ssize_t isl29501_read_ext(struct iio_dev *indio_dev,
+				 uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 char *buf)
+{
+	struct isl29501_private *isl29501 = iio_priv(indio_dev);
+	enum isl29501_register_name reg = private;
+	int ret;
+	u32 value, gain, coeff, exp;
+
+	switch (reg) {
+	case REG_GAIN:
+	case REG_GAIN_BIAS:
+		ret = isl29501_register_read(isl29501, reg, &gain);
+		if (ret < 0)
+			return ret;
+
+		value = gain;
+		break;
+	case REG_CALIB_PHASE_TEMP_A:
+	case REG_CALIB_PHASE_TEMP_B:
+	case REG_CALIB_PHASE_LIGHT_A:
+	case REG_CALIB_PHASE_LIGHT_B:
+		ret = isl29501_register_read(isl29501, REG_PHASE_EXP, &exp);
+		if (ret < 0)
+			return ret;
+
+		ret = isl29501_register_read(isl29501, reg, &coeff);
+		if (ret < 0)
+			return ret;
+
+		value = coeff << exp;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%u\n", value);
+}
+
+static int isl29501_set_shadow_coeff(struct isl29501_private *isl29501,
+				     enum isl29501_register_name reg,
+				     unsigned int val)
+{
+	enum isl29501_correction_coeff coeff;
+
+	switch (reg) {
+	case REG_CALIB_PHASE_TEMP_A:
+		coeff = COEFF_TEMP_A;
+		break;
+	case REG_CALIB_PHASE_TEMP_B:
+		coeff = COEFF_TEMP_B;
+		break;
+	case REG_CALIB_PHASE_LIGHT_A:
+		coeff = COEFF_LIGHT_A;
+		break;
+	case REG_CALIB_PHASE_LIGHT_B:
+		coeff = COEFF_LIGHT_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+	isl29501->shadow_coeffs[coeff] = val;
+
+	return 0;
+}
+
+static int isl29501_write_coeff(struct isl29501_private *isl29501,
+				enum isl29501_correction_coeff coeff,
+				int val)
+{
+	enum isl29501_register_name reg;
+	int ret;
+
+	switch (coeff) {
+	case COEFF_TEMP_A:
+		reg = REG_CALIB_PHASE_TEMP_A;
+		break;
+	case COEFF_TEMP_B:
+		reg = REG_CALIB_PHASE_TEMP_B;
+		break;
+	case COEFF_LIGHT_A:
+		reg = REG_CALIB_PHASE_LIGHT_A;
+		break;
+	case COEFF_LIGHT_B:
+		reg = REG_CALIB_PHASE_LIGHT_B;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return isl29501_register_write(isl29501, reg, val);
+}
+
+static unsigned int isl29501_find_corr_exp(unsigned int val,
+					   unsigned int max_exp,
+					   unsigned int max_mantissa)
+{
+	unsigned int exp = 1;
+
+	/*
+	 * Correction coefficients are represented under
+	 * mantissa * 2^exponent form, where mantissa and exponent
+	 * are stored in two separate registers of the sensor.
+	 *
+	 * Compute and return the lowest exponent such as:
+	 *	     mantissa = value / 2^exponent
+	 *
+	 *  where mantissa < max_mantissa.
+	 */
+	if (val <= max_mantissa)
+		return 0;
+
+	while ((val >> exp) > max_mantissa) {
+		exp++;
+
+		if (exp > max_exp)
+			return max_exp;
+	}
+
+	return exp;
+}
+
+static ssize_t isl29501_write_ext(struct iio_dev *indio_dev,
+				  uintptr_t private,
+				  const struct iio_chan_spec *chan,
+				  const char *buf, size_t len)
+{
+	struct isl29501_private *isl29501 = iio_priv(indio_dev);
+	enum isl29501_register_name reg = private;
+	unsigned int val;
+	int max_exp = 0;
+	int ret;
+	int i;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case REG_GAIN_BIAS:
+		if (val > U16_MAX)
+			return -ERANGE;
+
+		ret = isl29501_register_write(isl29501, reg, val);
+		if (ret < 0)
+			return ret;
+
+		break;
+	case REG_CALIB_PHASE_TEMP_A:
+	case REG_CALIB_PHASE_TEMP_B:
+	case REG_CALIB_PHASE_LIGHT_A:
+	case REG_CALIB_PHASE_LIGHT_B:
+
+		if (val > (U8_MAX << ISL29501_MAX_EXP_VAL))
+			return -ERANGE;
+
+		/* Store the correction coefficient under its exact form. */
+		ret = isl29501_set_shadow_coeff(isl29501, reg, val);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Find the highest exponent needed to represent
+		 * correction coefficients.
+		 */
+		for (i = 0; i < COEFF_MAX; i++) {
+			int corr;
+			int corr_exp;
+
+			corr = isl29501->shadow_coeffs[i];
+			corr_exp = isl29501_find_corr_exp(corr,
+							  ISL29501_MAX_EXP_VAL,
+							  U8_MAX / 2);
+			dev_dbg(&isl29501->client->dev,
+				"found exp of corr(%d) = %d\n", corr, corr_exp);
+
+			max_exp = max(max_exp, corr_exp);
+		}
+
+		/*
+		 * Represent every correction coefficient under
+		 * mantissa * 2^max_exponent form and force the
+		 * writing of those coefficients on the sensor.
+		 */
+		for (i = 0; i < COEFF_MAX; i++) {
+			int corr;
+			int mantissa;
+
+			corr = isl29501->shadow_coeffs[i];
+			if (!corr)
+				continue;
+
+			mantissa = corr >> max_exp;
+
+			ret = isl29501_write_coeff(isl29501, i, mantissa);
+			if (ret < 0)
+				return ret;
+		}
+
+		ret = isl29501_register_write(isl29501, REG_PHASE_EXP, max_exp);
+		if (ret < 0)
+			return ret;
+
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return len;
+}
+
+#define _ISL29501_EXT_INFO(_name, _ident) { \
+	.name = _name, \
+	.read = isl29501_read_ext, \
+	.write = isl29501_write_ext, \
+	.private = _ident, \
+	.shared = IIO_SEPARATE, \
+}
+
+static const struct iio_chan_spec_ext_info isl29501_ext_info[] = {
+	_ISL29501_EXT_INFO("agc_gain", REG_GAIN),
+	_ISL29501_EXT_INFO("agc_gain_bias", REG_GAIN_BIAS),
+	_ISL29501_EXT_INFO("calib_phase_temp_a", REG_CALIB_PHASE_TEMP_A),
+	_ISL29501_EXT_INFO("calib_phase_temp_b", REG_CALIB_PHASE_TEMP_B),
+	_ISL29501_EXT_INFO("calib_phase_light_a", REG_CALIB_PHASE_LIGHT_A),
+	_ISL29501_EXT_INFO("calib_phase_light_b", REG_CALIB_PHASE_LIGHT_B),
+	{ },
+};
+
+#define ISL29501_DISTANCE_SCAN_INDEX 0
+#define ISL29501_TIMESTAMP_SCAN_INDEX 1
+
+#define ISL29501_MAGNITUDE_CHANNEL 0
+#define ISL29501_AMBIENT_LIGHT_CHANNEL 1
+
+static const struct iio_chan_spec isl29501_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.scan_index = ISL29501_DISTANCE_SCAN_INDEX,
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW)   |
+			BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.ext_info = isl29501_ext_info,
+	},
+	{
+		.type = IIO_PHASE,
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = ISL29501_MAGNITUDE_CHANNEL,
+		.extend_name = "magnitude",
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = ISL29501_MAGNITUDE_CHANNEL,
+		.scan_index = -1,
+		.modified = 1,
+		.channel2 = IIO_MOD_I,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = ISL29501_MAGNITUDE_CHANNEL,
+		.scan_index = -1,
+		.modified = 1,
+		.channel2 = IIO_MOD_Q,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_CURRENT,
+		.scan_index = -1,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_TEMP,
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE)     |
+				BIT(IIO_CHAN_INFO_CALIBBIAS),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = ISL29501_AMBIENT_LIGHT_CHANNEL,
+		.extend_name = "ambient_light",
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_SCALE),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(ISL29501_TIMESTAMP_SCAN_INDEX),
+};
+
+static int isl29501_reset_registers(struct isl29501_private *isl29501)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(isl29501->client,
+					ISL29501_COMMAND_REGISTER,
+					ISL29501_RESET_ALL_REGISTERS);
+	ret = i2c_smbus_write_byte_data(isl29501->client,
+					ISL29501_COMMAND_REGISTER,
+					ISL29501_RESET_INT_SM);
+	if (ret < 0) {
+		dev_err(&isl29501->client->dev,
+			"cannot reset registers %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int isl29501_begin_acquisition(struct isl29501_private *isl29501)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(isl29501->client,
+					ISL29501_COMMAND_REGISTER,
+					ISL29501_EMUL_SAMPLE_START_PIN);
+	if (ret < 0) {
+		dev_err(&isl29501->client->dev,
+			"cannot begin acquisition %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL(ISL29501_INT_TIME_AVAILABLE);
+static IIO_CONST_ATTR(out_current_scale_available,
+		      ISL29501_CURRENT_SCALE_AVAILABLE);
+
+static struct attribute *isl29501_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_const_attr_out_current0_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group isl29501_attribute_group = {
+	.attrs = isl29501_attributes,
+};
+
+static const int isl29501_current_scale_table[][2] = {
+	{0, 3900}, {0, 7800}, {0, 11800}, {0, 15700},
+	{0, 19600}, {0, 23500}, {0, 27500}, {0, 31400},
+	{0, 35200}, {0, 39200}, {0, 43100}, {0, 47100},
+	{0, 51000}, {0, 54900}, {0, 58800},
+};
+
+static const int isl29501_int_time[][2] = {
+	{0, 70},    /* 0.07 ms */
+	{0, 140},   /* 0.14 ms */
+	{0, 280},   /* 0.28 ms */
+	{0, 570},   /* 0.57 ms */
+	{0, 1140},  /* 1.14 ms */
+	{0, 2280},  /* 2.28 ms */
+	{0, 4550},  /* 4.55 ms */
+	{0, 9100},  /* 9.11 ms */
+	{0, 18200}, /* 18.2 ms */
+	{0, 36400}, /* 36.4 ms */
+	{0, 72810}, /* 72.81 ms */
+	{0, 145610} /* 145.28 ms */
+};
+
+static int isl29501_get_raw(struct isl29501_private *isl29501,
+			    const struct iio_chan_spec *chan,
+			    int *raw)
+{
+	int ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		ret = isl29501_register_read(isl29501, REG_DISTANCE, raw);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_INTENSITY:
+		if (chan->channel == ISL29501_MAGNITUDE_CHANNEL) {
+			switch (chan->channel2) {
+			case IIO_NO_MOD:
+			case IIO_MOD_I:
+			case IIO_MOD_Q:
+				/* TODO: implement float read */
+				return -EINVAL;
+			default:
+				return -EINVAL;
+			}
+		} else if (chan->channel == ISL29501_AMBIENT_LIGHT_CHANNEL) {
+			ret = isl29501_register_read(isl29501,
+						     REG_AMBIENT_LIGHT,
+						     raw);
+			if (ret < 0)
+				return ret;
+
+			return IIO_VAL_INT;
+		} else {
+			return IIO_VAL_INT;
+		}
+	case IIO_PHASE:
+		ret = isl29501_register_read(isl29501, REG_PHASE, raw);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CURRENT:
+		ret = isl29501_register_read(isl29501, REG_EMITTER_DAC, raw);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_TEMP:
+		ret = isl29501_register_read(isl29501, REG_TEMPERATURE, raw);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_get_scale(struct isl29501_private *isl29501,
+			      const struct iio_chan_spec *chan,
+			      int *val, int *val2)
+{
+	int ret;
+	u32 current_scale;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		/* distance = raw_distance * 33.31 / 65536 (m) */
+		*val = 3331;
+		*val2 = 6553600;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_PHASE:
+		/* phase = raw_phase * 2pi / 65536 (rad) */
+		*val = 0;
+		*val2 = 95874;
+
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_INTENSITY:
+		if (chan->channel != ISL29501_AMBIENT_LIGHT_CHANNEL)
+			return -EINVAL;
+		/* light = raw_light * 35 / 10000 (mA) */
+		*val = 35;
+		*val2 = 10000;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CURRENT:
+		ret = isl29501_register_read(isl29501,
+					     REG_DRIVER_RANGE,
+					     &current_scale);
+		if (ret < 0)
+			return ret;
+
+		if (current_scale > ARRAY_SIZE(isl29501_current_scale_table))
+			return -EINVAL;
+
+		if (!current_scale) {
+			*val = 0;
+			*val2 = 0;
+			return IIO_VAL_INT;
+		}
+
+		*val = isl29501_current_scale_table[current_scale - 1][0];
+		*val2 = isl29501_current_scale_table[current_scale - 1][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_TEMP:
+		/* temperature = raw_temperature * 125 / 100000 (milli °C) */
+		*val = 125;
+		*val2 = 100000;
+
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_get_calibbias(struct isl29501_private *isl29501,
+				  const struct iio_chan_spec *chan,
+				  int *bias)
+{
+	int ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return isl29501_register_read(isl29501,
+					      REG_DISTANCE_BIAS,
+					      bias);
+	case IIO_INTENSITY:
+		if (chan->channel != ISL29501_MAGNITUDE_CHANNEL)
+			return -EINVAL;
+
+		switch (chan->channel2) {
+		case IIO_NO_MOD:
+		case IIO_MOD_I:
+		case IIO_MOD_Q:
+			/* TODO: Implement float read */
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_TEMP:
+		return isl29501_register_read(isl29501,
+					      REG_TEMPERATURE_BIAS,
+					      bias);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_get_inttime(struct isl29501_private *isl29501,
+				int *val, int *val2)
+{
+	int ret;
+	u32 inttime;
+
+	ret = isl29501_register_read(isl29501, REG_INT_TIME, &inttime);
+	if (ret < 0)
+		return ret;
+
+	if (inttime >= ARRAY_SIZE(isl29501_int_time))
+		return -EINVAL;
+
+	*val = isl29501_int_time[inttime][0];
+	*val2 = isl29501_int_time[inttime][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int isl29501_get_freq(struct isl29501_private *isl29501,
+			     int *val, int *val2)
+{
+	int ret;
+	int sample_time;
+	unsigned long long freq;
+
+	ret = isl29501_register_read(isl29501, REG_SAMPLE_TIME, &sample_time);
+	if (ret < 0)
+		return ret;
+
+	/* freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
+	freq = 1000000ULL * 1000000ULL / (450ULL * (sample_time + 1ULL));
+
+	*val = freq / 1000000;
+	*val2 = freq % 1000000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int isl29501_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct isl29501_private *isl29501 = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return isl29501_get_raw(isl29501, chan, val);
+	case IIO_CHAN_INFO_SCALE:
+		return isl29501_get_scale(isl29501, chan, val, val2);
+	case IIO_CHAN_INFO_INT_TIME:
+		return isl29501_get_inttime(isl29501, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return isl29501_get_freq(isl29501, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return isl29501_get_calibbias(isl29501, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_set_raw(struct isl29501_private *isl29501,
+			    const struct iio_chan_spec *chan,
+			    int raw)
+{
+	int ret;
+
+	switch (chan->type) {
+	case IIO_CURRENT:
+		return isl29501_register_write(isl29501, REG_EMITTER_DAC, raw);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_set_inttime(struct isl29501_private *isl29501,
+				int val, int val2)
+{
+	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(isl29501_int_time); i++) {
+		if (isl29501_int_time[i][0] == val &&
+		    isl29501_int_time[i][1] == val2) {
+			return isl29501_register_write(isl29501,
+						       REG_INT_TIME,
+						       i);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int isl29501_set_scale(struct isl29501_private *isl29501,
+			      const struct iio_chan_spec *chan,
+			      int val, int val2)
+{
+	int ret;
+	int i;
+
+	if (chan->type != IIO_CURRENT)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(isl29501_current_scale_table); i++) {
+		if (isl29501_current_scale_table[i][0] == val &&
+		    isl29501_current_scale_table[i][1] == val2) {
+			return isl29501_register_write(isl29501,
+						       REG_DRIVER_RANGE,
+						       i + 1);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int isl29501_set_calibbias(struct isl29501_private *isl29501,
+				  const struct iio_chan_spec *chan,
+				  int bias)
+{
+	int ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return isl29501_register_write(isl29501,
+					      REG_DISTANCE_BIAS,
+					      bias);
+	case IIO_INTENSITY:
+		if (chan->channel != ISL29501_MAGNITUDE_CHANNEL)
+			return -EINVAL;
+
+		switch (chan->channel2) {
+		case IIO_NO_MOD:
+		case IIO_MOD_I:
+		case IIO_MOD_Q:
+			/* TODO: Implement float read */
+			return -EINVAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_TEMP:
+		return isl29501_register_write(isl29501,
+					       REG_TEMPERATURE_BIAS,
+					       bias);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int isl29501_set_freq(struct isl29501_private *isl29501,
+			     int val, int val2)
+{
+	int freq;
+	unsigned long long sample_time;
+	int ret;
+
+	/* sample_freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
+	freq = val * 1000000 + val2 % 1000000;
+	sample_time = (2222ULL * 1000000ULL / freq) - 1ULL;
+
+	if (sample_time > 255)
+		return -ERANGE;
+
+	return isl29501_register_write(isl29501, REG_SAMPLE_TIME, sample_time);
+}
+
+static int isl29501_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct isl29501_private *isl29501 = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return isl29501_set_raw(isl29501, chan, val);
+	case IIO_CHAN_INFO_INT_TIME:
+		return isl29501_set_inttime(isl29501, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return isl29501_set_freq(isl29501, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return isl29501_set_scale(isl29501, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return isl29501_set_calibbias(isl29501, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info isl29501_info = {
+	.read_raw = &isl29501_read_raw,
+	.write_raw = &isl29501_write_raw,
+	.attrs = &isl29501_attribute_group,
+};
+
+static int isl29501_init_chip(struct isl29501_private *isl29501)
+{
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(isl29501->client, ISL29501_DEVICE_ID);
+	if (ret < 0) {
+		dev_err(&isl29501->client->dev, "Error reading device id\n");
+		return ret;
+	}
+
+	if (ret != ISL29501_ID) {
+		dev_err(&isl29501->client->dev,
+			"Wrong chip id, got %x expected %x\n",
+			ret, ISL29501_DEVICE_ID);
+		return -ENODEV;
+	}
+
+	ret = isl29501_reset_registers(isl29501);
+	if (ret < 0)
+		return ret;
+
+	return isl29501_begin_acquisition(isl29501);
+}
+
+static irqreturn_t isl29501_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct isl29501_private *isl29501 = iio_priv(indio_dev);
+	const unsigned long *active_mask = indio_dev->active_scan_mask;
+	u32 buffer[4]; /* 1x16-bit + ts */
+
+	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
+		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int isl29501_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct isl29501_private *isl29501;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*isl29501));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	isl29501 = iio_priv(indio_dev);
+
+	i2c_set_clientdata(client, indio_dev);
+	isl29501->client = client;
+
+	mutex_init(&isl29501->lock);
+
+	ret = isl29501_init_chip(isl29501);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = isl29501_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl29501_channels);
+	indio_dev->name = client->name;
+	indio_dev->info = &isl29501_info;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      isl29501_trigger_handler,
+					      NULL);
+	if (ret < 0) {
+		dev_err(&client->dev, "unable to setup iio triggered buffer\n");
+		return ret;
+	}
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id isl29501_id[] = {
+	{"isl29501", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, isl29501_id);
+
+#if defined(CONFIG_OF)
+static const struct of_device_id isl29501_i2c_matches[] = {
+	{ .compatible = "renesas,isl29501" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
+#endif
+
+static struct i2c_driver isl29501_driver = {
+	.driver = {
+		.name	= "isl29501",
+	},
+	.id_table	= isl29501_id,
+	.probe		= isl29501_probe,
+};
+module_i2c_driver(isl29501_driver);
+
+MODULE_AUTHOR("Mathieu Othacehe <m.othacehe@gmail.com>");
+MODULE_DESCRIPTION("ISL29501 Time of Flight sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

