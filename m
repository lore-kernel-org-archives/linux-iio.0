Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59320 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753955Ab2BJVuv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2012 16:50:51 -0500
Message-ID: <4F359170.9040106@kernel.org>
Date: Fri, 10 Feb 2012 21:51:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging:iio: Remove declaration for non existing
 function
References: <1328898269-26197-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1328898269-26197-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/10/2012 06:24 PM, Lars-Peter Clausen wrote:
> The declaration for iio_buffer_deinit has been around for quite some time, but
> the function itself has never been added. So remove the declaration.
> 
oops
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/buffer.h |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
> index 6fb6e64..df2046d 100644
> --- a/drivers/staging/iio/buffer.h
> +++ b/drivers/staging/iio/buffer.h
> @@ -91,8 +91,6 @@ struct iio_buffer {
>   **/
>  void iio_buffer_init(struct iio_buffer *buffer);
>  
> -void iio_buffer_deinit(struct iio_buffer *buffer);
> -
>  /**
>   * __iio_update_buffer() - update common elements of buffers
>   * @buffer:		buffer that is the event source

