Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1047 "EHLO
	smtp-out-085.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbaHWHAL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Aug 2014 03:00:11 -0400
Message-ID: <53F83BF6.5080705@metafoo.de>
Date: Sat, 23 Aug 2014 09:00:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 3/8] iio: adc: ad_sigma_delta: Fix indio_dev->trig
 assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-4-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-4-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/22/2014 10:48 PM, Srinivas Pandruvada wrote:
> This can result in wrong reference count for trigger device, call
> iio_trigger_get to increment reference.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/iio/adc/ad_sigma_delta.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
> index c55b81f..d10bd0c 100644
> --- a/drivers/iio/adc/ad_sigma_delta.c
> +++ b/drivers/iio/adc/ad_sigma_delta.c
> @@ -472,7 +472,7 @@ static int ad_sd_probe_trigger(struct iio_dev *indio_dev)
>   		goto error_free_irq;
>
>   	/* select default trigger */
> -	indio_dev->trig = sigma_delta->trig;
> +	indio_dev->trig = iio_trigger_get(sigma_delta->trig);
>
>   	return 0;
>
>

