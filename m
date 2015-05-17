Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58837 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbbEQImR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2015 04:42:17 -0400
Message-ID: <55585467.5080705@kernel.org>
Date: Sun, 17 May 2015 09:42:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: Replace printk in __iio_update_buffers with
 dev_dbg
References: <1431525891-19285-1-git-send-email-lars@metafoo.de> <1431525891-19285-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1431525891-19285-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/05/15 15:04, Lars-Peter Clausen wrote:
> While more verbose error messages are useful for debugging we should really
> not put those error messages into the kernel log for normal errors that are
> already reported to the application via the error code, when running in
> non-debug mode.
> 
> Otherwise application authors might expect that this is part of the ABI and
> to get the error they should scan the kernel log. Which would be rather
> error prone itself since there is no direct mapping between a operation and
> the error message so it is impossible to find out which error message
> belongs to which error.
Let's just hope no one is using these already!
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git, initially pushed out as testing (etc etc).

> ---
>  drivers/iio/industrialio-buffer.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index df919f4..1f91031 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -663,7 +663,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  	if (indio_dev->setup_ops->preenable) {
>  		ret = indio_dev->setup_ops->preenable(indio_dev);
>  		if (ret) {
> -			printk(KERN_ERR
> +			dev_dbg(&indio_dev->dev,
>  			       "Buffer not started: buffer preenable failed (%d)\n", ret);
>  			goto error_remove_inserted;
>  		}
> @@ -677,7 +677,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  		if (buffer->access->request_update) {
>  			ret = buffer->access->request_update(buffer);
>  			if (ret) {
> -				printk(KERN_INFO
> +				dev_dbg(&indio_dev->dev,
>  				       "Buffer not started: buffer parameter update failed (%d)\n", ret);
>  				goto error_run_postdisable;
>  			}
> @@ -688,7 +688,9 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  			->update_scan_mode(indio_dev,
>  					   indio_dev->active_scan_mask);
>  		if (ret < 0) {
> -			printk(KERN_INFO "Buffer not started: update scan mode failed (%d)\n", ret);
> +			dev_dbg(&indio_dev->dev,
> +				"Buffer not started: update scan mode failed (%d)\n",
> +				ret);
>  			goto error_run_postdisable;
>  		}
>  	}
> @@ -702,7 +704,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  	} else { /* Should never be reached */
>  		/* Can only occur on first buffer */
>  		if (indio_dev->modes & INDIO_BUFFER_TRIGGERED)
> -			pr_info("Buffer not started: no trigger\n");
> +			dev_dbg(&indio_dev->dev, "Buffer not started: no trigger\n");
>  		ret = -EINVAL;
>  		goto error_run_postdisable;
>  	}
> @@ -710,7 +712,7 @@ static int __iio_update_buffers(struct iio_dev *indio_dev,
>  	if (indio_dev->setup_ops->postenable) {
>  		ret = indio_dev->setup_ops->postenable(indio_dev);
>  		if (ret) {
> -			printk(KERN_INFO
> +			dev_dbg(&indio_dev->dev,
>  			       "Buffer not started: postenable failed (%d)\n", ret);
>  			indio_dev->currentmode = INDIO_DIRECT_MODE;
>  			if (indio_dev->setup_ops->postdisable)
> 

