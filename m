Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:51300 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846Ab1HYNhg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 09:37:36 -0400
Message-ID: <4E56520A.30708@cam.ac.uk>
Date: Thu, 25 Aug 2011 14:45:46 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: ad7152: Fix differential channel return value and
 increase delay.
References: <1314269930-5737-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314269930-5737-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/25/11 11:58, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> In differential mode zero scale equals to 0x8000.
> Increase readout delay by 1ms.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

merged to iio-blue.git
> ---
>  drivers/staging/iio/adc/ad7152.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
> index 41c3102..42efc37 100644
> --- a/drivers/staging/iio/adc/ad7152.c
> +++ b/drivers/staging/iio/adc/ad7152.c
> @@ -159,9 +159,9 @@ static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
>  static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
>  		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
>  
> -/* Values are Update Rate (Hz), Conversion Time (ms) */
> +/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
>  static const unsigned char ad7152_filter_rate_table[][2] = {
> -	{200, 5}, {50, 20}, {20, 50}, {17, 60},
> +	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
>  };
>  
>  static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
> @@ -366,6 +366,9 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
>  			goto out;
>  		*val = swab16(ret);
>  
> +		if (chan->differential)
> +			*val -= 0x8000;
> +
>  		ret = IIO_VAL_INT;
>  		break;
>  	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):

