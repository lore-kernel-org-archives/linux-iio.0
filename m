Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-085.synserver.de ([212.40.185.85]:1030 "EHLO
	smtp-out-085.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752331AbaHWHAX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Aug 2014 03:00:23 -0400
Message-ID: <53F83C03.50202@metafoo.de>
Date: Sat, 23 Aug 2014 09:00:19 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 8/8] iio: meter: ade7758: Fix indio_dev->trig assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-9-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-9-git-send-email-srinivas.pandruvada@linux.intel.com>
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
>   drivers/staging/iio/meter/ade7758_trigger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
> index ea01b8f..6f45ce0 100644
> --- a/drivers/staging/iio/meter/ade7758_trigger.c
> +++ b/drivers/staging/iio/meter/ade7758_trigger.c
> @@ -85,7 +85,7 @@ int ade7758_probe_trigger(struct iio_dev *indio_dev)
>   	ret = iio_trigger_register(st->trig);
>
>   	/* select default trigger */
> -	indio_dev->trig = st->trig;
> +	indio_dev->trig = iio_trigger_get(st->trig);
>   	if (ret)
>   		goto error_free_irq;
>
>

