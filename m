Return-Path: <SRS0=uHT8=C3=electromag.com.au=preid@kernel.org>
Subject: Re: [PATCH v5 04/13] IIO: inkern: API for manipulating channel
 attributes
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
  Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
  Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
  Lars-Peter Clausen <lars@metafoo.de>,
  Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
  Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
  Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
  linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
  Maxime Coquelin <mcoquelin.stm32@gmail.com>,
  Alexandre Torgue <alexandre.torgue@st.com>
References: <1511881557-28596-1-git-send-email-arnaud.pouliquen@st.com>
 <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <9e317698-11dd-934e-1bc7-75388ea65e35@electromag.com.au>
Date: Wed, 29 Nov 2017 14:20:06 +0800
MIME-Version: 1.0
In-Reply-To: <1511881557-28596-5-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 28/11/2017 23:05, Arnaud Pouliquen wrote:
> Extend the inkern API with functions for reading and writing
> attribute of iio channels.

I submitted a similar patch a while ago and never followed up with a v2.
This will address the same thing, nice.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>   drivers/iio/inkern.c         | 18 +++++++++++++-----
>   include/linux/iio/consumer.h | 26 ++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 069defc..f2e7824 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -664,9 +664,8 @@ int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>   }
>   EXPORT_SYMBOL_GPL(iio_convert_raw_to_processed);
>   
> -static int iio_read_channel_attribute(struct iio_channel *chan,
> -				      int *val, int *val2,
> -				      enum iio_chan_info_enum attribute)
> +int iio_read_channel_attribute(struct iio_channel *chan, int *val, int *val2,
> +			       enum iio_chan_info_enum attribute)
>   {
>   	int ret;
>   
> @@ -682,6 +681,8 @@ static int iio_read_channel_attribute(struct iio_channel *chan,
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(iio_read_channel_attribute);
> +
>   
>   int iio_read_channel_offset(struct iio_channel *chan, int *val, int *val2)
>   {
> @@ -850,7 +851,8 @@ static int iio_channel_write(struct iio_channel *chan, int val, int val2,
>   						chan->channel, val, val2, info);
>   }
>   
> -int iio_write_channel_raw(struct iio_channel *chan, int val)
> +int iio_write_channel_attribute(struct iio_channel *chan, int val, int val2,
> +				enum iio_chan_info_enum attribute)
>   {
>   	int ret;
>   
> @@ -860,12 +862,18 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
>   		goto err_unlock;
>   	}
>   
> -	ret = iio_channel_write(chan, val, 0, IIO_CHAN_INFO_RAW);
> +	ret = iio_channel_write(chan, val, val2, attribute);
>   err_unlock:
>   	mutex_unlock(&chan->indio_dev->info_exist_lock);
>   
>   	return ret;
>   }
> +EXPORT_SYMBOL_GPL(iio_write_channel_attribute);
> +
> +int iio_write_channel_raw(struct iio_channel *chan, int val)
> +{
> +	return iio_write_channel_attribute(chan, val, 0, IIO_CHAN_INFO_RAW);
> +}
>   EXPORT_SYMBOL_GPL(iio_write_channel_raw);
>   
>   unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 5e347a9..2017f35 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -216,6 +216,32 @@ int iio_read_channel_average_raw(struct iio_channel *chan, int *val);
>   int iio_read_channel_processed(struct iio_channel *chan, int *val);
>   
>   /**
> + * iio_write_channel_attribute() - Write values to the device attribute.
> + * @chan:	The channel being queried.
> + * @val:	Value being written.
> + * @val2:	Value being written.val2 use depends on attribute type.
> + * @attribute:	info attribute to be read.
i think s/read/written/

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
and also s/written/read/

> + *
> + * Returns an error code if failed. Else returns a description of what is in val
> + * and val2, such as IIO_VAL_INT_PLUS_MICRO telling us we have a value of val
> + * + val2/1e6
> + */
> +int iio_read_channel_attribute(struct iio_channel *chan, int *val,
> +			       int *val2, enum iio_chan_info_enum attribute);
> +
> +/**
>    * iio_write_channel_raw() - write to a given channel
>    * @chan:		The channel being queried.
>    * @val:		Value being written.
> 


-- 
Regards
Phil Reid
