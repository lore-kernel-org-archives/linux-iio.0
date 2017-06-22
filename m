Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36107 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdFVClp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jun 2017 22:41:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id g14so308014oib.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Jun 2017 19:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498052712-7659-1-git-send-email-fabio.estevam@nxp.com>
References: <1498052712-7659-1-git-send-email-fabio.estevam@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 21 Jun 2017 23:41:44 -0300
Message-ID: <CAOMZO5BkpoijnNOyBCvfNvRNs+fgdfhVxw4kwU4UEUJwySGx=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: mxs-lradc: Use devm_ioremap_resource()
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jun 21, 2017 at 10:45 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> By using devm_ioremap_resource() the code can be simplified, as we
> no longer need to check whether platform_get_resource() succeeded
> or not, as this check is already performed in devm_ioremap_resource().
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index 6888167..2faf65f 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -718,12 +718,9 @@ static int mxs_lradc_adc_probe(struct platform_device *pdev)
>         adc->dev = dev;
>
>         iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       if (!iores)
> -               return -EINVAL;
> -
> -       adc->base = devm_ioremap(dev, iores->start, resource_size(iores));
> -       if (!adc->base)
> -               return -ENOMEM;
> +       adc->base = devm_ioremap_resource(dev, iores);
> +       if (IS_ERR(adc->base))
> +               return PTR_ERR(adc->base);

Just realized that this has already been proposed and does not work:
http://www.spinics.net/lists/linux-iio/msg32864.html

Please discard it, thanks.
