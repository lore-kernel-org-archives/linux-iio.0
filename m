Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-30.csi.cam.ac.uk ([131.111.8.130]:57833 "EHLO
	ppsw-30.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab0IDP4z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 4 Sep 2010 11:56:55 -0400
Message-ID: <4C826D71.7050405@cam.ac.uk>
Date: Sat, 04 Sep 2010 17:01:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Shubhrajyoti D <shubhrajyoti@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: hmc5843 : trivial changes to the way scale is reported
References: <1283508448-19664-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1283508448-19664-1-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/10 11:07, Shubhrajyoti D wrote:
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Thanks.
Please forward to Greg KH <greg@kroah.com>
(or I can add it to my next series if you prefer.)

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 66aab5a..b35b443 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -465,7 +465,7 @@ static ssize_t show_scale(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hmc5843_data *data = indio_dev->dev_data;
> -	return strlen(strcpy(buf, regval_to_scale[data->range]));
> +	return sprintf(buf, "%s\n", regval_to_scale[data->range]);
>  }
>  static IIO_DEVICE_ATTR(magn_scale,
>  			S_IRUGO,

