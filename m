Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-136.synserver.de ([212.40.185.136]:1044 "EHLO
	smtp-out-134.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932421Ab2GBJYe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jul 2012 05:24:34 -0400
Message-ID: <4FF169B6.2000006@metafoo.de>
Date: Mon, 02 Jul 2012 11:28:22 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: add adjd_s311 I2C digital color sensor driver
References: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1341138013-28267-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/01/2012 12:20 PM, Peter Meerwald wrote:
> sensor has 4 channels (10-bit each, R/G/B and clear), sensitivity
> and gain is controlled in the driver by ext_info integration_time
> and CHAN_INFO_HARDWAREGAIN
> 
> driver supports triggered buffer and IIO_CHAN_INFO_RAW to get the
> sensor data
> 
> patch depends on IIO_MOD_LIGHT_RED etc, the patch providing that
> (http://permalink.gmane.org/gmane.linux.kernel.iio/4354) has not been
> merged yet, a new proposal is following
> 
> v3:
> * fix warnings
> 
> v2: address comments by Lars-Peter Clausen
> * buffer allocation now in update_scan_mode instead of in trigger
>   handler
> * simplify trigger code (assume active_scan_mask is not empty, use
>   for_each_set_bit, use iio_push_to_buffer)
> * reorder entry in Makefile and Kconfig
> * fix remove
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>


Looks pretty good to me. One issue in the IRQ handler and two minor
suggestions inline.

> ---
>  drivers/iio/light/Kconfig     |   12 ++
>  drivers/iio/light/Makefile    |    1 +
>  drivers/iio/light/adjd_s311.c |  395 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 408 insertions(+)
>  create mode 100644 drivers/iio/light/adjd_s311.c
> [...]
> +
> +static ssize_t adjd_s311_write_int_time(struct iio_dev *indio_dev,
> +	 uintptr_t private, const struct iio_chan_spec *chan, const char *buf,
> +	 size_t len)
> +{
> +	struct adjd_s311_data *data = iio_priv(indio_dev);
> +	unsigned long int_time;
> +	int ret;
> +
> +	ret = kstrtoul(buf, 10, &int_time);
> +	if (ret)
> +		return ret;
> +
> +	if (int_time > ADJD_S311_INT_MASK)
> +		return -EINVAL;
> +
> +	ret = i2c_smbus_write_word_data(data->client,
> +		ADJD_S311_INT_REG(chan->address), int_time);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret ? ret : len;

ret will always be zero here.

> +}
> +
> +static irqreturn_t adjd_s311_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct adjd_s311_data *data = iio_priv(indio_dev);
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	int len = 0;
> +	int i, j = 0;
> +
> +	int ret = adjd_s311_req_data(indio_dev);
> +	if (ret < 0)
> +		return ret;

I wouldn't return ret here since this is the interrupt handler and I'm not
quite sure how the core reacts if it gets a value which is not a
irqreturn_t, especially considering that irqreturn_t is basically unsigned.
You also have to call iio_trigger_notify_done before leaving the function

> +
> +	for_each_set_bit(i, indio_dev->active_scan_mask,
> +		indio_dev->masklength) {
> +
> +		ret = i2c_smbus_read_word_data(data->client,
> +			ADJD_S311_DATA_REG(i));
> +		if (ret < 0)
> +			return ret;

Same here.

> +
> +		data->buffer[j++] = ret & ADJD_S311_DATA_MASK;
> +		len += 2;
> +	}
> +
> +	if (indio_dev->scan_timestamp)
> +		*(s64 *)((phys_addr_t)data->buffer + ALIGN(len, sizeof(s64)))
> +			= pf->timestamp;
> +	iio_push_to_buffer(buffer, (u8 *)data->buffer, pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> [...]
> +
> +static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
> +	const unsigned long *scan_mask)
> +{
> +	struct adjd_s311_data *data = iio_priv(indio_dev);
> +	kfree(data->buffer);
> +	data->buffer = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);

The above two lines could be done in one with krealloc(...)

> +	if (!data->buffer)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> [...]
