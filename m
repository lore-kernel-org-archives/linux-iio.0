Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934210AbdEXTTF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:19:05 -0400
Date: Wed, 24 May 2017 20:19:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/3] iio: adc: cpcap: Fix die temperature
Message-ID: <20170524201902.2cb31bcb@kernel.org>
In-Reply-To: <20170523005146.726-3-tony@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
        <20170523005146.726-3-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 May 2017 17:51:45 -0700
Tony Lindgren <tony@atomide.com> wrote:

> It seems that "MC13783 Power Management and Audio Ciruit User's Guide"
> MC1378UG.pdf documents several similar components as in the CPCAP PMIC.
> 
> Chapter "9.5.5 Die Temperature and UID" says that the die temperature
> value is 282 at 25C with LSB of -1.14C. Converting CPCAP PMIC channel3
> values with following seems to produce values that make sense for a
> PMIC die:
> 
> temperature = 25000 + ((regval - 282) * 114)
> 
> As we don't have any other documentation, let's assume the die
> temperature is unconfigured in the Motorola mapphone Linux kernel
> and the current temperature conversion table should be only used
> for the battery thermistor and not for the die temperature.
> 
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
Applied to the togreg branch of iio.git which will shortly be
pushed out as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/cpcap-adc.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -875,6 +875,22 @@ static int cpcap_adc_init_request(struct cpcap_adc_request *req,
>  	return 0;
>  }
>  
> +static int cpcap_adc_read_st_die_temp(struct cpcap_adc *ddata,
> +				      int addr, int *val)
> +{
> +	int error;
> +
> +	error = regmap_read(ddata->reg, addr, val);
> +	if (error)
> +		return error;
> +
> +	*val -= 282;
> +	*val *= 114;
> +	*val += 25000;
> +
> +	return 0;
> +}
> +
>  static int cpcap_adc_read(struct iio_dev *indio_dev,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
> @@ -906,9 +922,18 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>  		error = cpcap_adc_start_bank(ddata, &req);
>  		if (error)
>  			goto err_unlock;
> -		error = cpcap_adc_read_bank_scaled(ddata, &req);
> -		if (error)
> -			goto err_unlock;
> +		if ((ddata->vendor == CPCAP_VENDOR_ST) &&
> +		    (chan->channel == CPCAP_ADC_AD3)) {
> +			error = cpcap_adc_read_st_die_temp(ddata,
> +							   chan->address,
> +							   &req.result);
> +			if (error)
> +				goto err_unlock;
> +		} else {
> +			error = cpcap_adc_read_bank_scaled(ddata, &req);
> +			if (error)
> +				goto err_unlock;
> +		}
>  		error = cpcap_adc_stop_bank(ddata);
>  		if (error)
>  			goto err_unlock;

