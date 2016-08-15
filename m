Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42093 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752877AbcHORCP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 13:02:15 -0400
Subject: Re: [PATCH 1/2] iio: adc: Use complete() instead of complete_all()
To: Daniel Wagner <wagi@monom.org>
References: <1470316030-4153-1-git-send-email-wagi@monom.org>
 <1470316030-4153-2-git-send-email-wagi@monom.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c8d17aaf-ab46-7d82-4dd5-6f69d65df674@kernel.org>
Date: Mon, 15 Aug 2016 18:02:13 +0100
MIME-Version: 1.0
In-Reply-To: <1470316030-4153-2-git-send-email-wagi@monom.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/16 14:07, Daniel Wagner wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
> 
> There is only one waiter for the completion, therefore there
> is no need to use complete_all(). Let's make that clear by
> using complete() instead of complete_all().
> 
> The usage pattern of the completion is:
> 
> waiter context                          waker context
> 
> nau7802_read_irq()
>   reinit_completion()
>   nau7802_read_conversion()
>   wait_for_completion_interruptible_timeout()
> 
>                                         nau7802_eoc_trigger()
>                                           complete()
> 
> Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
Applied to the togreg branch of iio.git - initially pushed
out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/nau7802.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index db9b829..08f4466 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -197,7 +197,7 @@ static irqreturn_t nau7802_eoc_trigger(int irq, void *private)
>  	if (st->conversion_count < NAU7802_MIN_CONVERSIONS)
>  		st->conversion_count++;
>  	if (st->conversion_count >= NAU7802_MIN_CONVERSIONS)
> -		complete_all(&st->value_ok);
> +		complete(&st->value_ok);
>  
>  	return IRQ_HANDLED;
>  }
> 

