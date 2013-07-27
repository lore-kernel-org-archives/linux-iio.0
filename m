Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53852 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276Ab3G0LCX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 07:02:23 -0400
Message-ID: <51F3B6D1.9000509@kernel.org>
Date: Sat, 27 Jul 2013 13:02:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/15] staging:iio:adis16260: Add scale for the inclination
 channel
References: <1374072279-7140-1-git-send-email-lars@metafoo.de> <1374072279-7140-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1374072279-7140-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/17/13 15:44, Lars-Peter Clausen wrote:
> While the inclination channel claims to support reading the scale the driver did
> not implement this, so trying to read the scale results in a -EINVAL. This patch
> fixes it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,

> ---
>  drivers/staging/iio/gyro/adis16260_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/gyro/adis16260_core.c b/drivers/staging/iio/gyro/adis16260_core.c
> index a140d73..48b0e63 100644
> --- a/drivers/staging/iio/gyro/adis16260_core.c
> +++ b/drivers/staging/iio/gyro/adis16260_core.c
> @@ -241,6 +241,10 @@ static int adis16260_read_raw(struct iio_dev *indio_dev,
>  				*val2 = IIO_DEGREE_TO_RAD(73260);
>  			}
>  			return IIO_VAL_INT_PLUS_MICRO;
> +		case IIO_INCLI:
> +			*val = 0;
> +			*val2 = IIO_DEGREE_TO_RAD(36630);
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_VOLTAGE:
>  			if (chan->channel == 0) {
>  				*val = 1;
> 
