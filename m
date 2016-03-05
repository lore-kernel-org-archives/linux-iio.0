Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56648 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbcCERTk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 12:19:40 -0500
Subject: Re: [PATCH 1/4] iio: mma8452: coding style fixes
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
 <1456993444-21320-2-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DB1527.9080509@kernel.org>
Date: Sat, 5 Mar 2016 17:19:35 +0000
MIME-Version: 1.0
In-Reply-To: <1456993444-21320-2-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 08:24, Martin Kepplinger wrote:
> fix checkpatch issues like "space before tabs", too long lines or alignment.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 7f4994f..17d72bc 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -357,7 +357,8 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		ret = i2c_smbus_read_byte_data(data->client,
> -					      MMA8452_OFF_X + chan->scan_index);
> +					       MMA8452_OFF_X +
> +					       chan->scan_index);
>  		if (ret < 0)
>  			return ret;
>  
> @@ -418,7 +419,7 @@ fail:
>  	return ret;
>  }
>  
> -/* returns >0 if in freefall mode, 0 if not or <0 if an error occured */
> +/* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
>  static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
>  {
>  	int val;
> @@ -668,7 +669,8 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		return !!(ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift));
> +		return !!(ret & BIT(chan->scan_index +
> +				    chip->ev_cfg_chan_shift));
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1003,7 +1005,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
>  		 * bit.
>  		 * The userspace interface uses m/s^2 and we declare micro units
>  		 * So scale factor for 12 bit here is given by:
> -		 * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
> +		 *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
>  		 */
>  		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
>  		.ev_cfg = MMA8452_TRANSIENT_CFG,
> 

