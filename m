Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753145AbeDOPCM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Apr 2018 11:02:12 -0400
Date: Sun, 15 Apr 2018 16:02:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?SGVybsOhbg==?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] staging: iio: ad7746: Automatically swap
 values in readings/writings
Message-ID: <20180415160207.59f6b698@archlinux>
In-Reply-To: <1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
        <1523637411-8531-2-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 13 Apr 2018 13:36:38 -0300
Hernán Gonzalez <hernan@vanguardiasur.com.ar> wrote:

> Data to read or write was being handled with the swab16() macro instead
> of using i2c_smbus_{read,write}_swapped.
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
> index 4882dbc..53e28ae 100644
> --- a/drivers/staging/iio/cdc/ad7746.c
> +++ b/drivers/staging/iio/cdc/ad7746.c
> @@ -451,7 +451,7 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> -		ret = i2c_smbus_write_word_data(chip->client, reg, swab16(val));
> +		ret = i2c_smbus_write_word_swapped(chip->client, reg, val);
>  		if (ret < 0)
>  			goto out;
>  
> @@ -462,8 +462,8 @@ static int ad7746_write_raw(struct iio_dev *indio_dev,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		ret = i2c_smbus_write_word_data(chip->client,
> -				AD7746_REG_CAP_OFFH, swab16(val));
> +		ret = i2c_smbus_write_word_swapped(chip->client,
> +						   AD7746_REG_CAP_OFFH, val);
>  		if (ret < 0)
>  			goto out;
>  
> @@ -594,21 +594,21 @@ static int ad7746_read_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		}
>  
> -		ret = i2c_smbus_read_word_data(chip->client, reg);
> +		ret = i2c_smbus_read_word_swapped(chip->client, reg);
>  		if (ret < 0)
>  			goto out;
>  		/* 1 + gain_val / 2^16 */
>  		*val = 1;
> -		*val2 = (15625 * swab16(ret)) / 1024;
> +		*val2 = (15625 * ret) / 1024;
>  
>  		ret = IIO_VAL_INT_PLUS_MICRO;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		ret = i2c_smbus_read_word_data(chip->client,
> -					       AD7746_REG_CAP_OFFH);
> +		ret = i2c_smbus_read_word_swapped(chip->client,
> +						  AD7746_REG_CAP_OFFH);
>  		if (ret < 0)
>  			goto out;
> -		*val = swab16(ret);
> +		*val = ret;
>  
>  		ret = IIO_VAL_INT;
>  		break;

