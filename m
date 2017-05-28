Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751024AbdE1OnM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 May 2017 10:43:12 -0400
Date: Sun, 28 May 2017 15:43:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paolo Cretaro <paolocretaro@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: use NULL instead of 0 for
 pointer
Message-ID: <20170528154309.243555e3@kernel.org>
In-Reply-To: <20170528112438.10427-1-paolocretaro@gmail.com>
References: <20170528112438.10427-1-paolocretaro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 May 2017 13:24:38 +0200
Paolo Cretaro <paolocretaro@gmail.com> wrote:

> Fix sparse warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
This looks fine to me, but ideally you should always try to include
the driver author - particularly in the case of patches to a recent
driver such as this one.

To that end I've cc'd Martin.

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 81cd39a57fe3..fb3f67a9ae1f 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -481,7 +481,7 @@ static void meson_sar_adc_clear_fifo(struct iio_dev *indio_dev)
>  		if (!meson_sar_adc_get_fifo_count(indio_dev))
>  			break;
>  
> -		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, 0);
> +		regmap_read(priv->regmap, MESON_SAR_ADC_FIFO_RD, NULL);
>  	}
>  }
>  

