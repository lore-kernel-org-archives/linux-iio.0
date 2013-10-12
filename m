Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46601 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab3JLKRa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Oct 2013 06:17:30 -0400
Message-ID: <52592FE9.4040506@kernel.org>
Date: Sat, 12 Oct 2013 12:18:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Add a helper to free a list of IIO device attributes
References: <1381146621-9326-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381146621-9326-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/13 12:50, Lars-Peter Clausen wrote:
> We have the same code to free a IIO device attribute list in multiple place.
> This patch adds a new helper function to take care of this and replaces the
> custom instances with a call to the helper function. Note that we do not need to
> call list_del() for each of the list items since we will never look at any of
> the list items nor the list itself again.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Sensible patch, thanks.

Applied to the togreg branch of iio.git


> ---
>  drivers/iio/iio_core.h            |  1 +
>  drivers/iio/industrialio-buffer.c | 21 ++-------------------
>  drivers/iio/industrialio-core.c   | 34 ++++++++++++++++++----------------
>  drivers/iio/industrialio-event.c  | 15 ++-------------
>  4 files changed, 23 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iio/iio_core.h b/drivers/iio/iio_core.h
> index 9209f47..c5e3e86 100644
> --- a/drivers/iio/iio_core.h
> +++ b/drivers/iio/iio_core.h
> @@ -33,6 +33,7 @@ int __iio_add_chan_devattr(const char *postfix,
>  			   enum iio_shared_by shared_by,
>  			   struct device *dev,
>  			   struct list_head *attr_list);
> +void iio_free_chan_devattr_list(struct list_head *attr_list);
>  
>  /* Event interface flags */
>  #define IIO_BUSY_BIT_POS 1
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index e9f389b..9ab8dba 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -251,23 +251,6 @@ error_ret:
>  	return ret;
>  }
>  
> -static void iio_buffer_remove_and_free_scan_dev_attr(struct iio_dev *indio_dev,
> -						     struct iio_dev_attr *p)
> -{
> -	kfree(p->dev_attr.attr.name);
> -	kfree(p);
> -}
> -
> -static void __iio_buffer_attr_cleanup(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_attr *p, *n;
> -	struct iio_buffer *buffer = indio_dev->buffer;
> -
> -	list_for_each_entry_safe(p, n,
> -				 &buffer->scan_el_dev_attr_list, l)
> -		iio_buffer_remove_and_free_scan_dev_attr(indio_dev, p);
> -}
> -
>  static const char * const iio_scan_elements_group_name = "scan_elements";
>  
>  int iio_buffer_register(struct iio_dev *indio_dev,
> @@ -344,7 +327,7 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>  error_free_scan_mask:
>  	kfree(buffer->scan_mask);
>  error_cleanup_dynamic:
> -	__iio_buffer_attr_cleanup(indio_dev);
> +	iio_free_chan_devattr_list(&buffer->scan_el_dev_attr_list);
>  
>  	return ret;
>  }
> @@ -354,7 +337,7 @@ void iio_buffer_unregister(struct iio_dev *indio_dev)
>  {
>  	kfree(indio_dev->buffer->scan_mask);
>  	kfree(indio_dev->buffer->scan_el_group.attrs);
> -	__iio_buffer_attr_cleanup(indio_dev);
> +	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
>  }
>  EXPORT_SYMBOL(iio_buffer_unregister);
>  
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 863aa01..c9f3d73 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -793,11 +793,22 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
>  	return attrcount;
>  }
>  
> -static void iio_device_remove_and_free_read_attr(struct iio_dev *indio_dev,
> -						 struct iio_dev_attr *p)
> +/**
> + * iio_free_chan_devattr_list() - Free a list of IIO device attributes
> + * @attr_list: List of IIO device attributes
> + *
> + * This function frees the memory allocated for each of the IIO device
> + * attributes in the list. Note: if you want to reuse the list after calling
> + * this function you have to reinitialize it using INIT_LIST_HEAD().
> + */
> +void iio_free_chan_devattr_list(struct list_head *attr_list)
>  {
> -	kfree(p->dev_attr.attr.name);
> -	kfree(p);
> +	struct iio_dev_attr *p, *n;
> +
> +	list_for_each_entry_safe(p, n, attr_list, l) {
> +		kfree(p->dev_attr.attr.name);
> +		kfree(p);
> +	}
>  }
>  
>  static ssize_t iio_show_dev_name(struct device *dev,
> @@ -813,7 +824,7 @@ static DEVICE_ATTR(name, S_IRUGO, iio_show_dev_name, NULL);
>  static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  {
>  	int i, ret = 0, attrcount, attrn, attrcount_orig = 0;
> -	struct iio_dev_attr *p, *n;
> +	struct iio_dev_attr *p;
>  	struct attribute **attr;
>  
>  	/* First count elements in any existing group */
> @@ -866,11 +877,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
>  	return 0;
>  
>  error_clear_attrs:
> -	list_for_each_entry_safe(p, n,
> -				 &indio_dev->channel_attr_list, l) {
> -		list_del(&p->l);
> -		iio_device_remove_and_free_read_attr(indio_dev, p);
> -	}
> +	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
>  
>  	return ret;
>  }
> @@ -878,12 +885,7 @@ error_clear_attrs:
>  static void iio_device_unregister_sysfs(struct iio_dev *indio_dev)
>  {
>  
> -	struct iio_dev_attr *p, *n;
> -
> -	list_for_each_entry_safe(p, n, &indio_dev->channel_attr_list, l) {
> -		list_del(&p->l);
> -		iio_device_remove_and_free_read_attr(indio_dev, p);
> -	}
> +	iio_free_chan_devattr_list(&indio_dev->channel_attr_list);
>  	kfree(indio_dev->chan_attr_group.attrs);
>  }
>  
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index 36f0c8e..32c9bc2 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -339,17 +339,6 @@ error_ret:
>  	return ret;
>  }
>  
> -static inline void __iio_remove_event_config_attrs(struct iio_dev *indio_dev)
> -{
> -	struct iio_dev_attr *p, *n;
> -	list_for_each_entry_safe(p, n,
> -				 &indio_dev->event_interface->
> -				 dev_attr_list, l) {
> -		kfree(p->dev_attr.attr.name);
> -		kfree(p);
> -	}
> -}
> -
>  static inline int __iio_add_event_config_attrs(struct iio_dev *indio_dev)
>  {
>  	int j, ret, attrcount = 0;
> @@ -441,7 +430,7 @@ int iio_device_register_eventset(struct iio_dev *indio_dev)
>  	return 0;
>  
>  error_free_setup_event_lines:
> -	__iio_remove_event_config_attrs(indio_dev);
> +	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
>  	kfree(indio_dev->event_interface);
>  error_ret:
>  
> @@ -452,7 +441,7 @@ void iio_device_unregister_eventset(struct iio_dev *indio_dev)
>  {
>  	if (indio_dev->event_interface == NULL)
>  		return;
> -	__iio_remove_event_config_attrs(indio_dev);
> +	iio_free_chan_devattr_list(&indio_dev->event_interface->dev_attr_list);
>  	kfree(indio_dev->event_interface->group.attrs);
>  	kfree(indio_dev->event_interface);
>  }
> 
