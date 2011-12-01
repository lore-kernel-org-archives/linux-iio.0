Return-Path: <jic23@kernel.org>
Message-ID: <4ED7E8CD.1080804@kernel.org>
Date: Thu, 01 Dec 2011 20:51:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH 03/10] staging:iio:ring_sw: Add helper function for initializing
 simple setups
References: <1322749170-21407-1-git-send-email-lars@metafoo.de> <1322749170-21407-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1322749170-21407-4-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/01/2011 02:19 PM, Lars-Peter Clausen wrote:
> Add a helper function for executing the common tasks which are usually involved
> in setting up a simple software ringbuffer. It will allocate the buffer,
> allocate the pollfunc and register the buffer.
> 
Hmm. this does hide a bit how to typically do it for other buffers, but
I guess it is easy enough for people to look in here.
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

> ---
>  drivers/staging/iio/ring_sw.c |   83 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/staging/iio/ring_sw.h |    8 ++++
>  2 files changed, 90 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/ring_sw.c b/drivers/staging/iio/ring_sw.c
> index 879c709..c93b069 100644
> --- a/drivers/staging/iio/ring_sw.c
> +++ b/drivers/staging/iio/ring_sw.c
> @@ -15,7 +15,8 @@
>  #include <linux/sched.h>
>  #include <linux/poll.h>
>  #include "ring_sw.h"
> -#include "trigger.h"
> +#include "buffer.h"
> +#include "trigger_consumer.h"
>  
>  /**
>   * struct iio_sw_ring_buffer - software ring buffer
> @@ -414,5 +415,85 @@ const struct iio_buffer_access_funcs ring_sw_access_funcs = {
>  };
>  EXPORT_SYMBOL(ring_sw_access_funcs);
>  
> +static const struct iio_buffer_setup_ops iio_sw_rb_simple_setup_ops = {
> +	.preenable = &iio_sw_buffer_preenable,
> +	.postenable = &iio_triggered_buffer_postenable,
> +	.predisable = &iio_triggered_buffer_predisable,
> +};
> +
> +/*
> + * iio_sw_rb_simple_setup() - Setup simple software ringbuffer and pollfunc
> + * @indio_dev:		IIO device structure
> + * @pollfunc_bh:	Function which will be used as pollfunc bottom half
> + * @pollfunc_th:	Function which will be used as pollfunc top half
> + *
> + * This function combines some common tasks which will normally be performed
> + * when setting up a simple software ringbuffer. It will allocate the ringbuffer
> + * and the pollfunc, as well as register the buffer with IIO core.
> + * Before calling this function the indio_dev structure should already be
> + * completly initzialized but not yet registered.
> + *
> + * To free the resources allocated by this function iio_sw_rb_simple_cleanup
> + * should be called.
> + */
> +int iio_sw_rb_simple_setup(struct iio_dev *indio_dev,
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> +	irqreturn_t (*pollfunc_th)(int irq, void *p))
> +{
> +	int ret;
> +
> +	indio_dev->buffer = iio_sw_rb_allocate(indio_dev);
> +	if (!indio_dev->buffer) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +
> +	indio_dev->pollfunc = iio_alloc_pollfunc(pollfunc_bh,
> +						 pollfunc_th,
> +						 IRQF_ONESHOT,
> +						 indio_dev,
> +						 "%s_consumer%d",
> +						 indio_dev->name,
> +						 indio_dev->id);
> +	if (indio_dev->pollfunc == NULL) {
> +		ret = -ENOMEM;
> +		goto error_deallocate_sw_rb;
> +	}
> +
> +	/* Ring buffer functions - here trigger setup related */
> +	indio_dev->setup_ops = &iio_sw_rb_simple_setup_ops;
> +
> +	/* Flag that polled ring buffering is possible */
> +	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +
> +	ret = iio_buffer_register(indio_dev,
> +				  indio_dev->channels,
> +				  indio_dev->num_channels);
> +	if (ret)
> +		goto error_dealloc_pollfunc;
> +
> +	return 0;
> +
> +error_dealloc_pollfunc:
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +error_deallocate_sw_rb:
> +	iio_sw_rb_free(indio_dev->buffer);
> +error_ret:
> +	return ret;
> +}
> +EXPORT_SYMBOL(iio_sw_rb_simple_setup);
> +
> +/*
> + * iio_sw_rb_simple_cleanup - Free resources allocated by iio_sw_rb_simple_setup
> + * @indio_dev:		IIO device structure
> + */
> +void iio_sw_rb_simple_cleanup(struct iio_dev *indio_dev)
> +{
> +	iio_buffer_unregister(indio_dev);
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
> +	iio_sw_rb_free(indio_dev->buffer);
> +}
> +EXPORT_SYMBOL(iio_sw_rb_simple_cleanup);
> +
>  MODULE_DESCRIPTION("Industrialio I/O software ring buffer");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/staging/iio/ring_sw.h b/drivers/staging/iio/ring_sw.h
> index e6a6e2c..69ed561 100644
> --- a/drivers/staging/iio/ring_sw.h
> +++ b/drivers/staging/iio/ring_sw.h
> @@ -23,6 +23,8 @@
>  
>  #ifndef _IIO_RING_SW_H_
>  #define _IIO_RING_SW_H_
> +
> +#include <linux/interrupt.h>
>  #include "buffer.h"
>  
>  /**
> @@ -32,4 +34,10 @@ extern const struct iio_buffer_access_funcs ring_sw_access_funcs;
>  
>  struct iio_buffer *iio_sw_rb_allocate(struct iio_dev *indio_dev);
>  void iio_sw_rb_free(struct iio_buffer *ring);
> +
> +int iio_sw_rb_simple_setup(struct iio_dev *indio_dev,
> +	irqreturn_t (*pollfunc_bh)(int irq, void *p),
> +	irqreturn_t (*pollfunc_th)(int irq, void *p));
> +void iio_sw_rb_simple_cleanup(struct iio_dev *indio_dev);
> +
>  #endif /* _IIO_RING_SW_H_ */
