Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41464 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab3A3VXz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jan 2013 16:23:55 -0500
Message-ID: <51098F69.9090609@kernel.org>
Date: Wed, 30 Jan 2013 21:23:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: lars@metafoo.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:magn: Add sensors_supported in st_magn_sensors
References: <1359460441-19310-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1359460441-19310-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2013 11:54 AM, Denis CIOCCA wrote:
> This patch add sensors_supported struct to st_magn_sensors. Without this the probe can't match the WhoAmI and sensor name.
I've merged this into the original patch.
> ---
>  drivers/iio/magnetometer/st_magn_core.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 1dfcb41..a69fbe1 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -136,6 +136,10 @@ static const struct iio_chan_spec st_magn_2_16bit_channels[] = {
>  static const struct st_sensors st_magn_sensors[] = {
>  	{
>  		.wai = ST_MAGN_1_WAI_EXP,
> +		.sensors_supported = {
> +			[0] = LSM303DLHC_MAGN_DEV_NAME,
> +			[1] = LSM303DLM_MAGN_DEV_NAME,
> +		},
>  		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
>  		.odr = {
>  			.addr = ST_MAGN_1_ODR_ADDR,
> @@ -210,6 +214,9 @@ static const struct st_sensors st_magn_sensors[] = {
>  	},
>  	{
>  		.wai = ST_MAGN_2_WAI_EXP,
> +		.sensors_supported = {
> +			[0] = LIS3MDL_MAGN_DEV_NAME,
> +		},
>  		.ch = (struct iio_chan_spec *)st_magn_2_16bit_channels,
>  		.odr = {
>  			.addr = ST_MAGN_2_ODR_ADDR,
> 
