Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41654 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab3I1KBI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 06:01:08 -0400
Message-ID: <5246B70D.9070708@kernel.org>
Date: Sat, 28 Sep 2013 12:01:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: Remove debugfs entries in iio_device_unregister()
References: <1379776901-19429-1-git-send-email-lars@metafoo.de> <1379776901-19429-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1379776901-19429-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/21/13 16:21, Lars-Peter Clausen wrote:
> Remove the the debugfs entries in iio_device_unregister(). Otherwise the debugfs
> entries might still be accessible even though the device used in the debugfs
> callback has already been freed.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/industrialio-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d189f6c..b8a16d7 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -853,7 +853,6 @@ static void iio_dev_release(struct device *device)
>  		iio_device_unregister_trigger_consumer(indio_dev);
>  	iio_device_unregister_eventset(indio_dev);
>  	iio_device_unregister_sysfs(indio_dev);
> -	iio_device_unregister_debugfs(indio_dev);
>  
>  	if (indio_dev->buffer)
>  		iio_buffer_put(indio_dev->buffer);
> @@ -1091,6 +1090,7 @@ void iio_device_unregister(struct iio_dev *indio_dev)
>  
>  	if (indio_dev->chrdev.dev)
>  		cdev_del(&indio_dev->chrdev);
> +	iio_device_unregister_debugfs(indio_dev);
>  
>  	iio_disable_all_buffers(indio_dev);
>  
> 
