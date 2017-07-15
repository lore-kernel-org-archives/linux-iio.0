Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbdGOMTI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Jul 2017 08:19:08 -0400
Date: Sat, 15 Jul 2017 13:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>,
        daniel.baluta@gmail.com
Subject: Re: [PATCH 2/8] iio: adc: ti-ads1015: remove unnecessary config
 register update
Message-ID: <20170715131905.5626b6c3@kernel.org>
In-Reply-To: <1499877124-21658-3-git-send-email-akinobu.mita@gmail.com>
References: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
        <1499877124-21658-3-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 13 Jul 2017 01:31:58 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The ti-ads1015 driver has eight iio voltage channels and each iio channel
> can hold own scale information.
> 
> The ADS1015 device only have a single config register which contains an
> input multiplexer selection, PGA and data rate settings.  So the driver
> should load the correct settings when the input multiplexer selection is
> changed.
> 
> However, regardless of which channlel is currently selected, changing any
> iio channel's scale information immediately overwrites the current PGA
> setting in the config register.
> 
> It is harmless because the correct PGA settings are reloaded just before
> getting adc result anyway.  But it is unnecessary register update and
> should be removed.
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Make sense but this one is as you say harmless so I'm 
not tempted to send it as a fix for stable.   The first
one 'might' go as such.

Input from Daniel still welcome though.
Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 7e21151..94c2221 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -303,26 +303,17 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>  static int ads1015_set_scale(struct ads1015_data *data, int chan,
>  			     int scale, int uscale)
>  {
> -	int i, ret, rindex = -1;
> +	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++)
> +	for (i = 0; i < ARRAY_SIZE(ads1015_scale); i++) {
>  		if (ads1015_scale[i].scale == scale &&
>  		    ads1015_scale[i].uscale == uscale) {
> -			rindex = i;
> -			break;
> +			data->channel_data[chan].pga = i;
> +			return 0;
>  		}
> -	if (rindex < 0)
> -		return -EINVAL;
> -
> -	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				 ADS1015_CFG_PGA_MASK,
> -				 rindex << ADS1015_CFG_PGA_SHIFT);
> -	if (ret < 0)
> -		return ret;
> -
> -	data->channel_data[chan].pga = rindex;
> +	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)

