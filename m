Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33458 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcADMF7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 Jan 2016 07:05:59 -0500
Subject: Re: [PATCH 3/5] Staging: iio: cdc: ad7152: Fix alignment should match
 open parenthesis
To: Shraddha Barke <shraddha.6596@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
 <1451388451-10342-4-git-send-email-shraddha.6596@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568A6025.7040805@kernel.org>
Date: Mon, 4 Jan 2016 12:05:57 +0000
MIME-Version: 1.0
In-Reply-To: <1451388451-10342-4-git-send-email-shraddha.6596@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/12/15 11:27, Shraddha Barke wrote:
> Fix checkpatch warning of "Alignment should match open parenthesis".
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
This is always a fun one.  Making the alignment fixes promptly breaks
the 80 character guidance (which is often why the alignment is deliberately wrong)
If it can't be done without breaking that rule, I'd argue that the code is more
readable with the shortened alignment.

Always take checkpath suggestions as advice rather than a rule as
sometimes they can be less than helpful!

Jonathan
> ---
>  drivers/staging/iio/cdc/ad7152.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
> index 472836d..15bbbe5 100644
> --- a/drivers/staging/iio/cdc/ad7152.c
> +++ b/drivers/staging/iio/cdc/ad7152.c
> @@ -166,8 +166,8 @@ static const unsigned char ad7152_filter_rate_table[][2] = {
>  };
>  
>  static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		char *buf)
> +					     struct device_attribute *attr,
> +					     char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7152_chip_info *chip = iio_priv(indio_dev);
> @@ -177,9 +177,9 @@ static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
>  }
>  
>  static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
> -		struct device_attribute *attr,
> -		const char *buf,
> -		size_t len)
> +					      struct device_attribute *attr,
> +					      const char *buf,
> +					      size_t len)
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7152_chip_info *chip = iio_priv(indio_dev);
> @@ -199,7 +199,7 @@ static ssize_t ad7152_store_filter_rate_setup(struct device *dev,
>  
>  	mutex_lock(&indio_dev->mlock);
>  	ret = i2c_smbus_write_byte_data(chip->client,
> -			AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
> +					AD7152_REG_CFG2, AD7152_CFG2_OSR(i));
>  	if (ret < 0) {
>  		mutex_unlock(&indio_dev->mlock);
>  		return ret;
> @@ -268,8 +268,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
>  		val = (val2 * 1024) / 15625;
>  
>  		ret = i2c_smbus_write_word_data(chip->client,
> -				ad7152_addresses[chan->channel][AD7152_GAIN],
> -				swab16(val));
> +						ad7152_addresses[chan->channel][AD7152_GAIN],
> +						swab16(val));
>  		if (ret < 0)
>  			goto out;
>  
> @@ -282,8 +282,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  		ret = i2c_smbus_write_word_data(chip->client,
> -				ad7152_addresses[chan->channel][AD7152_OFFS],
> -				swab16(val));
> +						ad7152_addresses[chan->channel][AD7152_OFFS],
> +						swab16(val));
>  		if (ret < 0)
>  			goto out;
>  
> @@ -302,8 +302,8 @@ static int ad7152_write_raw(struct iio_dev *indio_dev,
>  		chip->setup[chan->channel] |= AD7152_SETUP_RANGE(i);
>  
>  		ret = i2c_smbus_write_byte_data(chip->client,
> -				ad7152_addresses[chan->channel][AD7152_SETUP],
> -				chip->setup[chan->channel]);
> +						ad7152_addresses[chan->channel][AD7152_SETUP],
> +						chip->setup[chan->channel]);
>  		if (ret < 0)
>  			goto out;
>  
> 

