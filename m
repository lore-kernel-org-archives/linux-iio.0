Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39775 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932396Ab3JORWd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 13:22:33 -0400
Message-ID: <525D880E.7050109@kernel.org>
Date: Tue, 15 Oct 2013 19:23:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:buffer: Free active scan mask in iio_disable_all_buffers()
References: <1381826312-26546-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381826312-26546-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/13 09:38, Lars-Peter Clausen wrote:
> Usually the active scan mask is freed in __iio_update_buffers() when the buffer
> is disabled. But when the device is still sampling when it is removed we'll end
> up disabling the buffers in iio_disable_all_buffers(). So we also need to free
> the active scan mask here, otherwise it will be leaked.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Good spot. Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 796376a..1c72080 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -490,6 +490,9 @@ void iio_disable_all_buffers(struct iio_dev *indio_dev)
>  	indio_dev->currentmode = INDIO_DIRECT_MODE;
>  	if (indio_dev->setup_ops->postdisable)
>  		indio_dev->setup_ops->postdisable(indio_dev);
> +
> +	if (indio_dev->available_scan_masks == NULL)
> +		kfree(indio_dev->active_scan_mask);
>  }
>  
>  static int __iio_update_buffers(struct iio_dev *indio_dev,
> 
