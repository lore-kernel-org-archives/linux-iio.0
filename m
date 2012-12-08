Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44538 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab2LHJxe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Dec 2012 04:53:34 -0500
Message-ID: <50C30E1D.40708@kernel.org>
Date: Sat, 08 Dec 2012 09:53:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: Re: [PATCH] iio:adf4350: Fix typo
References: <1354810171-18780-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1354810171-18780-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/06/2012 04:09 PM, Lars-Peter Clausen wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> There is a typo in the adf4350 driver turning a shift into a compare. This patch
> fixes it.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
added to fixes-togreg branch of iio.git

> ---
>  drivers/iio/frequency/adf4350.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index e35bb8f..c7de8b5 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -173,7 +173,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>  			} while ((st->r1_mod > ADF4350_MAX_MODULUS) && r_cnt);
>  		} while (r_cnt == 0);
>  
> -		tmp = freq * (u64)st->r1_mod + (st->fpfd > 1);
> +		tmp = freq * (u64)st->r1_mod + (st->fpfd >> 1);
>  		do_div(tmp, st->fpfd); /* Div round closest (n + d/2)/d */
>  		st->r0_fract = do_div(tmp, st->r1_mod);
>  		st->r0_int = tmp;
> 
