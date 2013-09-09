Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:9921 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab3IIGKm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 02:10:42 -0400
Message-id: <522D665F.9040901@samsung.com>
Date: Mon, 09 Sep 2013 15:10:39 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org, jic23@cam.ac.uk,
	rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com,
	warren@wwwdotorg.org, ian.campbell@citrix.com,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Beomho Seo <beomho.seo@samsung.com>
Subject: [Patch 1/2] iio:cm36651: Add CM36651 proximity/light sensor driver
Content-type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add a new driver for Capella CM36651 proximity and RGB light
sensor.
The driver exposes two channels: light and proximity. It also support
detection proximity event.

This driver supports:
	- events - rising and falling proximity events.
	- reading channels through read_raw callback.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/light/Kconfig   |   11 +
 drivers/iio/light/cm36651.c |  607
+++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 618 insertions(+)
 create mode 100644 drivers/iio/light/cm36651.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index bf9fa0d..66fb76f 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -75,4 +75,15 @@ config VCNL4000
 	 To compile this driver as a module, choose M here: the
 	 module will be called vcnl4000.

+config CM36651
+	depends on I2C
+	tristate "CM36651 driver"
+	help
+	  Say Y here if you use cm36651.
+	  This option enables proximity & RGB sensor using
+	  Capella cm36651 device driver.
+
+	  To compile this driver as a module, choose M here:
+	  the module will be called cm36651.
+
 endmenu
diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
new file mode 100644
index 0000000..b3e1f0d
--- /dev/null
+++ b/drivers/iio/light/cm36651.c
@@ -0,0 +1,607 @@
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ * Author: Beomho Seo <beomho.seo@samsung.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General Public License version 2, as
published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+/* slave address 0x19 for PS of 7 bit addressing protocol for I2C */
+#define CM36651_I2C_ADDR_PS	0x19
+
+/* Ambient light sensor */
+#define CS_CONF1	0x00
+#define CS_CONF2	0x01
+#define CS_CONF3	0x06
+
+#define RED		0x00
+#define GREEN		0x01
+#define BLUE		0x02
+#define WHITE		0x03
+
+/* Proximity sensor */
+#define PS_CONF1	0x00
+#define PS_THD		0x01
+#define PS_CANC		0x02
+#define PS_CONF2	0x03
+
+#define ALS_REG_NUM	3
+#define PS_REG_NUM	4
+#define ALS_CHANNEL_NUM	4
+#define INITIAL_THD	0x09
+#define SCAN_MODE_LIGHT	0
+#define SCAN_MODE_PROX	1
+
+enum {
+	CM36651_LIGHT_EN,
+	CM36651_PROXIMITY_EN,
+	CM36651_PROXIMITY_EV_EN,
+};
+
+enum cm36651_cmd {
+	CM36651_CMD_READ_RAW_LIGHT,
+	CM36651_CMD_READ_RAW_PROXIMITY,
+	CM36651_CMD_PROX_EV_EN,
+	CM36651_CMD_PROX_EV_DIS,
+};
+
+enum {
+	CM36651_CLOSE_PROXIMITY,
+	CM36651_FAR_PROXIMITY,
+};
+
+/* register settings */
+static const u8 als_reg_setting[ALS_REG_NUM][2] = {
+	{ 0x00, 0x04 },	/* CS_CONF1 */
+	{ 0x01, 0x08 },	/* CS_CONF2 */
+	{ 0x06, 0x00 }	/* CS_CONF3 */
+};
+
+static const u8 ps_reg_setting[PS_REG_NUM][2] = {
+	{ 0x00, 0x3C },	/* PS_CONF1 */
+	{ 0x01, 0x09 },	/* PS_THD */
+	{ 0x02, 0x00 },	/* PS_CANC */
+	{ 0x03, 0x13 },	/* PS_CONF2 */
+};
+
+struct cm36651_data {
+	const struct cm36651_platform_data *pdata;
+	struct i2c_client *client;
+	struct i2c_client *ps_client;
+	struct mutex lock;
+	struct regulator *vled_reg;
+	unsigned long flags;
+	u8 thres;
+	u16 color[4];
+};
+
+int cm36651_i2c_read_byte(struct i2c_client *client, u8 *val)
+{
+	int ret = 0;
+	struct i2c_msg msg[1];
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	/* send slave address & command */
+	msg->addr = client->addr;
+	msg->flags = I2C_M_RD;
+	msg->len = 1;
+	msg->buf = val;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "i2c transfer error ret: %d\n", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+int cm36651_i2c_read_word(struct i2c_client *client, u8 command, u16 *val)
+{
+	int ret = 0;
+	struct i2c_msg msg[2];
+	unsigned char data[2] = { 0, };
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	/* send slave address & command */
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	msg[0].buf = &command;
+
+	/* read word data */
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = 2;
+	msg[1].buf = data;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	if (ret != 2) {
+		dev_err(&client->dev, "i2c transfer error ret: %d\n", ret);
+		ret = -EIO;
+	}
+	*val = le16_to_cpup((__le16 *)data);
+
+	return ret;
+}
+
+int cm36651_i2c_write_byte(struct i2c_client *client, u8 command, u8 val)
+{
+	int ret;
+	struct i2c_msg msg[1];
+	unsigned char data[2] = { command, val };
+
+	if (!client->adapter)
+		return -ENODEV;
+
+	/* send slave address & command */
+	msg->addr = client->addr;
+	msg->flags = 0;
+	msg->len = 2;
+	msg->buf = data;
+
+	ret = i2c_transfer(client->adapter, msg, 1);
+	if (ret != 1) {
+		dev_err(&client->dev, "i2c transfer error ret: %d\n", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int cm36651_setup_reg(struct cm36651_data *cm36651)
+{
+	struct i2c_client *client = cm36651->client;
+	int ret = 0, i = 0;
+	u8 tmp = 0;
+
+	/* ALS initialization */
+	for (i = 0; i < ALS_REG_NUM; i++) {
+		ret = cm36651_i2c_write_byte(client,
+			als_reg_setting[i][0], als_reg_setting[i][1]);
+		if (ret < 0)
+			goto err_setup_reg;
+	}
+
+	/* PS initialization */
+	for (i = 0; i < PS_REG_NUM; i++) {
+		ret = cm36651_i2c_write_byte(cm36651->ps_client,
+			ps_reg_setting[i][0], ps_reg_setting[i][1]);
+		if (ret < 0)
+			goto err_setup_reg;
+	}
+
+	ret = cm36651_i2c_read_byte(cm36651->ps_client, &tmp);
+	if (ret < 0)
+		goto err_setup_reg;
+
+	/* printing the initial proximity value with no contact */
+	dev_dbg(&client->dev, "initial proximity value: %d\n", tmp);
+
+	/* device turn off */
+	ret = cm36651_i2c_write_byte(client, CS_CONF1, 0x01);
+	if (ret < 0)
+		goto err_setup_reg;
+
+	ret = cm36651_i2c_write_byte(cm36651->ps_client, PS_CONF1, 0x01);
+	if (ret < 0)
+		goto err_setup_reg;
+
+	return 0;
+
+err_setup_reg:
+	dev_err(&client->dev, "cm36651_setup_reg() failed: %d\n", ret);
+	return ret;
+}
+
+static int cm36651_read_output(struct cm36651_data *cm36651,
+						int scan_index, int *val)
+{
+	struct i2c_client *client = cm36651->client;
+	int i;
+	int ret = -EINVAL;
+	u8 prox_val;
+
+	switch (scan_index) {
+	case SCAN_MODE_LIGHT:
+		for (i = 0; i < ALS_CHANNEL_NUM; i++) {
+			ret = cm36651_i2c_read_word(client, i,
+						&cm36651->color[i]);
+			if (ret < 0)
+				goto read_err;
+		}
+
+		dev_dbg(&client->dev, "red: %d, green: %d, blue: %d, white: %d\n",
+				cm36651->color[0] + 1, cm36651->color[1] + 1,
+				cm36651->color[2] + 1, cm36651->color[3] + 1);
+
+		ret = cm36651_i2c_write_byte(client, CS_CONF1, 0x01);
+		if (ret < 0)
+			goto write_err;
+
+		break;
+	case SCAN_MODE_PROX:
+		ret = cm36651_i2c_read_byte(cm36651->ps_client, &prox_val);
+		if (ret < 0)
+			goto read_err;
+
+		dev_dbg(&client->dev, "proximity value: %d\n", prox_val);
+
+		ret = cm36651_i2c_write_byte(cm36651->ps_client,
+							PS_CONF1, 0x01);
+		if (ret < 0)
+			goto write_err;
+
+		break;
+	}
+
+	return ret;
+
+read_err:
+	dev_err(&client->dev, "register read failed\n");
+	return ret;
+
+write_err:
+	dev_err(&client->dev, "register write failed\n");
+	return ret;
+}
+
+static irqreturn_t cm36651_irq_handler(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	struct i2c_client *client = cm36651->client;
+	int ev_dir, val, ret;
+	u64 ev_code;
+	u8 tmp;
+
+	ret = cm36651_i2c_read_byte(cm36651->ps_client, &tmp);
+	if (ret < 0) {
+		dev_err(&client->dev,
+				"%s: data read failed: %d\n", __func__, ret);
+		return IRQ_NONE;
+	}
+
+	if (tmp < ps_reg_setting[1][1]) {
+		ev_dir = IIO_EV_DIR_RISING;
+		val = CM36651_FAR_PROXIMITY;
+	} else {
+		ev_dir = IIO_EV_DIR_FALLING;
+		val = CM36651_CLOSE_PROXIMITY;
+	}
+
+	ev_code = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
+				CM36651_CMD_READ_RAW_PROXIMITY,
+				IIO_EV_TYPE_THRESH, ev_dir);
+
+	iio_push_event(indio_dev, ev_code, iio_get_time_ns());
+
+	return IRQ_HANDLED;
+}
+
+static int cm36651_set_operation_mode(struct cm36651_data *cm36651,
+						enum cm36651_cmd cmd)
+{
+	struct i2c_client *client = cm36651->client;
+	int ret = 0;
+	int i;
+
+	switch (cmd) {
+	case CM36651_CMD_READ_RAW_LIGHT:
+		ret = cm36651_i2c_write_byte(client, CS_CONF1, 0x04);
+		break;
+	case CM36651_CMD_READ_RAW_PROXIMITY:
+		ret = cm36651_i2c_write_byte(cm36651->ps_client,
+							PS_CONF1, 0x3C);
+		break;
+	case CM36651_CMD_PROX_EV_EN:
+		if (test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags)) {
+			dev_err(&client->dev,
+				"Already proximity event enable state\n");
+			return ret;
+		}
+		set_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
+		for (i = 0; i < 4; i++) {
+			ret = cm36651_i2c_write_byte(cm36651->ps_client,
+				ps_reg_setting[i][0], ps_reg_setting[i][1]);
+			if (ret < 0)
+				goto write_err;
+		}
+		enable_irq(client->irq);
+		break;
+	case CM36651_CMD_PROX_EV_DIS:
+		if (!test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags)) {
+			dev_err(&client->dev,
+				"Already proximity event disable state\n");
+			return ret;
+		}
+		clear_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
+		disable_irq(client->irq);
+		ret = cm36651_i2c_write_byte(cm36651->ps_client,
+							PS_CONF1, 0x01);
+		break;
+	}
+
+	if (ret < 0)
+		dev_err(&client->dev, "write register failed\n");
+
+	return ret;
+
+write_err:
+	dev_err(&client->dev, "proximity event toe enable is failed\n");
+	return ret;
+}
+
+static int cm36651_read_channel(struct cm36651_data *cm36651,
+				struct iio_chan_spec const *chan, int *val)
+{
+	struct i2c_client *client = cm36651->client;
+	enum cm36651_cmd cmd = 0;
+	int ret;
+
+	if (chan->scan_index == SCAN_MODE_LIGHT)
+		cmd = CM36651_CMD_READ_RAW_LIGHT;
+	else /* SCAN_MODE_PROX */
+		cmd = CM36651_CMD_READ_RAW_PROXIMITY;
+
+	ret = cm36651_set_operation_mode(cm36651, cmd);
+	if (ret < 0) {
+		dev_err(&client->dev, "cm36651 set operation mode failed\n");
+		return ret;
+	}
+	/* raw data integration time */
+	msleep(50);
+	ret = cm36651_read_output(cm36651, chan->scan_index, val);
+	if (ret < 0) {
+		dev_err(&client->dev, "cm36651 read output failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cm36651_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	mutex_lock(&cm36651->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = cm36651_read_channel(cm36651, chan, val);
+		break;
+	}
+	mutex_unlock(&cm36651->lock);
+
+	return ret;
+}
+
+static int cm36651_read_thresh(struct iio_dev *indio_dev,
+					u64 event_code, int *val)
+{
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
+	int event_type = IIO_EVENT_CODE_EXTRACT_TYPE(event_code);
+
+	if (event_type != IIO_EV_TYPE_THRESH ||	chan_type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	if (!cm36651->thres)
+		*val = ps_reg_setting[1][1]; /* initial threshold value */
+	else
+		*val = cm36651->thres;
+
+	return 0;
+}
+
+static int cm36651_write_thresh(struct iio_dev *indio_dev,
+					u64 event_code, int val)
+{
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	struct i2c_client *client = cm36651->client;
+	int ret;
+
+	cm36651->thres = val;
+	ret = cm36651_i2c_write_byte(cm36651->ps_client,
+					PS_THD, cm36651->thres);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "PS register read faied: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(&client->dev, "new threshold is 0x%x\n", cm36651->thres);
+
+	return 0;
+}
+
+static int cm36651_write_event_config(struct iio_dev *indio_dev,
+					u64 event_code, int state)
+{
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	enum cm36651_cmd cmd;
+	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
+	int ret = -EINVAL;
+
+	mutex_lock(&cm36651->lock);
+
+	if (chan_type == IIO_PROXIMITY) {
+		cmd = state ? CM36651_CMD_PROX_EV_EN : CM36651_CMD_PROX_EV_DIS;
+		ret = cm36651_set_operation_mode(cm36651, cmd);
+	}
+
+	mutex_unlock(&cm36651->lock);
+
+	return ret;
+}
+
+static int cm36651_read_event_config(struct iio_dev *indio_dev, u64
event_code)
+{
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
+	int event_en = -EINVAL;
+
+	mutex_lock(&cm36651->lock);
+
+	if (chan_type == IIO_PROXIMITY)
+		event_en = test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
+
+	mutex_unlock(&cm36651->lock);
+
+	return event_en;
+}
+
+static const struct iio_chan_spec cm36651_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.shift = 0,
+			.storagebits = 16,
+		},
+		.scan_index = SCAN_MODE_LIGHT
+	},
+	{
+		.type = IIO_PROXIMITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 8,
+			.shift = 0,
+			.storagebits = 8,
+		},
+		.scan_index = SCAN_MODE_PROX,
+		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER)
+	},
+};
+
+static const struct iio_info cm36651_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= &cm36651_read_raw,
+	.read_event_value	= &cm36651_read_thresh,
+	.write_event_value	= &cm36651_write_thresh,
+	.read_event_config	= &cm36651_read_event_config,
+	.write_event_config	= &cm36651_write_event_config,
+};
+
+static int cm36651_probe(struct i2c_client *client,
+			     const struct i2c_device_id *id)
+{
+	struct cm36651_data *cm36651;
+	struct iio_dev *indio_dev;
+	unsigned long irqflag;
+	int ret;
+
+	dev_dbg(&client->dev, "cm36651 light/proxymity sensor probe\n");
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm36651));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	cm36651 = iio_priv(indio_dev);
+
+	cm36651->vled_reg = devm_regulator_get(&client->dev, "vled");
+	if (IS_ERR(cm36651->vled_reg)) {
+		dev_err(&client->dev, "get regulator vled failed\n");
+		return PTR_ERR(cm36651->vled_reg);
+	}
+
+	ret = regulator_enable(cm36651->vled_reg);
+	if (ret) {
+		dev_err(&client->dev, "enable regulator failed\n");
+		return ret;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+
+	cm36651->client = client;
+	cm36651->ps_client = i2c_new_dummy(client->adapter,
+						CM36651_I2C_ADDR_PS);
+	mutex_init(&cm36651->lock);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->channels = cm36651_channels;
+	indio_dev->num_channels = ARRAY_SIZE(cm36651_channels);
+	indio_dev->info = &cm36651_info;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = cm36651_setup_reg(cm36651);
+
+	irqflag = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+	ret = request_threaded_irq(client->irq, NULL, cm36651_irq_handler,
+				irqflag, "cm36651_proximity", indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "%s: request irq failed\n", __func__);
+		return ret;
+	}
+	disable_irq(client->irq);
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		regulator_disable(cm36651->vled_reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int cm36651_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct cm36651_data *cm36651 = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	regulator_disable(cm36651->vled_reg);
+	free_irq(client->irq, indio_dev);
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static const struct i2c_device_id cm36651_id[] = {
+	{ "cm36651", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, cm36651_id);
+
+static const struct of_device_id cm36651_of_match[] = {
+	{ .compatible = "capella,cm36651" },
+	{ }
+};
+
+static struct i2c_driver cm36651_driver = {
+	.driver = {
+		.name	= "cm36651",
+		.of_match_table = of_match_ptr(cm36651_of_match),
+		.owner	= THIS_MODULE,
+	},
+	.probe		= cm36651_probe,
+	.remove		= cm36651_remove,
+	.id_table	= cm36651_id,
+};
+
+module_i2c_driver(cm36651_driver);
+
+MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
+MODULE_DESCRIPTION("CM36651 proximity/ambient light sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
1.7.9.5

-- 
Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
-- 
Beomho Seo, Assistant Engineer
System S/W Lab., S/W Platform Team, Software Center
Samsung Electronics
