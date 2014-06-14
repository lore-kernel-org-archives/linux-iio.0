Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:44681 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbaFNPjY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 14 Jun 2014 11:39:24 -0400
Message-ID: <539C6D20.7080907@kernel.org>
Date: Sat, 14 Jun 2014 16:41:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Himangi Saraogi <himangi774@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
CC: julia.lawall@lip6.fr
Subject: Re: [PATCH] iio: adc: at91_adc: Correct call to input_free_device
References: <20140613171146.GA2831@himangi-Dell>
In-Reply-To: <20140613171146.GA2831@himangi-Dell>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/06/14 18:11, Himangi Saraogi wrote:
> This error handling code can be reached before st->ts_input is
> initialized, so it is safer to always use the original name, input_dev.
>
> A simplified version of the semantic match that finds this problem is:
>
> // <smpl>
> @r exists@
> local idexpression struct input_dev * x;
> expression ra,rr;
> @@
>
> * x = input_allocate_device(...)
> ...  when != x = rr
>       when != input_free_device(x,...)
>       when != if (...) { ... input_free_device(x,...) ...}
> if(...) { ... when != x = ra
>       when forall
> *     when != input_free_device(x,...)
>   \(return <+...x...+>; \| return...; \) }
>
> // </smpl>
>
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
The error handling in this function has been completely rewritten so the
bug is no longer there and this no longer applies.

Thanks,

Jonathan
> ---
>   drivers/iio/adc/at91_adc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 3b5bacd..73b2bb5 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1114,7 +1114,7 @@ static int at91_ts_register(struct at91_adc_state *st,
>   	return ret;
>
>   err:
> -	input_free_device(st->ts_input);
> +	input_free_device(input);
>   	return ret;
>   }
>
>

