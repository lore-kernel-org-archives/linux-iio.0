Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49359 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab2JMU14 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 13 Oct 2012 16:27:56 -0400
Message-ID: <5079CEC9.8040203@kernel.org>
Date: Sat, 13 Oct 2012 21:27:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, manuel.stahl@iis.fraunhofer.de
Subject: Re: [PATCH 3/3] staging iio: consistent commas in adis16400 channel
 spec
References: <1348999545-19099-1-git-send-email-pmeerw@pmeerw.net> <1348999545-19099-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1348999545-19099-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/30/2012 11:05 AM, Peter Meerwald wrote:
> probably not the most important patch in the world
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: manuel.stahl@iis.fraunhofer.de
Applied to togreg branch of iio.git
> ---
>  drivers/staging/iio/imu/adis16400_core.c |   10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index b302c9b..5eab327 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -622,7 +622,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16400_SCAN_SUPPLY,
> -		.scan_type = IIO_ST('u', 14, 16, 0)
> +		.scan_type = IIO_ST('u', 14, 16, 0),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
> @@ -633,7 +633,7 @@ static const struct iio_chan_spec adis16400_channels[] = {
>  		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
>  		.address = gyro_x,
>  		.scan_index = ADIS16400_SCAN_GYRO_X,
> -		.scan_type = IIO_ST('s', 14, 16, 0)
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
> @@ -752,7 +752,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16400_SCAN_SUPPLY,
> -		.scan_type = IIO_ST('u', 12, 16, 0)
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
> @@ -763,7 +763,7 @@ static const struct iio_chan_spec adis16350_channels[] = {
>  		IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY_SHARED_BIT,
>  		.address = gyro_x,
>  		.scan_index = ADIS16400_SCAN_GYRO_X,
> -		.scan_type = IIO_ST('s', 14, 16, 0)
> +		.scan_type = IIO_ST('s', 14, 16, 0),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
> @@ -877,7 +877,7 @@ static const struct iio_chan_spec adis16300_channels[] = {
>  		IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>  		.address = in_supply,
>  		.scan_index = ADIS16400_SCAN_SUPPLY,
> -		.scan_type = IIO_ST('u', 12, 16, 0)
> +		.scan_type = IIO_ST('u', 12, 16, 0),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.modified = 1,
> 
