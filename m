Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42593 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570Ab2IFXgZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 6 Sep 2012 19:36:25 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: add driver for si114x ambient light / proximity sensors
Date: Fri,  7 Sep 2012 01:36:22 +0200
Message-Id: <1346974582-5936-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/Kconfig        |   13 +
 drivers/iio/light/si114x.c       | 1239 ++++++++++++++++++++++++++++++++++++++
 include/linux/iio/light/si114x.h |   21 +
 3 files changed, 1273 insertions(+)
 create mode 100644 drivers/iio/light/si114x.c
 create mode 100644 include/linux/iio/light/si114x.h

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 91d15d2..1af945b 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -32,6 +32,19 @@ config SENSORS_LM3533
 	  changes. The ALS-control output values can be set per zone for the
 	  three current output channels.
 
+config SI114X
+	tristate "SI114x combined ALS and proximity sensor"
+	depends on I2C
+	default n
+	---help---
+	  Say Y here if you want to build a driver for the Silicon Labs SI114x
+	  combined ambient light and proximity sensor chips (SI1141, SI1142,
+	  SI1143). The driver supports forced (with and w/o IRQ) and autonomous
+	  measurements (with IRQ only).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called si114x.
+
 config VCNL4000
 	tristate "VCNL4000 combined ALS and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/si114x.c b/drivers/iio/light/si114x.c
new file mode 100644
index 0000000..9ab0d4d
--- /dev/null
+++ b/drivers/iio/light/si114x.c
@@ -0,0 +1,1239 @@
+/*
+ * si114x.c - Support for Silabs si114x combined ambient light and
+ * proximity sensor
+ *
+ * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ *
+ * IIO driver for si114x (7-bit I2C slave address 0x5a)
+ *
+ * driver supports IRQ and non-IRQ mode; an IRQ is required for
+ * autonomous measurement mode
+ * TODO:
+ *   thresholds
+ *   power management (measurement rate zero)
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/buffer.h>
+
+#include "si114x.h"
+
+#define SI114X_REG_PART_ID		0x00
+#define SI114X_REG_REV_ID		0x01
+#define SI114X_REG_SEQ_ID		0x02
+#define SI114X_REG_INT_CFG		0x03
+#define SI114X_REG_IRQ_ENABLE		0x04
+#define SI114X_REG_IRQ_MODE1		0x05
+#define SI114X_REG_IRQ_MODE2		0x06
+#define SI114X_REG_HW_KEY		0x07
+/* RATE stores a 16 bit value compressed to 8 bit */
+#define SI114X_REG_MEAS_RATE		0x08
+#define SI114X_REG_ALS_RATE		0x09
+#define SI114X_REG_PS_RATE		0x0a
+#define SI114X_REG_ALS_LOW_TH0		0x0b
+#define SI114X_REG_ALS_LOW_TH1		0x0c
+#define SI114X_REG_ALS_HI_TH0		0x0d
+#define SI114X_REG_ALS_HI_TH1		0x0e
+#define SI114X_REG_PS_LED21		0x0f
+#define SI114X_REG_PS_LED3		0x10
+/*
+ * for rev A10 and below TH0 stores a 16 bit value compressed to 8 bit and
+ * TH1 is not used; newer revision have the LSB in TH0 and the MSB in TH1
+ */
+#define SI114X_REG_PS1_TH0		0x11
+#define SI114X_REG_PS1_TH1		0x12
+#define SI114X_REG_PS2_TH0		0x13
+#define SI114X_REG_PS2_TH1		0x11
+#define SI114X_REG_PS3_TH0		0x15
+#define SI114X_REG_PS3_TH1		0x16
+#define SI114X_REG_PARAM_WR		0x17
+#define SI114X_REG_COMMAND		0x18
+#define SI114X_REG_RESPONSE		0x20
+#define SI114X_REG_IRQ_STATUS		0x21
+#define SI114X_REG_ALSVIS_DATA0		0x22
+#define SI114X_REG_ALSVIS_DATA1		0x23
+#define SI114X_REG_ALSIR_DATA0		0x24
+#define SI114X_REG_ALSIR_DATA1		0x25
+#define SI114X_REG_PS1_DATA0		0x26
+#define SI114X_REG_PS1_DATA1		0x27
+#define SI114X_REG_PS2_DATA0		0x28
+#define SI114X_REG_PS2_DATA1		0x29
+#define SI114X_REG_PS3_DATA0		0x2a
+#define SI114X_REG_PS3_DATA1		0x2b
+#define SI114X_REG_AUX_DATA0		0x2c
+#define SI114X_REG_AUX_DATA1		0x2d
+#define SI114X_REG_PARAM_RD		0x2e
+#define SI114X_REG_CHIP_STAT		0x30
+
+/* Parameter offsets */
+#define SI114X_PARAM_I2C_ADDR		0x00
+#define SI114X_PARAM_CHLIST		0x01
+#define SI114X_PARAM_PSLED12_SELECT	0x02
+#define SI114X_PARAM_PSLED3_SELECT	0x03
+#define SI114X_PARAM_FILTER_EN		0x04
+#define SI114X_PARAM_PS_ENCODING	0x05
+#define SI114X_PARAM_ALS_ENCODING	0x06
+#define SI114X_PARAM_PS1_ADC_MUX	0x07
+#define SI114X_PARAM_PS2_ADC_MUX	0x08
+#define SI114X_PARAM_PS3_ADC_MUX	0x09
+#define SI114X_PARAM_PS_ADC_COUNTER	0x0a
+#define SI114X_PARAM_PS_ADC_GAIN	0x0b
+#define SI114X_PARAM_PS_ADC_MISC	0x0c
+#define SI114X_PARAM_ALS_ADC_MUX	0x0d
+#define SI114X_PARAM_ALSIR_ADC_MUX	0x0e
+#define SI114X_PARAM_AUX_ADC_MUX	0x0f
+#define SI114X_PARAM_ALSVIS_ADC_COUNTER	0x10
+#define SI114X_PARAM_ALSVIS_ADC_GAIN	0x11
+#define SI114X_PARAM_ALSVIS_ADC_MISC	0x12
+#define SI114X_PARAM_ALS_HYST		0x16
+#define SI114X_PARAM_PS_HYST		0x17
+#define SI114X_PARAM_PS_HISTORY		0x18
+#define SI114X_PARAM_ALS_HISTORY	0x19
+#define SI114X_PARAM_ADC_OFFSET		0x1a
+#define SI114X_PARAM_SLEEP_CTRL		0x1b
+#define SI114X_PARAM_LED_RECOVERY	0x1c
+#define SI114X_PARAM_ALSIR_ADC_COUNTER	0x1d
+#define SI114X_PARAM_ALSIR_ADC_GAIN	0x1e
+#define SI114X_PARAM_ALSIR_ADC_MISC	0x1f
+
+/* Channel enable masks for CHLIST parameter */
+#define SI114X_CHLIST_EN_PS1		0x01
+#define SI114X_CHLIST_EN_PS2		0x02
+#define SI114X_CHLIST_EN_PS3		0x04
+#define SI114X_CHLIST_EN_ALSVIS		0x10
+#define SI114X_CHLIST_EN_ALSIR		0x20
+#define SI114X_CHLIST_EN_AUX		0x40
+
+/* Signal range mask for ADC_MISC parameter */
+#define SI114X_MISC_RANGE		0x20
+
+/* Commands for REG_COMMAND */
+#define SI114X_COMMAND_NOP		0x00
+#define SI114X_COMMAND_RESET		0x01
+#define SI114X_COMMAND_BUSADDR		0x02
+#define SI114X_COMMAND_PS_FORCE		0x05
+#define SI114X_COMMAND_ALS_FORCE	0x06
+#define SI114X_COMMAND_PSALS_FORCE	0x07
+#define SI114X_COMMAND_PS_PAUSE		0x09
+#define SI114X_COMMAND_ALS_PAUSE	0x0a
+#define SI114X_COMMAND_PSALS_PAUSE	0x0b
+#define SI114X_COMMAND_PS_AUTO		0x0d
+#define SI114X_COMMAND_ALS_AUTO		0x0e
+#define SI114X_COMMAND_PSALS_AUTO	0x0f
+#define SI114X_COMMAND_PARAM_QUERY	0x80
+#define SI114X_COMMAND_PARAM_SET	0xa0
+#define SI114X_COMMAND_PARAM_AND	0xc0
+#define SI114X_COMMAND_PARAM_OR		0xe0
+
+/* Interrupt configuration masks for INT_CFG register */
+#define SI114x_INT_CFG_OE		0x01 /* enable interrupt */
+#define SI114x_INT_CFG_MODE		0x02 /* auto reset interrupt pin */
+
+/* Interrupt enable masks for IRQ_ENABLE register */
+#define SI114X_CMD_IE			0x20
+#define SI114X_PS3_IE			0x10
+#define SI114X_PS2_IE			0x08
+#define SI114X_PS1_IE			0x04
+#define SI114X_ALS_INT1_IE		0x02
+#define SI114X_ALS_INT0_IE		0x01
+
+/* Interrupt mode masks for IRQ_MODE1 register */
+#define SI114X_PS2_IM_GREATER		0xc0
+#define SI114X_PS2_IM_CROSS		0x40
+#define SI114X_PS1_IM_GREATER		0x30
+#define SI114X_PS1_IM_CROSS		0x10
+
+/* Interrupt mode masks for IRQ_MODE2 register */
+#define SI114X_CMD_IM_ERROR		0x04
+#define SI114X_PS3_IM_GREATER		0x03
+#define SI114X_PS3_IM_CROSS		0x01
+
+/* Measurement rate settings */
+#define SI114X_MEAS_RATE_FORCED		0x00
+#define SI114X_MEAS_RATE_10MS		0x84
+#define SI114X_MEAS_RATE_20MS		0x94
+#define SI114X_MEAS_RATE_100MS		0xb9
+#define SI114X_MEAS_RATE_496MS		0xdf
+#define SI114X_MEAS_RATE_1984MS		0xff
+
+/* ALS rate settings relative to measurement rate */
+#define SI114X_ALS_RATE_OFF		0x00
+#define SI114X_ALS_RATE_1X		0x08
+#define SI114X_ALS_RATE_10X		0x32
+#define SI114X_ALS_RATE_100X		0x69
+
+/* PS rate settings relative to measurement rate */
+#define SI114X_PS_RATE_OFF		0x00
+#define SI114X_PS_RATE_1X		0x08
+#define SI114X_PS_RATE_10X		0x32
+#define SI114X_PS_RATE_100X		0x69
+
+/* Sequencer revision from SEQ_ID */
+#define SI114X_SEQ_REV_A01		0x01
+#define SI114X_SEQ_REV_A02		0x02
+#define SI114X_SEQ_REV_A03		0x03
+#define SI114X_SEQ_REV_A10		0x08
+#define SI114X_SEQ_REV_A11		0x09
+
+#define SI114X_DRV_NAME "si114x"
+
+struct si114x_data {
+	struct i2c_client *client;
+	struct iio_info *info;
+	u8 part;
+	u8 rev;
+	u8 seq;
+	u16 *buffer;
+	bool ps_active;
+	bool als_active;
+	wait_queue_head_t data_avail;
+	bool got_data;
+	const struct si114x_platform_data *pdata;
+	bool use_irq;
+	struct iio_trigger *trig;
+};
+
+static const struct i2c_device_id si114x_id[] = {
+	{ "si114x", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, si114x_id);
+
+static u16 si114x_uncompress(u8 x)
+{
+	u16 result = 0;
+	u8 exponent = 0;
+
+	if (x < 8)
+		return 0;
+
+	exponent = (x & 0xf0) >> 4;
+	result = 0x10 | (x & 0x0f);
+
+	if (exponent >= 4)
+		return result << (exponent - 4);
+	return result >> (4 - exponent);
+}
+
+static u8 si114x_compress(u16 x)
+{
+	u32 exponent = 0;
+	u32 significand = 0;
+	u32 tmp = x;
+
+	if (x == 0x0000)
+		return 0x00;
+	if (x == 0x0001)
+		return 0x08;
+
+	while (1) {
+		tmp >>= 1;
+		exponent += 1;
+		if (tmp == 1)
+			break;
+	}
+
+	if (exponent < 5) {
+		significand = x << (4 - exponent);
+		return (exponent << 4) | (significand & 0xF);
+	}
+
+	significand = x >> (exponent - 5);
+	if (significand & 1) {
+		significand += 2;
+		if (significand & 0x0040) {
+			exponent += 1;
+			significand >>= 1;
+		}
+	}
+
+	return (exponent << 4) | ((significand >> 1) & 0xF);
+}
+
+static int si114x_param_op(struct si114x_data *data, u8 op, u8 param, u8 value)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_PARAM_WR, value);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_COMMAND,
+		op | (param & 0x1F));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int si114x_param_set(struct si114x_data *data, u8 param, u8 value)
+{
+	return si114x_param_op(data, SI114X_COMMAND_PARAM_SET, param, value);
+}
+
+static int si114x_param_or(struct si114x_data *data, u8 param, u8 value)
+{
+	return si114x_param_op(data, SI114X_COMMAND_PARAM_OR, param, value);
+}
+
+static int si114x_param_and(struct si114x_data *data, u8 param, u8 value)
+{
+	return si114x_param_op(data, SI114X_COMMAND_PARAM_AND, param, value);
+}
+
+static int si114x_param_get(struct si114x_data *data, u8 param)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_COMMAND,
+		SI114X_COMMAND_PARAM_QUERY | (param & 0x1F));
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_read_byte_data(client, SI114X_REG_PARAM_RD);
+	if (ret < 0)
+		return ret;
+
+	return ret & 0xff;
+}
+
+static irqreturn_t si114x_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct si114x_data *data = iio_priv(indio_dev);
+	struct iio_buffer *buffer = indio_dev->buffer;
+	s64 time_ns = iio_get_time_ns();
+	int len = 0;
+	int i, j = 0;
+
+	int ret = i2c_smbus_write_byte_data(data->client,
+		SI114X_REG_COMMAND, SI114X_COMMAND_PSALS_FORCE);
+	if (ret < 0)
+		goto done;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		ret = i2c_smbus_read_word_data(data->client,
+			indio_dev->channels[i].address);
+		if (ret < 0)
+			goto done;
+
+		data->buffer[j++] = ret & 0xffff;
+		len += 2;
+	}
+
+	if (indio_dev->scan_timestamp)
+		*(s64 *)((u8 *)data->buffer + ALIGN(len, sizeof(s64)))
+			= time_ns;
+	iio_push_to_buffer(buffer, (u8 *)data->buffer, time_ns);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t si114x_irq(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = i2c_smbus_read_byte_data(data->client,
+		SI114X_REG_IRQ_STATUS);
+	if (ret < 0 || !(ret & (SI114X_PS3_IE | SI114X_PS2_IE | SI114X_PS1_IE |
+		SI114X_ALS_INT1_IE | SI114X_ALS_INT0_IE)))
+		return IRQ_HANDLED;
+
+	if (iio_buffer_enabled(indio_dev)) {
+		iio_trigger_poll(indio_dev->trig, 0);
+	} else {
+		data->got_data = true;
+		wake_up_interruptible(&data->data_avail);
+	}
+
+	/* clearing IRQ */
+	ret = i2c_smbus_write_byte_data(data->client,
+		SI114X_REG_IRQ_STATUS, ret & 0x1f);
+	if (ret < 0)
+		dev_err(&data->client->dev, "clearing irq failed\n");
+
+	return IRQ_HANDLED;
+}
+
+static int si114x_trig_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	int cmd;
+
+	/* configure autonomous mode */
+	cmd = state ? SI114X_COMMAND_PSALS_AUTO :
+		SI114X_COMMAND_PSALS_PAUSE;
+
+	ret = i2c_smbus_write_byte_data(data->client,
+		SI114X_REG_COMMAND, cmd);
+
+	return ret;
+}
+
+static const struct iio_trigger_ops si114x_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = si114x_trig_set_state,
+};
+
+static int si114x_probe_trigger(struct iio_dev *indio_dev)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->trig = iio_trigger_alloc("si114x-dev%d", indio_dev->id);
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->dev.parent = &data->client->dev;
+	data->trig->ops = &si114x_trigger_ops;
+	data->trig->private_data = indio_dev;
+	ret = iio_trigger_register(data->trig);
+	if (ret)
+		goto error_free_trig;
+
+	/* select default trigger */
+	indio_dev->trig = data->trig;
+
+	return 0;
+
+error_free_trig:
+	iio_trigger_free(data->trig);
+	return ret;
+}
+
+static void si114x_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+
+	iio_trigger_unregister(data->trig);
+	iio_trigger_free(data->trig);
+}
+
+static int si114x_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	u8 cmd, reg, shift;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_INTENSITY:
+		case IIO_PROXIMITY:
+		case IIO_TEMP:
+			if (iio_buffer_enabled(indio_dev))
+				return -EBUSY;
+
+			if (chan->type == IIO_PROXIMITY)
+				cmd = SI114X_COMMAND_PS_FORCE;
+			else
+				cmd = SI114X_COMMAND_ALS_FORCE;
+			ret = i2c_smbus_write_byte_data(data->client,
+				SI114X_REG_COMMAND, cmd);
+			if (ret < 0)
+				return ret;
+			if (data->use_irq) {
+
+				ret = wait_event_interruptible_timeout(
+					data->data_avail, data->got_data,
+					msecs_to_jiffies(1000));
+				data->got_data = false;
+				if (ret == 0)
+					ret = -ETIMEDOUT;
+
+			} else
+				msleep(20);
+
+			if (ret < 0)
+				return ret;
+
+			ret = i2c_smbus_read_word_data(data->client,
+				chan->address);
+			if (ret < 0)
+				return ret;
+
+			*val = ret & 0xffff;
+
+			ret = IIO_VAL_INT;
+			break;
+		case IIO_CURRENT:
+			shift = 0;
+			switch (chan->channel) {
+			case 2:
+				reg = SI114X_REG_PS_LED3;
+				break;
+			case 1:
+				shift = 4;
+			case 0:
+				reg = SI114X_REG_PS_LED21;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			ret = i2c_smbus_read_byte_data(data->client, reg);
+			if (ret < 0)
+				return ret;
+
+			*val = (ret >> shift) & 0x0f;
+
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (chan->type == IIO_PROXIMITY)
+			reg = SI114X_PARAM_PS_ADC_GAIN;
+		else if (chan->type == IIO_INTENSITY) {
+			if (chan->channel2 == IIO_MOD_LIGHT_IR)
+				reg = SI114X_PARAM_ALSIR_ADC_GAIN;
+			else
+				reg = SI114X_PARAM_ALSVIS_ADC_GAIN;
+		} else
+			return -EINVAL;
+
+		ret = si114x_param_get(data, reg);
+		if (ret < 0)
+			return ret;
+
+		*val = ret & 0x07;
+
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int si114x_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	u8 reg1, reg2, shift;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (chan->type == IIO_PROXIMITY) {
+			if (val < 0 || val > 5)
+				return -EINVAL;
+			reg1 = SI114X_PARAM_PS_ADC_GAIN;
+			reg2 = SI114X_PARAM_PS_ADC_COUNTER;
+		} else if (chan->type == IIO_INTENSITY) {
+			if (val < 0 || val > 7)
+				return -EINVAL;
+			if (chan->channel2 == IIO_MOD_LIGHT_IR) {
+				reg1 = SI114X_PARAM_ALSIR_ADC_GAIN;
+				reg2 = SI114X_PARAM_ALSIR_ADC_COUNTER;
+			} else {
+				reg1 = SI114X_PARAM_ALSVIS_ADC_GAIN;
+				reg2 = SI114X_PARAM_ALSVIS_ADC_COUNTER;
+			}
+		} else
+			return -EINVAL;
+
+		ret = si114x_param_set(data, reg1, val);
+		if (ret < 0)
+			return ret;
+		/* set recovery period to one's complement of gain */
+		ret = si114x_param_set(data, reg2, (~val & 0x07) << 4);
+		return ret;
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type != IIO_CURRENT)
+			return -EINVAL;
+
+		if (val < 0 || val > 0xf)
+			return -EINVAL;
+
+		shift = 0;
+		switch (chan->channel) {
+		case 2:
+			reg1 = SI114X_REG_PS_LED3;
+			break;
+		case 1:
+			shift = 4;
+		case 0:
+			reg1 = SI114X_REG_PS_LED21;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		ret = i2c_smbus_read_byte_data(data->client, reg1);
+		if (ret < 0)
+			return ret;
+		ret = i2c_smbus_write_byte_data(data->client, reg1,
+			(ret & ~(0x0f << shift)) |
+			((val & 0x0f) << shift));
+		return ret;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
+
+static int si114x_update_scan_mode(struct iio_dev *indio_dev,
+	const unsigned long *scan_mask)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+
+	kfree(data->buffer);
+	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (data->buffer == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int si114x_reg_access(struct iio_dev *indio_dev,
+			      unsigned reg, unsigned writeval,
+			      unsigned *readval)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (readval) {
+		ret = i2c_smbus_read_byte_data(data->client, reg);
+		if (ret < 0)
+			return ret;
+		*readval = ret;
+		ret = 0;
+	} else
+		ret = i2c_smbus_write_byte_data(data->client, reg, writeval);
+
+	return ret;
+}
+
+static int si114x_revisions(struct si114x_data *data)
+{
+	int ret = i2c_smbus_read_byte_data(data->client, SI114X_REG_PART_ID);
+	if (ret < 0)
+		return ret;
+
+	switch (ret) {
+	case 0x41:
+	case 0x42:
+	case 0x43:
+		data->part = ret;
+		break;
+	default:
+		dev_err(&data->client->dev, "invalid part\n");
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_read_byte_data(data->client, SI114X_REG_REV_ID);
+	if (ret < 0)
+		return ret;
+	data->rev = ret;
+
+	ret = i2c_smbus_read_byte_data(data->client, SI114X_REG_SEQ_ID);
+	if (ret < 0)
+		return ret;
+	data->seq = ret;
+
+	if (data->seq < SI114X_SEQ_REV_A03)
+		dev_info(&data->client->dev, "WARNING: old sequencer revision\n");
+
+	return 0;
+}
+
+static inline unsigned int si114x_leds(struct si114x_data *data)
+{
+	return data->part - 0x40;
+}
+
+static const struct iio_chan_spec si114x_proximity_channel = {
+	.type = IIO_PROXIMITY,
+	.indexed = 1,
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_HARDWAREGAIN_SHARED_BIT,
+	.scan_type = IIO_ST('u', 16, 16, 0)
+};
+
+static const struct iio_chan_spec si114x_current_channel = {
+	.type = IIO_CURRENT,
+	.indexed = 1,
+	.output = 1,
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT
+};
+
+static const struct iio_chan_spec si114x_intensity_channel = {
+	.type = IIO_INTENSITY,
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_HARDWAREGAIN_SEPARATE_BIT,
+	.scan_type = IIO_ST('u', 16, 16, 0)
+};
+
+static const struct iio_chan_spec si114x_temp_channel = {
+	.type = IIO_TEMP,
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
+	.scan_type = IIO_ST('u', 16, 16, 0),
+	.address = SI114X_REG_AUX_DATA0
+};
+
+static const struct iio_chan_spec si114x_timestamp_channel =
+	IIO_CHAN_SOFT_TIMESTAMP(-1);
+
+static ssize_t si114x_range_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *dev_attr = to_iio_dev_attr(attr);
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (sysfs_streq(buf, "normal"))
+		ret = si114x_param_and(data, dev_attr->address,
+			~SI114X_MISC_RANGE);
+	else if (sysfs_streq(buf, "high"))
+		ret = si114x_param_or(data, dev_attr->address,
+			SI114X_MISC_RANGE);
+	else
+		return -EINVAL;
+
+	return ret ? ret : len;
+}
+
+static ssize_t si114x_range_show(struct device *dev,
+			struct device_attribute *attr,
+			char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev_attr *dev_attr = to_iio_dev_attr(attr);
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = si114x_param_get(data, dev_attr->address);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%s\n",
+		(ret & SI114X_MISC_RANGE) ? "high" : "normal");
+}
+
+static IIO_DEVICE_ATTR(in_proximity_range, S_IRUGO | S_IWUSR,
+			si114x_range_show,
+			si114x_range_store,
+			SI114X_PARAM_PS_ADC_MISC);
+
+static IIO_DEVICE_ATTR(in_intensity_range, S_IRUGO | S_IWUSR,
+			si114x_range_show,
+			si114x_range_store,
+			SI114X_PARAM_ALSVIS_ADC_MISC);
+
+static IIO_DEVICE_ATTR(in_intensity_ir_range, S_IRUGO | S_IWUSR,
+			si114x_range_show,
+			si114x_range_store,
+			SI114X_PARAM_ALSIR_ADC_MISC);
+
+static IIO_CONST_ATTR(in_proximity_range_available, "normal high");
+static IIO_CONST_ATTR(in_intensity_range_available, "normal high");
+static IIO_CONST_ATTR(in_intensity_ir_range_available, "normal high");
+
+static int si114x_alloc_channels(struct iio_dev *indio_dev)
+{
+	unsigned int i, j;
+	struct si114x_data *data = iio_priv(indio_dev);
+	unsigned int num_channels = 4 + 2*si114x_leds(data);
+	struct iio_chan_spec *channels = kcalloc(num_channels,
+		sizeof(struct iio_chan_spec), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	j = 0;
+	for (i = 0; i < si114x_leds(data); i++) {
+		channels[j] = si114x_proximity_channel;
+		channels[j].channel = i;
+		channels[j].scan_index = i;
+		channels[j].address = SI114X_REG_PS1_DATA0 + i*2;
+		j++;
+
+		channels[j] = si114x_current_channel;
+		channels[j].channel = i;
+		channels[j].scan_index = -1;
+		j++;
+	}
+
+	channels[j] = si114x_intensity_channel;
+	channels[j].scan_index = i;
+	channels[j].address = SI114X_REG_ALSVIS_DATA0;
+	j++;
+
+	channels[j] = si114x_intensity_channel;
+	channels[j].scan_index = i+1;
+	channels[j].modified = 1;
+	channels[j].channel2 = IIO_MOD_LIGHT_IR;
+	channels[j].address = SI114X_REG_ALSIR_DATA0;
+	j++;
+
+	channels[j] = si114x_temp_channel;
+	channels[j].scan_index = i+2;
+	j++;
+
+	channels[j] = si114x_timestamp_channel;
+	channels[j].scan_index = i+3;
+	j++;
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+
+	return 0;
+}
+
+static int si114x_set_chlist(struct iio_dev *indio_dev, bool all)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	u8 reg = 0;
+	int i;
+
+	if (all) {
+		reg = SI114X_CHLIST_EN_ALSVIS | SI114X_CHLIST_EN_ALSIR |
+			SI114X_CHLIST_EN_AUX;
+		switch (si114x_leds(data)) {
+		case 3:
+			reg |= SI114X_CHLIST_EN_PS3;
+		case 2:
+			reg |= SI114X_CHLIST_EN_PS2;
+		case 1:
+			reg |= SI114X_CHLIST_EN_PS1;
+			break;
+		}
+	} else
+		for_each_set_bit(i, indio_dev->active_scan_mask,
+			indio_dev->masklength) {
+			switch (indio_dev->channels[i].address) {
+			case SI114X_REG_ALSVIS_DATA0:
+				reg |= SI114X_CHLIST_EN_ALSVIS;
+				break;
+			case SI114X_REG_ALSIR_DATA0:
+				reg |= SI114X_CHLIST_EN_ALSIR;
+				break;
+			case SI114X_REG_PS1_DATA0:
+				reg |= SI114X_CHLIST_EN_PS1;
+				break;
+			case SI114X_REG_PS2_DATA0:
+				reg |= SI114X_CHLIST_EN_PS2;
+				break;
+			case SI114X_REG_PS3_DATA0:
+				reg |= SI114X_CHLIST_EN_PS3;
+				break;
+			case SI114X_REG_AUX_DATA0:
+				reg |= SI114X_CHLIST_EN_AUX;
+				break;
+			}
+		}
+
+	return si114x_param_set(data, SI114X_PARAM_CHLIST, reg);
+}
+
+static int si114x_initialize(struct iio_dev *indio_dev)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	u8 reg;
+	int ret;
+
+	/* send reset command */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_COMMAND,
+		SI114X_COMMAND_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* hardware key, magic value */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_HW_KEY, 0x17);
+	if (ret < 0)
+		return ret;
+
+	/* interrupt configuration, interrupt output enable */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_INT_CFG,
+		data->use_irq ? SI114x_INT_CFG_OE : 0);
+	if (ret < 0)
+		return ret;
+
+	/* enable interrupt for certain activities */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_IRQ_ENABLE,
+		SI114X_PS3_IE | SI114X_PS2_IE | SI114X_PS1_IE |
+		SI114X_ALS_INT0_IE);
+	if (ret < 0)
+		return ret;
+
+	/* configure interrupt mode for PS1 & PS2 (fire on measurement) */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_IRQ_MODE1, 0);
+	if (ret < 0)
+		return ret;
+
+	/* configure interrupt mode for PS3 (fire on measurement) */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_IRQ_MODE2, 0);
+	if (ret < 0)
+		return ret;
+
+	/* in autonomous mode, wakeup every 100 ms */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_MEAS_RATE,
+	    SI114X_MEAS_RATE_100MS);
+	if (ret < 0)
+		return ret;
+
+	/* measure ALS every time device wakes up */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_ALS_RATE,
+		SI114X_ALS_RATE_1X);
+	if (ret < 0)
+		return ret;
+
+	/* measure proximity every time device wakes up */
+	ret = i2c_smbus_write_byte_data(client, SI114X_REG_PS_RATE,
+		SI114X_PS_RATE_1X);
+	if (ret < 0)
+		return ret;
+
+	/* set LED currents to maximum */
+	reg = 0;
+	switch (si114x_leds(data)) {
+	case 3:
+		ret = i2c_smbus_write_byte_data(client,
+			SI114X_REG_PS_LED3, 0x0f);
+		if (ret < 0)
+			return ret;
+	case 2:
+		reg = 0xf0;
+	case 1:
+		reg |= 0x0f;
+		ret = i2c_smbus_write_byte_data(client,
+			SI114X_REG_PS_LED21, reg);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+
+	ret = si114x_set_chlist(indio_dev, true);
+	if (ret < 0)
+		return ret;
+
+	/* set normal proximity measurement mode, set high signal range
+	 * PS measurement */
+	ret = si114x_param_set(data, SI114X_PARAM_PS_ADC_MISC, 0x20 | 0x04);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static ssize_t si114x_read_frequency(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si114x_data *data = iio_priv(indio_dev);
+	int ret;
+	u16 rate;
+
+	ret = i2c_smbus_read_byte_data(data->client, SI114X_REG_MEAS_RATE);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		rate = 0;
+	else
+		rate = 32000 / si114x_uncompress(ret);
+
+	return sprintf(buf, "%d\n", rate);
+}
+
+static ssize_t si114x_write_frequency(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct si114x_data *data = iio_priv(indio_dev);
+	unsigned long val;
+	int ret;
+	u8 rate;
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	switch (val) {
+	case 250:
+	case 100:
+	case 50:
+	case 25:
+	case 10:
+	case 5:
+	case 2:
+	case 1:
+		rate = si114x_compress(32000 / val);
+		break;
+	case 0:
+		rate = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = i2c_smbus_write_byte_data(data->client, SI114X_REG_MEAS_RATE,
+		rate);
+
+	return ret ? ret : len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			      si114x_read_frequency,
+			      si114x_write_frequency);
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 2 5 10 25 50 100 250");
+
+static const struct attribute *si114x_attrs_general[] = {
+	&iio_dev_attr_in_proximity_range.dev_attr.attr,
+	&iio_const_attr_in_proximity_range_available.dev_attr.attr,
+	&iio_dev_attr_in_intensity_range.dev_attr.attr,
+	&iio_const_attr_in_intensity_range_available.dev_attr.attr,
+	&iio_dev_attr_in_intensity_ir_range.dev_attr.attr,
+	&iio_const_attr_in_intensity_ir_range_available.dev_attr.attr,
+};
+
+static const struct attribute *si114x_attrs_irq_only[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+};
+
+static int si114x_alloc_info(struct iio_dev *indio_dev)
+{
+	struct si114x_data *data = iio_priv(indio_dev);
+	struct attribute **attrs;
+	struct attribute_group *attr_group;
+	struct iio_info *info;
+	int num_attrs_general = ARRAY_SIZE(si114x_attrs_general);
+	int num_attrs_irq;
+	int ret;
+
+	num_attrs_irq = data->use_irq ?
+		ARRAY_SIZE(si114x_attrs_irq_only) : 0;
+
+	info = kzalloc(sizeof(struct iio_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	indio_dev->info = data->info = info;
+
+	info->read_raw = si114x_read_raw;
+	info->write_raw = si114x_write_raw;
+	info->update_scan_mode = si114x_update_scan_mode;
+	info->debugfs_reg_access = si114x_reg_access;
+	info->driver_module = THIS_MODULE;
+
+	attr_group = kzalloc(sizeof(struct attribute_group), GFP_KERNEL);
+	if (!attr_group) {
+		ret = -ENOMEM;
+		goto error_free_info;
+	}
+	info->attrs = attr_group;
+
+	attrs = kcalloc(num_attrs_general + num_attrs_irq + 1,
+		sizeof(struct attribute *), GFP_KERNEL);
+	if (!attrs) {
+		ret = -ENOMEM;
+		goto error_free_attr_group;
+	}
+	attr_group->attrs = attrs;
+
+	memcpy(&attrs[0], si114x_attrs_general,
+		num_attrs_general * sizeof(struct attribute *));
+	memcpy(&attrs[num_attrs_general], si114x_attrs_irq_only,
+		num_attrs_irq * sizeof(struct attribute *));
+
+	return 0;
+
+error_free_attr_group:
+	kfree(attr_group);
+error_free_info:
+	kfree(info);
+	return ret;
+}
+
+static void si114x_free_info(struct iio_info *info)
+{
+	kfree(info->attrs->attrs);
+	kfree(info->attrs);
+	kfree(info);
+}
+
+static int si114x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	return si114x_set_chlist(indio_dev, false);
+}
+
+static int si114x_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	ret = si114x_set_chlist(indio_dev, true);
+	if (ret < 0)
+		return ret;
+
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops si114x_buffer_setup_ops = {
+	.preenable = iio_sw_buffer_preenable,
+	.postenable = si114x_buffer_postenable,
+	.predisable = si114x_buffer_predisable
+};
+
+static int __devinit si114x_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	struct si114x_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = iio_device_alloc(sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->pdata = client->dev.platform_data;
+	if (data->pdata)
+		data->use_irq = data->pdata->use_irq;
+
+	ret = si114x_revisions(data);
+	if (ret < 0)
+		goto error_free_dev;
+
+	dev_info(&client->dev, "Si11%02x Ambient light/proximity sensor, Rev %02x, Seq: %02x\n",
+		data->part, data->rev, data->seq);
+
+	ret = si114x_alloc_channels(indio_dev);
+	if (ret < 0)
+		goto error_free_dev;
+
+	ret = si114x_alloc_info(indio_dev);
+	if (ret < 0)
+		goto error_free_channels;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = SI114X_DRV_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	init_waitqueue_head(&data->data_avail);
+
+	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+		si114x_trigger_handler, NULL);
+	if (ret < 0)
+		goto error_free_info;
+
+	if (data->use_irq) {
+		ret = request_threaded_irq(client->irq,
+			   NULL, si114x_irq,
+			   data->pdata->irq_flags | IRQF_ONESHOT,
+			   "si114x_irq", indio_dev);
+		if (ret < 0) {
+			dev_err(&client->dev, "irq request failed\n");
+			goto error_free_buffer;
+		}
+
+		ret = si114x_probe_trigger(indio_dev);
+		if (ret < 0)
+			goto error_free_irq;
+	} else
+		dev_info(&client->dev, "no platform data or irq, using polling\n");
+
+	ret = si114x_initialize(indio_dev);
+	if (ret < 0)
+		goto error_free_trigger;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto error_free_trigger;
+
+	return 0;
+
+error_free_trigger:
+	if (data->use_irq)
+		si114x_remove_trigger(indio_dev);
+error_free_irq:
+	if (data->use_irq)
+		free_irq(client->irq, indio_dev);
+error_free_buffer:
+	iio_triggered_buffer_cleanup(indio_dev);
+error_free_info:
+	si114x_free_info(data->info);
+error_free_channels:
+	kfree(indio_dev->channels);
+error_free_dev:
+	iio_device_free(indio_dev);
+	return ret;
+}
+
+static int __devexit si114x_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct si114x_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
+	kfree(data->buffer);
+	si114x_free_info(data->info);
+	kfree(indio_dev->channels);
+	if (data->use_irq) {
+		si114x_remove_trigger(indio_dev);
+		free_irq(client->irq, indio_dev);
+	}
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static struct i2c_driver si114x_driver = {
+	.driver = {
+		.name   = SI114X_DRV_NAME,
+		.owner  = THIS_MODULE,
+	},
+	.probe  = si114x_probe,
+	.remove = __devexit_p(si114x_remove),
+	.id_table = si114x_id,
+};
+
+module_i2c_driver(si114x_driver);
+
+MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
+MODULE_DESCRIPTION("Silabs si114x proximity/ambient light sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/iio/light/si114x.h b/include/linux/iio/light/si114x.h
new file mode 100644
index 0000000..5e04e7a
--- /dev/null
+++ b/include/linux/iio/light/si114x.h
@@ -0,0 +1,21 @@
+/*
+ * si114x.h - Support for Silabs si114x combined ambient light and
+ * proximity sensor
+ *
+ * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
+ *
+ * This file is subject to the terms and conditions of version 2 of
+ * the GNU General Public License.  See the file COPYING in the main
+ * directory of this archive for more details.
+ */
+
+#ifndef SI114X_H
+#define SI114X_H
+
+struct si114x_platform_data {
+	bool use_irq;
+	int irq_flags;
+};
+
+#endif /* SI114X_H */
+
-- 
1.7.9.5

