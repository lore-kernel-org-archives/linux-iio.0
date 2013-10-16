Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55509 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761111Ab3JPROQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:14:16 -0400
Message-ID: <525ED79D.9050304@kernel.org>
Date: Wed, 16 Oct 2013 19:14:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Jacek Anaszewski <j.anaszewski@samsung.com>
Subject: Re: [PATCH 11/17] iio:gp2ap020a00f: Remove redundant call to iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Applied to the togreg branch of iio.git

thanks
> ---
>  drivers/iio/light/gp2ap020a00f.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> index 2a65bc3..a530e77 100644
> --- a/drivers/iio/light/gp2ap020a00f.c
> +++ b/drivers/iio/light/gp2ap020a00f.c
> @@ -1483,7 +1483,6 @@ error_unlock:
>  }
>  
>  static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
> -	.preenable = &iio_sw_buffer_preenable,
>  	.postenable = &gp2ap020a00f_buffer_postenable,
>  	.predisable = &gp2ap020a00f_buffer_predisable,
>  };
> 
