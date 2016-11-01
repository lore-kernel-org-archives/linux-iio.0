Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33007 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbcKAED6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 1 Nov 2016 00:03:58 -0400
Received: by mail-qk0-f194.google.com with SMTP id x190so4474990qkb.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Oct 2016 21:03:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com> <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
From: Matt Ranostay <matt@ranostay.consulting>
Date: Mon, 31 Oct 2016 21:03:57 -0700
Message-ID: <CAJ_EiSTU_z_fNSLSUSTpzU+v5F5f-JEe7p2fUms3LKEd+wftDw@mail.gmail.com>
Subject: Re: [PATCH 1/6] staging: iio: set proper supply name to devm_regulator_get()
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael.Hennerich@analog.com, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Oct 31, 2016 at 10:04 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> The name passed to devm_regulator_get() should match the name of the
> supply as specified in the device datasheet. This makes it clear what
> power supply is being referred to in case of presence of other
> regulators.
>
> Currently, the supply name specified on the affected devices is 'vcc'.
> Use lowercase version of the datasheet name to specify the supply
> voltage.
>

Aren't we possibly breaking current device tree definitions that
people may have? We should still check the old name after the new
datasheet name in my opinion.

> Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7192.c                | 2 +-
>  drivers/staging/iio/adc/ad7780.c                | 2 +-
>  drivers/staging/iio/frequency/ad9832.c          | 2 +-
>  drivers/staging/iio/frequency/ad9834.c          | 2 +-
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index bfa12ce..41fb32d 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -633,7 +633,7 @@ static int ad7192_probe(struct spi_device *spi)
>
>         st = iio_priv(indio_dev);
>
> -       st->reg = devm_regulator_get(&spi->dev, "vcc");
> +       st->reg = devm_regulator_get(&spi->dev, "avdd");
>         if (!IS_ERR(st->reg)) {
>                 ret = regulator_enable(st->reg);
>                 if (ret)
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index c9a0c2a..a88236e 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -173,7 +173,7 @@ static int ad7780_probe(struct spi_device *spi)
>
>         ad_sd_init(&st->sd, indio_dev, spi, &ad7780_sigma_delta_info);
>
> -       st->reg = devm_regulator_get(&spi->dev, "vcc");
> +       st->reg = devm_regulator_get(&spi->dev, "avdd");
>         if (!IS_ERR(st->reg)) {
>                 ret = regulator_enable(st->reg);
>                 if (ret)
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 358400b..744c8ee 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -212,7 +212,7 @@ static int ad9832_probe(struct spi_device *spi)
>                 return -ENODEV;
>         }
>
> -       reg = devm_regulator_get(&spi->dev, "vcc");
> +       reg = devm_regulator_get(&spi->dev, "avdd");
>         if (!IS_ERR(reg)) {
>                 ret = regulator_enable(reg);
>                 if (ret)
> diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
> index 6366216..ca3cea6 100644
> --- a/drivers/staging/iio/frequency/ad9834.c
> +++ b/drivers/staging/iio/frequency/ad9834.c
> @@ -329,7 +329,7 @@ static int ad9834_probe(struct spi_device *spi)
>                 return -ENODEV;
>         }
>
> -       reg = devm_regulator_get(&spi->dev, "vcc");
> +       reg = devm_regulator_get(&spi->dev, "avdd");
>         if (!IS_ERR(reg)) {
>                 ret = regulator_enable(reg);
>                 if (ret)
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 5eecf1c..62f61bc 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -723,7 +723,7 @@ static int ad5933_probe(struct i2c_client *client,
>         if (!pdata)
>                 pdata = &ad5933_default_pdata;
>
> -       st->reg = devm_regulator_get(&client->dev, "vcc");
> +       st->reg = devm_regulator_get(&client->dev, "vdd");
>         if (!IS_ERR(st->reg)) {
>                 ret = regulator_enable(st->reg);
>                 if (ret)
> --
> 2.7.4
>
