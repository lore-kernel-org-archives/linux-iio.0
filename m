Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751779AbdFKOBu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Jun 2017 10:01:50 -0400
Date: Sun, 11 Jun 2017 15:01:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, paolocretaro@gmail.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix potential crash in
 meson_sar_adc_clear_fifo
Message-ID: <20170611150146.67423c44@kernel.org>
In-Reply-To: <20170604132823.21928-1-martin.blumenstingl@googlemail.com>
References: <20170604132823.21928-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Jun 2017 15:28:23 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> meson_sar_adc_clear_fifo passes a 0 as value-pointer to regmap_read().
> In case of the meson-saradc driver this ends up in regmap_mmio_read(),
> where the value-pointer is de-referenced unconditionally to assign the
> value which was read.
> Fix this by passing an actual pointer, even though all we want to do is
> to discard the value.
> 
> As a side-effect this fixes a sparse warning ("Using plain integer as
> NULL pointer") as reported by Paolo Cretaro.
> 
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Reported-by: Paolo Cretaro <paolocretaro@gmail.com>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 81cd39a57fe3..83da50ed73ab 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -475,13 +475,13 @@ static void meson_sar_adc_unlock(struct iio_dev *indio_dev)
>  static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
>  {
>  	struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
> -	int count;
> +	unsigned int count, tmp;
>  
>  	for (count = 0; count < MESON_SAR_ADC_MAX_FIFO_SIZE; count++) {
>  		if (!meson_sar_adc_get_fifo_count(indio_dev))
>  			break;
>  
> -		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
> +		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, &tmp);
>  	}
>  }
>  

