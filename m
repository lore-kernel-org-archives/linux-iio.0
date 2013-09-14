Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40204 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab3INKlu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 06:41:50 -0400
Message-ID: <52344B8B.1010704@kernel.org>
Date: Sat, 14 Sep 2013 12:42:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jon Brenner <jon.brenner@ams.com>
Subject: Re: [PATCH 4/4] iio: Add tcs3472 color light sensor driver
References: <1378653659-15665-1-git-send-email-pmeerw@pmeerw.net> <1378653659-15665-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378653659-15665-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/08/13 16:20, Peter Meerwald wrote:
> chip has four 16-bit channels for red, green, blue, clear color
> intensity; driver supports the TCS3x7x family of devices and was
> tested with a TCS34725 chip; further information here:
> http://www.ams.com/eng/Products/Light-Sensors/Color-Sensor/TCS34725
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Jon Brenner <jon.brenner@ams.com>


A few trivial bits:

I2C does not have any alignment constraints on the buffers used (these
are handled in the i2c driver by using a bounce buffer if needed). That means
you can just embed you data->buffer as an array directly inside data.  Saves
an allocation and 2 lines of code, hence whilst nicer it can be in a follow
up patch if you like.

For long writes to sysfs buffers make sure you use snprintf.  It's entirely
possible your write will always fit (and indeed it should) but as a reviewer
I'm happier letting it go with the added protection that it won't overrun
the buffer.

Anyhow, must be all of 2 mins work for you to roll a new version of with these
trivial bits cleaned up. (I very nearly just made the changes and merged, but
they are just a tiny bit too invasive given I can't test!)

Another nice driver. Thanks Peter.

Jonathan
...
> +struct tcs3472_data {
> +	struct i2c_client *client;
> +	u8 enable;
> +	u8 control;
> +	u8 atime;
As mentioned below,
u16 buffer[8];
> +	u16 *buffer;
> +};
> +
...
> +static int tcs3472_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct tcs3472_data *data = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		for (i = 0; i < ARRAY_SIZE(tcs3472_agains); i++) {
Do you want to check val2 here as well just to confirm it is 0?
You could otherwise implement the write_raw_get_fmt callback to
specify that this is IIO_VAL_INT to let the front end handle
any unwanted decimals.
> +			if (val == tcs3472_agains[i]) {
> +				data->control &= ~TCS3472_CONTROL_AGAIN_MASK;
> +				data->control |= i;
> +				return i2c_smbus_write_byte_data(
> +					data->client, TCS3472_CONTROL,
> +					data->control);
> +			}
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +		for (i = 0; i < 256; i++) {
> +			if (val2 == (256 - i) * 2400) {
> +				data->atime = i;
> +				return i2c_smbus_write_word_data(
> +					data->client, TCS3472_ATIME,
> +					data->atime);
> +			}
> +
> +		}
> +		return -EINVAL;
> +	}
> +	return -EINVAL;
> +}
...
> +static ssize_t tcs3472_show_int_time_available(struct device *dev,
> +					struct device_attribute *attr,
> +					char *buf)
> +{
> +	ssize_t total_n = 0;
> +	int i;
> +
> +	for (i = 1; i <= 256; i++) {
> +		ssize_t n = sprintf(buf, "0.%06d ", 2400 * i);
Ouch, that is quite a long text string.  Handling this sort of available
case nicely has been on the todo list for ages.  I've been meaning to
at least get proposed docs on how to do this out there and it might happen
one day soon!  For this I'd propose something like 2400..2400..614400 to
indicate that it is even steps size 2400 between 2400 and 614400.  Right
now what you have is all the ABI allows unfortunately.

Snprintf limited to a page would certainly be wise here.

> +		buf += n;
> +		total_n += n;
> +	}
> +	/* replace trailing space by newline */
> +	buf[-1] = '\n';
> +
> +	return total_n;
> +}
> +
> +static IIO_CONST_ATTR(calibscale_available, "1 4 16 60");
> +static IIO_DEV_ATTR_INT_TIME_AVAIL(tcs3472_show_int_time_available);
> +
> +static struct attribute *tcs3472_attributes[] = {
> +	&iio_const_attr_calibscale_available.dev_attr.attr,
> +	&iio_dev_attr_integration_time_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group tcs3472_attribute_group = {
> +	.attrs = tcs3472_attributes,
> +};
> +
> +static const struct iio_info tcs3472_info = {
> +	.read_raw = tcs3472_read_raw,
> +	.write_raw = tcs3472_write_raw,
> +	.attrs = &tcs3472_attribute_group,
> +	.driver_module = THIS_MODULE,
> +};
> +
> +static int tcs3472_probe(struct i2c_client *client,
> +			   const struct i2c_device_id *id)
> +{
> +	struct tcs3472_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
I2C has no alignment requirements (and even if there were there are ways
of ensuring all is fine - see spi drivers). Hence just put the buffer array
directly inside data and lose this separate allocation.

> +	data->buffer = devm_kzalloc(&indio_dev->dev, TSL3472_BUFFER_SIZE,
> +		GFP_KERNEL);
> +	if (data->buffer == NULL)
> +		return -ENOMEM;
...
