Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36017 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbdGHNnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jul 2017 09:43:08 -0400
MIME-Version: 1.0
In-Reply-To: <20170707064630.GA21945@embeddedgus>
References: <20170707064630.GA21945@embeddedgus>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 8 Jul 2017 15:42:46 +0200
Message-ID: <CAFBinCBgXAFvLqXP5e-j=UeQVd+foUDqKUNzO8hwQ71tKga1Vg@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: meson-saradc: add NULL check on
 of_match_device() return value
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>, linux-iio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jul 7, 2017 at 8:46 AM, Gustavo A. R. Silva
<garsilva@embeddedor.com> wrote:
> Check return value from call to of_match_device()
> in order to prevent a NULL pointer dereference.
>
> In case of NULL print error message and return -ENODEV
>
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
thanks for finding this. a crash here is a rather theoretical problem
(since all compatible strings have their corresponding match data) -
but it doesn't hurt either, so:

Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


> ---
>  drivers/iio/adc/meson_saradc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 83da50e..07dbcc3 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -915,6 +915,11 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>         init_completion(&priv->done);
>
>         match = of_match_device(meson_sar_adc_of_match, &pdev->dev);
> +       if (!match) {
> +               dev_err(&pdev->dev, "failed to match device\n");
> +               return -ENODEV;
> +       }
> +
>         priv->data = match->data;
>
>         indio_dev->name = priv->data->name;
> --
> 2.5.0
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
