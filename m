Return-Path: <daniel.baluta@intel.com>
Message-ID: <562DE019.3060807@intel.com>
Date: Mon, 26 Oct 2015 10:11:05 +0200
From: Daniel Baluta <daniel.baluta@intel.com>
MIME-Version: 1.0
To: Alison Schofield <amsfield22@gmail.com>,
 outreachy-kernel@googlegroups.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: dummy: clean up the define and usage of
 dummy_scan_elements
References: <20151023165418.GA18718@Ubuntu-D830>
In-Reply-To: <20151023165418.GA18718@Ubuntu-D830>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>



On 10/23/2015 07:54 PM, Alison Schofield wrote:
> Cleanups related to the usage of dummy_scan_elements in the
> iio dummy driver:
> - change enum names to upper case INDEX_*
> - use the enum for IIO_CHAN_SOFT_TIMESTAMP (rm hard coded value)
> - comment edited to match changes & follow preferred kernel style
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
>   drivers/staging/iio/iio_simple_dummy.c        | 22 ++++++++++++----------
>   drivers/staging/iio/iio_simple_dummy.h        | 20 +++++++++++---------
>   drivers/staging/iio/iio_simple_dummy_buffer.c |  9 +++++----
>   3 files changed, 28 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 381f90f..5e19068 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
This change should be in the 3rd patch.

>    * Copyright (c) 2011 Jonathan Cameron
>    *
>    * This program is free software; you can redistribute it and/or modify it
> @@ -137,7 +137,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>   		 */
>   		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>   		/* The ordering of elements in the buffer via an enum */
> -		.scan_index = voltage0,
> +		.scan_index = INDEX_VOLTAGE_0,
>   		.scan_type = { /* Description of storage in buffer */
>   			.sign = 'u', /* unsigned */
>   			.realbits = 13, /* 13 bits */
> @@ -176,7 +176,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>   		 * sampling_frequency
>   		 * The frequency in Hz at which the channels are sampled
>   		 */
> -		.scan_index = diffvoltage1m2,
> +		.scan_index = INDEX_DIFFVOLTAGE_1M2,
>   		.scan_type = { /* Description of storage in buffer */
>   			.sign = 's', /* signed */
>   			.realbits = 12, /* 12 bits */
> @@ -194,7 +194,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>   		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>   		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>   		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.scan_index = diffvoltage3m4,
> +		.scan_index = INDEX_DIFFVOLTAGE_3M4,
>   		.scan_type = {
>   			.sign = 's',
>   			.realbits = 11,
> @@ -221,7 +221,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>   		BIT(IIO_CHAN_INFO_CALIBSCALE) |
>   		BIT(IIO_CHAN_INFO_CALIBBIAS),
>   		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> -		.scan_index = accelx,
> +		.scan_index = INDEX_ACCELX,
>   		.scan_type = { /* Description of storage in buffer */
>   			.sign = 's', /* signed */
>   			.realbits = 16, /* 16 bits */
> @@ -230,10 +230,10 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
>   		},
>   	},
>   	/*
> -	 * Convenience macro for timestamps. 4 is the index in
> -	 * the buffer.
> +	 * Convenience macro for timestamps.
> +	 * INDEX_TIMESTAMP is the index in the buffer.
>   	 */
> -	IIO_CHAN_SOFT_TIMESTAMP(4),
> +	IIO_CHAN_SOFT_TIMESTAMP(INDEX_TIMESTAMP),
>   	/* DAC channel out_voltage0_raw */
>   	{
>   		.type = IIO_VOLTAGE,
> @@ -364,8 +364,10 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
>   				ret = IIO_VAL_INT_PLUS_MICRO;
>   				break;
>   			case 1:
> -				/* all differential adc channels ->
> -				 * 0.000001344 */
> +				/*
> +				 * all differential adc
> +				 * channels -> 0.000001344
> +				 */

Also this one. Could this be a one line comment?

>   				*val = 0;
>   				*val2 = 1344;
>   				ret = IIO_VAL_INT_PLUS_NANO;
> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
> index 5c2f4d0..31b62ad 100644
> --- a/drivers/staging/iio/iio_simple_dummy.h
> +++ b/drivers/staging/iio/iio_simple_dummy.h
> @@ -96,20 +96,22 @@ iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
>
>   #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
>
> -/**
> +/*
>    * enum iio_simple_dummy_scan_elements - scan index enum
> - * @voltage0:		the single ended voltage channel
> - * @diffvoltage1m2:	first differential channel
> - * @diffvoltage3m4:	second differenial channel
> - * @accelx:		acceleration channel
> + * @INDEX_VOLTAGE_0:		the single ended voltage channel
> + * @INDEX_DIFFVOLTAGE_1M2:	first differential channel
> + * @INDEX_DIFFVOLTAGE_3M4:	second differential channel
> + * @INDEX_ACCELX:		acceleration channel
> + * @INDEX_TIMESTAMP:		timestamp channel
>    *
>    * Enum provides convenient numbering for the scan index.
>    */
>   enum iio_simple_dummy_scan_elements {
> -	voltage0,
> -	diffvoltage1m2,
> -	diffvoltage3m4,
> -	accelx,
> +	INDEX_VOLTAGE_0,
> +	INDEX_DIFFVOLTAGE_1M2,
> +	INDEX_DIFFVOLTAGE_3M4,
> +	INDEX_ACCELX,
> +	INDEX_TIMESTAMP,
>   };
>
>   #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 00ed774..7516835 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -27,10 +27,11 @@
>   /* Some fake data */
>
>   static const s16 fakedata[] = {
> -	[voltage0] = 7,
> -	[diffvoltage1m2] = -33,
> -	[diffvoltage3m4] = -2,
> -	[accelx] = 344,
> +	[INDEX_VOLTAGE_0] = 7,
> +	[INDEX_DIFFVOLTAGE_1M2] = -33,
> +	[INDEX_DIFFVOLTAGE_3M4] = -2,
> +	[INDEX_ACCELX] = 344,
> +	[INDEX_TIMESTAMP] = 50,
>   };
>
>   /**
>
