Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbdFCIhk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:37:40 -0400
Date: Sat, 3 Jun 2017 09:37:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 01/38] iio: Use macro magic to avoid manual assign of
 driver_module
Message-ID: <20170603093736.2d9e0d03@kernel.org>
In-Reply-To: <20170529155154.22580-2-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
        <20170529155154.22580-2-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 May 2017 16:51:17 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> Starting point in boiler plate reduction similar to that done for
> many similar cases elsewhere in the kernel.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Hi all,

I've been slightly less lazy than last week and added some cc's.

If any of you lovely people have a bit of time to take a look at
the first two patches in this series that would be great.

I'm definitely looking for a acked-by or reviewed-by on this series
before applying.

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-core.c    | 35 +++++++++--------------------------
>  drivers/iio/industrialio-trigger.c |  6 +++---
>  include/linux/iio/iio.h            | 31 +++++++++++++++++++++++++++++--
>  3 files changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 4a1de59d153a..62dafa4414e3 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1665,14 +1665,11 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
>  
>  static const struct iio_buffer_setup_ops noop_ring_setup_ops;
>  
> -/**
> - * iio_device_register() - register a device with the IIO subsystem
> - * @indio_dev:		Device structure filled by the device driver
> - **/
> -int iio_device_register(struct iio_dev *indio_dev)
> +int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
>  {
>  	int ret;
>  
> +	indio_dev->driver_module = this_mod;
>  	/* If the calling driver did not initialize of_node, do it here */
>  	if (!indio_dev->dev.of_node && indio_dev->dev.parent)
>  		indio_dev->dev.of_node = indio_dev->dev.parent->of_node;
> @@ -1718,7 +1715,8 @@ int iio_device_register(struct iio_dev *indio_dev)
>  		indio_dev->setup_ops = &noop_ring_setup_ops;
>  
>  	cdev_init(&indio_dev->chrdev, &iio_buffer_fileops);
> -	indio_dev->chrdev.owner = indio_dev->info->driver_module;
> +
> +	indio_dev->chrdev.owner = this_mod;
>  
>  	ret = cdev_device_add(&indio_dev->chrdev, &indio_dev->dev);
>  	if (ret < 0)
> @@ -1736,7 +1734,7 @@ int iio_device_register(struct iio_dev *indio_dev)
>  	iio_device_unregister_debugfs(indio_dev);
>  	return ret;
>  }
> -EXPORT_SYMBOL(iio_device_register);
> +EXPORT_SYMBOL(__iio_device_register);
>  
>  /**
>   * iio_device_unregister() - unregister a device from the IIO subsystem
> @@ -1768,23 +1766,8 @@ static void devm_iio_device_unreg(struct device *dev, void *res)
>  	iio_device_unregister(*(struct iio_dev **)res);
>  }
>  
> -/**
> - * devm_iio_device_register - Resource-managed iio_device_register()
> - * @dev:	Device to allocate iio_dev for
> - * @indio_dev:	Device structure filled by the device driver
> - *
> - * Managed iio_device_register.  The IIO device registered with this
> - * function is automatically unregistered on driver detach. This function
> - * calls iio_device_register() internally. Refer to that function for more
> - * information.
> - *
> - * If an iio_dev registered with this function needs to be unregistered
> - * separately, devm_iio_device_unregister() must be used.
> - *
> - * RETURNS:
> - * 0 on success, negative error number on failure.
> - */
> -int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
> +int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> +			       struct module *this_mod)
>  {
>  	struct iio_dev **ptr;
>  	int ret;
> @@ -1794,7 +1777,7 @@ int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
>  		return -ENOMEM;
>  
>  	*ptr = indio_dev;
> -	ret = iio_device_register(indio_dev);
> +	ret = __iio_device_register(indio_dev, this_mod);
>  	if (!ret)
>  		devres_add(dev, ptr);
>  	else
> @@ -1802,7 +1785,7 @@ int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(devm_iio_device_register);
> +EXPORT_SYMBOL_GPL(__devm_iio_device_register);
>  
>  /**
>   * devm_iio_device_unregister - Resource-managed iio_device_unregister()
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 978e1592c2a3..067e58863592 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -250,7 +250,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
>  
>  	/* Prevent the module from being removed whilst attached to a trigger */
> -	__module_get(pf->indio_dev->info->driver_module);
> +	__module_get(pf->indio_dev->driver_module);
>  
>  	/* Get irq number */
>  	pf->irq = iio_trigger_get_irq(trig);
> @@ -286,7 +286,7 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
>  out_put_irq:
>  	iio_trigger_put_irq(trig, pf->irq);
>  out_put_module:
> -	module_put(pf->indio_dev->info->driver_module);
> +	module_put(pf->indio_dev->driver_module);
>  	return ret;
>  }
>  
> @@ -307,7 +307,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>  		trig->attached_own_device = false;
>  	iio_trigger_put_irq(trig, pf->irq);
>  	free_irq(pf->irq, pf);
> -	module_put(pf->indio_dev->info->driver_module);
> +	module_put(pf->indio_dev->driver_module);
>  
>  	return ret;
>  }
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 3f5ea2e9a39e..f65391067089 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -512,6 +512,7 @@ struct iio_buffer_setup_ops {
>  /**
>   * struct iio_dev - industrial I/O device
>   * @id:			[INTERN] used to identify device internally
> + * @driver_module:	[INTERN] used to make it harder to undercut users
>   * @modes:		[DRIVER] operating modes supported by device
>   * @currentmode:	[DRIVER] current operating mode
>   * @dev:		[DRIVER] device structure, should be assigned a parent
> @@ -552,6 +553,7 @@ struct iio_buffer_setup_ops {
>   */
>  struct iio_dev {
>  	int				id;
> +	struct module			*driver_module;
>  
>  	int				modes;
>  	int				currentmode;
> @@ -598,9 +600,34 @@ struct iio_dev {
>  
>  const struct iio_chan_spec
>  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
> -int iio_device_register(struct iio_dev *indio_dev);
> +/**
> + * iio_device_register() - register a device with the IIO subsystem
> + * @indio_dev:		Device structure filled by the device driver
> + **/
> +#define iio_device_register(iio_dev) \
> +	__iio_device_register(iio_dev, THIS_MODULE)
> +int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod);
>  void iio_device_unregister(struct iio_dev *indio_dev);
> -int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
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
> +#define devm_iio_device_register(dev, indio_dev) \
> +	__devm_iio_device_register(dev, indio_dev, THIS_MODULE);
> +int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> +			       struct module *this_mod);
>  void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);

