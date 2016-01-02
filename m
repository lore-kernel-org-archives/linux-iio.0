Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbcABS2L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Jan 2016 13:28:11 -0500
Subject: Re: [PATCH] iio: qcom-spmi-vadc: One check less in
 vadc_measure_ref_points() after error detection
To: SF Markus Elfring <elfring@users.sourceforge.net>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <567E9059.30709@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Julia Lawall <julia.lawall@lip6.fr>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <568816B4.2090003@kernel.org>
Date: Sat, 2 Jan 2016 18:28:04 +0000
MIME-Version: 1.0
In-Reply-To: <567E9059.30709@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/12/15 13:04, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 26 Dec 2015 13:53:15 +0100
> 
> This issue was detected by using the Coccinelle software.
> 
> Move the jump label directly before the desired log statement
> so that the variable "ret" does not need to be checked once more
> after it was determined that a function call failed.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
If we are going to change this, I would prefer to see more useful
local error messages and direct returns rather than jumping to
a very generic message at the end.

I'm also less than keen on jumping into conditionals as I find
it slightly less readable. 

We might technically be 'simplifying' the code, but in this case
the gain is very minor for a fair bit of code churn...

Thanks,

Jonathan
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index c2babe5..391eefa 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -424,7 +424,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
> -		goto err;
> +		goto report_failure;
In this first case we have already had a report that a conversion failed.
I suppose adding that it was during reference point measurement 'might'
be useful additional information.  I'm not really convinced of it does
however... Hence I'd drop reporting it entirely in this function.
>  
>  	/* Try with buffered 625mV channel first */
>  	prop = vadc_get_channel(vadc, VADC_SPARE1);
> @@ -433,11 +433,11 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
> -		goto err;
> +		goto report_failure;
>  
>  	if (read_1 == read_2) {
>  		ret = -EINVAL;
I think this one indicates we can't actually read anything at all
for some reason...  It's the only form of error we won't have effectively
already reported so is worthy of some sort of debug message...
> -		goto err;
> +		goto report_failure;
>  	}
>  
>  	vadc->graph[VADC_CALIB_ABSOLUTE].dy = read_1 - read_2;
> @@ -447,23 +447,24 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
>  	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
>  	ret = vadc_do_conversion(vadc, prop, &read_1);
>  	if (ret)
> -		goto err;
> +		goto report_failure;
>  
>  	prop = vadc_get_channel(vadc, VADC_GND_REF);
>  	ret = vadc_do_conversion(vadc, prop, &read_2);
>  	if (ret)
> -		goto err;
> +		goto report_failure;
>  
>  	if (read_1 == read_2) {
>  		ret = -EINVAL;
> -		goto err;
> +		goto report_failure;
>  	}
>  
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
>  	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
> -err:
> -	if (ret)
> +	if (ret) {
> +report_failure:
>  		dev_err(vadc->dev, "measure reference points failed\n");
> +	}
>  
>  	return ret;
>  }
> 

