Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46991 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934334AbaLLKsu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Dec 2014 05:48:50 -0500
Message-ID: <548AC80D.7080001@kernel.org>
Date: Fri, 12 Dec 2014 10:48:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 06/11] iio: Move buffer registration to the core
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/11/14 17:55, Lars-Peter Clausen wrote:
> Originally device and buffer registration were kept as separate operations
> in IIO to allow to register two distinct sets of channels for buffered and
> non-buffered operations. This has since already been further restricted and
> the channel set registered for the buffer needs to be a subset of the
> channel set registered for the device.

The only case I can think of that might make us effectively separate
these out again is that of multiple buffers.  However we don't support
that right now so I'll take this and if I get time start a conversation
on what the requirements for that will be.  There are ways to move
that support into the core that may well make more sense anyway.

> Additionally the possibility to not
> have a raw (or processed) attribute for a channel which was registered for
> the device was added a while ago. This means it is possible to not register
> any device level attributes for a channel even if it is registered for the
> device. Also if a channel's scan_index is set to -1 and the channel is
> registered for the buffer it is ignored.
> 
> So in summery it means it is possible to register the same channel array for
> both the device and the buffer yet still end up with distinctive sets of
> channels for both of them. This makes the argument for having to have to
> manually register the channels for both the device and the buffer invalid.
> Considering that the vast majority of all drivers want to register the same
> set of channels for both the buffer and the device it makes sense to move
> the buffer registration into the core to avoid some boiler-plate code in the
> device driver setup path.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/adc/ti_am335x_adc.c                 |  9 ---------
>  drivers/iio/iio_core.h                          |  9 +++++++++
>  drivers/iio/industrialio-buffer.c               | 18 ++++++++++-------
>  drivers/iio/industrialio-core.c                 | 14 ++++++++++++-
>  drivers/iio/industrialio-triggered-buffer.c     |  9 ---------
>  drivers/staging/iio/accel/lis3l02dq_core.c      | 13 +------------
>  drivers/staging/iio/accel/sca3000_core.c        | 10 +---------
>  drivers/staging/iio/iio_simple_dummy_buffer.c   |  8 --------
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 12 ++----------
>  drivers/staging/iio/meter/ade7758.h             |  1 -
>  drivers/staging/iio/meter/ade7758_core.c        | 15 ++------------
>  drivers/staging/iio/meter/ade7758_ring.c        |  5 -----
>  include/linux/iio/buffer.h                      | 26 -------------------------
>  13 files changed, 39 insertions(+), 110 deletions(-)
> 


> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index f667e4e..e1906ad 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -385,14 +385,16 @@ static int iio_buffer_add_channel_sysfs(struct iio_dev *indio_dev,
>  
>  static const char * const iio_scan_elements_group_name = "scan_elements";
>  
> -int iio_buffer_register(struct iio_dev *indio_dev,
> -			const struct iio_chan_spec *channels,
> -			int num_channels)
> +int iio_buffer_alloc_sysfs(struct iio_dev *indio_dev)
I've renamed this slightly as it also allocates the the bitmap (confusingly
called mask) of what channels are enabled for the buffer.

iio_buffer_alloc_sysfs_and_mask
Obviously renamed the free in a similar fashion. Doubt you'll mind, but
shout if you do.


>  {
>  	struct iio_dev_attr *p;
>  	struct attribute **attr;
>  	struct iio_buffer *buffer = indio_dev->buffer;
>  	int ret, i, attrn, attrcount, attrcount_orig = 0;
> +	const struct iio_chan_spec *channels;
> +
> +	if (!buffer)
> +		return 0;
>  
>  	if (buffer->attrs)
>  		indio_dev->groups[indio_dev->groupcounter++] = buffer->attrs;
> @@ -404,9 +406,10 @@ int iio_buffer_register(struct iio_dev *indio_dev,
>  	}
>  	attrcount = attrcount_orig;
>  	INIT_LIST_HEAD(&buffer->scan_el_dev_attr_list);
> +	channels = indio_dev->channels;
>  	if (channels) {
>  		/* new magic */
> -		for (i = 0; i < num_channels; i++) {
> +		for (i = 0; i < indio_dev->num_channels; i++) {
>  			if (channels[i].scan_index < 0)
>  				continue;
>  
> @@ -463,15 +466,16 @@ error_cleanup_dynamic:
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(iio_buffer_register);
>  
> -void iio_buffer_unregister(struct iio_dev *indio_dev)
> +void iio_buffer_free_sysfs(struct iio_dev *indio_dev)
>  {
> +	if (!indio_dev->buffer)
> +		return;
> +
>  	kfree(indio_dev->buffer->scan_mask);
>  	kfree(indio_dev->buffer->scan_el_group.attrs);
>  	iio_free_chan_devattr_list(&indio_dev->buffer->scan_el_dev_attr_list);
>  }
> -EXPORT_SYMBOL(iio_buffer_unregister);
>  
>  ssize_t iio_buffer_read_length(struct device *dev,
>  			       struct device_attribute *attr,
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 45bb3a4..0e596b4 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1158,11 +1158,19 @@ int iio_device_register(struct iio_dev *indio_dev)
>  			"Failed to register debugfs interfaces\n");
>  		return ret;
>  	}
> +
> +	ret = iio_buffer_alloc_sysfs(indio_dev);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"Failed to create buffer sysfs interfaces\n");
> +		goto error_unreg_debugfs;
> +	}
> +
>  	ret = iio_device_register_sysfs(indio_dev);
>  	if (ret) {
>  		dev_err(indio_dev->dev.parent,
>  			"Failed to register sysfs interfaces\n");
> -		goto error_unreg_debugfs;
> +		goto error_buffer_free_sysfs;
>  	}
>  	ret = iio_device_register_eventset(indio_dev);
>  	if (ret) {
> @@ -1195,6 +1203,8 @@ error_unreg_eventset:
>  	iio_device_unregister_eventset(indio_dev);
>  error_free_sysfs:
>  	iio_device_unregister_sysfs(indio_dev);
> +error_buffer_free_sysfs:
> +	iio_buffer_free_sysfs(indio_dev);
>  error_unreg_debugfs:
>  	iio_device_unregister_debugfs(indio_dev);
>  	return ret;
> @@ -1223,6 +1233,8 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  	iio_buffer_wakeup_poll(indio_dev);
>  
>  	mutex_unlock(&indio_dev->info_exist_lock);
> +
> +	iio_buffer_free_sysfs(indio_dev);
>  }
>  EXPORT_SYMBOL(iio_device_unregister);
>  

> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index 9eedb93..ba6d5ee 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -1155,11 +1155,6 @@ static int sca3000_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_buffer_register(indio_dev, indio_dev->channels,
> -		indio_dev->num_channels);
> -	if (ret < 0)
> -		goto error_unregister_dev;
> -
This caused some fuzz due to my reformatting of the earlier patch :(
Anyhow, the fix was trivial obviously.
>  	if (spi->irq) {
>  		ret = request_threaded_irq(spi->irq,
>  					   NULL,
> @@ -1168,7 +1163,7 @@ static int sca3000_probe(struct spi_device *spi)
>  					   "sca3000",
>  					   indio_dev);
>  		if (ret)
> -			goto error_unregister_ring;
> +			goto error_unregister_dev;
>  	}
>  	sca3000_register_ring_funcs(indio_dev);
>  	ret = sca3000_clean_setup(st);
> @@ -1179,8 +1174,6 @@ static int sca3000_probe(struct spi_device *spi)
>  error_free_irq:
>  	if (spi->irq)
>  		free_irq(spi->irq, indio_dev);
> -error_unregister_ring:
> -	iio_buffer_unregister(indio_dev);
>  error_unregister_dev:
>  	iio_device_unregister(indio_dev);
>  	return ret;
> @@ -1214,7 +1207,6 @@ static int sca3000_remove(struct spi_device *spi)
>  	if (spi->irq)
>  		free_irq(spi->irq, indio_dev);
>  	iio_device_unregister(indio_dev);
> -	iio_buffer_unregister(indio_dev);
>  	sca3000_unconfigure_ring(indio_dev);
>  
>  	return 0;
<snip>
> diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
> index 8c8ce61..b0e006c 100644
> --- a/include/linux/iio/buffer.h
> +++ b/include/linux/iio/buffer.h
> @@ -151,22 +151,6 @@ static inline int iio_push_to_buffers_with_timestamp(struct iio_dev *indio_dev,
>  int iio_update_demux(struct iio_dev *indio_dev);
>  
>  /**
> - * iio_buffer_register() - register the buffer with IIO core
> - * @indio_dev:		device with the buffer to be registered
> - * @channels:		the channel descriptions used to construct buffer
> - * @num_channels:	the number of channels
> - **/
> -int iio_buffer_register(struct iio_dev *indio_dev,
> -			const struct iio_chan_spec *channels,
> -			int num_channels);
> -
> -/**
> - * iio_buffer_unregister() - unregister the buffer from IIO core
> - * @indio_dev:		the device with the buffer to be unregistered
> - **/
> -void iio_buffer_unregister(struct iio_dev *indio_dev);
> -
> -/**
>   * iio_buffer_read_length() - attr func to get number of datums in the buffer
>   **/
>  ssize_t iio_buffer_read_length(struct device *dev,
> @@ -223,16 +207,6 @@ static inline void iio_device_attach_buffer(struct iio_dev *indio_dev,
>  
>  #else /* CONFIG_IIO_BUFFER */
>  
> -static inline int iio_buffer_register(struct iio_dev *indio_dev,
> -					   const struct iio_chan_spec *channels,
> -					   int num_channels)
> -{
> -	return 0;
> -}
> -
> -static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
> -{}
> -
>  static inline void iio_buffer_get(struct iio_buffer *buffer) {}
>  static inline void iio_buffer_put(struct iio_buffer *buffer) {}
>  
> 

