Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-138.synserver.de ([212.40.185.138]:1036 "EHLO
	smtp-out-138.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbbHBJmU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 05:42:20 -0400
Message-ID: <55BDE5F8.9090201@metafoo.de>
Date: Sun, 02 Aug 2015 11:42:16 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, marex@denx.de,
	matt@ohporter.com, pantelis.antoniou@gmail.com, jic23@kernel.org
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: proximity: add support for PulsedLight LIDAR
References: <1438401484-22101-1-git-send-email-mranostay@gmail.com> <1438401484-22101-3-git-send-email-mranostay@gmail.com>
In-Reply-To: <1438401484-22101-3-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/2015 05:58 AM, Matt Ranostay wrote:
[...]
> +
> +struct lidar_data {
> +	struct mutex lock;
> +	struct iio_dev *indio_dev;
> +	struct i2c_client *client;
> +
> +	/* config */
> +	int calib_bias;
> +
> +	u16 buffer[5]; /* 2 byte distance + 8 byte timestamp */

Needs to be in its own cacheline to avoid issues if the I2C controller is
using DMA.

	u16 buffer[5] ____cacheline_aligned;

> +};
[...]
> +static inline int lidar_read_byte(struct lidar_data *data, int reg)

I'd drop the inline. The compiler is smart enough to figure out whether it
makes sense to inline it or not.

> +{
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte(client, reg);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot write addr value");
> +		return ret;
> +	}
> +
> +	ret = i2c_smbus_read_byte(client);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "cannot read data value");
> +		return ret;
> +	}

Instead of using a write_byte/read_byte combination rather use
i2c_smbus_read_byte_data(). I think that will do the same, but in one atomic
operation.

> +
> +	return ret;
> +}
[...]
> +static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
> +{
> +	int ret;
> +	int val;
> +
> +	ret = lidar_read_byte(data, LIDAR_REG_DATA_HBYTE);
> +	if (ret < 0)
> +		return ret;
> +	val = ret << 8;
> +
> +	ret = lidar_read_byte(data, LIDAR_REG_DATA_LBYTE);
> +	if (ret < 0)
> +		return ret;
> +	val |= ret;
> +
> +	/* correct any possible overflow or underflow */
> +	val += data->calib_bias / 10000;

Typically calib bias is only meant for a offset correction that is done in
hardware rather than in software. What's the usecase for doing it in
kernelspace rather than in userspace?

> +	if (val < 0)
> +		val = 0;
> +
> +	if (val > LIDAR_REG_DATA_MAX)
> +		val = LIDAR_REG_DATA_MAX;
> +
> +	*reg = val;
> +
> +	return 0;
> +}
[...]
> +static int lidar_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int *val, int *val2, long mask)
> +{
> +	struct lidar_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	if (iio_buffer_enabled(indio_dev) && mask == IIO_CHAN_INFO_RAW)
> +		return -EBUSY;
> +
> +	mutex_lock(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		u16 reg;
> +
> +		ret = lidar_get_measurement(data, &reg);
> +		if (!ret) {
> +			*val = reg / 100;
> +			*val2 = (reg % 100) * 10000;
> +			ret = IIO_VAL_INT_PLUS_MICRO;

The raw attribute is supposed to return the raw value as a IIO_VAL_INT. A
scale attribute should be used to indicate the conversion factor to get the
proper unit.

> +		}
> +		break;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		*val = 0;
> +		*val2 = data->calib_bias;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	}
> +
> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}
[...]
> +static struct iio_info lidar_info = {

const

> +	.driver_module = THIS_MODULE,
> +	.read_raw = lidar_read_raw,
> +	.write_raw = lidar_write_raw,
> +};
[...]
> +static struct i2c_driver lidar_driver = {
> +	.driver = {
> +		.name	= LIDAR_DRV_NAME,
> +		.owner	= THIS_MODULE,

You added a DT vendor prefix, but there is no of match table for the driver.

> +	},
> +	.probe		= lidar_probe,
> +	.remove		= lidar_remove,
> +	.id_table	= lidar_id,
> +};
> +module_i2c_driver(lidar_driver);
