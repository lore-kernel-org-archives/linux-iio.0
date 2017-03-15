Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:32940 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbdCOKrh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 06:47:37 -0400
Received: by mail-lf0-f52.google.com with SMTP id a6so5143240lfa.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Mar 2017 03:47:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-3-javier@osg.samsung.com>
References: <20170315044505.20660-1-javier@osg.samsung.com> <20170315044505.20660-3-javier@osg.samsung.com>
From: Crt Mori <cmo@melexis.com>
Date: Wed, 15 Mar 2017 11:46:50 +0100
Message-ID: <CAKv63ut_b2-hGVHfS0Pa52oiajMJOoOXDBATJ2FPua7rtZxeEg@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] iio: mlx96014: Add OF device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org,
        Linux Iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,
Thanks for the patch. If the assumption will not be there than this
fix is needed. I tested it on BeagleBoneBlack and it does not effect
anything.

Tested-by: Crt Mori <cmo@melexis.com>
Acked-by: Crt Mori <cmo@melexis.com>

Best regards,
Crt


On 15 March 2017 at 05:44, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
>
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>
>  drivers/iio/temperature/mlx90614.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 4b645fc672aa..2077eef4095c 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -585,6 +585,12 @@ static const struct i2c_device_id mlx90614_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mlx90614_id);
>
> +static const struct of_device_id mlx90614_of_match[] = {
> +       { .compatible = "melexis,mlx90614" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, mlx90614_of_match);
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int mlx90614_pm_suspend(struct device *dev)
>  {
> @@ -644,6 +650,7 @@ static const struct dev_pm_ops mlx90614_pm_ops = {
>  static struct i2c_driver mlx90614_driver = {
>         .driver = {
>                 .name   = "mlx90614",
> +               .of_match_table = mlx90614_of_match,
>                 .pm     = &mlx90614_pm_ops,
>         },
>         .probe = mlx90614_probe,
> --
> 2.9.3
>
