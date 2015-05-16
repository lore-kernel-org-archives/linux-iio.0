Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53021 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932289AbbEPJ7H (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 May 2015 05:59:07 -0400
Message-ID: <555714EA.1010205@kernel.org>
Date: Sat, 16 May 2015 10:59:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Paul Cercueil <paul.cercueil@analog.com>
Subject: Re: [PATCH 3/5] iio: adis16400: Compute the scan mask from channel
 indices
References: <1431703118-32676-1-git-send-email-lars@metafoo.de> <1431703118-32676-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1431703118-32676-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/05/15 16:18, Lars-Peter Clausen wrote:
> From: Paul Cercueil <paul.cercueil@analog.com>
> 
> We unfortunately can't use ~0UL for the scan mask to indicate that the
> only valid scan mask is all channels selected. The IIO core needs the exact
> mask to work correctly and not a super-set of it. So calculate the masked
> based on the channels that are available for a particular device.
> 
> Signed-off-by: Paul Cercueil <paul.cercueil@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Fixes: 5eda3550a3cc ("staging:iio:adis16400: Preallocate transfer message")
Applied to the fixes-togreg branch, marked for stable.
> ---
>  drivers/iio/imu/adis16400.h      |  1 +
>  drivers/iio/imu/adis16400_core.c | 25 ++++++++++++++++++-------
>  2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.h b/drivers/iio/imu/adis16400.h
> index 0916bf6..1e8fd2e 100644
> --- a/drivers/iio/imu/adis16400.h
> +++ b/drivers/iio/imu/adis16400.h
> @@ -165,6 +165,7 @@ struct adis16400_state {
>  	int				filt_int;
>  
>  	struct adis adis;
> +	unsigned long avail_scan_mask[2];
>  };
>  
>  /* At the moment triggers are only used for ring buffer
> diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
> index 7b63788..7b06e058 100644
> --- a/drivers/iio/imu/adis16400_core.c
> +++ b/drivers/iio/imu/adis16400_core.c
> @@ -796,11 +796,6 @@ static const struct iio_info adis16400_info = {
>  	.debugfs_reg_access = adis_debugfs_reg_access,
>  };
>  
> -static const unsigned long adis16400_burst_scan_mask[] = {
> -	~0UL,
> -	0,
> -};
> -
>  static const char * const adis16400_status_error_msgs[] = {
>  	[ADIS16400_DIAG_STAT_ZACCL_FAIL] = "Z-axis accelerometer self-test failure",
>  	[ADIS16400_DIAG_STAT_YACCL_FAIL] = "Y-axis accelerometer self-test failure",
> @@ -848,6 +843,20 @@ static const struct adis_data adis16400_data = {
>  		BIT(ADIS16400_DIAG_STAT_POWER_LOW),
>  };
>  
> +static void adis16400_setup_chan_mask(struct adis16400_state *st)
> +{
> +	const struct adis16400_chip_info *chip_info = st->variant;
> +	unsigned i;
> +
> +	for (i = 0; i < chip_info->num_channels; i++) {
> +		const struct iio_chan_spec *ch = &chip_info->channels[i];
> +
> +		if (ch->scan_index >= 0 &&
> +		    ch->scan_index != ADIS16400_SCAN_TIMESTAMP)
> +			st->avail_scan_mask[0] |= BIT(ch->scan_index);
> +	}
> +}
> +
>  static int adis16400_probe(struct spi_device *spi)
>  {
>  	struct adis16400_state *st;
> @@ -871,8 +880,10 @@ static int adis16400_probe(struct spi_device *spi)
>  	indio_dev->info = &adis16400_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	if (!(st->variant->flags & ADIS16400_NO_BURST))
> -		indio_dev->available_scan_masks = adis16400_burst_scan_mask;
> +	if (!(st->variant->flags & ADIS16400_NO_BURST)) {
> +		adis16400_setup_chan_mask(st);
> +		indio_dev->available_scan_masks = st->avail_scan_mask;
> +	}
>  
>  	ret = adis_init(&st->adis, indio_dev, spi, &adis16400_data);
>  	if (ret)
> 

