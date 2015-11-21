Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39599 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760899AbbKUQBu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Nov 2015 11:01:50 -0500
Subject: Re: [patch] iio: fix some warning messages
To: Dan Carpenter <dan.carpenter@oracle.com>
References: <20151121103300.GD7002@mwanda>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5650956C.2090509@kernel.org>
Date: Sat, 21 Nov 2015 16:01:48 +0000
MIME-Version: 1.0
In-Reply-To: <20151121103300.GD7002@mwanda>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/11/15 10:33, Dan Carpenter wrote:
> WARN_ON() only takes a condition argument.  I have changed these to
> WARN() instead.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Oops and good spot.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 37697d5..fe80366 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -654,7 +654,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>  			break;
>  		case IIO_SEPARATE:
>  			if (!chan->indexed) {
> -				WARN_ON("Differential channels must be indexed\n");
> +				WARN(1, "Differential channels must be indexed\n");
>  				ret = -EINVAL;
>  				goto error_free_full_postfix;
>  			}
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index d7e908a..0f6f63b 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -302,7 +302,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> -		WARN_ON("Trying to set scanmask prior to registering buffer\n");
> +		WARN(1, "Trying to set scanmask prior to registering buffer\n");
>  		goto err_invalid_mask;
>  	}
>  	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
> 

