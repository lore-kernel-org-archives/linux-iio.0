Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57410 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbcLaPvO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 31 Dec 2016 10:51:14 -0500
Subject: Re: [PATCH v6 3/9] iio: inkern: api for manipulating ext_info of iio
 channels
To: Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
References: <1480493823-21462-1-git-send-email-peda@axentia.se>
 <1480493823-21462-4-git-send-email-peda@axentia.se>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ba7536cf-230d-e55c-5873-3a58df0b8d9c@kernel.org>
Date: Sat, 31 Dec 2016 15:51:08 +0000
MIME-Version: 1.0
In-Reply-To: <1480493823-21462-4-git-send-email-peda@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/11/16 08:16, Peter Rosin wrote:
> Extend the inkern api with functions for reading and writing ext_info
> of iio channels.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
Acked-by: Jonathan Cameron <jic23@kernel.org>

It may make more sense to take this particular patch separately via
IIO, but as the churn on this file is fairly low I think it is probably
going to be easier to take it with the rest of the series if / when that
heads upstream.

Jonathan
> ---
>  drivers/iio/inkern.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h | 37 +++++++++++++++++++++++++++
>  2 files changed, 97 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index b0f4630a163f..4848b8129e6c 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -863,3 +863,63 @@ int iio_write_channel_raw(struct iio_channel *chan, int val)
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iio_write_channel_raw);
> +
> +unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +	unsigned int i = 0;
> +
> +	if (!chan->channel->ext_info)
> +		return i;
> +
> +	for (ext_info = chan->channel->ext_info; ext_info->name; ext_info++)
> +		++i;
> +
> +	return i;
> +}
> +EXPORT_SYMBOL_GPL(iio_get_channel_ext_info_count);
> +
> +static const struct iio_chan_spec_ext_info *iio_lookup_ext_info(
> +						const struct iio_channel *chan,
> +						const char *attr)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	if (!chan->channel->ext_info)
> +		return NULL;
> +
> +	for (ext_info = chan->channel->ext_info; ext_info->name; ++ext_info) {
> +		if (!strcmp(attr, ext_info->name))
> +			return ext_info;
> +	}
> +
> +	return NULL;
> +}
> +
> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
> +				  const char *attr, char *buf)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info = iio_lookup_ext_info(chan, attr);
> +	if (!ext_info)
> +		return -EINVAL;
> +
> +	return ext_info->read(chan->indio_dev, ext_info->private,
> +			      chan->channel, buf);
> +}
> +EXPORT_SYMBOL_GPL(iio_read_channel_ext_info);
> +
> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
> +				   const char *buf, size_t len)
> +{
> +	const struct iio_chan_spec_ext_info *ext_info;
> +
> +	ext_info = iio_lookup_ext_info(chan, attr);
> +	if (!ext_info)
> +		return -EINVAL;
> +
> +	return ext_info->write(chan->indio_dev, ext_info->private,
> +			       chan->channel, buf, len);
> +}
> +EXPORT_SYMBOL_GPL(iio_write_channel_ext_info);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index 47eeec3218b5..5e347a9805fd 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -312,4 +312,41 @@ int iio_read_channel_scale(struct iio_channel *chan, int *val,
>  int iio_convert_raw_to_processed(struct iio_channel *chan, int raw,
>  	int *processed, unsigned int scale);
>  
> +/**
> + * iio_get_channel_ext_info_count() - get number of ext_info attributes
> + *				      connected to the channel.
> + * @chan:		The channel being queried
> + *
> + * Returns the number of ext_info attributes
> + */
> +unsigned int iio_get_channel_ext_info_count(struct iio_channel *chan);
> +
> +/**
> + * iio_read_channel_ext_info() - read ext_info attribute from a given channel
> + * @chan:		The channel being queried.
> + * @attr:		The ext_info attribute to read.
> + * @buf:		Where to store the attribute value. Assumed to hold
> + *			at least PAGE_SIZE bytes.
> + *
> + * Returns the number of bytes written to buf (perhaps w/o zero termination;
> + * it need not even be a string), or an error code.
> + */
> +ssize_t iio_read_channel_ext_info(struct iio_channel *chan,
> +				  const char *attr, char *buf);
> +
> +/**
> + * iio_write_channel_ext_info() - write ext_info attribute from a given channel
> + * @chan:		The channel being queried.
> + * @attr:		The ext_info attribute to read.
> + * @buf:		The new attribute value. Strings needs to be zero-
> + *			terminated, but the terminator should not be included
> + *			in the below len.
> + * @len:		The size of the new attribute value.
> + *
> + * Returns the number of accepted bytes, which should be the same as len.
> + * An error code can also be returned.
> + */
> +ssize_t iio_write_channel_ext_info(struct iio_channel *chan, const char *attr,
> +				   const char *buf, size_t len);
> +
>  #endif
> 

