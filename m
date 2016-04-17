Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53369 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbcDQMAV (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 08:00:21 -0400
Subject: Re: [PATCH 1/3] iio: core: Add devm_ APIs for
 iio_channel_{get,release}
To: Laxman Dewangan <ldewangan@nvidia.com>, corbet@lwn.net,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
References: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57137AD1.5030902@kernel.org>
Date: Sun, 17 Apr 2016 13:00:17 +0100
MIME-Version: 1.0
In-Reply-To: <1459938668-9180-1-git-send-email-ldewangan@nvidia.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/04/16 11:31, Laxman Dewangan wrote:
> Some of kernel driver uses the IIO framework to get the sensor
> value via ADC or IIO HW driver. The client driver get iio channel
> by iio_channel_get() and release it by calling iio_channel_release().
> 
> Add resource managed version (devm_*) of these APIs so that if client
> calls the devm_iio_channel_get() then it need not to release it explicitly,
> it can be done by managed device framework when driver get un-binded.
> 
> This reduces the code in error path and also need of .remove callback in
> some cases.
> 
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Applied to the togreg branch of iio.git.  
I guess the thermal driver use case will hit a cycle or so behind this.

Thanks,

Jonathan
> ---
>  drivers/iio/inkern.c         | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h | 27 +++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 734a004..18e623f 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -356,6 +356,54 @@ void iio_channel_release(struct iio_channel *channel)
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_release);
>  
> +static void devm_iio_channel_free(struct device *dev, void *res)
> +{
> +	struct iio_channel *channel = *(struct iio_channel **)res;
> +
> +	iio_channel_release(channel);
> +}
> +
> +static int devm_iio_channel_match(struct device *dev, void *res, void *data)
> +{
> +	struct iio_channel **r = res;
> +
> +	if (!r || !*r) {
> +		WARN_ON(!r || !*r);
> +		return 0;
> +	}
> +
> +	return *r == data;
> +}
> +
> +struct iio_channel *devm_iio_channel_get(struct device *dev,
> +					 const char *channel_name)
> +{
> +	struct iio_channel **ptr, *channel;
> +
> +	ptr = devres_alloc(devm_iio_channel_free, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	channel = iio_channel_get(dev, channel_name);
> +	if (IS_ERR(channel)) {
> +		devres_free(ptr);
> +		return channel;
> +	}
> +
> +	*ptr = channel;
> +	devres_add(dev, ptr);
> +
> +	return channel;
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_channel_get);
> +
> +void devm_iio_channel_release(struct device *dev, struct iio_channel *channel)
> +{
> +	WARN_ON(devres_release(dev, devm_iio_channel_free,
> +			       devm_iio_channel_match, channel));
> +}
> +EXPORT_SYMBOL_GPL(devm_iio_channel_release);
> +
>  struct iio_channel *iio_channel_get_all(struct device *dev)
>  {
>  	const char *name;
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index fad5867..e1e033d 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -49,6 +49,33 @@ struct iio_channel *iio_channel_get(struct device *dev,
>  void iio_channel_release(struct iio_channel *chan);
>  
>  /**
> + * devm_iio_channel_get() - Resource managed version of iio_channel_get().
> + * @dev:		Pointer to consumer device. Device name must match
> + *			the name of the device as provided in the iio_map
> + *			with which the desired provider to consumer mapping
> + *			was registered.
> + * @consumer_channel:	Unique name to identify the channel on the consumer
> + *			side. This typically describes the channels use within
> + *			the consumer. E.g. 'battery_voltage'
> + *
> + * Returns a pointer to negative errno if it is not able to get the iio channel
> + * otherwise returns valid pointer for iio channel.
> + *
> + * The allocated iio channel is automatically released when the device is
> + * unbound.
> + */
> +struct iio_channel *devm_iio_channel_get(struct device *dev,
> +					 const char *consumer_channel);
> +/**
> + * devm_iio_channel_release() - Resource managed version of
> + *				iio_channel_release().
> + * @dev:		Pointer to consumer device for which resource
> + *			is allocared.
> + * @chan:		The channel to be released.
> + */
> +void devm_iio_channel_release(struct device *dev, struct iio_channel *chan);
> +
> +/**
>   * iio_channel_get_all() - get all channels associated with a client
>   * @dev:		Pointer to consumer device.
>   *
> 

