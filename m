Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:41219 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750803AbbG0Hsy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 03:48:54 -0400
Date: Mon, 27 Jul 2015 09:48:52 +0200
From: Antoine Tenart <antoine.tenart@free-electrons.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: Re: [PATCH 4/8] iio:adc:berlin2-adc: constify iio_chan_spec
Message-ID: <20150727074852.GD16683@kwain>
References: <cover.1437862404.git.knaack.h@gmx.de>
 <075fdfa71c79b09fbb583e5ce6c6d28614e7465d.1437862404.git.knaack.h@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <075fdfa71c79b09fbb583e5ce6c6d28614e7465d.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jul 26, 2015 at 12:43:22AM +0200, Hartmut Knaack wrote:
> Mark berlin2_adc_channels array as constant.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>

> ---
>  drivers/iio/adc/berlin2-adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
> index 42e214b3e93a..b7df94a0b879 100644
> --- a/drivers/iio/adc/berlin2-adc.c
> +++ b/drivers/iio/adc/berlin2-adc.c
> @@ -86,7 +86,7 @@ struct berlin2_adc_priv {
>  			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>  		}
>  
> -static struct iio_chan_spec berlin2_adc_channels[] = {
> +static const struct iio_chan_spec berlin2_adc_channels[] = {
>  	BERLIN2_ADC_CHANNEL(0, IIO_VOLTAGE),	/* external input */
>  	BERLIN2_ADC_CHANNEL(1, IIO_VOLTAGE),	/* external input */
>  	BERLIN2_ADC_CHANNEL(2, IIO_VOLTAGE),	/* external input */
> -- 
> 2.4.3
> 

-- 
Antoine Ténart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
