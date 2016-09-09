Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:42133 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbcIIN70 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 09:59:26 -0400
Subject: Re: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass
 checkpatch.pl
To: Ico Doornekamp <ico@pruts.nl>, jic23@kernel.org
References: <20160909134026.12055-1-ico@pruts.nl>
Cc: linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <d848e8a4-d21d-8221-9e36-e89f653f9a35@metafoo.de>
Date: Fri, 9 Sep 2016 15:59:21 +0200
MIME-Version: 1.0
In-Reply-To: <20160909134026.12055-1-ico@pruts.nl>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Thanks for the patch. But this not a correct change, it is a false positive
reported by checkpatch.

- Lars

On 09/09/2016 03:40 PM, Ico Doornekamp wrote:
> ---
>  drivers/staging/iio/adc/ad7192.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 1cf6b79..5688b29 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -391,7 +391,7 @@ ad7192_show_scale_available(struct device *dev,
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> +			     in_voltage - voltage_scale_available,
>  			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
>  
>  static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
> 

