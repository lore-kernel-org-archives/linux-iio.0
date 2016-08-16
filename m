Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36792 "EHLO
	mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbcHPM0C (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 08:26:02 -0400
MIME-Version: 1.0
In-Reply-To: <1471349438-16262-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1471349438-16262-1-git-send-email-clabbe.montjoie@gmail.com>
From: =?UTF-8?Q?Ksenija_Stanojevi=C4=87?= <ksenija.stanojevic@gmail.com>
Date: Tue, 16 Aug 2016 14:26:01 +0200
Message-ID: <CAL7P5jLXhNX7m6y38xKqCoadd54Bg8BmEbWYkYj1Rjr1eSKbJg@mail.gmail.com>
Subject: Re: [PATCH] iio: mxs-lradc: fix a possible NULL dereference
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Corentin,

On Tue, Aug 16, 2016 at 2:10 PM, LABBE Corentin
<clabbe.montjoie@gmail.com> wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
>
> For fixing this problem, we use of_device_get_match_data(), this will
> simplify the code a little by using a standard function for
> getting the match data.
>
> Reported-by: coverity (CID 1127209)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/iio/adc/mxs-lradc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index b84d37c..378547c 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1570,10 +1570,7 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>
>  static int mxs_lradc_probe(struct platform_device *pdev)
>  {
> -       const struct of_device_id *of_id =
> -               of_match_device(mxs_lradc_dt_ids, &pdev->dev);
> -       const struct mxs_lradc_of_config *of_cfg =
> -               &mxs_lradc_of_config[(enum mxs_lradc_id)of_id->data];
> +       const struct mxs_lradc_of_config *of_cfg;
>         struct device *dev = &pdev->dev;
>         struct device_node *node = dev->of_node;
>         struct mxs_lradc *lradc;
> @@ -1591,7 +1588,8 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>         }
>
>         lradc = iio_priv(iio);
> -       lradc->soc = (enum mxs_lradc_id)of_id->data;
> +       lradc->soc = (enum mxs_lradc_id)of_device_get_match_data(&pdev->dev);
> +       of_cfg = &mxs_lradc_of_config[lradc->soc];
>
>         /* Grab the memory area */
>         iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> --

This driver has been split into adc, touchscreen and mfd part. It's currently in
process of review and not yet merged. And it's modified  in such a way that
your changes wouldn't apply anyway. Please see:
https://lkml.org/lkml/2016/8/4/270
I think it's better to wait for modified driver to be merged and after send
patches for it.

Thanks,
Ksenija
