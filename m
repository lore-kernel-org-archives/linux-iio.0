Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:43014 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbdKLB0O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Nov 2017 20:26:14 -0500
MIME-Version: 1.0
In-Reply-To: <20171107141006.30091-1-yixun.lan@amlogic.com>
References: <20171107141006.30091-1-yixun.lan@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 12 Nov 2017 02:25:52 +0100
Message-ID: <CAFBinCBOMBKd6mdxbo0veTm10GnP2pPtyJZxGHwr88xsbh=YCA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] iio: adc: meson-saradc: remove irrelevant clock "sana"
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Nov 7, 2017 at 3:10 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:
> From: Xingyu Chen <xingyu.chen@amlogic.com>
>
> The "sana" clock is not used at SAR ADC module in Amlogic Meson SoC,
> it is irrelevant for the SAR ADC.
>
> Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Jonathan, we'll let you know once it's time to apply this (without the
previous patches we would break the ADC on the 64-bit SoCs)

> ---
>  drivers/iio/adc/meson_saradc.c | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2e8dbb89c8c9..f7dcf187fb43 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -231,7 +231,6 @@ struct meson_sar_adc_priv {
>         const struct meson_sar_adc_data         *data;
>         struct clk                              *clkin;
>         struct clk                              *core_clk;
> -       struct clk                              *sana_clk;
>         struct clk                              *adc_sel_clk;
>         struct clk                              *adc_clk;
>         struct clk_gate                         clk_gate;
> @@ -708,12 +707,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>                 goto err_core_clk;
>         }
>
> -       ret = clk_prepare_enable(priv->sana_clk);
> -       if (ret) {
> -               dev_err(indio_dev->dev.parent, "failed to enable sana clk\n");
> -               goto err_sana_clk;
> -       }
> -
>         regval = FIELD_PREP(MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, 1);
>         regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG0,
>                            MESON_SAR_ADC_REG0_FIFO_CNT_IRQ_MASK, regval);
> @@ -741,8 +734,6 @@ static int meson_sar_adc_hw_enable(struct iio_dev *indio_dev)
>                            MESON_SAR_ADC_REG3_ADC_EN, 0);
>         regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>                            MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
> -       clk_disable_unprepare(priv->sana_clk);
> -err_sana_clk:
>         clk_disable_unprepare(priv->core_clk);
>  err_core_clk:
>         regulator_disable(priv->vref);
> @@ -768,7 +759,6 @@ static int meson_sar_adc_hw_disable(struct iio_dev *indio_dev)
>         regmap_update_bits(priv->regmap, MESON_SAR_ADC_REG11,
>                            MESON_SAR_ADC_REG11_BANDGAP_EN, 0);
>
> -       clk_disable_unprepare(priv->sana_clk);
>         clk_disable_unprepare(priv->core_clk);
>
>         regulator_disable(priv->vref);
> @@ -962,16 +952,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>                 return PTR_ERR(priv->core_clk);
>         }
>
> -       priv->sana_clk = devm_clk_get(&pdev->dev, "sana");
> -       if (IS_ERR(priv->sana_clk)) {
> -               if (PTR_ERR(priv->sana_clk) == -ENOENT) {
> -                       priv->sana_clk = NULL;
> -               } else {
> -                       dev_err(&pdev->dev, "failed to get sana clk\n");
> -                       return PTR_ERR(priv->sana_clk);
> -               }
> -       }
> -
>         priv->adc_clk = devm_clk_get(&pdev->dev, "adc_clk");
>         if (IS_ERR(priv->adc_clk)) {
>                 if (PTR_ERR(priv->adc_clk) == -ENOENT) {
> --
> 2.14.1
>
