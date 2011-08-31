Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:56911 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754677Ab1HaL33 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:29:29 -0400
Message-ID: <4E5E1D07.70909@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:37:43 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 10/12] iio: ad7192: return len and fix out of range checking
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-10-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-10-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Is 4096 a valid value?  I thought we only had 12 bits (hence the 0xFFF)
That would make maximum 4095
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/adc/ad7291.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 1a2fa66..334951c 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -240,10 +240,14 @@ static inline ssize_t ad7291_set_hyst(struct device *dev,
>  
>  	if (ret < 0)
>  		return ret;
> -	if (data < 4096)
> +	if (data > AD7291_VALUE_MASK)
>  		return -EINVAL;
>  
> -	return ad7291_i2c_write(chip, this_attr->address, data);
> +	ret = ad7291_i2c_write(chip, this_attr->address, data);
> +	if (ret < 0)
> +		return ret;
> +
> +	return len;
>  }
>  
>  static IIO_DEVICE_ATTR(in_temp0_thresh_both_hyst_raw,
> @@ -351,7 +355,7 @@ static int ad7291_write_event_value(struct iio_dev *indio_dev,
>  
>  	switch (IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event_code)) {
>  	case IIO_VOLTAGE:
> -		if (val > 0xFFF || val < 0)
> +		if (val > AD7291_VALUE_MASK || val < 0)
>  			return -EINVAL;
>  		reg = ad7291_limit_regs[IIO_EVENT_CODE_EXTRACT_NUM(event_code)]
>  			[!(IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==

