Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:35706 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbcIAU6j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2016 16:58:39 -0400
Received: by mail-oi0-f51.google.com with SMTP id p186so99577168oia.2
        for <linux-iio@vger.kernel.org>; Thu, 01 Sep 2016 13:58:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e47d50396f14793f50b2bc198d5ef20210058ebc.1472746681.git.gregor.boirie@parrot.com>
References: <cover.1472746681.git.gregor.boirie@parrot.com> <e47d50396f14793f50b2bc198d5ef20210058ebc.1472746681.git.gregor.boirie@parrot.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Sep 2016 22:30:28 +0200
Message-ID: <CACRpkdb2GDQ3WX5oWXcvw1KSkPRFf073QgJmJ0xM9coT3gLg2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] iio:pressure: initial zpa2326 barometer support
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Marek Vasut <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

LOn Thu, Sep 1, 2016 at 6:25 PM, Gregor Boirie <gregor.boirie@parrot.com> wrote:

> Introduce driver for Murata ZPA2326 pressure and temperature sensor:
> http://www.murata.com/en-us/products/productdetail?partno=ZPA2326-0311A-R
>
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>

Looking nice!

> +Optional properties:
> +- interrupt-parent: should be the phandle for the interrupt controller
> +- interrupts: interrupt mapping for IRQ
> +- vdd-supply: an optional regulator that needs to be on to provide VDD
> +  power to the sensor
> +

vref-supply?

> +/* Hardware sampling frequency descriptor. */
> +struct zpa2326_frequency {
> +       /* Stringified frequency in Hertz. */
> +       const char *hz;
> +       /* Output Data Rate word as expected by ZPA2326_CTRL_REG3_REG. */
> +       u16         odr;
> +};

I still prefer the kerneldoc style of documenting, even if we're not
building the
documentation from this file. But OK it's a matter of taste maybe.

> +/* Per-device internal private state. */
> +struct zpa2326_private {

That opinion applies also for this struct.

> +/*
> + * Fetch single byte from slave register.
> + * indio_dev: IIO device the slave is attached to.
> + * address:   address of register to read from.
> + *
> + * Returns the fetched byte when successful, a negative error code otherwise.
> + */
> +static int zpa2326_read_byte(const struct iio_dev *indio_dev, u8 address)

I also prefer functions to use kerneldoc style. Even if they
are not built into documents. For uniformness.

> +static int zpa2326_enable_device(const struct iio_dev *indio_dev)
> +{
> +       int err = zpa2326_write_byte(indio_dev, ZPA2326_CTRL_REG0_REG,
> +                                    ZPA2326_CTRL_REG0_ENABLE);

Argh declaring a variable and immediately performing an operation
assigning it a value scares me. I can't say why, it's just that I
want it like:

int ret;

ret = zpa...

I also use "ret" over "err". The rationale is that it is a return code,
not an error code. It is only an error code if it is negative or != 0.
Again that is a personal preference I guess, at least I have an
explanation for it.

> +static int zpa2326_power_on(const struct iio_dev         *indio_dev,
> +                           const struct zpa2326_private *private)
> +{
> +       int err = regulator_enable(private->vref);
> +
> +       if (err)
> +               return err;
> +
> +       err = regulator_enable(private->vdd);
> +       if (err)
> +               goto vref;
> +
> +       zpa2326_dbg(indio_dev, "powered on");
> +
> +       err = zpa2326_enable_device(indio_dev);
> +       if (err)
> +               goto vdd;
> +
> +       err = zpa2326_reset_device(indio_dev);
> +       if (err)
> +               goto disable;
> +
> +       return 0;
> +
> +disable:
> +       zpa2326_disable_device(indio_dev);
> +vdd:
> +       regulator_disable(private->vdd);
> +vref:
> +       regulator_disable(private->vref);

I would personally name the labels "out_disable_device"
"out_disable_vdd", "out_disable_vref" but maybe I
have a bit of talkative style.

> +/* Power off device, i.e. disable attached power regulators. */
> +static void zpa2326_power_off(const struct iio_dev         *indio_dev,
> +                             const struct zpa2326_private *private)
> +{
> +       regulator_disable(private->vdd);
> +       regulator_disable(private->vref);
> +
> +       zpa2326_dbg(indio_dev, "powered off");
> +}

Why is zpa2326_disable_device() called on the error path
but not in the power off function?

> +static int zpa2326_dequeue_pressure(const struct iio_dev *indio_dev,
> +                                   u32                  *pressure)
> +{
> +       int err = zpa2326_read_byte(indio_dev, ZPA2326_STATUS_REG);
> +       int cleared = -1;
> +
> +       if (err < 0)
> +               return err;
> +
> +       *pressure = 0;
> +
> +       if (err & ZPA2326_STATUS_P_OR) {
> +               /*
> +                * Fifo overrun : first sample dequeued from fifo is the
> +                * newest.
> +                */
> +               zpa2326_warn(indio_dev, "fifo overflow");
> +
> +               err = zpa2326_read_block(indio_dev, ZPA2326_PRESS_OUT_XL_REG, 3,
> +                                        (u8 *)pressure);
> +               if (err)
> +                       return err;
> +
> +#define ZPA2326_FIFO_DEPTH (16U)
> +               /* Hardware fifo may hold no more than 16 pressure samples. */
> +               return zpa2326_clear_fifo(indio_dev, ZPA2326_FIFO_DEPTH - 1);

I would not put a #define in the middle of the code like that, but
in the top of the file. But I've seen others do this so it's no
strong opinion.

> +                       /*
> +                        * Pressure resolution is 1/64 Pascal. Scale to kPascal
> +                        * as required by IIO ABI.
> +                        */
> +                       *val = 0;
> +                       *val2 = 1000000 / 64;
> +                       return IIO_VAL_INT_PLUS_NANO;

If what you return is a fraction why not:

*val = 1000000;
*val2 = 64;
return IIO_VAL_FRACTIONAL;

?

If you insist on performing a division in the code,
use DIV_ROUND_CLOSEST().

> +       case IIO_CHAN_INFO_OFFSET:
> +               switch (chan->type) {
> +               case IIO_TEMP:
> +                       *val = -17683000 / 649;
> +                       *val2 = ((17683000 % 649) * 1000000000ULL) / 649ULL;
> +                       return IIO_VAL_INT_PLUS_NANO;

Same here. Rewrite that equation as a fraction and it becomes
much prettier I think.

> +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> +                             zpa2326_show_frequency,
> +                             zpa2326_store_frequency);
> +
> +/* Expose supported hardware sampling frequencies (Hz) through sysfs. */
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 5 11 23");
> +
> +static struct attribute *zpa2326_attributes[] = {
> +       &iio_dev_attr_sampling_frequency.dev_attr.attr,
> +       &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +       NULL
> +};

I was asked to supply these through the raw read/write functions in my
driver by using IIO_CHAN_INFO_SAMP_FREQ. It works like a charm!
If you want it to apply to the whole device, use the
.info_mask_shared_by_all = = BIT(IIO_CHAN_INFO_SAMP_FREQ),

(See my MPU-3050 driver patch for an example.)

Yours,
Linus Walleij
