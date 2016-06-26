Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47805 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcFZQkT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:40:19 -0400
Subject: Re: [PATCH 1/3] iio:ad7266: Fix broken regulator error handling
To: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1466427214-13372-1-git-send-email-broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d8ff6bc9-a65d-a25e-f6fe-18e953fe79bf@kernel.org>
Date: Sun, 26 Jun 2016 17:40:17 +0100
MIME-Version: 1.0
In-Reply-To: <1466427214-13372-1-git-send-email-broonie@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/16 13:53, Mark Brown wrote:
> All regulator_get() variants return either a pointer to a regulator or an
> ERR_PTR() so testing for NULL makes no sense and may lead to bugs if we
> use NULL as a valid regulator. Fix this by using IS_ERR() as expected.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks Mark,

Jonathan
> ---
>  drivers/iio/adc/ad7266.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 21e19b60e2b9..835d45db258f 100644
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

