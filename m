Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35833 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974AbbFAVRG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:17:06 -0400
Message-ID: <556C3247.90802@kernel.org>
Date: Mon, 01 Jun 2015 11:21:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>,
	sudipm.mukherjee@gmail.com, daniel.baluta@intel.com,
	dan.carpenter@oracle.com, gregkh@linuxfoundation.org
CC: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] staging: iio_simple_dummy: fix return types
References: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com> <1432974017-24547-3-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432974017-24547-3-git-send-email-rodriguez.twister@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/05/15 09:20, Vladimirs Ambrosovs wrote:
> The functions iio_dummy_remove(), iio_simple_dummy_events_unregister() and
> iio_dummy_evgen_release_irq() were changed to return void instead of int.
> 
> Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
applied as per previous patch.
> ---
>  drivers/staging/iio/iio_dummy_evgen.c         |  4 +---
>  drivers/staging/iio/iio_dummy_evgen.h         |  2 +-
>  drivers/staging/iio/iio_simple_dummy.c        | 10 ++--------
>  drivers/staging/iio/iio_simple_dummy.h        |  8 +++-----
>  drivers/staging/iio/iio_simple_dummy_events.c |  4 +---
>  5 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_dummy_evgen.c b/drivers/staging/iio/iio_dummy_evgen.c
> index 0c9c86d..c54d5b5 100644
> --- a/drivers/staging/iio/iio_dummy_evgen.c
> +++ b/drivers/staging/iio/iio_dummy_evgen.c
> @@ -128,13 +128,11 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
>   *
>   * Used by client driver instances to give the irqs back when they disconnect
>   */
> -int iio_dummy_evgen_release_irq(int irq)
> +void iio_dummy_evgen_release_irq(int irq)
>  {
>  	mutex_lock(&iio_evgen->lock);
>  	iio_evgen->inuse[irq - iio_evgen->base] = false;
>  	mutex_unlock(&iio_evgen->lock);
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_GPL(iio_dummy_evgen_release_irq);
>  
> diff --git a/drivers/staging/iio/iio_dummy_evgen.h b/drivers/staging/iio/iio_dummy_evgen.h
> index 2ac293a..d044b94 100644
> --- a/drivers/staging/iio/iio_dummy_evgen.h
> +++ b/drivers/staging/iio/iio_dummy_evgen.h
> @@ -8,6 +8,6 @@ struct iio_dummy_regs {
>  
>  struct iio_dummy_regs *iio_dummy_evgen_get_regs(int irq);
>  int iio_dummy_evgen_get_irq(void);
> -int iio_dummy_evgen_release_irq(int irq);
> +void iio_dummy_evgen_release_irq(int irq);
>  
>  #endif /* _IIO_DUMMY_EVGEN_H_ */
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index d0a9963..dc9482c7 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -665,9 +665,8 @@ error_ret:
>   *
>   * Parameters follow those of iio_dummy_probe for buses.
>   */
> -static int iio_dummy_remove(int index)
> +static void iio_dummy_remove(int index)
>  {
> -	int ret;
>  	/*
>  	 * Get a pointer to the device instance iio_dev structure
>  	 * from the bus subsystem. E.g.
> @@ -685,15 +684,10 @@ static int iio_dummy_remove(int index)
>  	/* Buffered capture related cleanup */
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  
> -	ret = iio_simple_dummy_events_unregister(indio_dev);
> -	if (ret)
> -		goto error_ret;
> +	iio_simple_dummy_events_unregister(indio_dev);
>  
>  	/* Free all structures */
>  	iio_device_free(indio_dev);
> -
> -error_ret:
> -	return ret;
>  }
>  
>  /**
> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
> index d86ccb7..e877a99 100644
> --- a/drivers/staging/iio/iio_simple_dummy.h
> +++ b/drivers/staging/iio/iio_simple_dummy.h
> @@ -79,7 +79,7 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>  				       int val2);
>  
>  int iio_simple_dummy_events_register(struct iio_dev *indio_dev);
> -int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
> +void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev);
>  
>  #else /* Stubs for when events are disabled at compile time */
>  
> @@ -89,11 +89,9 @@ iio_simple_dummy_events_register(struct iio_dev *indio_dev)
>  	return 0;
>  };
>  
> -static inline int
> +static inline void
>  iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
> -{
> -	return 0;
> -};
> +{ };
>  
>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
>  
> diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
> index c32ef78..ecc563c 100644
> --- a/drivers/staging/iio/iio_simple_dummy_events.c
> +++ b/drivers/staging/iio/iio_simple_dummy_events.c
> @@ -257,13 +257,11 @@ error_ret:
>   * iio_simple_dummy_events_unregister() - tidy up interrupt handling on remove
>   * @indio_dev: device instance data
>   */
> -int iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
> +void iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
>  {
>  	struct iio_dummy_state *st = iio_priv(indio_dev);
>  
>  	free_irq(st->event_irq, indio_dev);
>  	/* Not part of normal driver */
>  	iio_dummy_evgen_release_irq(st->event_irq);
> -
> -	return 0;
>  }
> 

