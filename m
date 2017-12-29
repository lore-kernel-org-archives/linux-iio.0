Return-Path: <SRS0=3mEm=DZ=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <1514531684-3872-1-git-send-email-mastichi@gmail.com>
References: <1514531684-3872-1-git-send-email-mastichi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 29 Dec 2017 11:12:57 +0200
Message-ID: <CAHp75VfWSnJ0jtL8sVn-kF1VN6kCzYr6x9K9t6Lm1PEp-FpiiA@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: max9611: fix module auto-loading
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>, Rob Herring <robh@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 29, 2017 at 9:14 AM, Dmitry Mastykin <mastichi@gmail.com> wrote:
> Module auto-load doesn't work because i2c table is not exported.
>

The simplest fix is to move to ->probe_new() since the driver is not
used out of DT/ACPI enumeration.

> Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
> ---
>  drivers/iio/adc/max9611.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index b1dd17c..7924b5c 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -516,13 +516,20 @@ static int max9611_init(struct max9611_dev *max9611)
>         return 0;
>  }
>
> +static const struct i2c_device_id max9611_id[] = {
> +       { "max9611", 0 },
> +       { "max9612", 0 },
> +       { },
> + };
> +MODULE_DEVICE_TABLE(i2c, max9611_id);
> +
>  static const struct of_device_id max9611_of_table[] = {
>         {.compatible = "maxim,max9611", .data = "max9611"},
>         {.compatible = "maxim,max9612", .data = "max9612"},
>         { },
>  };
> -
>  MODULE_DEVICE_TABLE(of, max9611_of_table);
> +
>  static int max9611_probe(struct i2c_client *client,
>                          const struct i2c_device_id *id)
>  {
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
