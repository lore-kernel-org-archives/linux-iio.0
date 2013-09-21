Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56565 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752211Ab3IUK5i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:57:38 -0400
Message-ID: <523D89C6.3060001@kernel.org>
Date: Sat, 21 Sep 2013 12:57:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/10] iio:buffer: Ignore noop requests for iio_update_buffers()
References: <1379534574-11213-1-git-send-email-lars@metafoo.de> <1379534574-11213-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1379534574-11213-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 21:02, Lars-Peter Clausen wrote:
> Since the kernel now disables all buffers when a device is unregistered it might
> happen that a in-kernel consumer tries to disable that buffer again. So ignore
> requests where the buffer already is in the desired state.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/industrialio-buffer.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 8ceaaaf..2b36cea 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -673,9 +673,21 @@ int iio_update_buffers(struct iio_dev *indio_dev,
>  {
>  	int ret;
>  
> +	if (insert_buffer == remove_buffer)
> +		return 0;
> +
Can this first case occur without a bug in the calling function?

The rest are fine.
>  	mutex_lock(&indio_dev->info_exist_lock);
>  	mutex_lock(&indio_dev->mlock);
>  
> +	if (insert_buffer && iio_buffer_is_active(insert_buffer))
> +		insert_buffer = NULL;
> +
> +	if (remove_buffer && !iio_buffer_is_active(remove_buffer))
> +		remove_buffer = NULL;
> +
> +	if (!insert_buffer && !remove_buffer)
> +		return 0;
> +
>  	if (indio_dev->info == NULL)
>  		return -ENODEV;
>  
> 
