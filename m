Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-008.synserver.de ([212.40.185.8]:1051 "EHLO
	smtp-out-008.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab3IZU32 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Sep 2013 16:29:28 -0400
Message-ID: <5244998F.4090905@metafoo.de>
Date: Thu, 26 Sep 2013 22:31:11 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 01/32] iio: core: Implement devm_iio_device_{register,unregister}
References: <1380106208-6948-1-git-send-email-sachin.kamat@linaro.org> <1380106208-6948-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1380106208-6948-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/25/2013 12:49 PM, Sachin Kamat wrote:
> Add device managed devm_iio_device_{register,unregister}()
> to automatically unregister IIO drivers thus leading to
> simplified IIO driver code.
>

I have the same fears as Jonathan that this is going to be used incorrectly
for drivers where the remove function is not empty. But hopefully the
benefits outweigh the dangers. So I think we should add this functionality.
But the implementation looks broken. Also few nitpicks on style issue inline
below. Otherwise looks good.


> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  Documentation/driver-model/devres.txt |    2 ++
>  drivers/iio/industrialio-core.c       |   35 +++++++++++++++++++++++++++++++++
>  include/linux/iio/iio.h               |   25 +++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
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
> index 24db185..58f494b 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1125,6 +1125,41 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	device_del(&indio_dev->dev);
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
> +
> +static void devm_iio_device_unreg(struct device *dev, void *res)
> +{
> +	iio_device_unregister(*(struct iio_dev **)res);
> +}
> +
> +int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
> +{
> +	void *ptr;
> +	int iio_dev;

ret is probably a better name.

> +
> +	ptr = devres_alloc(devm_iio_device_unreg, 0, GFP_KERNEL);

So we allocate memory with the size of 0. And then never actually pass the
IIO device itself to the devres managed resource, but de-reference the
pointer in devm_iio_device_unreg assuming it points is a iio_dev struct
pointer. This doesn't seem right. I think it needs to be something like this:

struct iio_dev **ptr;

ptr = devres_alloc(devm_iio_device_unreg, sizeof(*ptr), GFP_KERNEL);

...

*ptr = indio_dev;

> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	iio_dev = iio_device_register(indio_dev);
> +	if (!iio_dev)
> +		devres_add(dev, ptr);
> +	else
> +		devres_free(ptr);
> +
> +	return iio_dev;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_device_register);
> +
> +void devm_iio_device_unregister(struct device *dev, struct iio_dev *iio_dev)

The last parameter should be named indio_dev.

> +{
> +	int rc;
> +
> +	rc = devres_release(dev, devm_iio_device_unreg,
> +			    devm_iio_device_match, iio_dev);
> +	WARN_ON(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_device_unregister);
> +
>  subsys_initcall(iio_init);
>  module_exit(iio_exit);
>  
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index ac1cb8f..be16dd6 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -453,6 +453,31 @@ int iio_device_register(struct iio_dev *indio_dev);
>  void iio_device_unregister(struct iio_dev *indio_dev);
>  
>  /**
> + * devm_iio_device_register - Resource-managed iio_device_register()
> + * @dev:	Device to allocate iio_dev for
> + * @indio_dev:	Device structure filled by the device driver
> + *
> + * Managed iio_device_register.  iio_dev registered with this function is

The IIO device registered ...

I would also add that this function calls iio_device_register() internally
and to look at that function for more information.

> + * automatically unregistered on driver detach.
> + *
> + * If an iio_dev registered with this function needs to be unregistered
> + * separately, devm_iio_device_unregister() must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */

The kernel doc should be placed above the implementation, not the
definition. And yes we got that wrong on quite a few functions.

> +int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
> +
> +/**
> + * devm_iio_device_unregister - Resource-managed iio_device_unregister()
> + * @dev:	Device this iio_dev belongs to
> + * @indio_dev:	the iio_dev associated with the device
> + *
> + * Unregister iio_dev registered with devm_iio_device_register().
> + */
> +void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
> +
> +/**
>   * iio_push_event() - try to add event to the list for userspace reading
>   * @indio_dev:		IIO device structure
>   * @ev_code:		What event
> 

