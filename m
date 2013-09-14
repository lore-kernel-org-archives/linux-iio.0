Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39637 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122Ab3INJrC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 14 Sep 2013 05:47:02 -0400
Message-ID: <52343EB1.7060700@kernel.org>
Date: Sat, 14 Sep 2013 11:47:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/10] staging: iio: ad2s1200: Use dev_err instead of
 pr_err
References: <1378893325-31764-1-git-send-email-sachin.kamat@linaro.org> <1378893325-31764-3-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378893325-31764-3-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 10:55, Sachin Kamat wrote:
> dev_err is preferred over pr_err.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Applied
> ---
>  drivers/staging/iio/resolver/ad2s1200.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> index 76f6d65..62d3017 100644
> --- a/drivers/staging/iio/resolver/ad2s1200.c
> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> @@ -110,8 +110,8 @@ static int ad2s1200_probe(struct spi_device *spi)
>  		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
>  					    DRV_NAME);
>  		if (ret) {
> -			pr_err("%s: request gpio pin %d failed\n",
> -						DRV_NAME, pins[pn]);
> +			dev_err(&spi->dev, "request gpio pin %d failed\n",
> +							pins[pn]);
>  			return ret;
>  		}
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> 
