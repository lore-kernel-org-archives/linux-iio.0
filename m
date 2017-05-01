Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35080 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969300AbdEALbB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 07:31:01 -0400
MIME-Version: 1.0
In-Reply-To: <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
References: <cover.1493450577.git.eraretuya@gmail.com> <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 1 May 2017 14:31:00 +0300
Message-ID: <CAHp75VcTptSxGnHJzosbio-8PG3ojgr2vfhL9QuUf+OgeCQWGA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
To: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Apr 29, 2017 at 10:49 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> The ADXL345 provides a DATA_READY interrupt function to signal
> availability of new data. This interrupt function is latched and can be
> cleared by reading the data registers. The polarity is set to active
> high by default.
>
> Support this functionality by setting it up as an IIO trigger.
>
> In addition, two output pins INT1 and INT2 are available for driving
> interrupts. Allow mapping to either pins by specifying the
> interrupt-names property in device tree.

> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
>                        const char *name);

I think I commented this once. Instead of increasing parameters,
please introduce a new struct (as separate preparatory patch) which
will hold current parameters. Let's call it
strut adxl345_chip {
 struct device *dev;
 struct regmap *regmap;
 const char *name;
};

I insisnt in this chage.

>  #include <linux/delay.h>
> +#include <linux/interrupt.h>
>  #include <linux/module.h>

> +#include <linux/of_irq.h>

Can we get rid of gnostic resource providers?

> +static const struct iio_trigger_ops adxl345_trigger_ops = {

> +       .owner = THIS_MODULE,

Do we still need this kind of lines?

> +       .set_trigger_state = adxl345_drdy_trigger_set_state,
> +};

>  static const struct iio_info adxl345_info = {

>         .driver_module  = THIS_MODULE,

Ditto, though it's in the current code.

>         .read_raw       = adxl345_read_raw,
>  };

> +       /*
> +        * Any bits set to 0 send their respective interrupts to the INT1 pin,
> +        * whereas bits set to 1 send their respective interrupts to the INT2
> +        * pin. Map all interrupts to the specified pin.
> +        */
> +       of_irq = of_irq_get_byname(dev->of_node, "INT2");

So, can we get it in resourse provider agnostic way?

> +       if (of_irq == irq)
> +               regval = 0xFF;
> +       else
> +               regval = 0x00;

regval = of_irq == irq ? 0xff : 0x00; ?

> +
> +       ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, regval);
> +       if (ret < 0) {
> +               dev_err(dev, "Failed to set up interrupts: %d\n", ret);
> +               return ret;
> +       }

-- 
With Best Regards,
Andy Shevchenko
