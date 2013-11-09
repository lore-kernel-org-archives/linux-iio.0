Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54743 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753773Ab3KIQnN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Nov 2013 11:43:13 -0500
Message-ID: <527E7467.8000103@kernel.org>
Date: Sat, 09 Nov 2013 17:44:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
CC: lars@metafoo.de
Subject: Re: [PATCH 01/33] iio: core: Implement devm_iio_device_{register,unregister}
References: <1383046796-329-1-git-send-email-sachin.kamat@linaro.org> <1383046796-329-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1383046796-329-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/29/13 11:39, Sachin Kamat wrote:
> Add device managed devm_iio_device_{register,unregister}()
> to automatically unregister IIO drivers thus leading to
> simplified IIO driver code.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Tested-by: Lars-Peter Clausen <lars@metafoo.de>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the togreg branch of iio.git

Thanks

> ---
>  Documentation/driver-model/devres.txt |    2 ++
>  drivers/iio/industrialio-core.c       |   59 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h               |    3 ++
>  3 files changed, 64 insertions(+)
> 
> diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
> index fcb34a5..ffeab1d 100644
> --- a/Documentation/driver-model/devres.txt
> +++ b/Documentation/driver-model/devres.txt
> @@ -242,6 +242,8 @@ IIO
>    devm_iio_device_free()
>    devm_iio_trigger_alloc()
>    devm_iio_trigger_free()
> +  devm_iio_device_register()
> +  devm_iio_device_unregister()
>  
>  IO region
>    devm_request_region()
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 18f72e3..1c280b5 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1161,6 +1161,65 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	mutex_unlock(&indio_dev->info_exist_lock);
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
> +
> +static void devm_iio_device_unreg(struct device *dev, void *res)
> +{
> +	iio_device_unregister(*(struct iio_dev **)res);
> +}
> +
> +/**
> + * devm_iio_device_register - Resource-managed iio_device_register()
> + * @dev:	Device to allocate iio_dev for
> + * @indio_dev:	Device structure filled by the device driver
> + *
> + * Managed iio_device_register.  The IIO device registered with this
> + * function is automatically unregistered on driver detach. This function
> + * calls iio_device_register() internally. Refer to that function for more
> + * information.
> + *
> + * If an iio_dev registered with this function needs to be unregistered
> + * separately, devm_iio_device_unregister() must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	struct iio_dev **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	*ptr = indio_dev;
> +	ret = iio_device_register(indio_dev);
> +	if (!ret)
> +		devres_add(dev, ptr);
> +	else
> +		devres_free(ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_device_register);
> +
> +/**
> + * devm_iio_device_unregister - Resource-managed iio_device_unregister()
> + * @dev:	Device this iio_dev belongs to
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Unregister iio_dev registered with devm_iio_device_register().
> + */
> +void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_iio_device_unreg,
> +			    devm_iio_device_match, indio_dev);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
> +
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 256a90a..a8cabda 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -510,6 +510,9 @@ int iio_device_register(struct iio_dev *indio_dev);
>   **/
>  void iio_device_unregister(struct iio_dev *indio_dev);
>  
> +int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
> +void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
> +
>  /**
>   * iio_push_event() - try to add event to the list for userspace reading
>   * @indio_dev:		IIO device structure
> 
