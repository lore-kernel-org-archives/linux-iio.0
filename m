Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59575 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbbGEMzP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 5 Jul 2015 08:55:15 -0400
Message-ID: <5599292F.6000205@kernel.org>
Date: Sun, 05 Jul 2015 13:55:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Teodora Baluta <teodora.baluta@intel.com>
CC: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, dan.carpenter@oracle.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: mmc35240: fix available sampling
 frequencies
References: <1435581891-1730-1-git-send-email-teodora.baluta@intel.com> <1435581891-1730-2-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1435581891-1730-2-git-send-email-teodora.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/15 13:44, Teodora Baluta wrote:
> Fix the sampling frequencies according to the datasheet (page 8). The
> datasheet specifies the following available frequencies for continuous
> mode: 1.5 Hz, 13 Hz, 25 Hz, and 50 Hz.
> 
> Also fix comments about the ODR to comply with datasheet.
> 
> Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
Applied to the fixes-for-4.2 branch of iio.git
Thanks,
> ---
>  drivers/iio/magnetometer/mmc35240.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index e89b059..36a4b53 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -84,10 +84,10 @@
>  #define MMC35240_OTP_START_ADDR		0x1B
>  
>  enum mmc35240_resolution {
> -	MMC35240_16_BITS_SLOW = 0, /* 100 Hz */
> -	MMC35240_16_BITS_FAST,     /* 200 Hz */
> -	MMC35240_14_BITS,          /* 333 Hz */
> -	MMC35240_12_BITS,          /* 666 Hz */
> +	MMC35240_16_BITS_SLOW = 0, /* 7.92 ms */
> +	MMC35240_16_BITS_FAST,     /* 4.08 ms */
> +	MMC35240_14_BITS,          /* 2.16 ms */
> +	MMC35240_12_BITS,          /* 1.20 ms */
>  };
>  
>  enum mmc35240_axis {
> @@ -100,22 +100,22 @@ static const struct {
>  	int sens[3]; /* sensitivity per X, Y, Z axis */
>  	int nfo; /* null field output */
>  } mmc35240_props_table[] = {
> -	/* 16 bits, 100Hz ODR */
> +	/* 16 bits, 125Hz ODR */
>  	{
>  		{1024, 1024, 1024},
>  		32768,
>  	},
> -	/* 16 bits, 200Hz ODR */
> +	/* 16 bits, 250Hz ODR */
>  	{
>  		{1024, 1024, 770},
>  		32768,
>  	},
> -	/* 14 bits, 333Hz ODR */
> +	/* 14 bits, 450Hz ODR */
>  	{
>  		{256, 256, 193},
>  		8192,
>  	},
> -	/* 12 bits, 666Hz ODR */
> +	/* 12 bits, 800Hz ODR */
>  	{
>  		{64, 64, 48},
>  		2048,
> @@ -133,9 +133,15 @@ struct mmc35240_data {
>  	int axis_scale[3];
>  };
>  
> -static const int mmc35240_samp_freq[] = {100, 200, 333, 666};
> +static const struct {
> +	int val;
> +	int val2;
> +} mmc35240_samp_freq[] = { {1, 500000},
> +			   {13, 0},
> +			   {25, 0},
> +			   {50, 0} };
>  
> -static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("100 200 333 666");
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.5 13 25 50");
>  
>  #define MMC35240_CHANNEL(_axis) { \
>  	.type = IIO_MAGN, \
> @@ -168,7 +174,8 @@ static int mmc35240_get_samp_freq_index(struct mmc35240_data *data,
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(mmc35240_samp_freq); i++)
> -		if (mmc35240_samp_freq[i] == val)
> +		if (mmc35240_samp_freq[i].val == val &&
> +		    mmc35240_samp_freq[i].val2 == val2)
>  			return i;
>  	return -EINVAL;
>  }
> @@ -378,9 +385,9 @@ static int mmc35240_read_raw(struct iio_dev *indio_dev,
>  		if (i < 0 || i >= ARRAY_SIZE(mmc35240_samp_freq))
>  			return -EINVAL;
>  
> -		*val = mmc35240_samp_freq[i];
> -		*val2 = 0;
> -		return IIO_VAL_INT;
> +		*val = mmc35240_samp_freq[i].val;
> +		*val2 = mmc35240_samp_freq[i].val2;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> 

