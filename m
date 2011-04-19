Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57420 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab1DSK4F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Apr 2011 06:56:05 -0400
Message-ID: <4DAD6ABB.8070407@cam.ac.uk>
Date: Tue, 19 Apr 2011 11:58:03 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO-onwards: ADC: free pollfunc->name on remove
References: <1303197557-32421-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1303197557-32421-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/19/11 08:19, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> 
Thanks, will merge fixes into the patches that introduced the bug.

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/adc/ad7476_ring.c  |    2 +-
>  drivers/staging/iio/adc/max1363_ring.c |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7476_ring.c b/drivers/staging/iio/adc/ad7476_ring.c
> index b6da824..de6006b 100644
> --- a/drivers/staging/iio/adc/ad7476_ring.c
> +++ b/drivers/staging/iio/adc/ad7476_ring.c
> @@ -109,7 +109,6 @@ done:
>  	return IRQ_HANDLED;
>  }
>  
> - 
>  static struct iio_ring_setup_ops ad7476_ring_setup_ops = {
>  	.preenable = &ad7476_ring_preenable,
>  	.postenable = &iio_triggered_ring_postenable,
> @@ -168,6 +167,7 @@ void ad7476_ring_cleanup(struct iio_dev *indio_dev)
>  		iio_trigger_dettach_poll_func(indio_dev->trig,
>  					      indio_dev->pollfunc);
>  	}
> +	kfree(indio_dev->pollfunc->name);
>  	kfree(indio_dev->pollfunc);
>  	iio_sw_rb_free(indio_dev->ring);
>  }
> diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
> index b8054be..da6b4f6 100644
> --- a/drivers/staging/iio/adc/max1363_ring.c
> +++ b/drivers/staging/iio/adc/max1363_ring.c
> @@ -210,6 +210,7 @@ void max1363_ring_cleanup(struct iio_dev *indio_dev)
>  		iio_trigger_dettach_poll_func(indio_dev->trig,
>  					      indio_dev->pollfunc);
>  	}
> +	kfree(indio_dev->pollfunc->name);
>  	kfree(indio_dev->pollfunc);
>  	iio_sw_rb_free(indio_dev->ring);
>  }

