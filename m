Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45038 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbbKVMGp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Nov 2015 07:06:45 -0500
Subject: Re: [PATCH] IIO: adc: at91_adc.c Prefer kmalloc_array over kmalloc
 with multiply
To: Nizam Haider <nizamhaider786@gmail.com>
References: <1447632357-8222-1-git-send-email-nizamhaider786@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	leupold@rsi-elektrotechnik.de, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com, octavian.purdila@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5651AFD0.8060905@kernel.org>
Date: Sun, 22 Nov 2015 12:06:40 +0000
MIME-Version: 1.0
In-Reply-To: <1447632357-8222-1-git-send-email-nizamhaider786@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/11/15 00:05, Nizam Haider wrote:
> So this patch swaps that use out for kmalloc_array instead.
> 
> Signed-off-by Nizam Haider <nijamh@cdac.in>
Applied to the togreg branch of iio.git - initially push out as staging
Thanks,

Jonathan
> ---
>  drivers/iio/adc/at91_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 7b40925..f284cd6 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -742,7 +742,7 @@ static int at91_adc_of_get_resolution(struct at91_adc_state *st,
>  		return count;
>  	}
>  
> -	resolutions = kmalloc(count * sizeof(*resolutions), GFP_KERNEL);
> +	resolutions = kmalloc_array(count, sizeof(*resolutions), GFP_KERNEL);
>  	if (!resolutions)
>  		return -ENOMEM;
>  
> 

