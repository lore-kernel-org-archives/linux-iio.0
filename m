Return-Path: <knaack.h@gmx.de>
Message-ID: <5478FB6D.8000303@gmx.de>
Date: Fri, 28 Nov 2014 23:47:09 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Stefan Wahren <stefan.wahren@i2se.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Fabio Estevam <festevam@gmail.com>,
 =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Stefan Wahren schrieb am 19.11.2014 um 23:19:
> The devicetree binding for mxs-lradc defines ranges for the
> touchscreen properties. In order to avoid unexpected behavior like
> division by zero, we better check these ranges during probe and
> abort in error case.
> 
This patch is functional correct, but I see some style issues:
To make a review with the DT bindings easier, it would help to compare against the values which got used there (which are not in hex). For sample count, the range is defined as 1...31, so it would look easier like this: if (_cnt < 1 || _cnt > 31) =>error.
Another thing to consider would be to do the boundary check on adapt, and only assign it to over_sample_cnt (or the other elements) if it is valid. Thinking this further, it would even make sense to assign a default value to over_sample_count (and the other ones) only in case that no DT property is set, instead of doing it in advance and overwriting it with the custom value.
A minor style nitpick inline.
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 6757f10..57c3cf6 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1500,16 +1500,36 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>  	if (ret == 0)
>  		lradc->over_sample_cnt = adapt;
> 
> +	if (!lradc->over_sample_cnt || lradc->over_sample_cnt > 0x1f) {
> +		dev_err(lradc->dev, "Invalid sample count (%u)\n",
> +				    lradc->over_sample_cnt);
The parameter should be indented with the opening parenthesis. Same for the other instances below.
> +		return -EINVAL;
> +	}
> +
>  	lradc->over_sample_delay = 2;
>  	ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
>  	if (ret == 0)
>  		lradc->over_sample_delay = adapt;
> 
> +	if (!lradc->over_sample_delay ||
> +	    lradc->over_sample_delay > LRADC_DELAY_DELAY_MASK) {
> +		dev_err(lradc->dev, "Invalid sample delay (%u)\n",
> +				    lradc->over_sample_delay);
> +		return -EINVAL;
> +	}
> +
>  	lradc->settling_delay = 10;
>  	ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
>  	if (ret == 0)
>  		lradc->settling_delay = adapt;
> 
> +	if (!lradc->settling_delay ||
> +	    lradc->settling_delay > LRADC_DELAY_DELAY_MASK) {
> +		dev_err(lradc->dev, "Invalid settling delay (%u)\n",
> +				    lradc->settling_delay);
> +		return -EINVAL;
> +	}
> +
>  	return 0;
>  }
> 
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
