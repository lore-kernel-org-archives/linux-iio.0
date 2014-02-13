Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45245 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaBMTMK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Feb 2014 14:12:10 -0500
Message-ID: <52FD1928.1010305@kernel.org>
Date: Thu, 13 Feb 2014 19:12:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Ge Gao <ggao@invensense.com>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	maxime.ripard@free-electrons.com
Subject: Re: [PATCH 1/4] IIO: core: Introduce read_raw_multi
References: <1390194142-25058-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1390194142-25058-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/01/14 05:02, Srinivas Pandruvada wrote:
> This callback is introduced to overcome some limitations of existing
> read_raw callback. The functionality of both existing read_raw and
> read_raw_multi is similar, both are used to request values from the
> device. The current read_raw callback allows only two return values.
> The new read_raw_multi allows returning multiple values. Instead of
> passing just address of val and val2, it passes length and pointer
> to values. Depending on the type and length of passed buffer, iio
> client drivers can return multiple values.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
I am fairly happy with this set, but would like to get a few more opinions
before taking this new chunk of ABI into the subsystem.

Peter made the point that there were other cases (RGB colour sensors,
where perhaps such a multi component type makes sense) and as such we
may have some redundancy.  I agree that this is a possible issue but
in the case of quaternion rotations the components have no meaning whatsoever
on their own under any circumstances. As such supporting them as single
components is a non starter to my mind.

The other option Peter raised was to only allow such compound types via
the buffered interface.  This would certainly be an option as then we could
use available channel masks to ensure that all or none of hte elements are
present.

I think I prefer the approach taken here as it still allows for 'what is my
current orientation' type polled queries via sysfs.

Anyhow, I've cc'd everyone I could immediately think of who might have an
opinion and / or has some involvement with inertial sensors that 'might'
use this functionality at some point.

Jonathan

p.s You will probably want to read the whole series if you haven't seen this
before.

> ---
>   drivers/iio/iio_core.h           |  2 +-
>   drivers/iio/industrialio-core.c  | 51 +++++++++++++++++++++++-----------------
>   drivers/iio/industrialio-event.c |  6 +++--
>   drivers/iio/inkern.c             | 15 ++++++++++--
>   include/linux/iio/iio.h          | 16 +++++++++++++
>   5 files changed, 63 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index f6db6af..4172f22 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -35,7 +35,7 @@ int __iio_add_chan_devattr(const char *postfix,
>   			   struct list_head *attr_list);
>   void iio_free_chan_devattr_list(struct list_head *attr_list);
>
> -ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2);
> +ssize_t iio_format_value(char *buf, unsigned int type, int *val);
>
>   /* Event interface flags */
>   #define IIO_BUSY_BIT_POS 1
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 18f72e3..f8b730a 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -367,41 +367,42 @@ EXPORT_SYMBOL_GPL(iio_enum_write);
>    * @buf: The buffer to which the formated value gets written
>    * @type: One of the IIO_VAL_... constants. This decides how the val and val2
>    *        parameters are formatted.
> - * @val: First part of the value, exact meaning depends on the type parameter.
> - * @val2: Second part of the value, exact meaning depends on the type parameter.
> + * @vals: pointer to the values, exact meaning depends on the type parameter.
>    */
> -ssize_t iio_format_value(char *buf, unsigned int type, int val, int val2)
> +ssize_t iio_format_value(char *buf, unsigned int type, int *vals)
>   {
>   	unsigned long long tmp;
>   	bool scale_db = false;
>
>   	switch (type) {
>   	case IIO_VAL_INT:
> -		return sprintf(buf, "%d\n", val);
> +		return sprintf(buf, "%d\n", vals[0]);
>   	case IIO_VAL_INT_PLUS_MICRO_DB:
>   		scale_db = true;
>   	case IIO_VAL_INT_PLUS_MICRO:
> -		if (val2 < 0)
> -			return sprintf(buf, "-%ld.%06u%s\n", abs(val), -val2,
> +		if (vals[1] < 0)
> +			return sprintf(buf, "-%ld.%06u%s\n", abs(vals[0]),
> +					-vals[1],
>   				scale_db ? " dB" : "");
>   		else
> -			return sprintf(buf, "%d.%06u%s\n", val, val2,
> +			return sprintf(buf, "%d.%06u%s\n", vals[0], vals[1],
>   				scale_db ? " dB" : "");
>   	case IIO_VAL_INT_PLUS_NANO:
> -		if (val2 < 0)
> -			return sprintf(buf, "-%ld.%09u\n", abs(val), -val2);
> +		if (vals[1] < 0)
> +			return sprintf(buf, "-%ld.%09u\n", abs(vals[0]),
> +					-vals[1]);
>   		else
> -			return sprintf(buf, "%d.%09u\n", val, val2);
> +			return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>   	case IIO_VAL_FRACTIONAL:
> -		tmp = div_s64((s64)val * 1000000000LL, val2);
> -		val2 = do_div(tmp, 1000000000LL);
> -		val = tmp;
> -		return sprintf(buf, "%d.%09u\n", val, val2);
> +		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
> +		vals[1] = do_div(tmp, 1000000000LL);
> +		vals[0] = tmp;
> +		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>   	case IIO_VAL_FRACTIONAL_LOG2:
> -		tmp = (s64)val * 1000000000LL >> val2;
> -		val2 = do_div(tmp, 1000000000LL);
> -		val = tmp;
> -		return sprintf(buf, "%d.%09u\n", val, val2);
> +		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
> +		vals[1] = do_div(tmp, 1000000000LL);
> +		vals[0] = tmp;
> +		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>   	default:
>   		return 0;
>   	}
> @@ -413,14 +414,20 @@ static ssize_t iio_read_channel_info(struct device *dev,
>   {
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int val, val2;
> -	int ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> -					    &val, &val2, this_attr->address);
> +	int vals[INDIO_MAX_RAW_ELEMENTS];
> +	int ret;
> +
> +	if (indio_dev->info->read_raw_multi)
> +		ret = indio_dev->info->read_raw_multi(indio_dev, this_attr->c,
> +			    INDIO_MAX_RAW_ELEMENTS, vals, this_attr->address);
> +	else
> +		ret = indio_dev->info->read_raw(indio_dev, this_attr->c,
> +				    &vals[0], &vals[1], this_attr->address);
>
>   	if (ret < 0)
>   		return ret;
>
> -	return iio_format_value(buf, ret, val, val2);
> +	return iio_format_value(buf, ret, vals);
>   }
>
>   /**
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index c10eab6..b249b48 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -274,7 +274,7 @@ static ssize_t iio_ev_value_show(struct device *dev,
>   {
>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>   	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> -	int val, val2;
> +	int val, val2, val_arr[2];
>   	int ret;
>
>   	if (indio_dev->info->read_event_value) {
> @@ -290,7 +290,9 @@ static ssize_t iio_ev_value_show(struct device *dev,
>   			&val, &val2);
>   		if (ret < 0)
>   			return ret;
> -		return iio_format_value(buf, ret, val, val2);
> +		val_arr[0] = val;
> +		val_arr[1] = val2;
> +		return iio_format_value(buf, ret, val_arr);
>   	}
>   }
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 0cf5f8e..6a93d57 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -417,12 +417,23 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>   	enum iio_chan_info_enum info)
>   {
>   	int unused;
> +	int vals[INDIO_MAX_RAW_ELEMENTS];
> +	int ret;
>
>   	if (val2 == NULL)
>   		val2 = &unused;
>
> -	return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
> -						val, val2, info);
> +	if (chan->indio_dev->info->read_raw_multi) {
> +		ret = chan->indio_dev->info->read_raw_multi(chan->indio_dev,
> +					chan->channel, INDIO_MAX_RAW_ELEMENTS,
> +					vals, info);
> +		*val = vals[0];
> +		*val2 = vals[1];
> +	} else
> +		ret = chan->indio_dev->info->read_raw(chan->indio_dev,
> +					chan->channel, val, val2, info);
> +
> +	return ret;
>   }
>
>   int iio_read_channel_raw(struct iio_channel *chan, int *val)
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 256a90a..7f76a45 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -286,6 +286,8 @@ static inline s64 iio_get_time_ns(void)
>   #define INDIO_ALL_BUFFER_MODES					\
>   	(INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE)
>
> +#define INDIO_MAX_RAW_ELEMENTS		4
> +
>   struct iio_trigger; /* forward declaration */
>   struct iio_dev;
>
> @@ -300,6 +302,14 @@ struct iio_dev;
>    *			the channel in question.  Return value will specify the
>    *			type of value returned by the device. val and val2 will
>    *			contain the elements making up the returned value.
> + * @read_raw_multi:	function to return values from the device.
> + *			mask specifies which value. Note 0 means a reading of
> + *			the channel in question.  Return value will specify the
> + *			type of value returned by the device. vals pointer
> + *			contain the elements making up the returned value.
> + *			val_len specifies maximum number of elements
> + *			vals pointer can contain. In contrast to to read_raw
> + *			device can return multiple values not just two.
>    * @write_raw:		function to write a value to the device.
>    *			Parameters are the same as for read_raw.
>    * @write_raw_get_fmt:	callback function to query the expected
> @@ -334,6 +344,12 @@ struct iio_info {
>   			int *val2,
>   			long mask);
>
> +	int (*read_raw_multi)(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int val_len,
> +			int *vals,
> +			long mask);
> +
>   	int (*write_raw)(struct iio_dev *indio_dev,
>   			 struct iio_chan_spec const *chan,
>   			 int val,
>

