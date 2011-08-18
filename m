Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:46145 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1HRPTv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Aug 2011 11:19:51 -0400
Message-ID: <4E4D2F7E.8090605@cam.ac.uk>
Date: Thu, 18 Aug 2011 16:27:58 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: capfun: fix inverted logic of ThrFixed
References: <1313679621-5347-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1313679621-5347-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/18/11 16:00, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Bit 7 of the AD7150 configuration register needs to be set for
> fixed threshold modes.
Oops.  Will merge with the relevant patch.


> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/adc/ad7150.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
> index 9e01614..fdf4da8 100644
> --- a/drivers/staging/iio/adc/ad7150.c
> +++ b/drivers/staging/iio/adc/ad7150.c
> @@ -349,7 +349,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
>  		goto error_ret;
>  	};
>  
> -	cfg |= (adaptive << 7) | (thresh_type << 5);
> +	cfg |= (!adaptive << 7) | (thresh_type << 5);
>  
>  	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
>  	if (ret < 0)

