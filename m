Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48131 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbcDPMdd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 08:33:33 -0400
Subject: Re: [PATCH 05/10] iio: adc: at91_adc: fix errors reported by
 checkpatch.pl
To: Slawomir Stepien <sst@poczta.fm>, knaack.h@gmx.de,
	pmeerw@pmeerw.net
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
 <1460662602-2951-6-git-send-email-sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5712311C.7080709@kernel.org>
Date: Sat, 16 Apr 2016 13:33:32 +0100
MIME-Version: 1.0
In-Reply-To: <1460662602-2951-6-git-send-email-sst@poczta.fm>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 20:36, Slawomir Stepien wrote:
> This fixes the errors reported by checkpatch.pl:
> 
> ERROR: space prohibited before that ',' (ctx:WxW)
> ERROR: code indent should use tabs where possible
Ouch - not sure how that one snuck in!

Applied and thanks,

Jonathan
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/iio/adc/at91_adc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index f284cd6..52430ba 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -797,8 +797,8 @@ static u32 calc_startup_ticks_9x5(u32 startup_time, u32 adc_clk_khz)
>  	 * Startup Time = <lookup_table_value> / ADC Clock
>  	 */
>  	const int startup_lookup[] = {
> -		0  , 8  , 16 , 24 ,
> -		64 , 80 , 96 , 112,
> +		0,   8,   16,  24,
> +		64,  80,  96,  112,
>  		512, 576, 640, 704,
>  		768, 832, 896, 960
>  		};
> @@ -924,14 +924,14 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  			ret = -EINVAL;
>  			goto error_ret;
>  		}
> -	        trig->name = name;
> +		trig->name = name;
>  
>  		if (of_property_read_u32(trig_node, "trigger-value", &prop)) {
>  			dev_err(&idev->dev, "Missing trigger-value property in the DT.\n");
>  			ret = -EINVAL;
>  			goto error_ret;
>  		}
> -	        trig->value = prop;
> +		trig->value = prop;
>  		trig->is_external = of_property_read_bool(trig_node, "trigger-external");
>  		i++;
>  	}
> 

