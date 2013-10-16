Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55475 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761123Ab3JPRNH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:13:07 -0400
Message-ID: <525ED759.6080704@kernel.org>
Date: Wed, 16 Oct 2013 19:13:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/17] iio:triggered-buffer: Remove redundant call to
 iio_sw_buffer_preenable().
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-8-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied
> ---
>  drivers/iio/industrialio-triggered-buffer.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
> index c1cb1f9..d6f54930 100644
> --- a/drivers/iio/industrialio-triggered-buffer.c
> +++ b/drivers/iio/industrialio-triggered-buffer.c
> @@ -17,7 +17,6 @@
>  #include <linux/iio/trigger_consumer.h>
>  
>  static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
>  	.postenable = &iio_triggered_buffer_postenable,
>  	.predisable = &iio_triggered_buffer_predisable,
>  };
> 
