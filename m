Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48837 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbcEAV0Z (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2016 17:26:25 -0400
Subject: Re: [RFC] iio: Release irq if set_trigger_state fails
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <28d5b780aa8bd065492e0be1aa2f5c59a0cc0e16.1461861330.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <202d0c23-c592-c891-a1aa-61b4a264c829@kernel.org>
Date: Sun, 1 May 2016 20:11:02 +0100
MIME-Version: 1.0
In-Reply-To: <28d5b780aa8bd065492e0be1aa2f5c59a0cc0e16.1461861330.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/16 17:40, Crestez Dan Leonard wrote:
> When attaching a pollfunc iio_trigger_attach_poll_func will allocate a
> virtual irq and call the driver's set_trigger_state function. Fix error
> handling to release the irq if set_trigger_state fails.
> 
> Otherwise when using triggered buffers and the driver's
> set_trigger_state fails once then the buffer becomes unusable.
> 
> It is not possible to handle this sort of error by calling
> iio_trigger_detach_poll_func externally somehow. That function should
> only be called if attach is successful.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
I'm embarrassed :(  good find! Not sure why you made such an obvious
bug fix an RFC though! 

Slight issue in the new error handling though I think..

Jonathan
> ---
> 
> I ran into this while adding some validation in driver's set_trigger_state
> function. It's much better to use buffer_ops->predisable for that kind of stuff
> but the iio core should still handle set_trigger_state errors correctly.
> 
>  drivers/iio/industrialio-trigger.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index ae2806a..cf2be3e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -214,18 +214,23 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  	ret = request_threaded_irq(pf->irq, pf->h, pf->thread,
>  				   pf->type, pf->name,
>  				   pf);
> -	if (ret < 0) {
> -		module_put(pf->indio_dev->info->driver_module);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		goto out_put_module;
>  
>  	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
>  		ret = trig->ops->set_trigger_state(trig, true);
>  		if (ret < 0)
> -			module_put(pf->indio_dev->info->driver_module);
> +			goto out_put_irq;
>  	}
>  
>  	return ret;
> +
> +out_put_irq:
> +	iio_trigger_put_irq(trig, pf->irq);
> +	free_irq(pf->irq, pf);
> +out_put_module:
I think the iio_trigger_put_irq should be here as it will have been gotten before the 
request_threaded_irq call and hence should always be unwound on error not just in the
case above.
> +	module_put(pf->indio_dev->info->driver_module);
> +	return ret;
>  }
>  
>  static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
> 

