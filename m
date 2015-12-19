Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55705 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932302AbbLSPHE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2015 10:07:04 -0500
Subject: Re: [PATCH] iio: ina2xx: fix channel order in software buffer
To: Marc Titinger <mtitinger@baylibre.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net
References: <566C5613.3040101@kernel.org>
 <1450193182-18179-1-git-send-email-mtitinger@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56757296.5060501@kernel.org>
Date: Sat, 19 Dec 2015 15:07:02 +0000
MIME-Version: 1.0
In-Reply-To: <1450193182-18179-1-git-send-email-mtitinger@baylibre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/15 15:26, Marc Titinger wrote:
> POWER and CURRENT were swapped out in the buffer:
> was current2 and power3, correct order is power2 and current3.
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> 
> ---
> 
> Hi Jon,
> 
> we just found this while testing with the buffered mode.
> My apologies for missing this bug ealier.
> 
> Cheers,
> Marc.
> 
> ---
>
Applied this one to the togreg branch of iio.git which will get
initially pushed out as testing for the autobuilders to play with it.
 
>  drivers/iio/adc/ina2xx-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 98939ba..91e1f2b 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -427,8 +427,8 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
>  static const struct iio_chan_spec ina2xx_channels[] = {
>  	INA2XX_CHAN_VOLTAGE(0, INA2XX_SHUNT_VOLTAGE),
>  	INA2XX_CHAN_VOLTAGE(1, INA2XX_BUS_VOLTAGE),
> -	INA2XX_CHAN(IIO_CURRENT, 2, INA2XX_CURRENT),
> -	INA2XX_CHAN(IIO_POWER, 3, INA2XX_POWER),
> +	INA2XX_CHAN(IIO_POWER, 2, INA2XX_POWER),
> +	INA2XX_CHAN(IIO_CURRENT, 3, INA2XX_CURRENT),
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> 

