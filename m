Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53623 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935413AbcJVREn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:04:43 -0400
Subject: Re: [PATCH 11/13] staging:iio:ad7606: Run trigger handler only once
 per trigger event
To: Lars-Peter Clausen <lars@metafoo.de>
References: <1476896828-10544-1-git-send-email-lars@metafoo.de>
 <1476896828-10544-12-git-send-email-lars@metafoo.de>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <0f17069b-d5c7-7247-2af6-662f84e150cc@kernel.org>
Date: Sat, 22 Oct 2016 18:04:41 +0100
MIME-Version: 1.0
In-Reply-To: <1476896828-10544-12-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 18:07, Lars-Peter Clausen wrote:
> Currently the ad7606 driver installs the same function for the hard-irq and
> threaded trigger handlers. This was introduced in commit 1caf7cb46135
> ("staging:iio:adc:ad7606 Convert to new channel registration method Update
> Add missing call to iio_trigger_notify_done() Set pollfunc top and bottom
> half handler"). Unfortunately the commit message does not mention why this
> was done and Michael does not remember either.
> 
> Since the trigger handler function is idempotent (set a GPIO to 1) running
> it twice does not do any harm, but is simply not necessary either. So set
> the threaded trigger handler for the driver to NULL.
> 
> While we are at it also remove the function description comment that does
> no say anything that can't be derived from the function name itself.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.  Thanks.

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_ring.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index b7bf0cf..81e4a0ac 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -18,11 +18,7 @@
>  
>  #include "ad7606.h"
>  
> -/**
> - * ad7606_trigger_handler_th() th/bh of trigger launched polling to ring buffer
> - *
> - **/
> -static irqreturn_t ad7606_trigger_handler_th_bh(int irq, void *p)
> +static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct ad7606_state *st = iio_priv(pf->indio_dev);
> @@ -63,9 +59,8 @@ int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>  
>  	INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
>  
> -	return iio_triggered_buffer_setup(indio_dev,
> -		&ad7606_trigger_handler_th_bh, &ad7606_trigger_handler_th_bh,
> -		NULL);
> +	return iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> +					  NULL, NULL);
>  }
>  
>  void ad7606_ring_cleanup(struct iio_dev *indio_dev)
> 

