Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-246.synserver.de ([212.40.185.246]:1199 "EHLO
	smtp-out-234.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752451Ab3FDOFO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 10:05:14 -0400
Message-ID: <51ADF25E.3050701@metafoo.de>
Date: Tue, 04 Jun 2013 15:57:50 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: jic23@kernel.org, linux-iio@vger.kernel.org,
	Lars-Peter.Clausen@analog.com, dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 1/4] iio: frequency: ad4350: Fix bug / typo
 in mask
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2013 03:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> t
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>me.

FWIW, complete series looks good to. All four patches:

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  drivers/iio/frequency/adf4350.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
> index a884252..e76d4ac 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -212,7 +212,7 @@ static int adf4350_set_freq(struct adf4350_state *st, unsigned long long freq)
>  		(pdata->r2_user_settings & (ADF4350_REG2_PD_POLARITY_POS |
>  		ADF4350_REG2_LDP_6ns | ADF4350_REG2_LDF_INT_N |
>  		ADF4350_REG2_CHARGE_PUMP_CURR_uA(5000) |
> -		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x9)));
> +		ADF4350_REG2_MUXOUT(0x7) | ADF4350_REG2_NOISE_MODE(0x3)));
>  
>  	st->regs[ADF4350_REG3] = pdata->r3_user_settings &
>  				 (ADF4350_REG3_12BIT_CLKDIV(0xFFF) |

