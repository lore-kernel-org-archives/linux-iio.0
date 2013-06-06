Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51033 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700Ab3FFS0d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2013 14:26:33 -0400
Message-ID: <51B0D459.1080702@kernel.org>
Date: Thu, 06 Jun 2013 19:26:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de, kbuild-all@01.org,
	Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] iio:trigger:interrupt fix formatting of rsize variable
 in name
References: <1370543094-10248-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1370543094-10248-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/2013 07:24 PM, Jonathan Cameron wrote:
> The name includes irq_res->start which of type resource_size_t not integer.
> We could in theory use %pa for this but then it would be in hex and also
> that causes a warning about incorrect types anyway.  Hence just
> use the irq local variable we assigned the line above.
> 
Sorry, sent the wrong version out due to forgetting to update the commit.

> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/iio/trigger/iio-trig-interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 84bf397..0a6756d 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -50,7 +50,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  
>  	irq = irq_res->start;
>  
> -	trig = iio_trigger_alloc("irqtrig%d", irq_res->start);
> +	trig = iio_trigger_alloc("irqtrig%zu", irq_res->start);
>  	if (!trig) {
>  		ret = -ENOMEM;
>  		goto error_ret;
> 
