Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdKSPn7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 10:43:59 -0500
Date: Sun, 19 Nov 2017 15:43:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/5] iio: adc: meson-saradc: fix the bit_idx of the
 adc_en clock
Message-ID: <20171119154355.5809ed79@archlinux>
In-Reply-To: <20171031200147.14660-2-martin.blumenstingl@googlemail.com>
References: <20171031200147.14660-1-martin.blumenstingl@googlemail.com>
        <20171031200147.14660-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 31 Oct 2017 21:01:43 +0100
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Meson8 and Meson8b SoCs use the the SAR ADC gate clock provided by the
> MESON_SAR_ADC_REG3 register within the SAR ADC register area.
> According to the datasheet (and the existing MESON_SAR_ADC_REG3_CLK_EN
> definition) the gate is on bit 30.
> The fls() function returns the last set bit, which is "bit index + 1"
> (fls(MESON_SAR_ADC_REG3_CLK_EN) returns 31). Fix this by switching to
> __ffs() which returns the first set bit, which is bit 30 in our case.
> 
> This off by one error results in the ADC not being usable on devices
> where the bootloader did not enable the clock.
> 
> Fixes: 3adbf3427330 ("iio: adc: add a driver for the SAR ADC found in Amlogic Meson SoCs")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2e8dbb89c8c9..55611244c799 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -600,7 +600,7 @@ static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
>  	init.num_parents = 1;
>  
>  	priv->clk_gate.reg = base + MESON_SAR_ADC_REG3;
> -	priv->clk_gate.bit_idx = fls(MESON_SAR_ADC_REG3_CLK_EN);
> +	priv->clk_gate.bit_idx = __ffs(MESON_SAR_ADC_REG3_CLK_EN);
>  	priv->clk_gate.hw.init = &init;
>  
>  	priv->adc_clk = devm_clk_register(&indio_dev->dev, &priv->clk_gate.hw);

