Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51130 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284Ab3FDRgJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Jun 2013 13:36:09 -0400
Message-ID: <51AE2588.6070501@kernel.org>
Date: Tue, 04 Jun 2013 18:36:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, Lars-Peter.Clausen@analog.com,
	dan.carpenter@oracle.com
Subject: Re: [PATCH RESEND V2 1/4] iio: frequency: ad4350: Fix bug / typo
 in mask
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/03/2013 02:30 PM, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Applied to fixes-togreg branch of iio.git
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
