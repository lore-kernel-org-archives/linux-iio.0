Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55199 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753007Ab3IQRbG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 Sep 2013 13:31:06 -0400
Date: Tue, 17 Sep 2013 19:30:54 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Beomho Seo <beomho.seo@samsung.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Jacek Anaszewski <j.anaszewski@samsung.com>,
	myungjoo.ham@samsung.com, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/2] iio: cm36651: Add CM36651 proximity/light sensor
 driver
In-Reply-To: <5237E16B.7080903@samsung.com>
Message-ID: <alpine.DEB.2.01.1309171823200.9630@pmeerw.net>
References: <5237E16B.7080903@samsung.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This patch add a new driver for Capella CM36651 proximity and RGB sensor.

moving in the right direction!
couple of comments inline

> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 0a25ae6..c965aeb 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -27,6 +27,17 @@ config APDS9300
>  	 To compile this driver as a module, choose M here: the
>  	 module will be called apds9300.
>  
> +config CM36651
> +	depends on I2C
> +	tristate "CM36651 driver"
> +	help
> +	  Say Y here if you use cm36651.
> +	  This option enables proximity & RGB sensor using
> +	  Capella cm36651 device driver.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called cm36651.
> +
>  config GP2AP020A00F
>  	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
> new file mode 100644
> index 0000000..e1958ac
> --- /dev/null
> +++ b/drivers/iio/light/cm36651.c
> @@ -0,0 +1,591 @@
> +/*
> + * Copyright (C) 2013 Samsung Electronics Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General Public License version 2, as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +
> +/* Slave address 0x19 for PS of 7 bit addressing protocol for I2C */
> +#define CM36651_I2C_ADDR_PS		0x19
> +
> +/* Ambient light sensor */
> +#define CM36651_CS_CONF1		0x00

what does CS stand for?
maybe ALS?

> +#define CM36651_CS_CONF2		0x01
> +#define CM36651_ALS_WH_M		0x02
> +#define CM36651_ALS_WH_L		0x03
> +#define CM36651_ALS_WL_M		0x04
> +#define CM36651_ALS_WL_L		0x05
> +#define CM36651_CS_CONF3		0x06
> +#define CM36651_CS_REG_NUM		0x07
> +
> +/* Proximity sensor */
> +#define CM36651_PS_CONF1		0x00
> +#define CM36651_PS_THD			0x01
> +#define CM36651_PS_CANC		0x02
> +#define CM36651_PS_CONF2		0x03
> +#define CM36651_PS_REG_NUM		0x04
> +
> +/* CS_CONF1 command code */
> +#define CM36651_ALS_ENABLE		0x00
> +#define CM36651_ALS_DISABLE		0x01
> +#define CM36651_ALS_INT_EN		0x02
> +#define CM36651_ALS_THRES		0x04
> +
> +/* CS_CONF2 command code */
> +#define CM36651_CS_CONF2_DEFAULT_BIT	0x08
> +
> +/* CS_CONF3 channel integration time */

which unit?
this could be made configurable via INT_TIME channel

> +#define CM36651_IT_80			0x00
> +#define CM36651_W_IT_160		0x01
> +#define CM36651_W_IT_320		0x02
> +#define CM36651_W_IT_640		0x03
> +#define CM36651_B_IT_160		0x04
> +#define CM36651_B_IT_320		0x08
> +#define CM36651_B_IT_640		0x0C
> +#define CM36651_G_IT_160		0x10
> +#define CM36651_G_IT_320		0x20
> +#define CM36651_G_IT_640		0x30
> +#define CM36651_R_IT_160		0x40
> +#define CM36651_R_IT_320		0x80
> +#define CM36651_R_IT_640		0xC0
> +
> +/* PS_CONF1 command code */
> +#define CM36651_PS_ENABLE		0x00
> +#define CM36651_PS_DISABLE		0x01
> +#define CM36651_PS_INT_EN		0x02
> +#define CM36651_PS_PERS_2		0x04
> +#define CM36651_PS_PERS_3		0x08
> +#define CM36651_PS_PERS_4		0x0C
> +#define CM36651_PS_IT_2		0x10
> +#define CM36651_PS_IT_3		0x20
> +#define CM36651_PS_IT_4		0x30
> +
> +/* PS_THD command code */
> +#define CM36651_PS_INITIAL_THD		0x09
> +
> +/* PS_CANC command code */
> +#define CM36651_PS_CANC_DEFAULT	0x00
> +
> +/* PS_CONF2 command code */
> +#define CM36651_PS_HYS_1		0x00
> +#define CM36651_PS_HYS_2		0x01
> +#define CM36651_PS_SMART_PERS_EN	0x02
> +#define CM36651_PS_MS			0x10
> +
> +#define CM36651_SCAN_MODE_LIGHT	0
> +#define CM36651_SCAN_MODE_PROX		1
> +
> +enum cm36651_operation_mode {
> +	CM36651_LIGHT_EN,
> +	CM36651_PROXIMITY_EN,
> +	CM36651_PROXIMITY_EV_EN,
> +};
> +
> +enum cm36651_light_channel_idx {
> +	CM36651_LIGHT_CHANNEL_IDX_RED,
> +	CM36651_LIGHT_CHANNEL_IDX_GREEN,
> +	CM36651_LIGHT_CHANNEL_IDX_BLUE,
> +	CM36651_LIGHT_CHANNEL_IDX_CLEAR,
> +};
> +
> +enum cm36651_command {
> +	CM36651_CMD_READ_RAW_LIGHT,
> +	CM36651_CMD_READ_RAW_PROXIMITY,
> +	CM36651_CMD_PROX_EV_EN,
> +	CM36651_CMD_PROX_EV_DIS,
> +};
> +
> +enum cm36651_proximity_event {
> +	CM36651_CLOSE_PROXIMITY,
> +	CM36651_FAR_PROXIMITY,
> +};
> +
> +static u8 cm36651_als_reg[2] = {

const 

> +	CM36651_CS_CONF1,
> +	CM36651_CS_CONF2,
> +};
> +
> +static u8 cm36651_ps_reg[4] = {

const

> +	CM36651_PS_CONF1,
> +	CM36651_PS_THD,
> +	CM36651_PS_CANC,
> +	CM36651_PS_CONF2,
> +};
> +
> +struct cm36651_data {
> +	const struct cm36651_platform_data *pdata;
> +	struct i2c_client *client;
> +	struct i2c_client *ps_client;
> +	struct mutex lock;
> +	struct regulator *vled_reg;
> +	unsigned long flags;
> +	u8 cs_ctrl_regs[2];
> +	u8 ps_ctrl_regs[4];
> +	u16 color[4];
> +};
> +
> +static int cm36651_setup_reg(struct cm36651_data *cm36651)
> +{
> +	struct i2c_client *client = cm36651->client;
> +	struct i2c_client *ps_client = cm36651->ps_client;
> +	int i, ret;
> +
> +	/* ALS initialization */
> +	cm36651->cs_ctrl_regs[CM36651_CS_CONF1] = CM36651_ALS_ENABLE
> +							| CM36651_ALS_THRES;
> +	cm36651->cs_ctrl_regs[CM36651_CS_CONF2] = CM36651_CS_CONF2_DEFAULT_BIT;
> +
> +	for (i = 0; i < 2; i++) {

use the CS_REG_NUM #defined

> +		ret = i2c_smbus_write_byte_data(client, cm36651_als_reg[i],
> +						cm36651->cs_ctrl_regs[i]);
> +		if (ret < 0)
> +			goto err_setup_reg;
> +	}
> +
> +	/* PS initialization */
> +	cm36651->ps_ctrl_regs[CM36651_PS_CONF1] = CM36651_PS_ENABLE
> +				   | CM36651_PS_PERS_4 | CM36651_PS_IT_4;
> +	cm36651->ps_ctrl_regs[CM36651_PS_THD] = CM36651_PS_INITIAL_THD;
> +	cm36651->ps_ctrl_regs[CM36651_PS_CANC] = CM36651_PS_CANC_DEFAULT;
> +	cm36651->ps_ctrl_regs[CM36651_PS_CONF2] = CM36651_PS_HYS_2
> +			      | CM36651_PS_SMART_PERS_EN | CM36651_PS_MS;
> +
> +	for (i = 0; i < 4; i++) {

use the PS_REG_NUM #defined

> +		ret = i2c_smbus_write_byte_data(ps_client, cm36651_ps_reg[i],
> +						cm36651->ps_ctrl_regs[i]);
> +		if (ret < 0)
> +			goto err_setup_reg;
> +	}
> +
> +	ret = i2c_smbus_read_byte(cm36651->ps_client);
> +	if (ret < 0)
> +		goto err_setup_reg;
> +
> +	/* Printing the initial proximity value with no contact */
> +	dev_dbg(&client->dev, "Initial proximity value: %d\n", ret);

maybe drop the initial read? not needed when not in debug mode

> +
> +	/* Device turn off */
> +	ret = i2c_smbus_write_byte_data(client, CM36651_CS_CONF1,
> +						CM36651_ALS_DISABLE);
> +	if (ret < 0)
> +		goto err_setup_reg;
> +
> +	ret = i2c_smbus_write_byte_data(cm36651->ps_client,
> +				CM36651_PS_CONF1, CM36651_PS_DISABLE);
> +	if (ret < 0)
> +		goto err_setup_reg;
> +
> +	return 0;
> +
> +err_setup_reg:
> +	dev_err(&client->dev, "Register setup failed: %d\n", ret);
> +	return ret;
> +}
> +
> +static int cm36651_read_output(struct cm36651_data *cm36651,
> +				struct iio_chan_spec const *chan, int *val)
> +{
> +	struct i2c_client *client = cm36651->client;
> +	int ret = -EINVAL;
> +
> +	switch (chan->scan_index) {
> +	case CM36651_SCAN_MODE_LIGHT:
> +		*val = i2c_smbus_read_word_data(client, chan->channel);

the CM36651 seems to be special here how data is returned; there seems to 
be no dedicated register to pass the measurement?

> +		if (val < 0)
> +			goto read_err;
> +
> +		ret = i2c_smbus_write_byte_data(client, CM36651_CS_CONF1,
> +							CM36651_ALS_DISABLE);
> +		if (ret < 0)
> +			goto write_err;
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	case CM36651_SCAN_MODE_PROX:
> +		*val = i2c_smbus_read_byte(cm36651->ps_client);
> +		if (val < 0)
> +			goto read_err;
> +
> +		ret = i2c_smbus_write_byte_data(cm36651->ps_client,
> +					CM36651_PS_CONF1, CM36651_PS_DISABLE);
> +		if (ret < 0)
> +			goto write_err;
> +
> +		ret = IIO_VAL_INT;
> +		break;
> +	}
> +
> +	return ret;
> +
> +read_err:
> +	dev_err(&client->dev, "Register read failed\n");
> +	return ret;
> +
> +write_err:
> +	dev_err(&client->dev, "Register write failed\n");
> +	return ret;
> +}
> +
> +static irqreturn_t cm36651_irq_handler(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	struct i2c_client *client = cm36651->client;
> +	int ev_dir, val, ret;
> +	u64 ev_code;
> +
> +	ret = i2c_smbus_read_byte(cm36651->ps_client);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +				"%s: Data read failed: %d\n", __func__, ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (ret < CM36651_PS_INITIAL_THD) {
> +		ev_dir = IIO_EV_DIR_RISING;
> +		val = CM36651_FAR_PROXIMITY;
> +	} else {
> +		ev_dir = IIO_EV_DIR_FALLING;
> +		val = CM36651_CLOSE_PROXIMITY;
> +	}
> +
> +	ev_code = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
> +				CM36651_CMD_READ_RAW_PROXIMITY,
> +				IIO_EV_TYPE_THRESH, ev_dir);
> +
> +	iio_push_event(indio_dev, ev_code, iio_get_time_ns());
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int cm36651_set_operation_mode(struct cm36651_data *cm36651,
> +						enum cm36651_command cmd)
> +{
> +	struct i2c_client *client = cm36651->client;
> +	int ret = 0;

unknown cmd are silently not handled; 
probably better to set ret = -EINVAL

> +	int i;
> +
> +	switch (cmd) {
> +	case CM36651_CMD_READ_RAW_LIGHT:
> +		ret = i2c_smbus_write_byte_data(client, CM36651_CS_CONF1,
> +				cm36651->cs_ctrl_regs[CM36651_CS_CONF1]);
> +		break;
> +	case CM36651_CMD_READ_RAW_PROXIMITY:
> +		ret = i2c_smbus_write_byte_data(cm36651->ps_client,
> +		   CM36651_PS_CONF1, cm36651->ps_ctrl_regs[CM36651_PS_CONF1]);
> +		break;
> +	case CM36651_CMD_PROX_EV_EN:
> +		if (test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags)) {
> +			dev_err(&client->dev,
> +				"Already proximity event enable state\n");
> +			return ret;
> +		}
> +		set_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
> +
> +		for (i = 0; i < 4; i++) {

REG_NUM

> +			ret = i2c_smbus_write_byte_data(cm36651->ps_client,
> +				cm36651_ps_reg[i], cm36651->ps_ctrl_regs[i]);
> +			if (ret < 0)
> +				goto write_err;
> +		}
> +
> +		enable_irq(client->irq);
> +		break;
> +	case CM36651_CMD_PROX_EV_DIS:
> +		if (!test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags)) {
> +			dev_err(&client->dev,
> +				"Already proximity event disable state\n");
> +			return ret;
> +		}
> +		clear_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
> +		disable_irq(client->irq);
> +		ret = i2c_smbus_write_byte_data(cm36651->ps_client,
> +					CM36651_PS_CONF1, CM36651_PS_DISABLE);
> +		break;
> +	}
> +
> +	if (ret < 0)
> +		dev_err(&client->dev, "Write register failed\n");
> +
> +	return ret;
> +
> +write_err:
> +	dev_err(&client->dev, "Proximity enable event is failed\n");

remove 'is'

> +	return ret;
> +}
> +
> +static int cm36651_read_channel(struct cm36651_data *cm36651,
> +				struct iio_chan_spec const *chan, int *val)
> +{
> +	struct i2c_client *client = cm36651->client;
> +	enum cm36651_command cmd = 0;
> +	int ret;
> +
> +	if (chan->scan_index == CM36651_SCAN_MODE_LIGHT)
> +		cmd = CM36651_CMD_READ_RAW_LIGHT;
> +	else /* CM36651_SCAN_MODE_PROX */
> +		cmd = CM36651_CMD_READ_RAW_PROXIMITY;

chan->type could be used to distinguish between LIGHT and PROXIMITY, so no
need for scan_index

> +
> +	ret = cm36651_set_operation_mode(cm36651, cmd);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "CM36651 set operation mode failed\n");
> +		return ret;
> +	}
> +	/* Raw data integration time */
> +	msleep(50);

shouldn't this depend on the integration time configured?
same for ALS and PS?

> +	ret = cm36651_read_output(cm36651, chan, val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "CM36651 read output failed\n");
> +		return ret;
> +	}
> +
> +	return ret;
> +}
> +
> +static int cm36651_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&cm36651->lock);
> +
> +	if (mask == IIO_CHAN_INFO_RAW)
> +		ret = cm36651_read_channel(cm36651, chan, val);
> +
> +	mutex_unlock(&cm36651->lock);
> +
> +	return ret;
> +}
> +
> +static int cm36651_read_thresh(struct iio_dev *indio_dev,
> +					u64 event_code, int *val)
> +{
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
> +	int event_type = IIO_EVENT_CODE_EXTRACT_TYPE(event_code);
> +
> +	if (event_type != IIO_EV_TYPE_THRESH ||	chan_type != IIO_PROXIMITY)
> +		return -EINVAL;
> +
> +	*val = cm36651->ps_ctrl_regs[CM36651_PS_THD];
> +
> +	return 0;
> +}
> +
> +static int cm36651_write_thresh(struct iio_dev *indio_dev,
> +					u64 event_code, int val)
> +{
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	struct i2c_client *client = cm36651->client;
> +	int ret;
> +
> +	if (val < 3 || val > 255)
> +		return -EINVAL;
> +
> +	cm36651->ps_ctrl_regs[CM36651_PS_THD] = val;
> +	ret = i2c_smbus_write_byte_data(cm36651->ps_client, CM36651_PS_THD,
> +					cm36651->ps_ctrl_regs[CM36651_PS_THD]);
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev, "PS register read faied: %d\n", ret);

that's a write; 'failed', maybe more specific: "PS threshold write failed"

> +		return ret;
> +	}
> +	dev_dbg(&client->dev, "New threshold is 0x%x\n",
> +					cm36651->ps_ctrl_regs[CM36651_PS_THD]);
> +
> +	return 0;
> +}
> +
> +static int cm36651_write_event_config(struct iio_dev *indio_dev,
> +					u64 event_code, int state)
> +{
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	enum cm36651_command cmd;

could avoid that local variable or move it down

> +	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
> +	int ret = -EINVAL;
> +
> +	mutex_lock(&cm36651->lock);
> +
> +	if (chan_type == IIO_PROXIMITY) {
> +		cmd = state ? CM36651_CMD_PROX_EV_EN : CM36651_CMD_PROX_EV_DIS;
> +		ret = cm36651_set_operation_mode(cm36651, cmd);
> +	}
> +
> +	mutex_unlock(&cm36651->lock);
> +
> +	return ret;
> +}
> +
> +static int cm36651_read_event_config(struct iio_dev *indio_dev, u64 event_code)
> +{
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +	int chan_type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code);
> +	int event_en = -EINVAL;
> +
> +	mutex_lock(&cm36651->lock);
> +
> +	if (chan_type == IIO_PROXIMITY)
> +		event_en = test_bit(CM36651_PROXIMITY_EV_EN, &cm36651->flags);
> +
> +	mutex_unlock(&cm36651->lock);
> +
> +	return event_en;
> +}
> +
> +#define CM36651_LIGHT_CHANNEL(_color, _idx) {		\
> +	.type = IIO_LIGHT,				\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
> +	.scan_type = IIO_ST('u', 16, 16, 0),		\
> +	.scan_index = CM36651_SCAN_MODE_LIGHT,		\

no need scan_type and scan_index; driver does not support buffering

> +	.channel = _idx,

I'd rather use .address than .channel; there is just one light channel
				\
> +	.modified = 1,					\
> +	.channel2 = IIO_MOD_LIGHT_##_color,		\
> +}
> +
> +static const struct iio_chan_spec cm36651_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.scan_type = IIO_ST('u', 8, 8, 0),
> +		.scan_index = CM36651_SCAN_MODE_PROX,
> +		.event_mask = IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER)
> +	},
> +	CM36651_LIGHT_CHANNEL(RED, CM36651_LIGHT_CHANNEL_IDX_RED),
> +	CM36651_LIGHT_CHANNEL(GREEN, CM36651_LIGHT_CHANNEL_IDX_GREEN),
> +	CM36651_LIGHT_CHANNEL(BLUE, CM36651_LIGHT_CHANNEL_IDX_BLUE),
> +	CM36651_LIGHT_CHANNEL(CLEAR, CM36651_LIGHT_CHANNEL_IDX_CLEAR),
> +};
> +
> +static const struct iio_info cm36651_info = {
> +	.driver_module		= THIS_MODULE,
> +	.read_raw		= &cm36651_read_raw,
> +	.read_event_value	= &cm36651_read_thresh,
> +	.write_event_value	= &cm36651_write_thresh,
> +	.read_event_config	= &cm36651_read_event_config,
> +	.write_event_config	= &cm36651_write_event_config,
> +};
> +
> +static int cm36651_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	struct cm36651_data *cm36651;
> +	struct iio_dev *indio_dev;
> +	unsigned long irqflag;

could avoid variable irqflag

> +	int ret;
> +
> +	dev_dbg(&client->dev, "cm36651 light/proxymity sensor probe\n");

proximity

> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*cm36651));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	cm36651 = iio_priv(indio_dev);
> +
> +	cm36651->vled_reg = devm_regulator_get(&client->dev, "vled");
> +	if (IS_ERR(cm36651->vled_reg)) {
> +		dev_err(&client->dev, "get regulator vled failed\n");
> +		return PTR_ERR(cm36651->vled_reg);
> +	}
> +
> +	ret = regulator_enable(cm36651->vled_reg);
> +	if (ret) {
> +		dev_err(&client->dev, "enable regulator failed\n");

regulator vled

> +		return ret;
> +	}
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	cm36651->client = client;
> +	cm36651->ps_client = i2c_new_dummy(client->adapter,
> +						CM36651_I2C_ADDR_PS);
> +	mutex_init(&cm36651->lock);
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->channels = cm36651_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(cm36651_channels);
> +	indio_dev->info = &cm36651_info;
> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* Check if the device is there or not */
> +	ret = i2c_smbus_write_byte_data(cm36651->ps_client, CM36651_PS_CONF1,
> +							   CM36651_PS_DISABLE);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "PS register read faied: %d\n", ret);

"failed"
isn't there a better way to check? setup_reg() would fail also if the 
device is not there?!

regulator doesn't get disabled

> +		return ret;
> +	}
> +
> +	ret = cm36651_setup_reg(cm36651);

ret not checked

> +
> +	irqflag = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
> +	ret = request_threaded_irq(client->irq, NULL, cm36651_irq_handler,
> +				irqflag, "cm36651_proximity", indio_dev);
> +	if (ret) {
> +		dev_err(&client->dev, "%s: request irq failed\n", __func__);

regulator not disabled

> +		return ret;
> +	}
> +	disable_irq(client->irq);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		regulator_disable(cm36651->vled_reg);
> +		free_irq(client->irq, indio_dev);
> +		return ret;

move 'return ret' down, save 'return 0'

> +	}
> +
> +	return 0;
> +}
> +
> +static int cm36651_remove(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct cm36651_data *cm36651 = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);
> +	regulator_disable(cm36651->vled_reg);
> +	free_irq(client->irq, indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cm36651_id[] = {
> +	{ "cm36651", 0 },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cm36651_id);
> +
> +static const struct of_device_id cm36651_of_match[] = {
> +	{ .compatible = "capella,cm36651" },
> +	{ }
> +};
> +
> +static struct i2c_driver cm36651_driver = {
> +	.driver = {
> +		.name	= "cm36651",
> +		.of_match_table = of_match_ptr(cm36651_of_match),
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= cm36651_probe,
> +	.remove		= cm36651_remove,
> +	.id_table	= cm36651_id,
> +};
> +
> +module_i2c_driver(cm36651_driver);
> +
> +MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
> +MODULE_DESCRIPTION("CM36651 proximity/ambient light sensor driver");
> +MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
