Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47594 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdDBJcz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 05:32:55 -0400
Subject: Re: [PATCH] IIO: bmp280-core.c: fix error in humidity calculation
To: Andreas Klinger <ak@it-klinger.de>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linus.walleij@linaro.org,
        ddvlad@gmail.com, akinobu.mita@gmail.com,
        yongjun_wei@trendmicro.com.cn, a.mathur@samsung.com
References: <20170327100646.GA8128@project>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <2bec8c26-f33c-d331-aa97-047871b4cc57@kernel.org>
Date: Sun, 2 Apr 2017 10:32:52 +0100
MIME-Version: 1.0
In-Reply-To: <20170327100646.GA8128@project>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/03/17 11:06, Andreas Klinger wrote:
> While calculating the compensation of the humidity there are negative
> values interpreted as unsigned because of unsigned variables used.
> These values need to be casted to signed as indicated by the documentation
> of the sensor.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Looks superficially right to me, but would like an Ack from Linus Walleij.

Linus?

J
> ---
>  drivers/iio/pressure/bmp280-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 4d18826ac63c..73308f0ea260 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -177,9 +177,9 @@ static u32 bmp280_compensate_humidity(struct bmp280_data *data,
>  
>  	var = ((s32)data->t_fine) - 76800;
>  	var = ((((adc_humidity << 14) - (H4 << 20) - (H5 * var)) + 16384) >> 15)
> -		* (((((((var * H6) >> 10) * (((var * H3) >> 11) + 32768)) >> 10)
> -		+ 2097152) * H2 + 8192) >> 14);
> -	var -= ((((var >> 15) * (var >> 15)) >> 7) * H1) >> 4;
> +		* (((((((var * H6) >> 10) * (((var * (s32)H3) >> 11) + 32768))
> +		>> 10) + 2097152) * H2 + 8192) >> 14);
> +	var -= ((((var >> 15) * (var >> 15)) >> 7) * (s32)H1) >> 4;
>  
>  	return var >> 12;
>  };
> 

