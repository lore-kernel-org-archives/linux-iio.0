Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47499 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbFGPeK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 7 Jun 2015 11:34:10 -0400
Message-ID: <55746470.9000201@kernel.org>
Date: Sun, 07 Jun 2015 16:34:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: magnetometer: mmc35240: Fix broken processed
 value
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com> <1433502195-30296-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-4-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/15 12:03, Daniel Baluta wrote:
> The current computation for fractional part of the magnetic
> field is broken. This patch fixes it by taking a different
> approach. We expose the raw reading in milli Gauss (to avoid
> rounding errors) with a scale of 0.001.
> 
> Thus the final computation is done in userspace where floating
> point operation are more relaxed.
> 
> Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the togreg branch of iio.git.

Thanks
> ---
>  drivers/iio/magnetometer/mmc35240.c | 43 +++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 9d62c53..7fff38e 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -113,8 +113,9 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 333 666");
>  	.modified = 1, \
>  	.channel2 = IIO_MOD_ ## _axis, \
>  	.address = AXIS_ ## _axis, \
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> +			BIT(IIO_CHAN_INFO_SCALE), \
>  }
>  
>  static const struct iio_chan_spec mmc35240_channels[] = {
> @@ -241,9 +242,19 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
>  				3 * sizeof(__le16));
>  }
>  
> -static int mmc35240_raw_to_gauss(struct mmc35240_data *data, int index,
> -				 __le16 buf[],
> -				 int *val, int *val2)
> +/**
> + * mmc35240_raw_to_mgauss - convert raw readings to milli gauss. Also apply
> +			    compensation for output value.
> + *
> + * @data: device private data
> + * @index: axis index for which we want the conversion
> + * @buf: raw data to be converted, 2 bytes in little endian format
> + * @val: compensated output reading (unit is milli gauss)
> + *
> + * Returns: 0 in case of success, -EINVAL when @index is not valid
> + */
> +static int mmc35240_raw_to_mgauss(struct mmc35240_data *data, int index,
> +				  __le16 buf[], int *val)
>  {
>  	int raw_x, raw_y, raw_z;
>  	int sens_x, sens_y, sens_z;
> @@ -261,18 +272,15 @@ static int mmc35240_raw_to_gauss(struct mmc35240_data *data, int index,
>  
>  	switch (index) {
>  	case AXIS_X:
> -		*val = (raw_x - nfo) / sens_x;
> -		*val2 = ((raw_x - nfo) % sens_x) * 1000000;
> +		*val = (raw_x - nfo) * 1000 / sens_x;
>  		break;
>  	case AXIS_Y:
> -		*val = (raw_y - nfo) / sens_y - (raw_z - nfo) / sens_z;
> -		*val2 = (((raw_y - nfo) % sens_y - (raw_z - nfo) % sens_z))
> -			* 1000000;
> +		*val = (raw_y - nfo) * 1000 / sens_y -
> +			(raw_z - nfo)  * 1000 / sens_z;
>  		break;
>  	case AXIS_Z:
> -		*val = (raw_y - nfo) / sens_y + (raw_z - nfo) / sens_z;
> -		*val2 = (((raw_y - nfo) % sens_y + (raw_z - nfo) % sens_z))
> -			* 1000000;
> +		*val = (raw_y - nfo) * 1000 / sens_y +
> +			(raw_z - nfo) * 1000 / sens_z;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -290,16 +298,19 @@ static int mmc35240_read_raw(struct iio_dev *indio_dev,
>  	__le16 buf[3];
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_RAW:
>  		mutex_lock(&data->mutex);
>  		ret = mmc35240_read_measurement(data, buf);
>  		mutex_unlock(&data->mutex);
>  		if (ret < 0)
>  			return ret;
> -		ret = mmc35240_raw_to_gauss(data, chan->address,
> -					    buf, val, val2);
> +		ret = mmc35240_raw_to_mgauss(data, chan->address, buf, val);
>  		if (ret < 0)
>  			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = 1000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		mutex_lock(&data->mutex);
> 

