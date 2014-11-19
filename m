Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:44612 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbaKSWma (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Nov 2014 17:42:30 -0500
Received: by mail-la0-f47.google.com with SMTP id hz20so1370350lab.6
        for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2014 14:42:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com>
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com>
Date: Wed, 19 Nov 2014 20:42:28 -0200
Message-ID: <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
From: Fabio Estevam <festevam@gmail.com>
To: Stefan Wahren <stefan.wahren@i2se.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?Q?Kristina_Mart=C5=A1enko?= <kristina.martsenko@gmail.com>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

[Adding Marek]

On Wed, Nov 19, 2014 at 8:19 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> The devicetree binding for mxs-lradc defines ranges for the
> touchscreen properties. In order to avoid unexpected behavior like
> division by zero, we better check these ranges during probe and
> abort in error case.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 6757f10..57c3cf6 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1500,16 +1500,36 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>         if (ret == 0)
>                 lradc->over_sample_cnt = adapt;
>
> +       if (!lradc->over_sample_cnt || lradc->over_sample_cnt > 0x1f) {
> +               dev_err(lradc->dev, "Invalid sample count (%u)\n",
> +                                   lradc->over_sample_cnt);
> +               return -EINVAL;
> +       }
> +
>         lradc->over_sample_delay = 2;
>         ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
>         if (ret == 0)
>                 lradc->over_sample_delay = adapt;
>
> +       if (!lradc->over_sample_delay ||
> +           lradc->over_sample_delay > LRADC_DELAY_DELAY_MASK) {
> +               dev_err(lradc->dev, "Invalid sample delay (%u)\n",
> +                                   lradc->over_sample_delay);
> +               return -EINVAL;
> +       }
> +
>         lradc->settling_delay = 10;
>         ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
>         if (ret == 0)
>                 lradc->settling_delay = adapt;
>
> +       if (!lradc->settling_delay ||
> +           lradc->settling_delay > LRADC_DELAY_DELAY_MASK) {
> +               dev_err(lradc->dev, "Invalid settling delay (%u)\n",
> +                                   lradc->settling_delay);
> +               return -EINVAL;
> +       }
> +

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
