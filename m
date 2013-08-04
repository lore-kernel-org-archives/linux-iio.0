Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44369 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab3HDJKq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 05:10:46 -0400
Message-ID: <51FE28AE.8050601@kernel.org>
Date: Sun, 04 Aug 2013 11:10:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: Re: [PATCH 5/9] staging:iio:hmc5843: Device has 3 channels, no need
 to store separately
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net> <1374939112-18237-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-6-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/13 16:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
I was a little in two minds about whether the slight loss of clarity in dropping
this was worth the saving in code.  Personally I wouldn't have bothered making
the change, but as you have done it I'll take it ;)

Applied to the togreg branch of iio.git

Thanks,


> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 465dc2a..042467d 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -178,7 +178,6 @@ static const char * const hmc5883_regval_to_sample_freq[] = {
>  /* Describe chip variants */
>  struct hmc5843_chip_info {
>  	const struct iio_chan_spec *channels;
> -	int num_channels;
>  	const char * const *regval_to_sample_freq;
>  	const int *regval_to_input_field_mga;
>  	const int *regval_to_nanoscale;
> @@ -594,7 +593,6 @@ static const struct attribute_group hmc5843_group = {
>  static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
>  	[HMC5843_ID] = {
>  		.channels = hmc5843_channels,
> -		.num_channels = ARRAY_SIZE(hmc5843_channels),
>  		.regval_to_sample_freq = hmc5843_regval_to_sample_freq,
>  		.regval_to_input_field_mga =
>  			hmc5843_regval_to_input_field_mga,
> @@ -602,7 +600,6 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
>  	},
>  	[HMC5883_ID] = {
>  		.channels = hmc5883_channels,
> -		.num_channels = ARRAY_SIZE(hmc5883_channels),
>  		.regval_to_sample_freq = hmc5883_regval_to_sample_freq,
>  		.regval_to_input_field_mga =
>  			hmc5883_regval_to_input_field_mga,
> @@ -610,7 +607,6 @@ static const struct hmc5843_chip_info hmc5843_chip_info_tbl[] = {
>  	},
>  	[HMC5883L_ID] = {
>  		.channels = hmc5883_channels,
> -		.num_channels = ARRAY_SIZE(hmc5883_channels),
>  		.regval_to_sample_freq = hmc5883_regval_to_sample_freq,
>  		.regval_to_input_field_mga =
>  			hmc5883l_regval_to_input_field_mga,
> @@ -627,7 +623,7 @@ static void hmc5843_init_client(struct i2c_client *client,
>  
>  	data->variant = &hmc5843_chip_info_tbl[id->driver_data];
>  	indio_dev->channels = data->variant->channels;
> -	indio_dev->num_channels = data->variant->num_channels;
> +	indio_dev->num_channels = 3;
>  	hmc5843_set_meas_conf(client, data->meas_conf);
>  	hmc5843_set_rate(client, data->rate);
>  	hmc5843_configure(client, data->operating_mode);
> 
