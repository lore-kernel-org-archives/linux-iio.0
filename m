Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753218AbeCQUvS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Mar 2018 16:51:18 -0400
Date: Sat, 17 Mar 2018 20:51:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: ad7780: remove IIO_CHAN_INFO_SAMP_FREQ
 support
Message-ID: <20180317205112.3aa4cdc6@archlinux>
In-Reply-To: <20180312154815.24950-1-alexandru.ardelean@analog.com>
References: <20180312154815.24950-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 12 Mar 2018 17:48:15 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> The `ad7780` driver does not implement setting/getting the sampling
> frequency.
> For the ad7780/ad7781 devices, the control is done via an external pin,
> and the ad7170/ad7171 devices have a fixed sampling rate (so, no control).
> 
> For these devices, and similar other that may be added later on,
> a AD_SD_CHANNEL_NO_SAMPLE_FREQ() macro has been added, which doesn't set
> the IIO_CHAN_INFO_SAMP_FREQ flag.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Makes sense,

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7780.c       |  2 +-
>  include/linux/iio/adc/ad_sigma_delta.h | 24 +++++++++++++++++-------
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index a7797af579b9..16d72072c076 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -128,7 +128,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  };
>  
>  #define AD7780_CHANNEL(bits, wordsize) \
> -	AD_SD_CHANNEL(1, 0, 0, bits, 32, wordsize - bits)
> +	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
>  
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7170] = {
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 1fc7abd28b0b..730ead1a46df 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -127,7 +127,7 @@ void ad_sd_cleanup_buffer_and_trigger(struct iio_dev *indio_dev);
>  int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  
>  #define __AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -	_storagebits, _shift, _extend_name, _type) \
> +	_storagebits, _shift, _extend_name, _type, _mask_all) \
>  	{ \
>  		.type = (_type), \
>  		.differential = (_channel2 == -1 ? 0 : 1), \
> @@ -139,7 +139,7 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
>  			BIT(IIO_CHAN_INFO_OFFSET), \
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_all = _mask_all, \
>  		.scan_index = (_si), \
>  		.scan_type = { \
>  			.sign = 'u', \
> @@ -153,25 +153,35 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  #define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
>  	_storagebits, _shift) \
>  	__AD_SD_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_VOLTAGE)
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD_SD_SHORTED_CHANNEL(_si, _channel, _address, _bits, \
>  	_storagebits, _shift) \
>  	__AD_SD_CHANNEL(_si, _channel, _channel, _address, _bits, \
> -		_storagebits, _shift, "shorted", IIO_VOLTAGE)
> +		_storagebits, _shift, "shorted", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD_SD_CHANNEL(_si, _channel, _address, _bits, \
>  	_storagebits, _shift) \
>  	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_VOLTAGE)
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, \
> +		 BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +
> +#define AD_SD_CHANNEL_NO_SAMP_FREQ(_si, _channel, _address, _bits, \
> +	_storagebits, _shift) \
> +	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> +		_storagebits, _shift, NULL, IIO_VOLTAGE, 0)
>  
>  #define AD_SD_TEMP_CHANNEL(_si, _address, _bits, _storagebits, _shift) \
>  	__AD_SD_CHANNEL(_si, 0, -1, _address, _bits, \
> -		_storagebits, _shift, NULL, IIO_TEMP)
> +		_storagebits, _shift, NULL, IIO_TEMP, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #define AD_SD_SUPPLY_CHANNEL(_si, _channel, _address, _bits, _storagebits, \
>  	_shift) \
>  	__AD_SD_CHANNEL(_si, _channel, -1, _address, _bits, \
> -		_storagebits, _shift, "supply", IIO_VOLTAGE)
> +		_storagebits, _shift, "supply", IIO_VOLTAGE, \
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ))
>  
>  #endif

