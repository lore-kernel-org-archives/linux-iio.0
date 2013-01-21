Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:47548 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815Ab3AUUgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2013 15:36:47 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so6590845oag.11
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2013 12:36:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1358798722-25102-1-git-send-email-marex@denx.de>
References: <1358798722-25102-1-git-send-email-marex@denx.de>
From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Date: Mon, 21 Jan 2013 21:36:26 +0100
Message-ID: <CAHXqBFLQUY6g6p988MVkk=sRu44B5tEzDMH2UbU2n2UDda0Q-A@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: mxs: Add MX23 support into the IIO driver
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2013/1/21 Marek Vasut <marex@denx.de>:
> This patch adds support for i.MX23 into the LRADC driver. The LRADC
> block on MX23 is not much different from the one on MX28, thus this
> is only a few changes fixing the parts that are specific to MX23.
[...]
> +struct mxs_lradc_of_config {
> +       const int               irq_count;
> +       const char * const      *irq_name;
> +};
> +
> +static const struct mxs_lradc_of_config const mxs_lradc_of_config[] = {
> +       [IMX23_LRADC] = {
> +               .irq_count      = ARRAY_SIZE(mx23_lradc_irq_names),
> +               .irq_name       = mx23_lradc_irq_names,
> +       },
> +       [IMX28_LRADC] = {
> +               .irq_count      = ARRAY_SIZE(mx28_lradc_irq_names),
> +               .irq_name       = mx28_lradc_irq_names,
> +       },
> +};
> +
>  enum mxs_lradc_ts {
>         MXS_LRADC_TOUCHSCREEN_NONE = 0,
>         MXS_LRADC_TOUCHSCREEN_4WIRE,
> @@ -857,8 +890,19 @@ static void mxs_lradc_hw_stop(struct mxs_lradc *lradc)
>                 writel(0, lradc->base + LRADC_DELAY(i));
>  }
>
> +static const struct of_device_id mxs_lradc_dt_ids[] = {
> +       { .compatible = "fsl,imx23-lradc", .data = (void *)IMX23_LRADC, },
> +       { .compatible = "fsl,imx28-lradc", .data = (void *)IMX28_LRADC, },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
> +

Why not s/(void \*)\(IMX.._LRADC\)/\&mxs_lradc_of_config[\1]/ ?

Best Regards,
Michał Mirosław
