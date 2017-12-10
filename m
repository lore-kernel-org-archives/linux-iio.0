Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752105AbdLJRxb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Dec 2017 12:53:31 -0500
Date: Sun, 10 Dec 2017 17:53:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v7 04/13] IIO: inkern: API for manipulating channel
 attributes
Message-ID: <20171210175325.5c0771a9@archlinux>
In-Reply-To: <1512744566-13233-5-git-send-email-arnaud.pouliquen@st.com>
References: <1512744566-13233-1-git-send-email-arnaud.pouliquen@st.com>
        <1512744566-13233-5-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 15:49:17 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Extend the inkern API with functions for reading and writing
> attribute of iio channels.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
One nitpick inline. If you aren't rerolling can get sorted
whilst applying the series.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> V6 to V7 update:
>  - Move iio_chan_info_enum from iio.h to types.h.
> 
>  drivers/iio/inkern.c         | 18 +++++++++++++-----
>  include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
>  include/linux/iio/iio.h      | 28 ----------------------------
>  include/linux/iio/types.h    | 28 ++++++++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 069defc..f2e7824 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -664,9 +664,8 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>  }
>  EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
>  
> -static int iio_read_channel_attribute(struct iio_channel *chan,
> -				      int *val, int *val2,
> -				      enum iio_chan_info_enum attribute)
> +int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
> +			       enum iio_chan_info_enum attribute)
>  {
>  	int ret;
>  
> @@ -682,6 +681,8 @@ static int iio_read_channel_attribute(struct iio_channel *chan,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
> +
Nitpick if you are rerolling the series.  Don't need the extra line here.
>  
>  int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
>  {
> @@ -850,7 +851,8 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>  						chan->channel, val, val2, info);
>  }
>  
> -int iio_write_channel_raw(struct iio_channel *chan, int val)
> +int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
> +				enum iio_chan_info_enum attribute)
>  {
>  	int ret;
>  
> @@ -860,12 +862,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
>  		goto err_unlock;
>  	}
>  
> -	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
> +	ret = iio_channel_write(chan, val, val2, attribute);
>  err_unlock:
>  	mutex_unlock(&chan->indio_dev->info_exist_lock);
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
> +
> +int iio_write_channel_raw(struct iio_channel *chan, int val)
> +{
> +	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
> +}
>  EXPORT_SYMBOL_GPL(iio_write_channel_raw);
>  
>  unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 5e347a9..2017f35 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -216,6 +216,32 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
>  int iio_read_channel_processed(struct iio_channel *chan, int *val);
>  
>  /**
> + * iio_write_channel_attribute() - Write values to the device attribute.
> + * @chan:	The channel being queried.
> + * @val:	Value being written.
> + * @val2:	Value being written.val2 use depends on attribute type.
> + * @attribute:	info attribute to be read.
> + *
> + * Returns an error code or 0.
> + */
> +int iio_write_channel_attribute(struct iio_channel *chan, int val,
> +				int val2, enum iio_chan_info_enum attribute);
> +
> +/**
> + * iio_read_channel_attribute() - Read values from the device attribute.
> + * @chan:	The channel being queried.
> + * @val:	Value being written.
> + * @val2:	Value being written.Val2 use depends on attribute type.
> + * @attribute:	info attribute to be written.
> + *
> + * Returns an error code if failed. Else returns a description of what is in val
> + * and val2, such as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
> + * + val2/1e6
> + */
> +int iio_read_channel_attribute(struct iio_channel *chan, int *val,
> +			       int *val2, enum iio_chan_info_enum attribute);
> +
> +/**
>   * iio_write_channel_raw() - write to a given channel
>   * @chan:		The channel being queried.
>   * @val:		Value being written.
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index c380daa..007caf7 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -20,34 +20,6 @@
>   * Currently assumes nano seconds.
>   */
>  
> -enum iio_chan_info_enum {
> -	IIO_CHAN_INFO_RAW = 0,
> -	IIO_CHAN_INFO_PROCESSED,
> -	IIO_CHAN_INFO_SCALE,
> -	IIO_CHAN_INFO_OFFSET,
> -	IIO_CHAN_INFO_CALIBSCALE,
> -	IIO_CHAN_INFO_CALIBBIAS,
> -	IIO_CHAN_INFO_PEAK,
> -	IIO_CHAN_INFO_PEAK_SCALE,
> -	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
> -	IIO_CHAN_INFO_AVERAGE_RAW,
> -	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
> -	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
> -	IIO_CHAN_INFO_SAMP_FREQ,
> -	IIO_CHAN_INFO_FREQUENCY,
> -	IIO_CHAN_INFO_PHASE,
> -	IIO_CHAN_INFO_HARDWAREGAIN,
> -	IIO_CHAN_INFO_HYSTERESIS,
> -	IIO_CHAN_INFO_INT_TIME,
> -	IIO_CHAN_INFO_ENABLE,
> -	IIO_CHAN_INFO_CALIBHEIGHT,
> -	IIO_CHAN_INFO_CALIBWEIGHT,
> -	IIO_CHAN_INFO_DEBOUNCE_COUNT,
> -	IIO_CHAN_INFO_DEBOUNCE_TIME,
> -	IIO_CHAN_INFO_CALIBEMISSIVITY,
> -	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> -};
> -
>  enum iio_shared_by {
>  	IIO_SEPARATE,
>  	IIO_SHARED_BY_TYPE,
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index 2aa7b63..6eb3d683 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -34,4 +34,32 @@ enum iio_available_type {
>  	IIO_AVAIL_RANGE,
>  };
>  
> +enum iio_chan_info_enum {
> +	IIO_CHAN_INFO_RAW = 0,
> +	IIO_CHAN_INFO_PROCESSED,
> +	IIO_CHAN_INFO_SCALE,
> +	IIO_CHAN_INFO_OFFSET,
> +	IIO_CHAN_INFO_CALIBSCALE,
> +	IIO_CHAN_INFO_CALIBBIAS,
> +	IIO_CHAN_INFO_PEAK,
> +	IIO_CHAN_INFO_PEAK_SCALE,
> +	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW,
> +	IIO_CHAN_INFO_AVERAGE_RAW,
> +	IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY,
> +	IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY,
> +	IIO_CHAN_INFO_SAMP_FREQ,
> +	IIO_CHAN_INFO_FREQUENCY,
> +	IIO_CHAN_INFO_PHASE,
> +	IIO_CHAN_INFO_HARDWAREGAIN,
> +	IIO_CHAN_INFO_HYSTERESIS,
> +	IIO_CHAN_INFO_INT_TIME,
> +	IIO_CHAN_INFO_ENABLE,
> +	IIO_CHAN_INFO_CALIBHEIGHT,
> +	IIO_CHAN_INFO_CALIBWEIGHT,
> +	IIO_CHAN_INFO_DEBOUNCE_COUNT,
> +	IIO_CHAN_INFO_DEBOUNCE_TIME,
> +	IIO_CHAN_INFO_CALIBEMISSIVITY,
> +	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
> +};
> +
>  #endif /* _IIO_TYPES_H_ */

