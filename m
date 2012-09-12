Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33857 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab2ILRas (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Sep 2012 13:30:48 -0400
Message-ID: <5050C6C5.3020304@kernel.org>
Date: Wed, 12 Sep 2012 18:30:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] staging:iio:dummy: Fix potential NULL pointer dereference
References: <1347447997-16473-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1347447997-16473-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/12/2012 12:06 PM, Lars-Peter Clausen wrote:
> If the config contains CONFIG_IIO_BUFFER=y and CONFIG_IIO_SIMPLE_DUMMY_BUFFER=n
> iio_simple_dummy_configure_buffer() is stubbed out and iio_buffer_register() is
> not. As a result we try to register a buffer which has not been configured.
> This will causes a NULL pointer deref in iio_buffer_register. To solve this
> issue move the iio_buffer_register() call to iio_simple_dummy_configure_buffer(),
> so it will only be called if iio_simple_dummy_configure_buffer() has been called.
> 
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Merge to fixes-togreg branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

> ---
> Just noticed I never really sent this patch out...
Yup, I've still got that thread flagged as expecting a followup ;)
> ---
>  drivers/staging/iio/iio_simple_dummy.c        |   20 +++++++-------------
>  drivers/staging/iio/iio_simple_dummy.h        |    6 ++++--
>  drivers/staging/iio/iio_simple_dummy_buffer.c |   11 ++++++++++-
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
> index 029bcc6..dc6c728 100644
> --- a/drivers/staging/iio/iio_simple_dummy.c
> +++ b/drivers/staging/iio/iio_simple_dummy.c
> @@ -445,26 +445,20 @@ static int __devinit iio_dummy_probe(int index)
>  	if (ret < 0)
>  		goto error_free_device;
>  
> -	/* Configure buffered capture support. */
> -	ret = iio_simple_dummy_configure_buffer(indio_dev);
> -	if (ret < 0)
> -		goto error_unregister_events;
> -
>  	/*
> -	 * Register the channels with the buffer, but avoid the output
> -	 * channel being registered by reducing the number of channels by 1.
> +	 * Configure buffered capture support and register the channels with the
> +	 * buffer, but avoid the output channel being registered by reducing the
> +	 * number of channels by 1.
>  	 */
> -	ret = iio_buffer_register(indio_dev, iio_dummy_channels, 5);
> +	ret = iio_simple_dummy_configure_buffer(indio_dev, iio_dummy_channels, 5);
>  	if (ret < 0)
> -		goto error_unconfigure_buffer;
> +		goto error_unregister_events;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
> -		goto error_unregister_buffer;
> +		goto error_unconfigure_buffer;
>  
>  	return 0;
> -error_unregister_buffer:
> -	iio_buffer_unregister(indio_dev);
>  error_unconfigure_buffer:
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  error_unregister_events:
> @@ -499,7 +493,6 @@ static int iio_dummy_remove(int index)
>  	/* Device specific code to power down etc */
>  
>  	/* Buffered capture related cleanup */
> -	iio_buffer_unregister(indio_dev);
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  
>  	ret = iio_simple_dummy_events_unregister(indio_dev);
> @@ -530,6 +523,7 @@ static __init int iio_dummy_init(void)
>  		instances = 1;
>  		return -EINVAL;
>  	}
> +
>  	/* Fake a bus */
>  	iio_dummy_devs = kcalloc(instances, sizeof(*iio_dummy_devs),
>  				 GFP_KERNEL);
> diff --git a/drivers/staging/iio/iio_simple_dummy.h b/drivers/staging/iio/iio_simple_dummy.h
> index 53975d9..c9e8702 100644
> --- a/drivers/staging/iio/iio_simple_dummy.h
> +++ b/drivers/staging/iio/iio_simple_dummy.h
> @@ -95,10 +95,12 @@ enum iio_simple_dummy_scan_elements {
>  };
>  
>  #ifdef CONFIG_IIO_SIMPLE_DUMMY_BUFFER
> -int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev);
> +int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *channels, unsigned int num_channels);
>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev);
>  #else
> -static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
> +static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *channels, unsigned int num_channels)
>  {
>  	return 0;
>  };
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 1fd3809..697d970 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -126,7 +126,8 @@ static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
>  	.predisable = &iio_triggered_buffer_predisable,
>  };
>  
> -int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
> +int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev,
> +	const struct iio_chan_spec *channels, unsigned int num_channels)
>  {
>  	int ret;
>  	struct iio_buffer *buffer;
> @@ -182,8 +183,15 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
>  	 * driven by a trigger.
>  	 */
>  	indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
> +
> +	ret = iio_buffer_register(indio_dev, channels, num_channels);
> +	if (ret)
> +		goto error_dealloc_pollfunc;
> +
>  	return 0;
>  
> +error_dealloc_pollfunc:
> +	iio_dealloc_pollfunc(indio_dev->pollfunc);
>  error_free_buffer:
>  	iio_kfifo_free(indio_dev->buffer);
>  error_ret:
> @@ -197,6 +205,7 @@ error_ret:
>   */
>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
>  {
> +	iio_buffer_unregister(indio_dev);
>  	iio_dealloc_pollfunc(indio_dev->pollfunc);
>  	iio_kfifo_free(indio_dev->buffer);
>  }
> 
