Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:44445 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab1FGIkF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 04:40:05 -0400
Message-ID: <4DEDE5C5.6080309@cam.ac.uk>
Date: Tue, 07 Jun 2011 09:48:05 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: trigger: Add filter callbac
References: <1307389953-15467-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307389953-15467-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/11 20:52, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Allow devices to reject triggers and vice versa.
> 
> Changes since V1:
> Added kernel-doc
> Moved callback into iio_info
> Changed function naming
> Revised return value passing
> Included trigger.h to avoid warnings
> Moved definition of struct iio_poll_func to avoid warnings
This last change should be a separate patch.  If nothing else
it ought to go into mainline asap, whereas the rest of this
isn't quite so obviously a fix.  Also, what is the warning?
(nought showing up here)

Hence, if you have time please break that bit out.  Ack is
for both patches if you do this.

Otherwise, all looks good to me - I'll pull into my local
tree to rebase the trigger cleanups on top, but feel free
to push to Greg as well.  I'm waiting on a few tests of non
ADI parts before pushing out the dev_data removal set.

The addition of these functions would also be slightly nicer
if in a set with a patch that actually uses them.

Thanks,

Jonathan
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/iio.h                  |    6 +++
>  drivers/staging/iio/industrialio-trigger.c |   20 ++++++++++-
>  drivers/staging/iio/trigger.h              |   52 +++++++++++++++-------------
>  3 files changed, 53 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
> index 78a0927..9bf8b11 100644
> --- a/drivers/staging/iio/iio.h
> +++ b/drivers/staging/iio/iio.h
> @@ -15,6 +15,7 @@
>  #include <linux/irq.h>
>  #include "sysfs.h"
>  #include "chrdev.h"
> +#include "trigger.h"
>  
>  /* IIO TODO LIST */
>  /*
> @@ -224,6 +225,8 @@ static inline s64 iio_get_time_ns(void)
>   *			is event dependant. event_code specifies which event.
>   * @write_event_value:	write the value associate with the event.
>   *			Meaning is event dependent.
> + * @validate_trigger:	function to validate the trigger when the
> + *			current trigger gets changed.
>   **/
>  struct iio_info {
>  	struct module			*driver_module;
> @@ -256,6 +259,9 @@ struct iio_info {
>  	int (*write_event_value)(struct iio_dev *indio_dev,
>  				 int event_code,
>  				 int val);
> +	int (*validate_trigger)(struct iio_dev *indio_dev,
> +				struct iio_trigger *trig);
> +
>  };
>  
>  /**
> diff --git a/drivers/staging/iio/industrialio-trigger.c b/drivers/staging/iio/industrialio-trigger.c
> index d504aa2..90ca2df 100644
> --- a/drivers/staging/iio/industrialio-trigger.c
> +++ b/drivers/staging/iio/industrialio-trigger.c
> @@ -340,6 +340,9 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_get_drvdata(dev);
>  	struct iio_trigger *oldtrig = dev_info->trig;
> +	struct iio_trigger *trig;
> +	int ret;
> +
>  	mutex_lock(&dev_info->mlock);
>  	if (dev_info->currentmode == INDIO_RING_TRIGGERED) {
>  		mutex_unlock(&dev_info->mlock);
> @@ -347,7 +350,22 @@ static ssize_t iio_trigger_write_current(struct device *dev,
>  	}
>  	mutex_unlock(&dev_info->mlock);
>  
> -	dev_info->trig = iio_trigger_find_by_name(buf, len);
> +	trig = iio_trigger_find_by_name(buf, len);
> +
> +	if (trig && dev_info->info->validate_trigger) {
> +		ret = dev_info->info->validate_trigger(dev_info, trig);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (trig && trig->validate_device) {
> +		ret = trig->validate_device(trig, dev_info);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	dev_info->trig = trig;
> +
>  	if (oldtrig && dev_info->trig != oldtrig)
>  		iio_put_trigger(oldtrig);
>  	if (dev_info->trig)
> diff --git a/drivers/staging/iio/trigger.h b/drivers/staging/iio/trigger.h
> index f329fe1..e0b58ed 100644
> --- a/drivers/staging/iio/trigger.h
> +++ b/drivers/staging/iio/trigger.h
> @@ -29,6 +29,8 @@ struct iio_subirq {
>   * @set_trigger_state:	[DRIVER] switch on/off the trigger on demand
>   * @try_reenable:	function to reenable the trigger when the
>   *			use count is zero (may be NULL)
> + * @validate_device:	function to validate the device when the
> + *			current trigger gets changed.
>   * @subirq_chip:	[INTERN] associate 'virtual' irq chip.
>   * @subirq_base:	[INTERN] base number for irqs provided by trigger.
>   * @subirqs:		[INTERN] information about the 'child' irqs.
> @@ -48,6 +50,8 @@ struct iio_trigger {
>  
>  	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>  	int (*try_reenable)(struct iio_trigger *trig);
> +	int (*validate_device)(struct iio_trigger *trig,
> +			       struct iio_dev *indio_dev);
>  
>  	struct irq_chip			subirq_chip;
>  	int				subirq_base;
> @@ -57,6 +61,30 @@ struct iio_trigger {
>  	struct mutex			pool_lock;
>  };
>  
> +/**
> + * struct iio_poll_func - poll function pair
> + *
> + * @private_data:		data specific to device (passed into poll func)
> + * @h:				the function that is actually run on trigger
> + * @thread:			threaded interrupt part
> + * @type:			the type of interrupt (basically if oneshot)
> + * @name:			name used to identify the trigger consumer.
> + * @irq:			the corresponding irq as allocated from the
> + *				trigger pool
> + * @timestamp:			some devices need a timestamp grabbed as soon
> + *				as possible after the trigger - hence handler
> + *				passes it via here.
> + **/
> +struct iio_poll_func {
> +	void				*private_data;
> +	irqreturn_t (*h)(int irq, void *p);
> +	irqreturn_t (*thread)(int irq, void *p);
> +	int type;
> +	char *name;
> +	int irq;
> +	s64 timestamp;
> +};
> +
>  static inline struct iio_trigger *to_iio_trigger(struct device *d)
>  {
>  	return container_of(d, struct iio_trigger, dev);
> @@ -136,30 +164,6 @@ static inline void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
>  	mutex_unlock(&trig->pool_lock);
>  };
>  
> -/**
> - * struct iio_poll_func - poll function pair
> - *
> - * @private_data:		data specific to device (passed into poll func)
> - * @h:				the function that is actually run on trigger
> - * @thread:			threaded interrupt part
> - * @type:			the type of interrupt (basically if oneshot)
> - * @name:			name used to identify the trigger consumer.
> - * @irq:			the corresponding irq as allocated from the
> - *				trigger pool
> - * @timestamp:			some devices need a timestamp grabbed as soon
> - *				as possible after the trigger - hence handler
> - *				passes it via here.
> - **/
> -struct iio_poll_func {
> -	void				*private_data;
> -	irqreturn_t (*h)(int irq, void *p);
> -	irqreturn_t (*thread)(int irq, void *p);
> -	int type;
> -	char *name;
> -	int irq;
> -	s64 timestamp;
> -};
> -
>  struct iio_poll_func
>  *iio_alloc_pollfunc(irqreturn_t (*h)(int irq, void *p),
>  		    irqreturn_t (*thread)(int irq, void *p),

