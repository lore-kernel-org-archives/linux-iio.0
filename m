Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53071 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756997Ab3IOPjP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Sep 2013 11:39:15 -0400
Message-ID: <5235E2C1.6020606@kernel.org>
Date: Sun, 15 Sep 2013 17:39:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:kfifo_buf: Use wake_up_interruptible_poll()
References: <1379259094-22577-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1379259094-22577-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/15/13 16:31, Lars-Peter Clausen wrote:
> Use wake_up_interruptible_poll() instead of wake_up_interruptible() to only wake
> up those threads that listen for input poll notifications.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
You learn something new every day (or several things today!)...

Applied to the togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/kfifo_buf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index a923c78..1bea41b 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -7,6 +7,7 @@
>  #include <linux/mutex.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/sched.h>
> +#include <linux/poll.h>
>  
>  struct iio_kfifo {
>  	struct iio_buffer buffer;
> @@ -102,7 +103,7 @@ static int iio_store_to_kfifo(struct iio_buffer *r,
>  	if (ret != 1)
>  		return -EBUSY;
>  	r->stufftoread = true;
> -	wake_up_interruptible(&r->pollq);
> +	wake_up_interruptible_poll(&r->pollq, POLLIN | POLLRDNORM);
>  
>  	return 0;
>  }
> 
