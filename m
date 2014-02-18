Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36809 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbaBRIrA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 03:47:00 -0500
Message-ID: <53031E2A.3010709@kernel.org>
Date: Tue, 18 Feb 2014 08:47:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH]iio get rid of unneccessary error_ret
References: <5300A6CE.2090707@gmx.de>
In-Reply-To: <5300A6CE.2090707@gmx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/02/14 11:53, Hartmut Knaack wrote:
> Get rid of obsolete uses of goto error_ret and some empty lines.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Nice little cleanup of what is mostly my old bad habbits back
when I was younger.

Thanks for doing this,

Applied to the togreg branch of iio.git.  Pushed out as testing initially.

Jonathan
> ---
> diff --git a/drivers/iio/buffer_cb.c b/drivers/iio/buffer_cb.c
> index 2d9c6f8..eb46e72 100644
> --- a/drivers/iio/buffer_cb.c
> +++ b/drivers/iio/buffer_cb.c
> @@ -46,10 +46,8 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>   	struct iio_channel *chan;
>
>   	cb_buff = kzalloc(sizeof(*cb_buff), GFP_KERNEL);
> -	if (cb_buff == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (cb_buff == NULL)
> +		return ERR_PTR(-ENOMEM);
>
>   	iio_buffer_init(&cb_buff->buffer);
>
> @@ -91,7 +89,6 @@ error_release_channels:
>   	iio_channel_release_all(cb_buff->channels);
>   error_free_cb_buff:
>   	kfree(cb_buff);
> -error_ret:
>   	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index c67d83b..e108f2a 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -264,7 +264,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   				     &indio_dev->dev,
>   				     &buffer->scan_el_dev_attr_list);
>   	if (ret)
> -		goto error_ret;
> +		return ret;
>   	attrcount++;
>   	ret = __iio_add_chan_devattr("type",
>   				     chan,
> @@ -275,7 +275,7 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   				     &indio_dev->dev,
>   				     &buffer->scan_el_dev_attr_list);
>   	if (ret)
> -		goto error_ret;
> +		return ret;
>   	attrcount++;
>   	if (chan->type != IIO_TIMESTAMP)
>   		ret = __iio_add_chan_devattr("en",
> @@ -296,10 +296,9 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>   					     &indio_dev->dev,
>   					     &buffer->scan_el_dev_attr_list);
>   	if (ret)
> -		goto error_ret;
> +		return ret;
>   	attrcount++;
>   	ret = attrcount;
> -error_ret:
>   	return ret;
>   }
>
> @@ -553,13 +552,13 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>   		if (indio_dev->setup_ops->predisable) {
>   			ret = indio_dev->setup_ops->predisable(indio_dev);
>   			if (ret)
> -				goto error_ret;
> +				return ret;
>   		}
>   		indio_dev->currentmode = INDIO_DIRECT_MODE;
>   		if (indio_dev->setup_ops->postdisable) {
>   			ret = indio_dev->setup_ops->postdisable(indio_dev);
>   			if (ret)
> -				goto error_ret;
> +				return ret;
>   		}
>   	}
>   	/* Keep a copy of current setup to allow roll back */
> @@ -613,7 +612,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>   			else {
>   				kfree(compound_mask);
>   				ret = -EINVAL;
> -				goto error_ret;
> +				return ret;
>   			}
>   		}
>   	} else {
> @@ -696,13 +695,10 @@ error_run_postdisable:
>   	if (indio_dev->setup_ops->postdisable)
>   		indio_dev->setup_ops->postdisable(indio_dev);
>   error_remove_inserted:
> -
>   	if (insert_buffer)
>   		iio_buffer_deactivate(insert_buffer);
>   	indio_dev->active_scan_mask = old_mask;
>   	kfree(compound_mask);
> -error_ret:
> -
>   	return ret;
>   }
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index acc911a..a85b660 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -692,10 +692,8 @@ int __iio_add_chan_devattr(const char *postfix,
>   	struct iio_dev_attr *iio_attr, *t;
>
>   	iio_attr = kzalloc(sizeof(*iio_attr), GFP_KERNEL);
> -	if (iio_attr == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (iio_attr == NULL)
> +		return -ENOMEM;
>   	ret = __iio_device_attr_init(&iio_attr->dev_attr,
>   				     postfix, chan,
>   				     readfunc, writefunc, shared_by);
> @@ -720,7 +718,6 @@ error_device_attr_deinit:
>   	__iio_device_attr_deinit(&iio_attr->dev_attr);
>   error_iio_dev_attr_free:
>   	kfree(iio_attr);
> -error_ret:
>   	return ret;
>   }
>
> @@ -1134,7 +1131,7 @@ int iio_device_register(struct iio_dev *indio_dev)
>   	if (ret) {
>   		dev_err(indio_dev->dev.parent,
>   			"Failed to register debugfs interfaces\n");
> -		goto error_ret;
> +		return ret;
>   	}
>   	ret = iio_device_register_sysfs(indio_dev);
>   	if (ret) {
> @@ -1175,7 +1172,6 @@ error_free_sysfs:
>   	iio_device_unregister_sysfs(indio_dev);
>   error_unreg_debugfs:
>   	iio_device_unregister_debugfs(indio_dev);
> -error_ret:
>   	return ret;
>   }
>   EXPORT_SYMBOL(iio_device_register);
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index c9c1419..2e6f8e0 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -366,32 +366,31 @@ static int iio_device_add_event_sysfs(struct iio_dev *indio_dev,
>   		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
>   			IIO_SEPARATE, &chan->event_spec[i].mask_separate);
>   		if (ret < 0)
> -			goto error_ret;
> +			return ret;
>   		attrcount += ret;
>
>   		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
>   			IIO_SHARED_BY_TYPE,
>   			&chan->event_spec[i].mask_shared_by_type);
>   		if (ret < 0)
> -			goto error_ret;
> +			return ret;
>   		attrcount += ret;
>
>   		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
>   			IIO_SHARED_BY_DIR,
>   			&chan->event_spec[i].mask_shared_by_dir);
>   		if (ret < 0)
> -			goto error_ret;
> +			return ret;
>   		attrcount += ret;
>
>   		ret = iio_device_add_event(indio_dev, chan, i, type, dir,
>   			IIO_SHARED_BY_ALL,
>   			&chan->event_spec[i].mask_shared_by_all);
>   		if (ret < 0)
> -			goto error_ret;
> +			return ret;
>   		attrcount += ret;
>   	}
>   	ret = attrcount;
> -error_ret:
>   	return ret;
>   }
>
> @@ -440,10 +439,8 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>
>   	indio_dev->event_interface =
>   		kzalloc(sizeof(struct iio_event_interface), GFP_KERNEL);
> -	if (indio_dev->event_interface == NULL) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> +	if (indio_dev->event_interface == NULL)
> +		return -ENOMEM;
>
>   	INIT_LIST_HEAD(&indio_dev->event_interface->dev_attr_list);
>
> @@ -489,8 +486,6 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>   error_free_setup_event_lines:
>   	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
>   	kfree(indio_dev->event_interface);
> -error_ret:
> -
>   	return ret;
>   }
>
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 766fab2..3383b02 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -62,10 +62,9 @@ int iio_trigger_register(struct iio_trigger *trig_info)
>   	int ret;
>
>   	trig_info->id = ida_simple_get(&iio_trigger_ida, 0, 0, GFP_KERNEL);
> -	if (trig_info->id < 0) {
> -		ret = trig_info->id;
> -		goto error_ret;
> -	}
> +	if (trig_info->id < 0)
> +		return trig_info->id;
> +
>   	/* Set the name used for the sysfs directory etc */
>   	dev_set_name(&trig_info->dev, "trigger%ld",
>   		     (unsigned long) trig_info->id);
> @@ -83,7 +82,6 @@ int iio_trigger_register(struct iio_trigger *trig_info)
>
>   error_unregister_id:
>   	ida_simple_remove(&iio_trigger_ida, trig_info->id);
> -error_ret:
>   	return ret;
>   }
>   EXPORT_SYMBOL(iio_trigger_register);
> @@ -234,13 +232,12 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
>   	if (trig->ops && trig->ops->set_trigger_state && no_other_users) {
>   		ret = trig->ops->set_trigger_state(trig, false);
>   		if (ret)
> -			goto error_ret;
> +			return ret;
>   	}
>   	iio_trigger_put_irq(trig, pf->irq);
>   	free_irq(pf->irq, pf);
>   	module_put(pf->indio_dev->info->driver_module);
>
> -error_ret:
>   	return ret;
>   }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

