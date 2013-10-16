Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55565 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760920Ab3JPRP0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:15:26 -0400
Message-ID: <525ED7E4.6010303@kernel.org>
Date: Wed, 16 Oct 2013 19:16:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 14/17] staging:iio:simple-dummy: Remove redundant call
 to iio_sw_buffer_preenable()
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-14-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-14-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git
> ---
>  drivers/staging/iio/iio_simple_dummy_buffer.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
> index 2612e87..46c134b 100644
> --- a/drivers/staging/iio/iio_simple_dummy_buffer.c
> +++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
> @@ -99,14 +99,6 @@ done:
>  
>  static const struct iio_buffer_setup_ops iio_simple_dummy_buffer_setup_ops = {
>  	/*
> -	 * iio_sw_buffer_preenable:
> -	 * Generic function for equal sized ring elements + 64 bit timestamp
> -	 * Assumes that any combination of channels can be enabled.
> -	 * Typically replaced to implement restrictions on what combinations
> -	 * can be captured (hardware scan modes).
> -	 */
> -	.preenable = &iio_sw_buffer_preenable,
> -	/*
>  	 * iio_triggered_buffer_postenable:
>  	 * Generic function that simply attaches the pollfunc to the trigger.
>  	 * Replace this to mess with hardware state before we attach the
> 
