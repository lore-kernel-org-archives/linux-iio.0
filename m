Return-Path: <SRS0=yyGB=7U=gmail.com=s.abhisit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170811143847.GA19152@localhost>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net> <20170811143847.GA19152@localhost>
From: Abhisit Sangjan <s.abhisit@gmail.com>
Date: Fri, 18 Aug 2017 09:34:16 +0700
Message-ID: <CAMV_pUa0XvzNYcR0ryHSt=qsdLKCtOLfQNz3LsWxaj9VGmFxLw@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
To: jmondi <jacopo@jmondi.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	fabrice.gasnier@st.com, Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>, marek.vasut+renesas@gmail.com,
	jacopo+renesas@jmondi.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403045ec4322c39780556fdf7f1"
List-ID: <linux-iio@vger.kernel.org>

--f403045ec4322c39780556fdf7f1
Content-Type: text/plain; charset="UTF-8"

Hi Jmondi,

Thank you for your recommend, I am testing the code will be send the new
patch in soon.

On Fri, Aug 11, 2017 at 9:38 PM, jmondi <jacopo@jmondi.org> wrote:

> Hi Abhisit,
>
> On Thu, Aug 03, 2017 at 12:40:49PM +0200, Peter Meerwald-Stadler wrote:
> >
> > > From: Abhisit Sangjan <s.abhisit@gmail.com>
> >
> > some more comments in addition to Jonathan's
>
> and some more here... As a general one, I see all code indented with
> spaces O_0
>
> Please run checkpatch as Jonathan said, and instruct your editor to
> indent with tabs instead.
>

Abhisit: I have changed all space-bar to  tab.


>
> Also, your Signed-off-by is missing (not sure it has been mentioned in
> other review comments)
>

Abhisit: Sorry, I forget it, thanks.


>
>
>
> > > ---
> > >  drivers/iio/adc/Kconfig        |  10 +
> > >  drivers/iio/adc/Makefile       |   1 +
> > >  drivers/iio/adc/lmp92001-adc.c | 479 ++++++++++++++++++++++++++++++
> +++++++++++
> > >  3 files changed, 490 insertions(+)
> > >  create mode 100644 drivers/iio/adc/lmp92001-adc.c
> > >
> > > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > > index 614fa41..b623b4d 100644
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -857,4 +857,14 @@ config XILINX_XADC
> > >       The driver can also be build as a module. If so, the module will
> be called
> > >       xilinx-xadc.
> > >
> > > +config LMP92001_ADC
> > > +       tristate "TI LMP92001 ADC Driver"
> > > +       depends on MFD_LMP92001
> > > +       help
> > > +         If you say yes here you get support for TI LMP92001 ADCs
> > > +         conversion.
> > > +
> > > +         This driver can also be built as a module. If so, the module
> will
> > > +         be called lmp92001_adc.
> > > +
> > >  endmenu
> > > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > > index b546736a..75b24b1 100644
> > > --- a/drivers/iio/adc/Makefile
> > > +++ b/drivers/iio/adc/Makefile
> > > @@ -78,3 +78,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> > >  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> > >  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
> > >  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> > > +obj-$(CONFIG_LMP92001_ADC) += lmp92001-adc.o
> > > diff --git a/drivers/iio/adc/lmp92001-adc.c
> b/drivers/iio/adc/lmp92001-adc.c
> > > new file mode 100644
> > > index 0000000..909ff47
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/lmp92001-adc.c
> > > @@ -0,0 +1,479 @@
> > > +/*
> > > + * lmp92001-adc.c - Support for TI LMP92001 ADCs
> > > + *
> > > + * Copyright 2016-2017 Celestica Ltd.
> > > + *
> > > + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> > > + *
> > > + * Inspired by wm831x and ad5064 drivers.
> > > + *
> > > + * This program is free software; you can redistribute it and/or
> modify
> > > + * it under the terms of the GNU General Public License as published
> by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > + *
> > > + */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/interrupt.h>
>
> Keep also includes alphabetically sorted please
>

Abhisit: I see, thanks.


>
> > > +
> > > +#include <linux/mfd/lmp92001/core.h>
> > > +
> > > +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> > > +                                struct iio_chan_spec const *channel,
> int *val,
> > > +                                int *val2, long mask)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int code, cgen, sgen, try;
> > > +        int ret;
> > > +
> > > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        /*
> > > +         * Is not continuous conversion?
> > > +         * Lock the registers (if needed).
> > > +         * Triggering single-short conversion.
> > > +         * Waiting for conversion successfully.
> > > +         */
> > > +        if (!(cgen & 1))
> > > +        {
> > > +                if (!(cgen & 2))
> > > +                {
> > > +                        ret = regmap_update_bits(lmp92001->regmap,
> > > +
> LMP92001_CGEN, 2, 2);
> > > +                        if (ret < 0)
> > > +                                return ret;
> > > +                }
> > > +
> > > +                ret = regmap_write(lmp92001->regmap, LMP92001_CTRIG,
> 1);
> > > +                if (ret < 0)
> > > +                        return ret;
> > > +
> > > +                try = 10;
> > > +                do {
> > > +                        ret = regmap_read(lmp92001->regmap,
> > > +                                                LMP92001_SGEN, &sgen);
> > > +                        if(ret < 0)
> >
> > style, space after if, space around operators
> >
> > > +                                return ret;
> > > +                } while ((sgen & 1<<7) && (--try > 0));
> > > +
> > > +                if (!try)
> > > +                        return -ETIME;
> >
> > most drivers use ETIMEOUT
> >
> > > +        }
> > > +
> > > +        ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel,
> &code);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        switch (mask)
> > > +        {
> > > +        case IIO_CHAN_INFO_RAW:
> > > +                switch (channel->type) {
> > > +                case IIO_VOLTAGE:
> > > +                case IIO_TEMP:
> > > +                        *val = code;
> > > +                        return IIO_VAL_INT;
> > > +                default:
> > > +                        break;
> > > +                }
> > > +                break;
> > > +        default:
> > > +                break;
>
> You can remove these default cases or return -EINVAL here.
>

Abhisit: Okay, I will remove it.
             Could you tell me in detail. Sorry, I do not understand the
Technical.


>
> > > +        }
> > > +
> > > +        return -EINVAL;
> > > +}
> > > +
> > > +/*
> > > + * TODO: do your attributes even handler for
> > > + * Current limit low/high for CH 1-3, 9-11!
> > > + * In case INT1 and INT2 were connected to i.MX6.
> > > + */
>
> Why mention the SoC here?
>

Abhisit: I have remove it.


>
> > > +static const struct iio_info lmp92001_info = {
> > > +        .read_raw = lmp92001_read_raw,
> > > +        .driver_module = THIS_MODULE,
> > > +};
> > > +
> > > +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                        struct iio_chan_spec const *channel, char
> *buf)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int cref;
> > > +        int ret;
> > > +
> > > +        ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        return sprintf(buf, "%s\n", cref & 2 ? "external" :
> "internal");
> > > +}
> > > +
> > > +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > > +                         size_t len)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int cref;
> > > +        int ret;
> > > +
> > > +        if (strcmp("external\n", buf) == 0)
> > > +                cref = 2;
> > > +        else if (strcmp("internal\n", buf) == 0)
> > > +                cref = 0;
> > > +        else
> > > +                return -EINVAL;
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, 2,
> cref);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        return len;
> > > +}
> > > +
> > > +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                        struct iio_chan_spec const *channel, char
> *buf)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int reg, cad;
> > > +        int ret;
> > > +
> > > +        switch (channel->channel)
> > > +        {
> > > +        case 1 ... 8:
> > > +                reg = LMP92001_CAD1;
> > > +                break;
> > > +        case 9 ... 16:
> > > +                reg = LMP92001_CAD2;
> > > +                break;
> > > +        case 17:
> > > +                reg = LMP92001_CAD3;
> > > +                break;
> > > +        default:
> > > +                return -EINVAL;
> > > +        }
> > > +
> > > +        ret = regmap_read(lmp92001->regmap, reg, &cad);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        if (channel->channel <= 8)
> > > +                cad >>= channel->channel - 1;
> > > +        else if(channel->channel > 8)
> > > +                cad >>= channel->channel - 9;
> > > +        else if(channel->channel > 16)
> > > +                cad >>= channel->channel - 17;
> > > +        else
> > > +                return -EINVAL;
> > > +
> > > +        return sprintf(buf, "%s\n", cad & 1 ? "enable" : "disable");
> > > +}
> > > +
> > > +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > > +                         size_t len)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int reg, enable, shif, mask;
> > > +        int ret;
> > > +
> > > +        switch (channel->channel)
> > > +        {
> > > +        case 1 ... 8:
> > > +                reg = LMP92001_CAD1;
> > > +                shif = (channel->channel - 1);
> > > +                break;
> > > +        case 9 ... 16:
> > > +                reg = LMP92001_CAD2;
> > > +                shif = (channel->channel - 9);
> > > +                break;
> > > +        case 17:
> > > +                reg = LMP92001_CAD3;
> > > +                shif = (channel->channel - 17);
> > > +                break;
> > > +        default:
> > > +                return -EINVAL;
> > > +        }
> > > +
> > > +        if (strcmp("enable\n", buf) == 0)
>
> Always use the length limited version of string manipulation functions
> when possible (drop the \n, also)
>

Abhisit: It is optimization, I got you.


>
> > > +                enable = 1;
> > > +        else if (strcmp("disable\n", buf) == 0)
> > > +                enable = 0;
> > > +        else
> > > +                return -EINVAL;
> > > +
> > > +        enable <<= shif;
> > > +        mask = 1 << shif;
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, reg, mask,
> enable);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        return len;
> > > +}
> > > +
> > > +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                        struct iio_chan_spec const *channel, char
> *buf)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int cgen;
> > > +        int ret;
> > > +
> > > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        return sprintf(buf, "%s\n", cgen & 1 ? "continuous" :
> "single-shot");
> > > +}
> > > +
> > > +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev,
> uintptr_t private,
> > > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > > +                         size_t len)
> > > +{
> > > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_
> dev);
> > > +        unsigned int cgen;
> > > +        int ret;
> > > +
> > > +        if (strcmp("continuous\n", buf) == 0)
> > > +                cgen = 1;
> > > +        else if (strcmp("single-shot\n", buf) == 0)
> > > +                cgen = 0;
> > > +        else
> > > +                return -EINVAL;
> > > +
> > > +        /*
> > > +         * Unlock the registers.
> > > +         * Set conversion mode.
> > > +         * Lock the registers.
> > > +         */
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
> 0);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 1,
> cgen);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
> 2);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        return len;
> > > +}
> > > +
> > > +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> > > +        {
> > > +                .name = "vref",
> > > +                .read = lmp92001_avref_read,
> > > +                .write = lmp92001_avref_write,
> > > +                .shared = IIO_SHARED_BY_ALL,
> > > +        },
> > > +        {
> > > +                .name = "en",
> > > +                .read = lmp92001_enable_read,
> > > +                .write = lmp92001_enable_write,
> > > +                .shared = IIO_SEPARATE,
> > > +        },
> > > +        {
> > > +                .name = "mode",
> > > +                .read = lmp92001_mode_read,
> > > +                .write = lmp92001_mode_write,
> > > +                .shared = IIO_SHARED_BY_ALL,
> > > +        },
> > > +        { },
> > > +};
> > > +
> > > +static const struct iio_event_spec lmp92001_events[] = {
> > > +        {
> > > +                .type = IIO_EV_TYPE_THRESH,
> > > +                .dir = IIO_EV_DIR_RISING,
> > > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> > > +                        BIT(IIO_EV_INFO_VALUE),
> > > +        },
> > > +        {
> > > +                .type = IIO_EV_TYPE_THRESH,
> > > +                .dir = IIO_EV_DIR_FALLING,
> > > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> > > +                        BIT(IIO_EV_INFO_VALUE),
> > > +        },
> > > +        { },
> > > +};
> > > +
> > > +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
> > > +{ \
> > > +        .channel = _ch, \
> > > +        .scan_index = _ch, \
> > > +        .scan_type = { \
> > > +                        .sign = 'u', \
> > > +                        .realbits = 12, \
> > > +                        .storagebits = 16, \
> > > +                        .repeat = 1, \
> > > +                        .endianness = IIO_BE, \
> > > +        }, \
> > > +        .type = _type, \
> > > +        .indexed = 1, \
> > > +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > > +        .event_spec = _event, \
> > > +        .num_event_specs = _nevent, \
> > > +        .ext_info = lmp92001_ext_info, \
> > > +}
> > > +
> > > +/*
> > > + * TODO: do your ext_info for current low/high limit.
> > > + * Example driver/iio/dac/ad5064.c
> > > + */
> > > +static const struct iio_chan_spec lmp92001_adc_channels[] = {
> > > +        LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > > +        LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL, 0),
> > > +        LMP92001_CHAN_SPEC(17,    IIO_TEMP, NULL, 0),
> >
> > wondering in what unit the drivers reports _TEMP, probably _SCALE needed
> >
> > > +};
> > > +
> > > +static int lmp92001_adc_probe(struct platform_device *pdev)
> > > +{
> > > +        struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.
> parent);
> > > +        struct iio_dev *indio_dev;
> > > +        struct device_node *np = pdev->dev.of_node;
> > > +        const char *conversion;
> > > +        unsigned int cgen = 0, cad1, cad2, cad3;
> > > +        u32 mask;
> > > +        int ret;
> > > +
> > > +        indio_dev = devm_iio_device_alloc(&pdev->dev,
> sizeof(*lmp92001));
> > > +        if (!indio_dev)
> > > +                return -ENOMEM;
> > > +
> > > +        iio_device_set_drvdata(indio_dev, lmp92001);
> > > +
> > > +        indio_dev->name = pdev->name;
> > > +        indio_dev->dev.parent = &pdev->dev;
> > > +        indio_dev->modes = INDIO_DIRECT_MODE;
> > > +        indio_dev->info = &lmp92001_info;
> > > +        indio_dev->channels = lmp92001_adc_channels;
> > > +        indio_dev->num_channels = ARRAY_SIZE(lmp92001_adc_channels);
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN,
> 0x80, 0x80);
> > > +        if (ret < 0)
> > > +        {
> > > +                dev_err(&pdev->dev,"failed to self reset all
> registers\n");
> > > +                return ret;
> > > +        }
> > > +
> > > +        ret = of_property_read_u32(np, "ti,lmp92001-adc-mask", &mask);
> > > +        if (ret < 0)
> > > +        {
> > > +                cad1 = cad2 = cad3 = 0xFF;
> > > +                dev_info(&pdev->dev, "turn on all of channels by
> default\n");
> > > +        }
> > > +        else
> > > +        {
> > > +                cad1 = mask & 0xFF;
> > > +                cad2 = (mask >> 8) & 0xFF;
> > > +                cad3 = (mask >> 16) & 0xFF;
> > > +        }
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD1,
> 0xFF, cad1);
> > > +        if (ret < 0)
> > > +        {
> > > +                dev_err(&pdev->dev,"failed to enable channels 1-8\n");
> > > +                return ret;
> > > +        }
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD2,
> 0xFF, cad2);
> > > +        if (ret < 0)
> > > +        {
> > > +                dev_err(&pdev->dev, "failed to enable channels
> 9-16\n");
> > > +                return ret;
> > > +        }
> > > +
> > > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD3, 1,
> cad3);
> > > +        if (ret < 0)
> > > +        {
> > > +                dev_err(&pdev->dev, "failed to enable channel 17
> (temperature)\n");
> > > +                return ret;
> > > +        }
> > > +
> > > +        ret = of_property_read_string_index(np,
> "ti,lmp92001-adc-mode", 0,
> > > +                                                &conversion);
> > > +        if (!ret)
> > > +        {
> > > +                if (strcmp("continuous", conversion) == 0)
> > > +                        cgen |= 1;
> > > +                else if (strcmp("single-shot", conversion) == 0)
> > > +                        { /* Okay */ }
> > > +                else
> > > +                        dev_warn(&pdev->dev,
> > > +                        "wrong adc mode! set to single-short
> conversion\n");
> > > +        }
> > > +        else
> > > +                dev_info(&pdev->dev,
> > > +                "single-short conversion was chosen by default\n");
> > > +
> > > +        /*
> > > +         * Lock the registers and set conversion mode.
> > > +         */
> > > +        ret = regmap_update_bits(lmp92001->regmap,
> > > +                                        LMP92001_CGEN, 3, cgen | 2);
> > > +        if (ret < 0)
> > > +                return ret;
> > > +
> > > +        platform_set_drvdata(pdev, indio_dev);
> > > +
> > > +        return iio_device_register(indio_dev);
>
> You are using devm_ version of iio_device_alloc, maybe you can use
> devm version of iio_device_register here as well
>

Abhisit: I will be changed it.


>
> > > +}
> > > +
> > > +static int lmp92001_adc_remove(struct platform_device *pdev)
> > > +{
> > > +        struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > +
> > > +        iio_device_unregister(indio_dev);
>
> with devm_ version of above functions, I guess you can remove this if
> no other clean ups are required
>

Abhisit: I will do, thanks.


>
> Thanks
>   j
>
> > > +
> > > +        return 0;
> > > +}
> > > +
> > > +static struct platform_driver lmp92001_adc_driver = {
> > > +        .driver.name    = "lmp92001-adc",
> > > +        .driver.owner   = THIS_MODULE,
> > > +        .probe          = lmp92001_adc_probe,
> > > +        .remove         = lmp92001_adc_remove,
> > > +};
> > > +
> > > +static int __init lmp92001_adc_init(void)
> > > +{
> > > +        return platform_driver_register(&lmp92001_adc_driver);
> > > +}
> > > +subsys_initcall(lmp92001_adc_init);
> > > +
> > > +static void __exit lmp92001_adc_exit(void)
> > > +{
> > > +        platform_driver_unregister(&lmp92001_adc_driver);
> > > +}
> > > +module_exit(lmp92001_adc_exit);
> > > +
> > > +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> > > +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:lmp92001-adc");
> > >
> >
> > --
> >
> > Peter Meerwald-Stadler
> > Mobile: +43 664 24 44 418
>

--f403045ec4322c39780556fdf7f1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Jmondi,<div><br></div><div>Thank you for your recommend=
, I am testing the code will be send the new patch in soon.<br><div class=
=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, Aug 11, 2017 at 9:3=
8 PM, jmondi <span dir=3D"ltr">&lt;<a href=3D"mailto:jacopo@jmondi.org" tar=
get=3D"_blank">jacopo@jmondi.org</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi Abhisit,<br>
<span class=3D""><br>
On Thu, Aug 03, 2017 at 12:40:49PM +0200, Peter Meerwald-Stadler wrote:<br>
&gt;<br>
&gt; &gt; From: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail.com">=
s.abhisit@gmail.com</a>&gt;<br>
&gt;<br>
&gt; some more comments in addition to Jonathan&#39;s<br>
<br>
</span>and some more here... As a general one, I see all code indented with=
<br>
spaces O_0<br>
<br>
Please run checkpatch as Jonathan said, and instruct your editor to<br>
indent with tabs instead.<br></blockquote><div><br></div><div>Abhisit: I ha=
ve changed all space-bar to =C2=A0tab.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
<br>
Also, your Signed-off-by is missing (not sure it has been mentioned in<br>
other review comments)<br></blockquote><div><br></div><div>Abhisit: Sorry, =
I forget it, thanks.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><div class=3D"h5"><span style=3D"color:rgb(34,34,34)">=C2=A0</span><br=
></div></div></blockquote><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div><div class=3D=
"h5">
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;=C2=A0 drivers/iio/adc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
10 +<br>
&gt; &gt;=C2=A0 drivers/iio/adc/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A01 +<br>
&gt; &gt;=C2=A0 drivers/iio/adc/lmp92001-adc.c | 479 ++++++++++++++++++++++=
++++++++<wbr>+++++++++++<br>
&gt; &gt;=C2=A0 3 files changed, 490 insertions(+)<br>
&gt; &gt;=C2=A0 create mode 100644 drivers/iio/adc/lmp92001-adc.c<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig<br=
>
&gt; &gt; index 614fa41..b623b4d 100644<br>
&gt; &gt; --- a/drivers/iio/adc/Kconfig<br>
&gt; &gt; +++ b/drivers/iio/adc/Kconfig<br>
&gt; &gt; @@ -857,4 +857,14 @@ config XILINX_XADC<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0The driver can also be build as a modul=
e. If so, the module will be called<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0xilinx-xadc.<br>
&gt; &gt;<br>
&gt; &gt; +config LMP92001_ADC<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;TI LMP92001 ADC Driver=
&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_LMP92001<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes here you get su=
pport for TI LMP92001 ADCs<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conversion.<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built =
as a module. If so, the module will<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be called lmp92001_adc.<br>
&gt; &gt; +<br>
&gt; &gt;=C2=A0 endmenu<br>
&gt; &gt; diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile<=
br>
&gt; &gt; index b546736a..75b24b1 100644<br>
&gt; &gt; --- a/drivers/iio/adc/Makefile<br>
&gt; &gt; +++ b/drivers/iio/adc/Makefile<br>
&gt; &gt; @@ -78,3 +78,4 @@ obj-$(CONFIG_VF610_ADC) +=3D vf610_adc.o<br>
&gt; &gt;=C2=A0 obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o<br>
&gt; &gt;=C2=A0 xilinx-xadc-y :=3D xilinx-xadc-core.o xilinx-xadc-events.o<=
br>
&gt; &gt;=C2=A0 obj-$(CONFIG_XILINX_XADC) +=3D xilinx-xadc.o<br>
&gt; &gt; +obj-$(CONFIG_LMP92001_ADC) +=3D lmp92001-adc.o<br>
&gt; &gt; diff --git a/drivers/iio/adc/lmp92001-<wbr>adc.c b/drivers/iio/ad=
c/lmp92001-<wbr>adc.c<br>
&gt; &gt; new file mode 100644<br>
&gt; &gt; index 0000000..909ff47<br>
&gt; &gt; --- /dev/null<br>
&gt; &gt; +++ b/drivers/iio/adc/lmp92001-<wbr>adc.c<br>
&gt; &gt; @@ -0,0 +1,479 @@<br>
&gt; &gt; +/*<br>
&gt; &gt; + * lmp92001-adc.c - Support for TI LMP92001 ADCs<br>
&gt; &gt; + *<br>
&gt; &gt; + * Copyright 2016-2017 Celestica Ltd.<br>
&gt; &gt; + *<br>
&gt; &gt; + * Author: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail=
.com">s.abhisit@gmail.com</a>&gt;<br>
&gt; &gt; + *<br>
&gt; &gt; + * Inspired by wm831x and ad5064 drivers.<br>
&gt; &gt; + *<br>
&gt; &gt; + * This program is free software; you can redistribute it and/or=
 modify<br>
&gt; &gt; + * it under the terms of the GNU General Public License as publi=
shed by<br>
&gt; &gt; + * the Free Software Foundation; either version 2 of the License=
, or<br>
&gt; &gt; + * (at your option) any later version.<br>
&gt; &gt; + *<br>
&gt; &gt; + * This program is distributed in the hope that it will be usefu=
l,<br>
&gt; &gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty o=
f<br>
&gt; &gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 Se=
e the<br>
&gt; &gt; + * GNU General Public License for more details.<br>
&gt; &gt; + *<br>
&gt; &gt; + */<br>
&gt; &gt; +<br>
&gt; &gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; &gt; +#include &lt;linux/module.h&gt;<br>
&gt; &gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; &gt; +#include &lt;linux/mfd/core.h&gt;<br>
&gt; &gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; &gt; +#include &lt;linux/interrupt.h&gt;<br>
<br>
</div></div>Keep also includes alphabetically sorted please<br></blockquote=
><div><br></div><div>Abhisit: I see, thanks.</div><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; &gt; +<br>
&gt; &gt; +#include &lt;linux/mfd/lmp92001/core.h&gt;<br>
&gt; &gt; +<br>
&gt; &gt; +static int lmp92001_read_raw(struct iio_dev *indio_dev,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const=
 *channel, int *val,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *val2, long mask)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int code, cgen, sgen, try;<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;reg=
map, LMP92001_CGEN, &amp;cgen);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Is not continuous conversion=
?<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers (if neede=
d).<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Triggering single-short conv=
ersion.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Waiting for conversion succe=
ssfully.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cgen &amp; 1))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cg=
en &amp; 2))<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<wbr>regmap,<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CGEN, =
2, 2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D =
regmap_write(lmp92001-&gt;regmap, LMP92001_CTRIG, 1);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =
&lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try =3D =
10;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_SGEN, &amp;sgen);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 if(ret &lt; 0)<br>
&gt;<br>
&gt; style, space after if, space around operators<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while =
((sgen &amp; 1&lt;&lt;7) &amp;&amp; (--try &gt; 0));<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try=
)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return -ETIME;<br>
&gt;<br>
&gt; most drivers use ETIMEOUT<br>
&gt;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;reg=
map, 0x1F + channel-&gt;channel, &amp;code);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (=
channel-&gt;type) {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO=
_VOLTAGE:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO=
_TEMP:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *val =3D code;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 return IIO_VAL_INT;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
<br>
</div></div>You can remove these default cases or return -EINVAL here.<br><=
/blockquote><div><br></div><div>Abhisit: Okay, I will remove it.</div><div>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Could you tell me in detail=
. Sorry, I do not understand the Technical.</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">
<span class=3D""><br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +/*<br>
&gt; &gt; + * TODO: do your attributes even handler for<br>
&gt; &gt; + * Current limit low/high for CH 1-3, 9-11!<br>
&gt; &gt; + * In case INT1 and INT2 were connected to i.MX6.<br>
&gt; &gt; + */<br>
<br>
</span>Why mention the SoC here?<br></blockquote><div><br></div><div>Abhisi=
t: I have remove it.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><div class=3D"h5"><br>
&gt; &gt; +static const struct iio_info lmp92001_info =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_raw =3D lmp92001_read_raw,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver_module =3D THIS_MODULE,<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev, ui=
ntptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cref;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;reg=
map, LMP92001_CREF, &amp;cref);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;=
, cref &amp; 2 ? &quot;external&quot; : &quot;internal&quot;);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev, u=
intptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char =
*buf,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cref;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;external\n&quot;, b=
uf) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cref =3D=
 2;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;internal\n&quo=
t;, buf) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cref =3D=
 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CREF, 2, cref);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev, u=
intptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int reg, cad;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt;channel)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1 ... 8:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 9 ... 16:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD2;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD3;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;reg=
map, reg, &amp;cad);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (channel-&gt;channel &lt;=3D 8)<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;=
&gt;=3D channel-&gt;channel - 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if(channel-&gt;channel &gt; 8)<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;=
&gt;=3D channel-&gt;channel - 9;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if(channel-&gt;channel &gt; 16)=
<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;=
&gt;=3D channel-&gt;channel - 17;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;=
, cad &amp; 1 ? &quot;enable&quot; : &quot;disable&quot;);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev, =
uintptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char =
*buf,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int reg, enable, shif, mask=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt;channel)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1 ... 8:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D=
 (channel-&gt;channel - 1);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 9 ... 16:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD2;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D=
 (channel-&gt;channel - 9);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D =
LMP92001_CAD3;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D=
 (channel-&gt;channel - 17);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<b=
r>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;enable\n&quot;, buf=
) =3D=3D 0)<br>
<br>
</div></div>Always use the length limited version of string manipulation fu=
nctions<br>
when possible (drop the \n, also)<br></blockquote><div><br></div><div>Abhis=
it: It is optimization, I got you.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div><div class=3D"h5"><br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable =
=3D 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;disable\n&quot=
;, buf) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable =
=3D 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable &lt;&lt;=3D shif;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 1 &lt;&lt; shif;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, reg, mask, enable);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev, uin=
tptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;reg=
map, LMP92001_CGEN, &amp;cgen);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;=
, cgen &amp; 1 ? &quot;continuous&quot; : &quot;single-shot&quot;);<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev, ui=
ntptr_t private,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char =
*buf,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_de=
vice_get_drvdata(indio_<wbr>dev);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;continuous\n&quot;,=
 buf) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgen =3D=
 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;single-shot\n&=
quot;, buf) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgen =3D=
 0;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
EINVAL;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Unlock the registers.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set conversion mode.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CGEN, 2, 0);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CGEN, 1, cgen);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CGEN, 2, 2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] =
=3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =
=3D &quot;vref&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =
=3D lmp92001_avref_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =
=3D lmp92001_avref_write,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =
=3D IIO_SHARED_BY_ALL,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =
=3D &quot;en&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =
=3D lmp92001_enable_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =
=3D lmp92001_enable_write,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =
=3D IIO_SEPARATE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =
=3D &quot;mode&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =
=3D lmp92001_mode_read,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =
=3D lmp92001_mode_write,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =
=3D IIO_SHARED_BY_ALL,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static const struct iio_event_spec lmp92001_events[] =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =
=3D IIO_EV_TYPE_THRESH,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dir =3D=
 IIO_EV_DIR_RISING,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_se=
parate =3D BIT(IIO_EV_INFO_ENABLE) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 BIT(IIO_EV_INFO_VALUE),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =
=3D IIO_EV_TYPE_THRESH,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dir =3D=
 IIO_EV_DIR_FALLING,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_se=
parate =3D BIT(IIO_EV_INFO_ENABLE) |<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 BIT(IIO_EV_INFO_VALUE),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \<br>
&gt; &gt; +{ \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .channel =3D _ch, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scan_index =3D _ch, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scan_type =3D { \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .sign =3D &#39;u&#39;, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .realbits =3D 12, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .storagebits =3D 16, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .repeat =3D 1, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 .endianness =3D IIO_BE, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D _type, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .indexed =3D 1, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .info_mask_separate =3D BIT(IIO_CHAN=
_INFO_RAW), \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .event_spec =3D _event, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_event_specs =3D _nevent, \<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ext_info =3D lmp92001_ext_info, \<b=
r>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +/*<br>
&gt; &gt; + * TODO: do your ext_info for current low/high limit.<br>
&gt; &gt; + * Example driver/iio/dac/ad5064.c<br>
&gt; &gt; + */<br>
&gt; &gt; +static const struct iio_chan_spec lmp92001_adc_channels[] =3D {<=
br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, =
lmp92001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, =
NULL, 0),<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(17,=C2=A0 =C2=A0 =
IIO_TEMP, NULL, 0),<br>
&gt;<br>
&gt; wondering in what unit the drivers reports _TEMP, probably _SCALE need=
ed<br>
&gt;<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static int lmp92001_adc_probe(struct platform_device *pdev)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D dev_ge=
t_drvdata(pdev-&gt;dev.<wbr>parent);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_node *np =3D pdev-&gt;=
dev.of_node;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *conversion;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen =3D 0, cad1, cad2,=
 cad3;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mask;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev =3D devm_iio_device_alloc(=
&amp;pdev-&gt;<wbr>dev, sizeof(*lmp92001));<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!indio_dev)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -=
ENOMEM;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_set_drvdata(indio_<wbr>de=
v, lmp92001);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;name =3D pdev-&gt;name=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;dev.parent =3D &amp;pd=
ev-&gt;dev;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;modes =3D INDIO_DIRECT=
_MODE;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;info =3D &amp;lmp92001=
_info;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;channels =3D lmp92001_=
adc_channels;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;num_channels =3D ARRAY=
_SIZE(lmp92001_adc_<wbr>channels);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CGEN, 0x80, 0x80);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(=
&amp;pdev-&gt;dev,&quot;failed to self reset all registers\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D of_property_read_u32(np, &qu=
ot;ti,lmp92001-adc-mask&quot;, &amp;mask);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad1 =3D=
 cad2 =3D cad3 =3D 0xFF;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info=
(&amp;pdev-&gt;dev, &quot;turn on all of channels by default\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad1 =3D=
 mask &amp; 0xFF;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad2 =3D=
 (mask &gt;&gt; 8) &amp; 0xFF;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad3 =3D=
 (mask &gt;&gt; 16) &amp; 0xFF;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CAD1, 0xFF, cad1);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(=
&amp;pdev-&gt;dev,&quot;failed to enable channels 1-8\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CAD2, 0xFF, cad2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(=
&amp;pdev-&gt;dev, &quot;failed to enable channels 9-16\n&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap, LMP92001_CAD3, 1, cad3);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(=
&amp;pdev-&gt;dev, &quot;failed to enable channel 17 (temperature)\n&quot;)=
;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D of_property_read_string_inde=
x(<wbr>np, &quot;ti,lmp92001-adc-mode&quot;, 0,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;conversion);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strc=
mp(&quot;continuous&quot;, conversion) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 cgen |=3D 1;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if =
(strcmp(&quot;single-shot&quot;, conversion) =3D=3D 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 { /* Okay */ }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 dev_warn(&amp;pdev-&gt;dev,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 &quot;wrong adc mode! set to single-short conversion\n=
&quot;);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info=
(&amp;pdev-&gt;dev,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;si=
ngle-short conversion was chosen by default\n&quot;);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers and set c=
onversion mode.<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-=
&gt;<wbr>regmap,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 LMP92001_CGEN, 3, cgen | 2);<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return r=
et;<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, indio_dev=
);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return iio_device_register(indio_dev=
)<wbr>;<br>
<br>
</div></div>You are using devm_ version of iio_device_alloc, maybe you can =
use<br>
devm version of iio_device_register here as well<br></blockquote><div><br><=
/div><div>Abhisit: I will be changed it.</div><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid=
;padding-left:1ex">
<span class=3D""><br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static int lmp92001_adc_remove(struct platform_device *pdev)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D platfo=
rm_get_drvdata(pdev);<br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(indio_<wbr>dev=
);<br>
<br>
</span>with devm_ version of above functions, I guess you can remove this i=
f<br>
no other clean ups are required<br></blockquote><div><br></div><div>Abhisit=
: I will do, thanks.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks<br>
<span class=3D"HOEnZb"><font color=3D"#888888">=C2=A0 j<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; &gt; +<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; &gt; +}<br>
&gt; &gt; +<br>
&gt; &gt; +static struct platform_driver lmp92001_adc_driver =3D {<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .<a href=3D"http://driver.name" rel=
=3D"noreferrer" target=3D"_blank">driver.name</a>=C2=A0 =C2=A0 =3D &quot;lm=
p92001-adc&quot;,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver.owner=C2=A0 =C2=A0=3D THIS_M=
ODULE,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D lmp92001_adc_probe,<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0=3D lmp92001_adc_remove,<br>
&gt; &gt; +};<br>
&gt; &gt; +<br>
&gt; &gt; +static int __init lmp92001_adc_init(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&amp=
;<wbr>lmp92001_adc_driver);<br>
&gt; &gt; +}<br>
&gt; &gt; +subsys_initcall(lmp92001_adc_<wbr>init);<br>
&gt; &gt; +<br>
&gt; &gt; +static void __exit lmp92001_adc_exit(void)<br>
&gt; &gt; +{<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&amp;<wbr=
>lmp92001_adc_driver);<br>
&gt; &gt; +}<br>
&gt; &gt; +module_exit(lmp92001_adc_<wbr>exit);<br>
&gt; &gt; +<br>
&gt; &gt; +MODULE_AUTHOR(&quot;Abhisit Sangjan &lt;<a href=3D"mailto:s.abhi=
sit@gmail.com">s.abhisit@gmail.com</a>&gt;&quot;);<br>
&gt; &gt; +MODULE_DESCRIPTION(&quot;IIO ADC interface for TI LMP92001&quot;=
);<br>
&gt; &gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; &gt; +MODULE_ALIAS(&quot;platform:<wbr>lmp92001-adc&quot;);<br>
&gt; &gt;<br>
&gt;<br>
&gt; --<br>
&gt;<br>
&gt; Peter Meerwald-Stadler<br>
&gt; Mobile: +43 664 24 44 418<br>
</div></div></blockquote></div><br></div></div></div>

--f403045ec4322c39780556fdf7f1--
