Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48270 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754368AbcJON4U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 09:56:20 -0400
Subject: Re: [PATCH] [BUGFIX] iio: ms65611_core: Fixes dereferencing regulator
 pointer
To: Crt Mori <cmo@melexis.com>, linux-iio@vger.kernel.org
References: <20161014134314.2608-1-cmo@melexis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <86b79b54-2aab-57cc-1fa5-e40b36368743@kernel.org>
Date: Sat, 15 Oct 2016 14:56:14 +0100
MIME-Version: 1.0
In-Reply-To: <20161014134314.2608-1-cmo@melexis.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/10/16 14:43, Crt Mori wrote:
> Change in handling of the regulator description means that static
> checkers correctly assume we could be using dereferenced pointer to the
> regulator. In reality we will never get the -ENODEV error, as current
> behavior flow does not predict it, because:
> If the device tree or board file does not define suitable regulators for
> the component, it will be substituted by a dummy regulator, or, if
> regulators are disabled altogether, by stubs.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Crt Mori <cmo@melexis.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/ms5611_core.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
> index a74ed1f..6bd53e7 100644
> --- a/drivers/iio/pressure/ms5611_core.c
> +++ b/drivers/iio/pressure/ms5611_core.c
> @@ -392,17 +392,14 @@ static int ms5611_init(struct iio_dev *indio_dev)
>  
>  	/* Enable attached regulator if any. */
>  	st->vdd = devm_regulator_get(indio_dev->dev.parent, "vdd");
> -	if (!IS_ERR(st->vdd)) {
> -		ret = regulator_enable(st->vdd);
> -		if (ret) {
> -			dev_err(indio_dev->dev.parent,
> -				"failed to enable Vdd supply: %d\n", ret);
> -			return ret;
> -		}
> -	} else {
> -		ret = PTR_ERR(st->vdd);
> -		if (ret != -ENODEV)
> -			return ret;
> +	if (IS_ERR(st->vdd))
> +		return PTR_ERR(st->vdd);
> +
> +	ret = regulator_enable(st->vdd);
> +	if (ret) {
> +		dev_err(indio_dev->dev.parent,
> +			"failed to enable Vdd supply: %d\n", ret);
> +		return ret;
>  	}
>  
>  	ret = ms5611_reset(indio_dev);
> 

