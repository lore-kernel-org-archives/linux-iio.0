Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeIYCR3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Sep 2018 22:17:29 -0400
Date: Mon, 24 Sep 2018 21:13:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/3] iio: adc: meson-saradc: remove #define
 MESON_SAR_ADC_DELTA_10_TS_C_SHIFT
Message-ID: <20180924211331.29fdcd6a@archlinux>
In-Reply-To: <20180922222102.12023-2-martin.blumenstingl@googlemail.com>
References: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
        <20180922222102.12023-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 23 Sep 2018 00:21:00 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> This define is of no use because the driver is avoiding shifting bits
> by itself but using FIELD_GET/FIELD_PREP (which are using bit masks)
> instead. There is already a MESON_SAR_ADC_DELTA_10_TS_C_MASK bit mask so
> MESON_SAR_ADC_DELTA_10_TS_C_SHIFT was redundant.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index da2d16dfa63e..b97b06bf7713 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -148,7 +148,6 @@
>  	#define MESON_SAR_ADC_DELTA_10_TS_REVE1			BIT(26)
>  	#define MESON_SAR_ADC_DELTA_10_CHAN1_DELTA_VALUE_MASK	GENMASK(25, 16)
>  	#define MESON_SAR_ADC_DELTA_10_TS_REVE0			BIT(15)
> -	#define MESON_SAR_ADC_DELTA_10_TS_C_SHIFT		11
>  	#define MESON_SAR_ADC_DELTA_10_TS_C_MASK		GENMASK(14, 11)
>  	#define MESON_SAR_ADC_DELTA_10_TS_VBG_EN		BIT(10)
>  	#define MESON_SAR_ADC_DELTA_10_CHAN0_DELTA_VALUE_MASK	GENMASK(9, 0)
