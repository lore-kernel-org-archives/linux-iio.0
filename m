Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39698 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902Ab3JORSl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 13:18:41 -0400
Message-ID: <525D8725.9060706@kernel.org>
Date: Tue, 15 Oct 2013 19:19:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio:kfifo: Fix memory leak
References: <1381825830-25581-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1381825830-25581-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/15/13 09:30, Lars-Peter Clausen wrote:
> We need to free the kfifo when we release the buffer, otherwise the fifos memory
> will be leaked.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch.
> 
> ---
> New in v2
> 
> Btw. This is all against togreg, since it is probably already to late for
> fixes-togreg.
Indeed, probably is.

We should work out which of these we want stable to pick up at somepoint though...

> ---
>  drivers/iio/kfifo_buf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/kfifo_buf.c b/drivers/iio/kfifo_buf.c
> index b4ac55a..ce51092 100644
> --- a/drivers/iio/kfifo_buf.c
> +++ b/drivers/iio/kfifo_buf.c
> @@ -132,7 +132,10 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  
>  static void iio_kfifo_buffer_release(struct iio_buffer *buffer)
>  {
> -	kfree(iio_to_kfifo(buffer));
> +	struct iio_kfifo *kf = iio_to_kfifo(buffer);
> +
> +	kfifo_free(&kf->kf);
> +	kfree(kf);
>  }
>  
>  static const struct iio_buffer_access_funcs kfifo_access_funcs = {
> 
