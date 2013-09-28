Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41508 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821Ab3I1JqH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Sep 2013 05:46:07 -0400
Message-ID: <5246B388.2060101@kernel.org>
Date: Sat, 28 Sep 2013 11:46:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:iio-trig-bfin-timer: Fix compile error
References: <1380289838-27029-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380289838-27029-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/13 14:50, Lars-Peter Clausen wrote:
> This patch fixes the following compile errors for the iio-trig-bfin-timer
> driver:
> 	drivers/staging/iio/trigger/iio-trig-bfin-timer.c: In function ‘iio_bfin_tmr_frequency_store’:
> 	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:121: error: invalid storage class for function ‘iio_bfin_tmr_frequency_show’
> 	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:118: warning: ISO C90 forbids mixed declarations and code
> 	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:135: error: initializer element is not constant
> 	...
> 
> The issue was introduced in commit e5e26dd5 ("staging: iio: replace
> strict_strto*() with kstrto*()") by leaving an excess opening bracket.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> index ebb189c..26e1ca0 100644
> --- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> +++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
> @@ -91,7 +91,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	if (val > 100000) {
> +	if (val > 100000)
>  		return -EINVAL;
>  
>  	enabled = get_enabled_gptimers() & st->t->bit;
> 
