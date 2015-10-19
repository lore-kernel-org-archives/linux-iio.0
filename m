Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:63571 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbbJSTFY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Oct 2015 15:05:24 -0400
Subject: Re: [PATCH] adc: correctly check return value
To: Insu Yun <wuninsu@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu,
	changwoo@gatech.edu
References: <1445270931-24109-1-git-send-email-wuninsu@gmail.com>
From: Hartmut Knaack <knaack.h@gmx.de>
Message-ID: <56253EE7.5050107@gmx.de>
Date: Mon, 19 Oct 2015 21:05:11 +0200
MIME-Version: 1.0
In-Reply-To: <1445270931-24109-1-git-send-email-wuninsu@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Insu Yun schrieb am 19.10.2015 um 18:08:
> Since devm_regulator_get returns address or error, not NULL,
> it needs to be checked with IS_ERR, not IS_ERR_OR_NULL.
> 

Actually, it does return NULL, if regulator support is disabled
(see [1]).

[1]http://lxr.free-electrons.com/source/include/linux/regulator/consumer.h#L286

> Signed-off-by: Insu Yun <wuninsu@gmail.com>
> ---
>  drivers/iio/adc/ad7266.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 70f78c3..26cd54b 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -397,7 +397,7 @@ static int ad7266_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  
>  	st->reg = devm_regulator_get(&spi->dev, "vref");
> -	if (!IS_ERR_OR_NULL(st->reg)) {
> +	if (!IS_ERR(st->reg)) {
>  		ret = regulator_enable(st->reg);
>  		if (ret)
>  			return ret;
> 

