Return-Path: <lars@metafoo.de>
Message-ID: <4FD219D9.5010008@metafoo.de>
Date: Fri, 08 Jun 2012 17:27:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 4/4] staging:iio: Proof of concept input driver.
References: <1338406594-14550-1-git-send-email-jic23@kernel.org> <1338406594-14550-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406594-14550-5-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 05/30/2012 09:36 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <jic23@cam.ac.uk>
> 
> This is no where near ready to merge.  Lots of stuff missing.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/Kconfig     |   11 +++
>  drivers/staging/iio/Makefile    |    1 +
>  drivers/staging/iio/iio_input.c |  176 +++++++++++++++++++++++++++++++++++++++
>  drivers/staging/iio/iio_input.h |   23 +++++
>  4 files changed, 211 insertions(+)
> 
> diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> index 04cd6ec..022463e 100644
> --- a/drivers/staging/iio/Kconfig
> +++ b/drivers/staging/iio/Kconfig
> @@ -4,6 +4,17 @@
[...]
> +};
> +
> +static int iio_channel_value(u8 *data,
> +			     const struct iio_chan_spec *chan,
> +			     int *val)
> +{
> +	int value;
> +
> +	if (chan->scan_type.sign == 's') {
> +		switch (chan->scan_type.storagebits) {
> +		case 8:
> +			value = *(s8 *)(data);
> +			break;
> +		case 16:
> +			value = *(s16 *)(data);
> +			break;
> +		case 32:
> +			value = *(s32 *)(data);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		value >>= chan->scan_type.shift;
> +		value &= (1 << chan->scan_type.realbits) - 1;
> +		value = (value << (sizeof(value)*8 - chan->scan_type.realbits))
> +			>> (sizeof(value)*8 - chan->scan_type.realbits);

This looks scarey. There is a sign_extend32 function. It probably makes
sense to add one which works on ints. Btw. I think until the sign extension
the type should still be unsigned. This will also get rid of the duplicated
code.

> +	} else {
> +		switch (chan->scan_type.storagebits) {
> +		case 8:
> +			value = *(u8 *)(data);
> +			break;
> +		case 16:
> +			value = *(u16 *)(data);
> +			break;
> +		case 32:
> +			value = *(u32 *)(data);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		value >>= chan->scan_type.shift;
> +		value &= (1 << chan->scan_type.realbits) - 1;
> +	}
> +	*val = value;

This function probably needs to be extended to deal with the endianness
field of the scan type at some point.
> +
> +	return 0;
> +}
> +
> +static int iio_input_store_to(u8 *data, void *private)
> +{
> +	struct iio_input_state *st = private;
> +	struct iio_channel *channel;
> +	struct iio_input_channel_data *input_data;
> +	int offset = 0;
> +	int value, ret;
> +
> +	channel = iio_channel_cb_get_channels(st->buff);
> +	while (channel->indio_dev) {
> +		input_data = channel->data;
> +		offset = ALIGN(offset,
> +			       channel->channel->scan_type.storagebits/8);
> +		offset += channel->channel->scan_type.storagebits/8;

Maybe I'm missing something, but shouldn't offset be increased after reading
the data?

> +		ret = iio_channel_value(&data[offset],
> +					channel->channel,
> +					&value);
> +		if (ret < 0)
> +			return ret;
> +		input_report_abs(st->idev, input_data->code, value);
> +	}
> +	input_sync(st->idev);
> +
> +	return 0;
> +}
> +
[...]
