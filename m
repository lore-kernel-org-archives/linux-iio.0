Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:37505 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753982AbdHWNVy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Aug 2017 09:21:54 -0400
Received: by mail-wr0-f169.google.com with SMTP id z91so214660wrc.4
        for <linux-iio@vger.kernel.org>; Wed, 23 Aug 2017 06:21:53 -0700 (PDT)
Date: Wed, 23 Aug 2017 14:21:49 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Abhisit Sangjan <s.abhisit@gmail.com>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        jmondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mfd: Add support for TI LMP92001
Message-ID: <20170823132149.svvvhtvrxv3fxhax@dell>
References: <1503383171-15515-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708220911130.5706@vps.pmeerw.net>
 <CAMV_pUbBCkX6NME1c4NG-e48c0Vcs48N8JDYaDQqqypC0VjmDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAMV_pUbBCkX6NME1c4NG-e48c0Vcs48N8JDYaDQqqypC0VjmDw@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 23 Aug 2017, Abhisit Sangjan wrote:
> > > From: Abhisit Sangjan <s.abhisit@gmail.com>
> > >
> > > TI LMP92001 Analog System Monitor and Controller
 
[...]

> > > Signed-off-by: Abhisit Sangjan <s.abhisit@gmail.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-iio-lmp920001  |  92 ++++
> > >  .../devicetree/bindings/gpio/gpio-lmp92001.txt     |  22 +
> > >  .../bindings/iio/adc/ti-lmp92001-adc.txt           |  21 +
> > >  .../bindings/iio/dac/ti-lmp92001-dac.txt           |  35 ++
> > >  drivers/gpio/Kconfig                               |   7 +
> > >  drivers/gpio/Makefile                              |   1 +
> > >  drivers/gpio/gpio-lmp92001.c                       | 209 +++++++++
> > >  drivers/iio/adc/Kconfig                            |  10 +
> > >  drivers/iio/adc/Makefile                           |   1 +
> > >  drivers/iio/adc/lmp92001-adc.c                     | 500
> > +++++++++++++++++++++
> > >  drivers/iio/dac/Kconfig                            |   9 +
> > >  drivers/iio/dac/Makefile                           |   1 +
> > >  drivers/iio/dac/lmp92001-dac.c                     | 390
> > ++++++++++++++++
> > >  drivers/mfd/Kconfig                                |  12 +
> > >  drivers/mfd/Makefile                               |   4 +
> > >  drivers/mfd/lmp92001-core.c                        | 308 +++++++++++++
> > >  drivers/mfd/lmp92001-debug.c                       |  67 +++
> > >  drivers/mfd/lmp92001-i2c.c                         | 215 +++++++++
> > >  include/linux/mfd/lmp92001/core.h                  | 119 +++++
> > >  include/linux/mfd/lmp92001/debug.h                 |  28 ++
> > >  20 files changed, 2051 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-lmp920001
> > >  create mode 100644 Documentation/devicetree/
> > bindings/gpio/gpio-lmp92001.txt
> > >  create mode 100644 Documentation/devicetree/
> > bindings/iio/adc/ti-lmp92001-adc.txt
> > >  create mode 100644 Documentation/devicetree/
> > bindings/iio/dac/ti-lmp92001-dac.txt
> > >  create mode 100644 drivers/gpio/gpio-lmp92001.c
> > >  create mode 100644 drivers/iio/adc/lmp92001-adc.c
> > >  create mode 100644 drivers/iio/dac/lmp92001-dac.c
> > >  create mode 100644 drivers/mfd/lmp92001-core.c
> > >  create mode 100644 drivers/mfd/lmp92001-debug.c
> > >  create mode 100644 drivers/mfd/lmp92001-i2c.c
> > >  create mode 100644 include/linux/mfd/lmp92001/core.h
> > >  create mode 100644 include/linux/mfd/lmp92001/debug.h

[...]

> > > +struct lmp92001_gpio {
> > > +     struct lmp92001 *lmp92001;
> > > +     struct gpio_chip gpio_chip;
> > > +};
> > > +
> > > +static int lmp92001_gpio_get_direction(struct gpio_chip *chip,
> > unsigned offset)
> >
> > unsigned vs unsigned int
> >
> 
> I am follow the function prototype, it is unsigned.
> 
> struct gpio_chip {
> ...
> int (*get_direction)(struct gpio_chip *chip,
> unsigned offset);
> ...
> };

[...]

> > > +#ifdef CONFIG_DEBUG_FS
> > > +static void lmp92001_gpio_dbg_show(struct seq_file *s, struct gpio_chip
> > *chip)
> > > +{
> > > +     struct lmp92001_gpio *lmp92001_gpio = gpiochip_get_data(chip);
> > > +     struct lmp92001 *lmp92001 = lmp92001_gpio->lmp92001;
> > > +     int i, gpio;
> > > +     unsigned int cgpo;
> > > +     const char *label, *dir, *logic;
> > > +
> > > +     for (i = 0; i < chip->ngpio; i++) {
> > > +             gpio = i + chip->base;
> > > +
> > > +             label = gpiochip_is_requested(chip, i);
> > > +             if (!label)
> > > +                     continue;
> > > +
> > > +             regmap_read(lmp92001->regmap, LMP92001_CGPO, &cgpo);
> >
> > retval is not checked here (and elsewhere)
> >
> 
> This function is return void.

Please clip your responses!

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
