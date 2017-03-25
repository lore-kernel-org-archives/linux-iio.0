Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43602 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751242AbdCYROi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 13:14:38 -0400
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix permission coding style
 issue
To: Olivier Leveque <o_leveque@orange.fr>, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org
References: <1490275089-2737-1-git-send-email-o_leveque@orange.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b3ddef00-5a0a-cc1e-3776-53142cbca7a2@kernel.org>
Date: Sat, 25 Mar 2017 17:07:53 +0000
MIME-Version: 1.0
In-Reply-To: <1490275089-2737-1-git-send-email-o_leveque@orange.fr>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/03/17 13:18, Olivier Leveque wrote:
> Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider using
> octal permissions '0644'. Found running checkpatch.
> 
> Signed-off-by: Olivier Leveque <o_leveque@orange.fr>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7280a.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 6a85e28..d5ab83f 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -560,7 +560,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  			st->iio_attr[cnt].address =
>  				AD7280A_DEVADDR(dev) << 8 | ch;
>  			st->iio_attr[cnt].dev_attr.attr.mode =
> -				S_IWUSR | S_IRUGO;
> +				0644;
>  			st->iio_attr[cnt].dev_attr.show =
>  				ad7280_show_balance_sw;
>  			st->iio_attr[cnt].dev_attr.store =
> @@ -577,7 +577,7 @@ static int ad7280_attr_init(struct ad7280_state *st)
>  				AD7280A_DEVADDR(dev) << 8 |
>  				(AD7280A_CB1_TIMER + ch);
>  			st->iio_attr[cnt].dev_attr.attr.mode =
> -				S_IWUSR | S_IRUGO;
> +				0644;
>  			st->iio_attr[cnt].dev_attr.show =
>  				ad7280_show_balance_timer;
>  			st->iio_attr[cnt].dev_attr.store =
> @@ -746,26 +746,26 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
>  		in_voltage-voltage_thresh_low_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
>  		in_voltage-voltage_thresh_high_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_OVERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_low_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_AUX_ADC_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR(in_temp_thresh_high_value,
> -		S_IRUGO | S_IWUSR,
> +		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_AUX_ADC_OVERVOLTAGE);
> 

