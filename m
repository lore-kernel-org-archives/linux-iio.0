Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45718 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674Ab3FVKiS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jun 2013 06:38:18 -0400
Message-ID: <51C57E98.5020409@kernel.org>
Date: Sat, 22 Jun 2013 11:38:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: lars@metafoo.de, yongjun_wei@trendmicro.com.cn,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH -next] iio: dac: ad7303: fix error return code in ad7303_probe()
References: <CAPgLHd_7GTkOavGHctmaODV-gQBjRi5aiUF7+BR-FRnP8eCa7w@mail.gmail.com>
In-Reply-To: <CAPgLHd_7GTkOavGHctmaODV-gQBjRi5aiUF7+BR-FRnP8eCa7w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/18/2013 02:08 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
This one looks pretty obvious so I'll take it without waiting
for any other comments.

Applied to togreg branch of iio.git

Thanks,


> ---
>  drivers/iio/dac/ad7303.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad7303.c b/drivers/iio/dac/ad7303.c
> index 85aeef6..d546f50 100644
> --- a/drivers/iio/dac/ad7303.c
> +++ b/drivers/iio/dac/ad7303.c
> @@ -235,8 +235,10 @@ static int ad7303_probe(struct spi_device *spi)
>  
>  	if (ext_ref) {
>  		st->vref_reg = regulator_get(&spi->dev, "REF");
> -		if (IS_ERR(st->vref_reg))
> +		if (IS_ERR(st->vref_reg)) {
> +			ret = PTR_ERR(st->vref_reg);
>  			goto err_disable_vdd_reg;
> +		}
>  
>  		ret = regulator_enable(st->vref_reg);
>  		if (ret)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
