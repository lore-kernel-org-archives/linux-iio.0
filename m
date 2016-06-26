Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47821 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554AbcFZQlk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:41:40 -0400
Subject: Re: [PATCH 3/3] iio:ad7266: Fix probe deferral for vref
To: Mark Brown <broonie@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
References: <1466427214-13372-1-git-send-email-broonie@kernel.org>
 <1466427214-13372-3-git-send-email-broonie@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5ecdf1d9-67ef-2266-4ba5-6da8dd15bcd7@kernel.org>
Date: Sun, 26 Jun 2016 17:41:38 +0100
MIME-Version: 1.0
In-Reply-To: <1466427214-13372-3-git-send-email-broonie@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/16 13:53, Mark Brown wrote:
> Currently the ad7266 driver treats any failure to get vref as though the
> regulator were not present but this means that if probe deferral is
> triggered the driver will act as though the regulator were not present.
> Instead only use the internal reference if we explicitly got -ENODEV which
> is what is returned for absent regulators.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Lars, these all seems obviously correct to me, but I'll hold that
tree for a day or two so still time to comment.

I dread to think how many other missuses we have of these interfaces
in the tree...

Jonathan
> ---
>  drivers/iio/adc/ad7266.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 655b36b4e9cb..2123f0ac2e2a 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -408,6 +408,9 @@ static int ad7266_probe(struct spi_device *spi)
>  
>  		st->vref_mv = ret / 1000;
>  	} else {
> +		/* Any other error indicates that the regulator does exist */
> +		if (PTR_ERR(st->reg) != -ENODEV)
> +			return PTR_ERR(st->reg);
>  		/* Use internal reference */
>  		st->vref_mv = 2500;
>  	}
> 

