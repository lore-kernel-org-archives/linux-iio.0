Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752524AbdHTLFV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 07:05:21 -0400
Date: Sun, 20 Aug 2017 11:58:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 07/11] iio: adc: ti-ads1015: remove unnecessary
 config register update
Message-ID: <20170820115847.6e5be80f@archlinux>
In-Reply-To: <1500564267-8613-8-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
        <1500564267-8613-8-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 21 Jul 2017 00:24:23 +0900
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
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 9c501e5..e83cebc 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -312,28 +312,18 @@ static int ads1015_set_scale(struct ads1015_data *data,
>  			     struct iio_chan_spec const *chan,
>  			     int scale, int uscale)
>  {
> -	int i, ret, rindex = -1;
> +	int i;
>  	int fullscale = div_s64((scale * 1000000LL + uscale) <<
>  				(chan->scan_type.realbits - 1), 1000000);
>  
>  	for (i = 0; i < ARRAY_SIZE(ads1015_fullscale_range); i++) {
>  		if (ads1015_fullscale_range[i] == fullscale) {
> -			rindex = i;
> -			break;
> +			data->channel_data[chan->address].pga = i;
> +			return 0;
>  		}
>  	}
> -	if (rindex < 0)
> -		return -EINVAL;
> -
> -	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				 ADS1015_CFG_PGA_MASK,
> -				 rindex << ADS1015_CFG_PGA_SHIFT);
> -	if (ret < 0)
> -		return ret;
> -
> -	data->channel_data[chan->address].pga = rindex;
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)

