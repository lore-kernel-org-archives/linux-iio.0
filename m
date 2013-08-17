Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58505 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753937Ab3HQRfk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Aug 2013 13:35:40 -0400
Message-ID: <520FC278.1030500@kernel.org>
Date: Sat, 17 Aug 2013 19:35:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacek Anaszewski <j.anaszewski@samsung.com>
CC: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	kyungmin.park@samsung.com, s.nawrocki@samsung.com
Subject: Re: [PATCH/RFC v4 1/3] iio: trigger: implement devm_iio_trigger_alloc/devm_iio_triger_free
References: <1376658718-3324-1-git-send-email-j.anaszewski@samsung.com>
In-Reply-To: <1376658718-3324-1-git-send-email-j.anaszewski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/16/13 14:11, Jacek Anaszewski wrote:
> Add a resource managed devm_iio_trigger_alloc()/devm_iio_triger_free()
> to automatically clean up triggers allocated by IIO drivers, thus
> leading to simplified IIO drivers code.
> 
> Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
> Signed-off-by: Kyunmin Park <kyungmin.park@samsung.com>
Good.  I thought of doing this myself when the iio_dev version came
along but am always happy to have someone else put in the work for me ;)

Couple of little points though before we merge this:
1) Needs adding to the list in Documentation/driver-model/devres.txt
2) The viio_trigger_alloc sould be static
3) A few bits of additional unwanted whitespace have snuck in.

I've fixed these little bits up and applied the patch to the togreg
branch of iio.git

Thanks,

Jonathan


> ---
>  drivers/iio/industrialio-trigger.c |   71 ++++++++++++++++++++++++++++++++++--
>  include/linux/iio/iio.h            |   29 +++++++++++++++
>  2 files changed, 96 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 0dd9bb8..3c4180e 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -424,9 +424,8 @@ static void iio_trig_subirqunmask(struct irq_data *d)
>  	trig->subirqs[d->irq - trig->subirq_base].enabled = true;
>  }
>  
> -struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
> +struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
>  {
> -	va_list vargs;
>  	struct iio_trigger *trig;
>  	trig = kzalloc(sizeof *trig, GFP_KERNEL);
>  	if (trig) {
> @@ -444,9 +443,9 @@ struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
>  			kfree(trig);
>  			return NULL;
>  		}
> -		va_start(vargs, fmt);
> +
>  		trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
> -		va_end(vargs);
> +
>  		if (trig->name == NULL) {
>  			irq_free_descs(trig->subirq_base,
>  				       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> @@ -469,6 +468,18 @@ struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
>  	}
>  	return trig;
>  }
> +
> +struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
> +{
> +	struct iio_trigger *trig;
> +	va_list vargs;
> +
> +	va_start(vargs, fmt);
> +	trig = viio_trigger_alloc(fmt, vargs);
> +	va_end(vargs);
> +
> +	return trig;
> +}
>  EXPORT_SYMBOL(iio_trigger_alloc);
>  
>  void iio_trigger_free(struct iio_trigger *trig)
> @@ -478,6 +489,58 @@ void iio_trigger_free(struct iio_trigger *trig)
>  }
>  EXPORT_SYMBOL(iio_trigger_free);
>  
> +
> +static void devm_iio_trigger_release(struct device *dev, void *res)
> +{
> +	iio_trigger_free(*(struct iio_trigger **)res);
> +}
> +
> +static int devm_iio_trigger_match(struct device *dev, void *res, void *data)
> +{
> +	struct iio_trigger **r = res;
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}
> +	return *r == data;
> +}
> +
> +struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> +						const char *fmt, ...)
> +{
> +	struct iio_trigger **ptr, *trig;
> +	va_list vargs;
> +
> +	ptr = devres_alloc(devm_iio_trigger_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return NULL;
> +
> +	/* use raw alloc_dr for kmalloc caller tracing */
> +	va_start(vargs, fmt);
> +	trig = viio_trigger_alloc(fmt, vargs);
> +	va_end(vargs);
> +	if (trig) {
> +		*ptr = trig;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}
> +
> +	return trig;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_trigger_alloc);
> +
> +void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_iio_trigger_release,
> +			    devm_iio_trigger_match, iio_trig);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_trigger_free);
> +
>  void iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  	indio_dev->groups[indio_dev->groupcounter++] =
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 09ebe0a..2103cc3 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -557,6 +557,35 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
>  void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
>  
>  /**
> + * devm_iio_trigger_alloc - Resource-managed iio_trigger_alloc()
> + * @dev:		Device to allocate iio_trigger for
> + * @fmt:		trigger name format. If it includes format
> + *			specifiers, the additional arguments following
> + *			format are formatted and inserted in the resulting
> + *			string replacing their respective specifiers.
> + *
> + * Managed iio_trigger_alloc.  iio_trigger allocated with this function is
> + * automatically freed on driver detach.
> + *
> + * If an iio_trigger allocated with this function needs to be freed separately,
> + * devm_iio_trigger_free() must be used.
> + *
> + * RETURNS:
> + * Pointer to allocated iio_trigger on success, NULL on failure.
> + */
> +struct iio_trigger *devm_iio_trigger_alloc(struct device *dev,
> +						const char *fmt, ...);
> +
> +/**
> + * devm_iio_trigger_free - Resource-managed iio_trigger_free()
> + * @dev:		Device this iio_dev belongs to
> + * @iio_trig:		the iio_trigger associated with the device
> + *
> + * Free iio_trigger allocated with devm_iio_trigger_alloc().
> + */
> +void devm_iio_trigger_free(struct device *dev, struct iio_trigger *iio_trig);
> +
> +/**
>   * iio_buffer_enabled() - helper function to test if the buffer is enabled
>   * @indio_dev:		IIO device structure for device
>   **/
> 
