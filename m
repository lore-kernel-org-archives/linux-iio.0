Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36248 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab1JFLBr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Oct 2011 07:01:47 -0400
Message-ID: <4E8D8C8A.1000309@cam.ac.uk>
Date: Thu, 06 Oct 2011 12:10:02 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Frysinger <vapier@gentoo.org>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org
Subject: Re: [patch] Staging: iio/adc/ad7150: release lock on error
References: <20111006061700.GC14701@elgon.mountain>
In-Reply-To: <20111006061700.GC14701@elgon.mountain>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/11 07:17, Dan Carpenter wrote:
> The error_ret label should have been before the mutex_unlock().  It's
> a typo.
Good catch thanks!
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
> index 8943420..d1767d8 100644
> --- a/drivers/staging/iio/adc/ad7150.c
> +++ b/drivers/staging/iio/adc/ad7150.c
> @@ -332,8 +332,8 @@ static int ad7150_write_event_value(struct iio_dev *indio_dev,
>  	/* write back if active */
>  	ret = ad7150_write_event_params(indio_dev, event_code);
>  
> -	mutex_unlock(&chip->state_lock);
>  error_ret:
> +	mutex_unlock(&chip->state_lock);
>  	return ret;
>  }
>  
> 

