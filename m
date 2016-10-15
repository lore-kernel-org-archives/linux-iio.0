Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48625 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbcJOO77 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 10:59:59 -0400
Subject: Re: [PATCH] iio: pressure: mpl3115: claim direct mode during raw
 reads
To: Alison Schofield <amsfield22@gmail.com>
References: <20161011193306.GA8724@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <915d3140-1b52-aaf8-13ce-1d2d264f04cf@kernel.org>
Date: Sat, 15 Oct 2016 15:59:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161011193306.GA8724@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/16 20:33, Alison Schofield wrote:
> Driver was checking for direct mode but not locking it.  Use
> claim/release helper functions to guarantee the device stays
> in direct mode during raw reads.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
breaks again also the goto goes to an 'unsual location'.

You don't even need the gotos if you put that unwind code
in the standard spot and use break whenever there is an error
to drop out of the switch statement.

I've fixed up and applied, please take a look.

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan


> ---
>  drivers/iio/pressure/mpl3115.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> index 6392d7b..fb36f7d 100644
> --- a/drivers/iio/pressure/mpl3115.c
> +++ b/drivers/iio/pressure/mpl3115.c
> @@ -82,8 +82,9 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (iio_buffer_enabled(indio_dev))
> -			return -EBUSY;
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
>  
>  		switch (chan->type) {
>  		case IIO_PRESSURE: /* in 0.25 pascal / LSB */
> @@ -91,31 +92,35 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
>  			ret = mpl3115_request(data);
>  			if (ret < 0) {
>  				mutex_unlock(&data->lock);
> -				return ret;
> +				goto release;
>  			}
>  			ret = i2c_smbus_read_i2c_block_data(data->client,
>  				MPL3115_OUT_PRESS, 3, (u8 *) &tmp);
>  			mutex_unlock(&data->lock);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  			*val = be32_to_cpu(tmp) >> 12;
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
>  		case IIO_TEMP: /* in 0.0625 celsius / LSB */
>  			mutex_lock(&data->lock);
>  			ret = mpl3115_request(data);
>  			if (ret < 0) {
>  				mutex_unlock(&data->lock);
> -				return ret;
> +				goto release;
>  			}
>  			ret = i2c_smbus_read_i2c_block_data(data->client,
>  				MPL3115_OUT_TEMP, 2, (u8 *) &tmp);
>  			mutex_unlock(&data->lock);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  			*val = sign_extend32(be32_to_cpu(tmp) >> 20, 11);
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
> +
> +release:
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
>  		}
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> 

