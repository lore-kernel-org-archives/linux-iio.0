Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35770 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbcEDOhQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:37:16 -0400
Subject: Re: [PATCHv2] iio: Fix error handling in iio_trigger_attach_poll_func
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <0045891ad86e52d9b7c93ed297d060f252f69381.1462278295.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bcc2f693-5882-7ed2-5d8a-ea5bf3d1e678@kernel.org>
Date: Wed, 4 May 2016 10:13:12 +0100
MIME-Version: 1.0
In-Reply-To: <0045891ad86e52d9b7c93ed297d060f252f69381.1462278295.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/05/16 13:27, Crestez Dan Leonard wrote:
> When attaching a pollfunc iio_trigger_attach_poll_func will allocate a
> virtual irq and call the driver's set_trigger_state function. Fix error
> handling to undo previous steps if any fails.
> 
> In particular this fixes handling errors from a driver's
> set_trigger_state function. When using triggered buffers a failure to
> enable the trigger used to make the buffer unusable.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Thought hard about this but in the end marked it for stable as can be caused
by hardware issues and perhaps some configuration path I've missed in an existing
driver.

Applied to the fixes-togreg branch of iio.git (I was going to do that whatever!)

Thanks for fixing this mess up,

Jonathan
> ---
> 
> Previous version was sent as a RFC. This version also properly handles errors
> from iio_trigger_get_irq and request_threaded_irq.
> 
> Calling request_threaded_irq with a negative/invalid irq parameter might work
> and return an error but let's not rely on that.
> 
>  drivers/iio/industrialio-trigger.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ae2806a..0c52dfe 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -210,22 +210,35 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  
>  	/* Prevent the module from being removed whilst attached to a trigger */
>  	__module_get(pf->indio_dev->info->driver_module);
> +
> +	/* Get irq number */
>  	pf->irq = iio_trigger_get_irq(trig);
> +	if (pf->irq < 0)
> +		goto out_put_module;
> +
> +	/* Request irq */
>  	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
>  				   pf->type, pf->name,
>  				   pf);
> -	if (ret < 0) {
> -		module_put(pf->indio_dev->info->driver_module);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto out_put_irq;
>  
> +	/* Enable trigger in driver */
>  	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
>  		ret = trig->ops->set_trigger_state(trig, true);
>  		if (ret < 0)
> -			module_put(pf->indio_dev->info->driver_module);
> +			goto out_free_irq;
>  	}
>  
>  	return ret;
> +
> +out_free_irq:
> +	free_irq(pf->irq, pf);
> +out_put_irq:
> +	iio_trigger_put_irq(trig, pf->irq);
> +out_put_module:
> +	module_put(pf->indio_dev->info->driver_module);
> +	return ret;
>  }
>  
>  static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> 

