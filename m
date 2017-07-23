Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbdGWLco (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 23 Jul 2017 07:32:44 -0400
Date: Sun, 23 Jul 2017 12:32:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2 01/11] iio: adc: ti-ads1015: fix incorrect data rate
 setting update
Message-ID: <20170723123239.7f05094a@kernel.org>
In-Reply-To: <1500564267-8613-2-git-send-email-akinobu.mita@gmail.com>
References: <1500564267-8613-1-git-send-email-akinobu.mita@gmail.com>
        <1500564267-8613-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 21 Jul 2017 00:24:17 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> The ti-ads1015 driver has eight iio voltage channels and each iio channel
> can hold own sampling frequency information.
> 
> The ADS1015 device only have a single config register which contains an
> input multiplexer selection, PGA and data rate settings.  So the driver
> should load the correct settings when the input multiplexer selection is
> changed.
> 
> However, regardless of which channlel is currently selected, changing any
> iio channel's sampling frequency information immediately overwrites the
> current data rate setting in the config register.
> 
> It breaks the current data rate setting if the different channel's sampling
> frequency information is changed because the data rate setting is not
> reloaded when the input multiplexer is switched.
> 
> This removes the unexpected config register update and correctly load the
> data rate setting before getting adc result.
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Looks good to me - ideally would have a fixes tag.

However, I'm a little nervous about this series in general
so would like to leave a little more time for Daniel to
have a chance to look.

Daniel, feel free to say you are too busy if you are and
I'll go with my own judgement.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/ti-ads1015.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 884b8e46..443444c 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -252,9 +252,11 @@ int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
>  
>  	ret = regmap_update_bits_check(data->regmap, ADS1015_CFG_REG,
>  				       ADS1015_CFG_MUX_MASK |
> -				       ADS1015_CFG_PGA_MASK,
> +				       ADS1015_CFG_PGA_MASK |
> +				       ADS1015_CFG_DR_MASK,
>  				       chan << ADS1015_CFG_MUX_SHIFT |
> -				       pga << ADS1015_CFG_PGA_SHIFT,
> +				       pga << ADS1015_CFG_PGA_SHIFT |
> +				       dr << ADS1015_CFG_DR_SHIFT,
>  				       &change);
>  	if (ret < 0)
>  		return ret;
> @@ -325,25 +327,16 @@ static int ads1015_set_scale(struct ads1015_data *data, int chan,
>  
>  static int ads1015_set_data_rate(struct ads1015_data *data, int chan, int rate)
>  {
> -	int i, ret, rindex = -1;
> +	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++)
> +	for (i = 0; i < ARRAY_SIZE(ads1015_data_rate); i++) {
>  		if (data->data_rate[i] == rate) {
> -			rindex = i;
> -			break;
> +			data->channel_data[chan].data_rate = i;
> +			return 0;
>  		}
> -	if (rindex < 0)
> -		return -EINVAL;
> -
> -	ret = regmap_update_bits(data->regmap, ADS1015_CFG_REG,
> -				 ADS1015_CFG_DR_MASK,
> -				 rindex << ADS1015_CFG_DR_SHIFT);
> -	if (ret < 0)
> -		return ret;
> -
> -	data->channel_data[chan].data_rate = rindex;
> +	}
>  
> -	return 0;
> +	return -EINVAL;
>  }
>  
>  static int ads1015_read_raw(struct iio_dev *indio_dev,

