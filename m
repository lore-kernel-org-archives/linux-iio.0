Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751740AbdLBOq3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 09:46:29 -0500
Date: Sat, 2 Dec 2017 14:46:23 +0000
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
Subject: Re: [PATCH v6 04/13] IIO: inkern: API for manipulating channel
 attributes
Message-ID: <20171202144623.27438bb2@archlinux>
In-Reply-To: <1512150020-20335-5-git-send-email-arnaud.pouliquen@st.com>
References: <1512150020-20335-1-git-send-email-arnaud.pouliquen@st.com>
        <1512150020-20335-5-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 1 Dec 2017 18:40:11 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Extend the inkern API with functions for reading and writing
> attribute of iio channels.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
> V5 to V6 update:
>  Replace include type.h with iio.h to fix build warning

Except don't do that.   Consumers should not be able to see the internals
of iio devices..  Hence instead, move the required enum to types.h please.

One other passing comment inline (not one I'm expecting you to do anything
about!).  Otherwise this is fine with me.

Thanks,

Jonathan

> 
>  drivers/iio/inkern.c         | 18 +++++++++++++-----
>  include/linux/iio/consumer.h | 28 +++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 6 deletions(-)
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
> index 5e347a9..70658b1 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -11,7 +11,7 @@
>  #define _IIO_INKERN_CONSUMER_H_
>  
>  #include <linux/types.h>
> -#include <linux/iio/types.h>
> +#include <linux/iio/iio.h>

Hmm. Not keen on this include as it just exposed the internals
to IIO consumers which we really don't want to do.

This is to allow access to the enum iio_chan_info_enum?
Move it to types.h please.

>  
>  struct iio_dev;
>  struct iio_chan_spec;
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

This pretty much highlights that we are still missing a function to allow us
to query what form write data should be presented in...

Here we have tightly coupled hardware so we know the answer, but in general
we don't.

Still can be a follow up patch when someone needs it.

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

