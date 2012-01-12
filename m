Return-Path: <jic23@kernel.org>
Message-ID: <4F0F35EA.1010507@kernel.org>
Date: Thu, 12 Jan 2012 19:35:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, jic23@cam.ac.uk
Subject: Re: [PATCH 3/3] staging: iio: core: add error message when buffer
 length is zero
References: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <1326124974-7288-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1326124974-7288-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

I'd like a little more or a commit message for this.

Why is such a message useful?  (I agree it probably is, having
at least once stumbled into a 0 length buffer myself).

Anyhow, a good idea.
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

Thanks for these 3 patches Manuel, and glad to see you are active in IIO
again!
> ---
>  drivers/staging/iio/industrialio-buffer.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
> index f5c4999..c789d39 100644
> --- a/drivers/staging/iio/industrialio-buffer.c
> +++ b/drivers/staging/iio/industrialio-buffer.c
> @@ -426,6 +426,17 @@ ssize_t iio_buffer_store_enable(struct device *dev,
>  		goto done;
>  	}
>  	if (requested_state) {
> +		if (buffer->access->get_length) {
> +			ret = buffer->access->get_length(buffer);
> +			if (ret <= 0) {
> +				printk(KERN_INFO
> +				       "Buffer not started: "
> +				       "buffer length must be greater than zero\n");
> +				ret = -EINVAL;
> +				goto error_ret;
> +			}
> +		}
> +
>  		if (indio_dev->setup_ops->preenable) {
>  			ret = indio_dev->setup_ops->preenable(indio_dev);
>  			if (ret) {
