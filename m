Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:10517 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754143AbdKKAeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Nov 2017 19:34:50 -0500
Date: Sat, 11 Nov 2017 00:33:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Martin Kepplinger <martink@posteo.de>
CC: <harinath922@gmail.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: mma8452: add power_mode sysfs configuration
Message-ID: <20171111003350.000077b7@huawei.com>
In-Reply-To: <20171106071958.322-1-martink@posteo.de>
References: <20171106071958.322-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 6 Nov 2017 08:19:58 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> This adds the power_mode sysfs interface to the device as documented in
> sysfs-bus-iio.
> 
> ---
> 
> Note that I explicitely don't sign off on this.
> 
> This is a starting point for anybody who can test it and check for correct
> API usage, and ABI correctness, as documented in Documentation/ABI/testing/sys-bus-iio
> (grep it for "power_mode"). The ABI doc probably would need an addition
> too, if the 4 power modes here seem generally useful (there are only
>  2 listed there)!
> 
> So, if you can test this, feel free to set up a proper patch or
> two, and I'm happy to review.
> 
> Please note that this patch is quite old. It really should be that simple
> as far as my understanding back then. We always list the available frequencies
> of the given power mode we are in, for example, already, and everything
> basically is in place except for the user interface.

Hmm. A lot of devices support something along these lines.  The issue
has always been - how is userspace to figure out what to do with it?
It's all very vague...

Funnily enough - this used to be really common, but is becoming less so
now - presumably because no one was using it much (or maybe I am reading
too much into that ;)

Now the question is whether it can be tied to better defined things?

Here low noise restricts the range to 4g.  Issue is that we don't actually
have writeable _available attributes (which correspond to range in this case).

Low power mode... This one is apparently oversampling.  If possible support
it as that as we have well defined interfaces for that.

Jonathan.
> 
> thanks
>                             martin
> 
> 
> 
>  drivers/iio/accel/mma8452.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index bfd4bc806fc2..640bbd9872ab 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1166,6 +1166,41 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	.attrs = mma8452_event_attributes,
>  };
>  
> +static const char * const mma8452_power_modes[] = {"normal",
> +						   "low_noise_low_power",
> +						   "low_noise",
> +						   "low_power"};
> +
> +static int mma8452_get_power_mode_iio_enum(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	return mma8452_get_power_mode(data);
> +}
> +
> +static int mma8452_set_power_mode_iio_enum(struct iio_dev *indio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   unsigned int mode)
> +{
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +
> +	return mma8452_set_power_mode(data, mode);
> +}
> +
> +static const struct iio_enum mma8452_power_mode_enum = {
> +	.items = mma8452_power_modes,
> +	.num_items = ARRAY_SIZE(mma8452_power_modes),
> +	.get = mma8452_get_power_mode_iio_enum,
> +	.set = mma8452_set_power_mode_iio_enum,
> +};
> +
> +static const struct iio_chan_spec_ext_info mma8452_ext_info[] = {
> +	IIO_ENUM("power_mode", true, &mma8452_power_mode_enum),
> +	IIO_ENUM_AVAILABLE("power_mode", &mma8452_power_mode_enum),
> +	{ },
> +};
> +
>  #define MMA8452_FREEFALL_CHANNEL(modifier) { \
>  	.type = IIO_ACCEL, \
>  	.modified = 1, \
> @@ -1204,6 +1239,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_transient_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_transient_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  #define MMA8652_CHANNEL(axis, idx, bits) { \
> @@ -1225,6 +1261,7 @@ static struct attribute_group mma8452_event_attribute_group = {
>  	}, \
>  	.event_spec = mma8452_motion_event, \
>  	.num_event_specs = ARRAY_SIZE(mma8452_motion_event), \
> +	.ext_info = mma8452_ext_info, \
>  }
>  
>  static const struct iio_chan_spec mma8451_channels[] = {

