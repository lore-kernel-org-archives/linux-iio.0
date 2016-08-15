Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41746 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbcHOQE0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 12:04:26 -0400
Subject: Re: [PATCH] iio: magnetometer: mag3110: claim direct mode during raw
 reads
To: Alison Schofield <amsfield22@gmail.com>
References: <20160801154827.GA7017@d830.WORKGROUP>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <14defd5e-ef8c-047a-0512-e94835629201@kernel.org>
Date: Mon, 15 Aug 2016 17:04:24 +0100
MIME-Version: 1.0
In-Reply-To: <20160801154827.GA7017@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/08/16 16:48, Alison Schofield wrote:
> Driver was checking for direct mode but not locking it.  Use
> claim/release helper functions to guarantee the device stays
> in direct mode during raw reads.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> ---
>  drivers/iio/magnetometer/mag3110.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
> index f2be4a0..90574ff 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -154,34 +154,39 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
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
>  		case IIO_MAGN: /* in 0.1 uT / LSB */
>  			ret = mag3110_read(data, buffer);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  			*val = sign_extend32(
>  				be16_to_cpu(buffer[chan->scan_index]), 15);
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
No break?
>  		case IIO_TEMP: /* in 1 C / LSB */
>  			mutex_lock(&data->lock);
>  			ret = mag3110_request(data);
>  			if (ret < 0) {
>  				mutex_unlock(&data->lock);
> -				return ret;
> +				goto release;
>  			}
>  			ret = i2c_smbus_read_byte_data(data->client,
>  				MAG3110_DIE_TEMP);
>  			mutex_unlock(&data->lock);
>  			if (ret < 0)
> -				return ret;
> +				goto release;
>  			*val = sign_extend32(ret, 7);
> -			return IIO_VAL_INT;
> +			ret = IIO_VAL_INT;
No break here either....
>  		default:
> -			return -EINVAL;
> +			ret = -EINVAL;
>  		}
> +release:
> +		iio_device_release_direct_mode(indio_dev);
> +		return ret;
> +
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_MAGN:
> 

