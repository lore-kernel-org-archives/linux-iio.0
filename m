Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-109.synserver.de ([212.40.185.109]:1113 "EHLO
	smtp-out-108.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751796Ab3AaPUi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 31 Jan 2013 10:20:38 -0500
Message-ID: <510A8BF6.2070701@metafoo.de>
Date: Thu, 31 Jan 2013 16:21:26 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk,
	Thorsten Nowak <thorsten.nowak@iis.fraunhofer.de>
Subject: Re: [PATCH V3] iio: gyro: Add itg3200
References: <201301311254.49626.manuel.stahl@iis.fraunhofer.de> <1359634652-25868-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1359634652-25868-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 01:17 PM, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Having at least a short commit message wouldn't hurt. E.g. something along
the lines of: "This patch adds support for the InvenSense itg3200. The
itg3200 is a three-axis gyro and ..."

I get one build warning:
	CC      drivers/iio/gyro/itg3200_core.o
	drivers/iio/gyro/itg3200_core.c:302: warning: initialization from
	incompatible pointer type


I've overlooked one issue with the frequency read/write functions the
previous review, sorry for that. And one issue with the newly introduced
avail_scan_masks.

[...]
> diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
> new file mode 100644
> index 0000000..d9efa56
> --- /dev/null
> +++ b/drivers/iio/gyro/itg3200_buffer.c
> @@ -0,0 +1,159 @@
[...]
> +
> +static irqreturn_t itg3200_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
> +
> +	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength)) {

You don't need this check either, if no channels are selected we'll never
get here in the first place.

> +		int ret = itg3200_read_all_channels(st->i2c, buf);
> +		if (ret < 0)
> +			goto error_ret;
> +	}
> +
> +	if (indio_dev->scan_timestamp)
> +		memcpy(buf + indio_dev->scan_bytes - sizeof(s64),
> +				&pf->timestamp, sizeof(pf->timestamp));
> +
> +	iio_push_to_buffers(indio_dev, (u8 *)buf);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +error_ret:
> +	return IRQ_HANDLED;
> +}
[...]
> +static int itg3200_read_reg_s16(struct iio_dev *indio_dev, u8 lower_reg_address,
> +		int *val)
> +{
[...]
> +}
> +
> +

Excess newline

> +static ssize_t itg3200_read_raw(struct iio_dev *indio_dev,

This triggers the build warning, the return type should be int.

> +		const struct iio_chan_spec *chan,
> +		int *val, int *val2, long info)
> +{
> +	ssize_t ret = 0;

What I meant with the comment in my previous mail was make ret int.

> +	u8 reg;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		reg = (u8)chan->address;
> +		ret = itg3200_read_reg_s16(indio_dev, reg, val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		if (chan->type == IIO_TEMP)
> +			*val2 = 1000000000/280;
> +		else
> +			*val2 = 1214142; /* (1 / 14,375) * (PI / 180) */
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Only the temperature channel has an offset */
> +		*val = 23000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t itg3200_read_frequency(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);

I've overlooked this during the last review. This wont work anymore.
Use struct iio_dev *indio_dev = dev_to_iio_dev(dev); instead

> +	int ret;
> +	u8 val;
> +	int sps;
> +
[...]
> +}
> +
> +static ssize_t itg3200_write_frequency(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf,
> +		size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);

Same here

[...]
> +}
> +
> +/*
> + *  Reset device and internal registers to the power-up-default settings

Excess space

> + * Use the gyro clock as reference, as suggested by the datasheet
> + */
> +static int itg3200_reset(struct iio_dev *indio_dev)
[...]
> +
> +static int itg3200_initial_setup(struct iio_dev *indio_dev)
> +{
> +	struct itg3200 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	u8 val;

I'd add a newline after u8 val; but not before it.

> +	ret = itg3200_read_reg_8(indio_dev, ITG3200_REG_ADDRESS, &val);
> +	if (ret)
> +		goto err_ret;
> +
> +	if (((val >> 1) & 0x3f) != 0x34) {
> +		dev_err(&st->i2c->dev, "invalid reg value 0x%02x", val);
> +		ret = -ENXIO;
> +		goto err_ret;
> +	}
> +
> +	ret = itg3200_reset(indio_dev);
> +	if (ret)
> +		goto err_ret;
> +
> +	ret = itg3200_enable_full_scale(indio_dev);
> +err_ret:
> +	return ret;
> +}
[...]
> +static int itg3200_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct itg3200 *st;
> +	struct iio_dev *indio_dev;
> +	const unsigned long avail_scan_masks[] = { 0xffffffff, 0x0 };

This needs to be static. Right now it is on the stack and well gone after
probe has been run.

> +
[...]

