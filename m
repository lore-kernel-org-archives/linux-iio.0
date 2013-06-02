Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49667 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762Ab3FBQKg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 12:10:36 -0400
Message-ID: <51AB6E79.7070108@kernel.org>
Date: Sun, 02 Jun 2013 17:10:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH 1/4] iio: frequency: ad4350: Fix bug / typo in mask
References: <1369321259-14602-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1369321259-14602-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/2013 04:00 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
I got lost in the original discussion.

Is this a fix for the current cycle, or does it want to go with the
rest of the series, for the next one?

I'm guessing you'll do a refreshed version with the bits in patch
4 fixed up so I'll wait for that to apply it.

Jonathan
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
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
> 
