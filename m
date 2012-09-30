Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47101 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751201Ab2I3Kfk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 30 Sep 2012 06:35:40 -0400
Message-ID: <50682076.7040306@kernel.org>
Date: Sun, 30 Sep 2012 11:35:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, 21cnbao@gmail.com,
	hennerich@blackfin.uclinux.org, marex@denx.de, lars@metafoo.de
Subject: Re: [PATCH 2/3] iio staging: make use of IIO_ST macro where easily
 possible
References: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net> <1348999545-19099-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348999545-19099-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/30/2012 11:05 AM, Peter Meerwald wrote:
> saves a couple of lines for each .scan_type specification
Hi Peter,

Sorry to say I'm against this patch as I would rather
like to get rid of the IIO_ST macro entirely (pushing any
such macros down into the drivers where relevant).

The reason is precisely what you have been dealing with in
your IIO_ST_BE patch. However thoroughly we specify a macro
like this the chances of needing to extend it to cover new
elements of the structure is extremely high.  When that
happens we either end up with lots of variants of the macro
like your IIO_ST_BE version or we end up having to add the
additional parameters to every instance of the macro whether
or not it matters for a particular driver.

The same thing happened with the macros for iio_chan
(despite Arnd and others warning me it was a bad idea to have
them) and we eventually had a huge set of patches ripping the
macro out of all the drivers.

Also, we ideally want to push the endian conversions out of
some of these drivers and leave it up to userspace so as to
cut down on the load when it doesn't need to be done at capture
time (logging typically).

The only reason I haven't ripped out IIO_ST already was that
it was small and I was planning at some quiet moment to do the
removal of unwanted endian conversions from within the drivers.

Curriously, such a quiet time hasn't occured for rather a long time!

Sorry,

Jonathan

> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: 21cnbao@gmail.com
> Cc: jic23@kernel.org
> Cc: hennerich@blackfin.uclinux.org
> Cc: marex@denx.de
> Cc: lars@metafoo.de
> ---
>  drivers/staging/iio/accel/adis16201_core.c      |   42 ++---------
>  drivers/staging/iio/accel/adis16203_core.c      |   30 ++------
>  drivers/staging/iio/accel/adis16204_core.c      |   36 ++-------
>  drivers/staging/iio/accel/adis16209_core.c      |   48 ++----------
>  drivers/staging/iio/accel/adis16240_core.c      |   36 ++-------
>  drivers/staging/iio/accel/lis3l02dq_core.c      |    6 +-
>  drivers/staging/iio/accel/sca3000_core.c        |    7 +-
>  drivers/staging/iio/adc/ad7298_core.c           |   12 +--
>  drivers/staging/iio/adc/max1363_core.c          |   14 +---
>  drivers/staging/iio/adc/mxs-lradc.c             |    6 +-
>  drivers/staging/iio/gyro/adis16260_core.c       |   30 ++------
>  drivers/staging/iio/iio_simple_dummy.c          |    8 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c |   18 +----
>  drivers/staging/iio/meter/ade7758_core.c        |   90 ++++-------------------
>  include/linux/iio/adc/ad_sigma_delta.h          |    8 +-
>  15 files changed, 65 insertions(+), 326 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
> index 8e37d6e..ad52d97 100644
> --- a/drivers/staging/iio/accel/adis16201_core.c
> +++ b/drivers/staging/iio/accel/adis16201_core.c
> @@ -400,11 +400,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16201_SCAN_SUPPLY,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 1,
> @@ -414,11 +410,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16201_SCAN_TEMP,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -428,11 +420,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = accel_x,
>  		.scan_index = ADIS16201_SCAN_ACC_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -442,11 +430,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = accel_y,
>  		.scan_index = ADIS16201_SCAN_ACC_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -455,11 +439,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_aux,
>  		.scan_index = ADIS16201_SCAN_AUX_ADC,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -469,11 +449,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = incli_x,
>  		.scan_index = ADIS16201_SCAN_INCLI_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -483,11 +459,7 @@ static const struct iio_chan_spec adis16201_channels[] = {
>  		 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = incli_y,
>  		.scan_index = ADIS16201_SCAN_INCLI_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(7)
>  };
> diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
> index 002fa9d..27663dc 100644
> --- a/drivers/staging/iio/accel/adis16203_core.c
> +++ b/drivers/staging/iio/accel/adis16203_core.c
> @@ -365,11 +365,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16203_SCAN_SUPPLY,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -378,11 +374,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_aux,
>  		.scan_index = ADIS16203_SCAN_AUX_ADC,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -392,11 +384,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = incli_x,
>  		.scan_index = ADIS16203_SCAN_INCLI_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, { /* Fixme: Not what it appears to be - see data sheet */
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -405,11 +393,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = incli_y,
>  		.scan_index = ADIS16203_SCAN_INCLI_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 1,
> @@ -419,11 +403,7 @@ static const struct iio_chan_spec adis16203_channels[] = {
>  		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16203_SCAN_TEMP,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(5),
>  };
> diff --git a/drivers/staging/iio/accel/adis16204_core.c b/drivers/staging/iio/accel/adis16204_core.c
> index 05bdb7c..8b6e028 100644
> --- a/drivers/staging/iio/accel/adis16204_core.c
> +++ b/drivers/staging/iio/accel/adis16204_core.c
> @@ -407,11 +407,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16204_SCAN_SUPPLY,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -420,11 +416,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_aux,
>  		.scan_index = ADIS16204_SCAN_AUX_ADC,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 1,
> @@ -434,11 +426,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16204_SCAN_TEMP,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -449,11 +437,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_x,
>  		.scan_index = ADIS16204_SCAN_ACC_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -464,11 +448,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_y,
>  		.scan_index = ADIS16204_SCAN_ACC_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(5),
>  	{
> @@ -479,11 +459,7 @@ static const struct iio_chan_spec adis16204_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_xy,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 14, 16, 0),
>  	}
>  };
>  
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index b7333bf..e4abb48 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> @@ -400,11 +400,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16209_SCAN_SUPPLY,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 14, 16, 0),
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 0,
> @@ -414,11 +410,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16209_SCAN_TEMP,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -428,11 +420,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = accel_x,
>  		.scan_index = ADIS16209_SCAN_ACC_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -442,11 +430,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
>  		.address = accel_y,
>  		.scan_index = ADIS16209_SCAN_ACC_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -455,11 +439,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_aux,
>  		.scan_index = ADIS16209_SCAN_AUX_ADC,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 12,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -468,11 +448,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = incli_x,
>  		.scan_index = ADIS16209_SCAN_INCLI_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_INCLI,
>  		.modified = 1,
> @@ -481,11 +457,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = incli_y,
>  		.scan_index = ADIS16209_SCAN_INCLI_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ROT,
>  		.modified = 1,
> @@ -493,11 +465,7 @@ static const struct iio_chan_spec adis16209_channels[] = {
>  		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
>  		.address = rot,
>  		.scan_index = ADIS16209_SCAN_ROT,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(8)
>  };
> diff --git a/drivers/staging/iio/accel/adis16240_core.c b/drivers/staging/iio/accel/adis16240_core.c
> index 0fc26a4..f1c7242 100644
> --- a/drivers/staging/iio/accel/adis16240_core.c
> +++ b/drivers/staging/iio/accel/adis16240_core.c
> @@ -458,11 +458,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16240_SCAN_SUPPLY,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 10, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -470,11 +466,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
>  		.address = in_aux,
>  		.scan_index = ADIS16240_SCAN_AUX_ADC,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 10, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -485,11 +477,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_x,
>  		.scan_index = ADIS16240_SCAN_ACC_X,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 10, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -500,11 +488,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_y,
>  		.scan_index = ADIS16240_SCAN_ACC_Y,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 10, 16, 0),
>  	}, {
>  		.type = IIO_ACCEL,
>  		.modified = 1,
> @@ -515,11 +499,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>  		.address = accel_z,
>  		.scan_index = ADIS16240_SCAN_ACC_Z,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 10, 16, 0),
>  	}, {
>  		.type = IIO_TEMP,
>  		.indexed = 1,
> @@ -528,11 +508,7 @@ static const struct iio_chan_spec adis16240_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16240_SCAN_TEMP,
> -		.scan_type = {
> -			.sign = 'u',
> -			.realbits = 10,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('u', 10, 16, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(6)
>  };
> diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
> index 21b0469..12b0ae0 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_core.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_core.c
> @@ -530,11 +530,7 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
>  		.info_mask =  LIS3L02DQ_INFO_MASK,		\
>  		.address = index,				\
>  		.scan_index = index,				\
> -		.scan_type = {					\
> -			.sign = 's',				\
> -			.realbits = 12,				\
> -			.storagebits = 16,			\
> -		},						\
> +		.scan_type = IIO_ST('s', 12, 16, 0),		\
>  		.event_mask = LIS3L02DQ_EVENT_MASK,		\
>  	 }
>  
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index ffd1697..e8093ea 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -441,12 +441,7 @@ static IIO_DEVICE_ATTR(revision, S_IRUGO, sca3000_show_rev, NULL, 0);
>  		.info_mask = SCA3000_INFO_MASK,			\
>  		.address = index,				\
>  		.scan_index = index,				\
> -		.scan_type = {					\
> -			.sign = 's',				\
> -			.realbits = 11,				\
> -			.storagebits = 16,			\
> -			.shift = 5,				\
> -		},						\
> +		.scan_type = IIO_ST('s', 11, 16, 5),		\
>  		.event_mask = SCA3000_EVENT_MASK,		\
>  	 }
>  
> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
> index 4c75114..ac0b344 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c
> +++ b/drivers/staging/iio/adc/ad7298_core.c
> @@ -31,11 +31,7 @@
>  		IIO_CHAN_INFO_SCALE_SHARED_BIT,				\
>  		.address = index,					\
>  		.scan_index = index,					\
> -		.scan_type = {						\
> -			.sign = 'u',					\
> -			.realbits = 12,					\
> -			.storagebits = 16,				\
> -		},							\
> +		.scan_type = IIO_ST('u', 12, 16, 0),			\
>  	}
>  
>  static const struct iio_chan_spec ad7298_channels[] = {
> @@ -47,11 +43,7 @@ static const struct iio_chan_spec ad7298_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = AD7298_CH_TEMP,
>  		.scan_index = -1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 32,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 32, 32, 0),
>  	},
>  	AD7298_V_CHAN(0),
>  	AD7298_V_CHAN(1),
> diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
> index d7b4ffc..07b9623 100644
> --- a/drivers/staging/iio/adc/max1363_core.c
> +++ b/drivers/staging/iio/adc/max1363_core.c
> @@ -292,12 +292,7 @@ static const enum max1363_modes max1363_mode_list[] = {
>  		.address = addr,					\
>  		.info_mask = MAX1363_INFO_MASK,				\
>  		.datasheet_name = "AIN"#num,				\
> -		.scan_type = {						\
> -			.sign = 'u',					\
> -			.realbits = bits,				\
> -			.storagebits = (bits > 8) ? 16 : 8,		\
> -			.endianness = IIO_BE,				\
> -		},							\
> +		.scan_type = IIO_ST_BE('u', bits, (bits > 8) ? 16 : 8, 0), \
>  		.scan_index = si,					\
>  		.event_mask = evmask,					\
>  	}
> @@ -313,12 +308,7 @@ static const enum max1363_modes max1363_mode_list[] = {
>  		.address = addr,					\
>  		.info_mask = MAX1363_INFO_MASK,				\
>  		.datasheet_name = "AIN"#num"-AIN"#num2,			\
> -		.scan_type = {						\
> -			.sign = 's',					\
> -			.realbits = bits,				\
> -			.storagebits = (bits > 8) ? 16 : 8,		\
> -			.endianness = IIO_BE,				\
> -		},							\
> +		.scan_type = IIO_ST_BE('s', bits, (bits > 8) ? 16 : 8, 0), \
>  		.scan_index = si,					\
>  		.event_mask = evmask,					\
>  	}
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index ca7c1fa..3b43b56 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -414,11 +414,7 @@ static const struct iio_buffer_setup_ops mxs_lradc_buffer_ops = {
>  	.scan_index = (idx),					\
>  	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,		\
>  	.channel = (idx),					\
> -	.scan_type = {						\
> -		.sign = 'u',					\
> -		.realbits = 18,					\
> -		.storagebits = 32,				\
> -	},							\
> +	.scan_type = IIO_ST('u', 18, 32, 0),			\
>  }
>  
>  static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index 9571c03..04e83e4 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -383,11 +383,7 @@ enum adis16260_channel {
>  			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
>  			.address = gyro,				\
>  			.scan_index = ADIS16260_SCAN_GYRO,		\
> -			.scan_type = {					\
> -				.sign = 's',				\
> -				.realbits = 14,				\
> -				.storagebits = 16,			\
> -			},						\
> +			.scan_type = IIO_ST('s', 14, 16, 0),		\
>  		}, {							\
>  			.type = IIO_ANGL,				\
>  			.modified = 1,					\
> @@ -395,11 +391,7 @@ enum adis16260_channel {
>  			.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
>  			.address = angle,				\
>  			.scan_index = ADIS16260_SCAN_ANGL,		\
> -			.scan_type = {					\
> -				.sign = 'u',				\
> -				.realbits = 14,				\
> -				.storagebits = 16,			\
> -			},						\
> +			.scan_type = IIO_ST('u', 14, 16, 0),		\
>  		}, {							\
>  			.type = IIO_TEMP,				\
>  			.indexed = 1,					\
> @@ -409,11 +401,7 @@ enum adis16260_channel {
>  			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
>  			.address = temp,				\
>  			.scan_index = ADIS16260_SCAN_TEMP,		\
> -			.scan_type = {					\
> -				.sign = 'u',				\
> -				.realbits = 12,				\
> -				.storagebits = 16,			\
> -			},						\
> +			.scan_type = IIO_ST('u', 12, 16, 0),		\
>  		}, {							\
>  			.type = IIO_VOLTAGE,				\
>  			.indexed = 1,					\
> @@ -423,11 +411,7 @@ enum adis16260_channel {
>  			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
>  			.address = in_supply,				\
>  			.scan_index = ADIS16260_SCAN_SUPPLY,		\
> -			.scan_type = {					\
> -				.sign = 'u',				\
> -				.realbits = 12,				\
> -				.storagebits = 16,			\
> -			},						\
> +			.scan_type = IIO_ST('u', 12, 16, 0),		\
>  		}, {							\
>  			.type = IIO_VOLTAGE,				\
>  			.indexed = 1,					\
> @@ -436,11 +420,7 @@ enum adis16260_channel {
>  			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,		\
>  			.address = in_aux,				\
>  			.scan_index = ADIS16260_SCAN_AUX_ADC,		\
> -			.scan_type = {					\
> -				.sign = 'u',				\
> -				.realbits = 12,				\
> -				.storagebits = 16,			\
> -			},						\
> +			.scan_type = IIO_ST('u', 12, 16, 0),		\
>  		},							\
>  		IIO_CHAN_SOFT_TIMESTAMP(5),				\
>  	}
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index dc6c728..6d38685 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -150,12 +150,8 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>  		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>  		IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.scan_index = diffvoltage3m4,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 11,
> -			.storagebits = 16,
> -			.shift = 0,
> -		},
> +		.scan_type = /* use IIO_ST macro for brevity */
> +			IIO_ST('s', 11, 16, 0),
>  	},
>  	/*
>  	 * 'modified' (i.e. axis specified) acceleration channel
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index de21d47..441430f 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -115,11 +115,7 @@ static const struct iio_chan_spec ad5933_channels[] = {
>  		.channel = 0,
>  		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT,
>  		.address = AD5933_REG_TEMP_DATA,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 14,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, { /* Ring Channels */
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -129,11 +125,7 @@ static const struct iio_chan_spec ad5933_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = AD5933_REG_REAL_DATA,
>  		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 16, 16, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -143,11 +135,7 @@ static const struct iio_chan_spec ad5933_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = AD5933_REG_IMAG_DATA,
>  		.scan_index = 1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 16,
> -			.storagebits = 16,
> -		},
> +		.scan_type = IIO_ST('s', 16, 16, 0),
>  	},
>  };
>  
> diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
> index a0fef77..c465a7a 100644
> --- a/drivers/staging/iio/meter/ade7758_core.c
> +++ b/drivers/staging/iio/meter/ade7758_core.c
> @@ -671,11 +671,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_VOLTAGE),
>  		.scan_index = 0,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
> @@ -685,11 +681,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_CURRENT),
>  		.scan_index = 1,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -699,11 +691,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_APP_PWR),
>  		.scan_index = 2,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -713,11 +701,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_ACT_PWR),
>  		.scan_index = 3,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -727,11 +711,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_A, AD7758_REACT_PWR),
>  		.scan_index = 4,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -741,11 +721,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_VOLTAGE),
>  		.scan_index = 5,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
> @@ -755,11 +731,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_CURRENT),
>  		.scan_index = 6,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -769,11 +741,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_APP_PWR),
>  		.scan_index = 7,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -783,11 +751,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_ACT_PWR),
>  		.scan_index = 8,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -797,11 +761,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_B, AD7758_REACT_PWR),
>  		.scan_index = 9,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_VOLTAGE,
>  		.indexed = 1,
> @@ -811,11 +771,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_VOLTAGE),
>  		.scan_index = 10,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_CURRENT,
>  		.indexed = 1,
> @@ -825,11 +781,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_CURRENT),
>  		.scan_index = 11,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -839,11 +791,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_APP_PWR),
>  		.scan_index = 12,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -853,11 +801,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_ACT_PWR),
>  		.scan_index = 13,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	}, {
>  		.type = IIO_POWER,
>  		.indexed = 1,
> @@ -867,11 +811,7 @@ static const struct iio_chan_spec ade7758_channels[] = {
>  			     IIO_CHAN_INFO_SCALE_SHARED_BIT,
>  		.address = AD7758_WT(AD7758_PHASE_C, AD7758_REACT_PWR),
>  		.scan_index = 14,
> -		.scan_type = {
> -			.sign = 's',
> -			.realbits = 24,
> -			.storagebits = 32,
> -		},
> +		.scan_type = IIO_ST('s', 24, 32, 0),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(15),
>  };
> diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
> index 2e4eab9..a57f819 100644
> --- a/include/linux/iio/adc/ad_sigma_delta.h
> +++ b/include/linux/iio/adc/ad_sigma_delta.h
> @@ -137,13 +137,7 @@ int ad_sd_validate_trigger(struct iio_dev *indio_dev, struct iio_trigger *trig);
>  			IIO_CHAN_INFO_SCALE_SHARED_BIT | \
>  			IIO_CHAN_INFO_OFFSET_SEPARATE_BIT, \
>  		.scan_index = (_si), \
> -		.scan_type = { \
> -			.sign = 'u', \
> -			.realbits = (_bits), \
> -			.storagebits = (_storagebits), \
> -			.shift = (_shift), \
> -			.endianness = IIO_BE, \
> -		}, \
> +		.scan_type = IIO_ST_BE('u', _bits, _storagebits, _shift), \
>  	}
>  
>  #define AD_SD_DIFF_CHANNEL(_si, _channel1, _channel2, _address, _bits, \
> 
