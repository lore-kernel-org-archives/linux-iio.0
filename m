Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60087 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750975AbdETPzU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 11:55:20 -0400
Subject: Re: [PATCH 2/3] iio: adc: cpcap: Fix die temperature
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
References: <20170519034035.16795-1-tony@atomide.com>
 <20170519034035.16795-3-tony@atomide.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6b8ea7a4-5f5e-2d48-0893-94aa320433c6@kernel.org>
Date: Sat, 20 May 2017 16:55:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170519034035.16795-3-tony@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 04:40, Tony Lindgren wrote:
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
Is there any route we have available to confirm this?  I.e. doe anyone
have one where we can check plausibility?

If not such is life, but thought I'd ask.

Code is fine as far as I can see.

Jonathan
> 
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/iio/adc/cpcap-adc.c | 31 ++++++++++++++++++++++++++++---
>   1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -875,6 +875,22 @@ static int cpcap_adc_init_request(struct cpcap_adc_request *req,
>   	return 0;
>   }
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
>   static int cpcap_adc_read(struct iio_dev *indio_dev,
>   			  struct iio_chan_spec const *chan,
>   			  int *val, int *val2, long mask)
> @@ -906,9 +922,18 @@ static int cpcap_adc_read(struct iio_dev *indio_dev,
>   		error = cpcap_adc_start_bank(ddata, &req);
>   		if (error)
>   			goto err_unlock;
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
>   		error = cpcap_adc_stop_bank(ddata);
>   		if (error)
>   			goto err_unlock;
> 

