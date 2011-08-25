Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57471 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab1HYP5O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 11:57:14 -0400
Message-ID: <4E5672C3.6070707@cam.ac.uk>
Date: Thu, 25 Aug 2011 17:05:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: imu: adis16400: Avoid using printk facility
References: <1314285832-26879-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314285832-26879-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/25/11 16:23, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> use dev_info() instead.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merge to iio-blue.git. Feel free to send it directly to Greg if you like though.

As an aside: I've done a fairly substantial reorganization of what was in iio-blue.git master
branch to make it more coherent for merging. Will push out shortly.

Jonathan
> ---
>  drivers/staging/iio/imu/adis16400_core.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index c1ed832..2f0d221 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -392,7 +392,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
>  		if ((prod_id & 0xF000) != st->variant->product_id)
>  			dev_warn(&indio_dev->dev, "incorrect id");
>  
> -		printk(KERN_INFO "%s: prod_id 0x%04x at CS%d (irq %d)\n",
> +		dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
>  		       indio_dev->name, prod_id,
>  		       st->us->chip_select, st->us->irq);
>  	}

