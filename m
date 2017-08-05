Return-Path: <SRS0=IZNu=7H=gmail.com=s.abhisit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com> <alpine.DEB.2.20.1708011317000.5987@vps.pmeerw.net>
From: Abhisit Sangjan <s.abhisit@gmail.com>
Date: Sat, 5 Aug 2017 11:49:36 +0700
Message-ID: <CAMV_pUbfPBkfYa0dMvtQ_+8rn-BXvkQgH8BMgZaROcd7LpjLtg@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, fabrice.gasnier@st.com,
	Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>, marek.vasut+renesas@gmail.com,
	jacopo+renesas@jmondi.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: multipart/related; boundary="001a1140541842f0450555fa5787"
List-ID: <linux-iio@vger.kernel.org>

--001a1140541842f0450555fa5787
Content-Type: multipart/alternative; boundary="001a1140541842f0420555fa5786"

--001a1140541842f0420555fa5786
Content-Type: text/plain; charset="UTF-8"

Hi Peter,

Thank you for your suggestion and reply, could you find my comment.

Thank you,
Abhisit S.

On Thu, Aug 3, 2017 at 5:40 PM, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
wrote:

>
> > From: Abhisit Sangjan <s.abhisit@gmail.com>
>
> some more comments in addition to Jonathan's
>
> > ---
> >  drivers/iio/adc/Kconfig        |  10 +
> >  drivers/iio/adc/Makefile       |   1 +
> >  drivers/iio/adc/lmp92001-adc.c | 479 ++++++++++++++++++++++++++++++
> +++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/iio/adc/lmp92001-adc.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 614fa41..b623b4d 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -857,4 +857,14 @@ config XILINX_XADC
> >         The driver can also be build as a module. If so, the module will
> be called
> >         xilinx-xadc.
> >
> > +config LMP92001_ADC
> > +       tristate "TI LMP92001 ADC Driver"
> > +       depends on MFD_LMP92001
> > +       help
> > +         If you say yes here you get support for TI LMP92001 ADCs
> > +         conversion.
> > +
> > +         This driver can also be built as a module. If so, the module
> will
> > +         be called lmp92001_adc.
> > +
> >  endmenu
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index b546736a..75b24b1 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -78,3 +78,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
> >  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
> >  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
> >  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
> > +obj-$(CONFIG_LMP92001_ADC) += lmp92001-adc.o
> > diff --git a/drivers/iio/adc/lmp92001-adc.c b/drivers/iio/adc/lmp92001-
> adc.c
> > new file mode 100644
> > index 0000000..909ff47
> > --- /dev/null
> > +++ b/drivers/iio/adc/lmp92001-adc.c
> > @@ -0,0 +1,479 @@
> > +/*
> > + * lmp92001-adc.c - Support for TI LMP92001 ADCs
> > + *
> > + * Copyright 2016-2017 Celestica Ltd.
> > + *
> > + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
> > + *
> > + * Inspired by wm831x and ad5064 drivers.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/interrupt.h>
> > +
> > +#include <linux/mfd/lmp92001/core.h>
> > +
> > +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> > +                                struct iio_chan_spec const *channel,
> int *val,
> > +                                int *val2, long mask)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int code, cgen, sgen, try;
> > +        int ret;
> > +
> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        /*
> > +         * Is not continuous conversion?
> > +         * Lock the registers (if needed).
> > +         * Triggering single-short conversion.
> > +         * Waiting for conversion successfully.
> > +         */
> > +        if (!(cgen & 1))
> > +        {
> > +                if (!(cgen & 2))
> > +                {
> > +                        ret = regmap_update_bits(lmp92001->regmap,
> > +                                                        LMP92001_CGEN,
> 2, 2);
> > +                        if (ret < 0)
> > +                                return ret;
> > +                }
> > +
> > +                ret = regmap_write(lmp92001->regmap, LMP92001_CTRIG, 1);
> > +                if (ret < 0)
> > +                        return ret;
> > +
> > +                try = 10;
> > +                do {
> > +                        ret = regmap_read(lmp92001->regmap,
> > +                                                LMP92001_SGEN, &sgen);
> > +                        if(ret < 0)
>
> style, space after if, space around operators
>
> > +                                return ret;
> > +                } while ((sgen & 1<<7) && (--try > 0));
> > +
> > +                if (!try)
> > +                        return -ETIME;
>
> most drivers use ETIMEOUT
>
> > +        }
> > +
> > +        ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel,
> &code);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        switch (mask)
> > +        {
> > +        case IIO_CHAN_INFO_RAW:
> > +                switch (channel->type) {
> > +                case IIO_VOLTAGE:
> > +                case IIO_TEMP:
> > +                        *val = code;
> > +                        return IIO_VAL_INT;
> > +                default:
> > +                        break;
> > +                }
> > +                break;
> > +        default:
> > +                break;
> > +        }
> > +
> > +        return -EINVAL;
> > +}
> > +
> > +/*
> > + * TODO: do your attributes even handler for
> > + * Current limit low/high for CH 1-3, 9-11!
> > + * In case INT1 and INT2 were connected to i.MX6.
> > + */
> > +static const struct iio_info lmp92001_info = {
> > +        .read_raw = lmp92001_read_raw,
> > +        .driver_module = THIS_MODULE,
> > +};
> > +
> > +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev, uintptr_t
> private,
> > +                        struct iio_chan_spec const *channel, char *buf)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int cref;
> > +        int ret;
> > +
> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        return sprintf(buf, "%s\n", cref & 2 ? "external" : "internal");
> > +}
> > +
> > +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev,
> uintptr_t private,
> > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > +                         size_t len)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int cref;
> > +        int ret;
> > +
> > +        if (strcmp("external\n", buf) == 0)
> > +                cref = 2;
> > +        else if (strcmp("internal\n", buf) == 0)
> > +                cref = 0;
> > +        else
> > +                return -EINVAL;
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, 2,
> cref);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        return len;
> > +}
> > +
> > +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev,
> uintptr_t private,
> > +                        struct iio_chan_spec const *channel, char *buf)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int reg, cad;
> > +        int ret;
> > +
> > +        switch (channel->channel)
> > +        {
> > +        case 1 ... 8:
> > +                reg = LMP92001_CAD1;
> > +                break;
> > +        case 9 ... 16:
> > +                reg = LMP92001_CAD2;
> > +                break;
> > +        case 17:
> > +                reg = LMP92001_CAD3;
> > +                break;
> > +        default:
> > +                return -EINVAL;
> > +        }
> > +
> > +        ret = regmap_read(lmp92001->regmap, reg, &cad);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        if (channel->channel <= 8)
> > +                cad >>= channel->channel - 1;
> > +        else if(channel->channel > 8)
> > +                cad >>= channel->channel - 9;
> > +        else if(channel->channel > 16)
> > +                cad >>= channel->channel - 17;
> > +        else
> > +                return -EINVAL;
> > +
> > +        return sprintf(buf, "%s\n", cad & 1 ? "enable" : "disable");
> > +}
> > +
> > +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev,
> uintptr_t private,
> > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > +                         size_t len)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int reg, enable, shif, mask;
> > +        int ret;
> > +
> > +        switch (channel->channel)
> > +        {
> > +        case 1 ... 8:
> > +                reg = LMP92001_CAD1;
> > +                shif = (channel->channel - 1);
> > +                break;
> > +        case 9 ... 16:
> > +                reg = LMP92001_CAD2;
> > +                shif = (channel->channel - 9);
> > +                break;
> > +        case 17:
> > +                reg = LMP92001_CAD3;
> > +                shif = (channel->channel - 17);
> > +                break;
> > +        default:
> > +                return -EINVAL;
> > +        }
> > +
> > +        if (strcmp("enable\n", buf) == 0)
> > +                enable = 1;
> > +        else if (strcmp("disable\n", buf) == 0)
> > +                enable = 0;
> > +        else
> > +                return -EINVAL;
> > +
> > +        enable <<= shif;
> > +        mask = 1 << shif;
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, reg, mask, enable);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        return len;
> > +}
> > +
> > +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev, uintptr_t
> private,
> > +                        struct iio_chan_spec const *channel, char *buf)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int cgen;
> > +        int ret;
> > +
> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        return sprintf(buf, "%s\n", cgen & 1 ? "continuous" :
> "single-shot");
> > +}
> > +
> > +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev, uintptr_t
> private,
> > +                         struct iio_chan_spec const *channel, const
> char *buf,
> > +                         size_t len)
> > +{
> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> > +        unsigned int cgen;
> > +        int ret;
> > +
> > +        if (strcmp("continuous\n", buf) == 0)
> > +                cgen = 1;
> > +        else if (strcmp("single-shot\n", buf) == 0)
> > +                cgen = 0;
> > +        else
> > +                return -EINVAL;
> > +
> > +        /*
> > +         * Unlock the registers.
> > +         * Set conversion mode.
> > +         * Lock the registers.
> > +         */
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
> 0);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 1,
> cgen);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
> 2);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        return len;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> > +        {
> > +                .name = "vref",
> > +                .read = lmp92001_avref_read,
> > +                .write = lmp92001_avref_write,
> > +                .shared = IIO_SHARED_BY_ALL,
> > +        },
> > +        {
> > +                .name = "en",
> > +                .read = lmp92001_enable_read,
> > +                .write = lmp92001_enable_write,
> > +                .shared = IIO_SEPARATE,
> > +        },
> > +        {
> > +                .name = "mode",
> > +                .read = lmp92001_mode_read,
> > +                .write = lmp92001_mode_write,
> > +                .shared = IIO_SHARED_BY_ALL,
> > +        },
> > +        { },
> > +};
> > +
> > +static const struct iio_event_spec lmp92001_events[] = {
> > +        {
> > +                .type = IIO_EV_TYPE_THRESH,
> > +                .dir = IIO_EV_DIR_RISING,
> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> > +                        BIT(IIO_EV_INFO_VALUE),
> > +        },
> > +        {
> > +                .type = IIO_EV_TYPE_THRESH,
> > +                .dir = IIO_EV_DIR_FALLING,
> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> > +                        BIT(IIO_EV_INFO_VALUE),
> > +        },
> > +        { },
> > +};
> > +
> > +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
> > +{ \
> > +        .channel = _ch, \
> > +        .scan_index = _ch, \
> > +        .scan_type = { \
> > +                        .sign = 'u', \
> > +                        .realbits = 12, \
> > +                        .storagebits = 16, \
> > +                        .repeat = 1, \
> > +                        .endianness = IIO_BE, \
> > +        }, \
> > +        .type = _type, \
> > +        .indexed = 1, \
> > +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> > +        .event_spec = _event, \
> > +        .num_event_specs = _nevent, \
> > +        .ext_info = lmp92001_ext_info, \
> > +}
> > +
> > +/*
> > + * TODO: do your ext_info for current low/high limit.
> > + * Example driver/iio/dac/ad5064.c
> > + */
> > +static const struct iio_chan_spec lmp92001_adc_channels[] = {
> > +        LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92001_events,
> ARRAY_SIZE(lmp92001_events)),
> > +        LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL, 0),
> > +        LMP92001_CHAN_SPEC(17,    IIO_TEMP, NULL, 0),
>
> wondering in what unit the drivers reports _TEMP, probably _SCALE needed
>

Abhisit: Do you mean like a blue highlight?

{ \
.channel = 17, \
.type = IIO_TEMP, \
.indexed = 1, \
.info_mask_separate = (1UL << (IIO_CHAN_INFO_RAW)), \
.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
.event_spec = ((void *)0), \
.num_event_specs = 0, \
.ext_info = lmp92001_ext_info, \
}

It is depend on vref, the vref is number of voltage is bias to hardware,
the chip does not know a number. Application is needed to replace a number
in its equation.  So, I thought, should be raw, no scale.
The equation should be T= (VREF*CODE)/......
Could you help me to clear this.

[image: Inline image 1]


> > +};
> > +
> > +static int lmp92001_adc_probe(struct platform_device *pdev)
> > +{
> > +        struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
> > +        struct iio_dev *indio_dev;
> > +        struct device_node *np = pdev->dev.of_node;
> > +        const char *conversion;
> > +        unsigned int cgen = 0, cad1, cad2, cad3;
> > +        u32 mask;
> > +        int ret;
> > +
> > +        indio_dev = devm_iio_device_alloc(&pdev->dev,
> sizeof(*lmp92001));
> > +        if (!indio_dev)
> > +                return -ENOMEM;
> > +
> > +        iio_device_set_drvdata(indio_dev, lmp92001);
> > +
> > +        indio_dev->name = pdev->name;
> > +        indio_dev->dev.parent = &pdev->dev;
> > +        indio_dev->modes = INDIO_DIRECT_MODE;
> > +        indio_dev->info = &lmp92001_info;
> > +        indio_dev->channels = lmp92001_adc_channels;
> > +        indio_dev->num_channels = ARRAY_SIZE(lmp92001_adc_channels);
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN,
> 0x80, 0x80);
> > +        if (ret < 0)
> > +        {
> > +                dev_err(&pdev->dev,"failed to self reset all
> registers\n");
> > +                return ret;
> > +        }
> > +
> > +        ret = of_property_read_u32(np, "ti,lmp92001-adc-mask", &mask);
> > +        if (ret < 0)
> > +        {
> > +                cad1 = cad2 = cad3 = 0xFF;
> > +                dev_info(&pdev->dev, "turn on all of channels by
> default\n");
> > +        }
> > +        else
> > +        {
> > +                cad1 = mask & 0xFF;
> > +                cad2 = (mask >> 8) & 0xFF;
> > +                cad3 = (mask >> 16) & 0xFF;
> > +        }
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD1,
> 0xFF, cad1);
> > +        if (ret < 0)
> > +        {
> > +                dev_err(&pdev->dev,"failed to enable channels 1-8\n");
> > +                return ret;
> > +        }
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD2,
> 0xFF, cad2);
> > +        if (ret < 0)
> > +        {
> > +                dev_err(&pdev->dev, "failed to enable channels 9-16\n");
> > +                return ret;
> > +        }
> > +
> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD3, 1,
> cad3);
> > +        if (ret < 0)
> > +        {
> > +                dev_err(&pdev->dev, "failed to enable channel 17
> (temperature)\n");
> > +                return ret;
> > +        }
> > +
> > +        ret = of_property_read_string_index(np,
> "ti,lmp92001-adc-mode", 0,
> > +                                                &conversion);
> > +        if (!ret)
> > +        {
> > +                if (strcmp("continuous", conversion) == 0)
> > +                        cgen |= 1;
> > +                else if (strcmp("single-shot", conversion) == 0)
> > +                        { /* Okay */ }
> > +                else
> > +                        dev_warn(&pdev->dev,
> > +                        "wrong adc mode! set to single-short
> conversion\n");
> > +        }
> > +        else
> > +                dev_info(&pdev->dev,
> > +                "single-short conversion was chosen by default\n");
> > +
> > +        /*
> > +         * Lock the registers and set conversion mode.
> > +         */
> > +        ret = regmap_update_bits(lmp92001->regmap,
> > +                                        LMP92001_CGEN, 3, cgen | 2);
> > +        if (ret < 0)
> > +                return ret;
> > +
> > +        platform_set_drvdata(pdev, indio_dev);
> > +
> > +        return iio_device_register(indio_dev);
> > +}
> > +
> > +static int lmp92001_adc_remove(struct platform_device *pdev)
> > +{
> > +        struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +        iio_device_unregister(indio_dev);
> > +
> > +        return 0;
> > +}
> > +
> > +static struct platform_driver lmp92001_adc_driver = {
> > +        .driver.name    = "lmp92001-adc",
> > +        .driver.owner   = THIS_MODULE,
> > +        .probe          = lmp92001_adc_probe,
> > +        .remove         = lmp92001_adc_remove,
> > +};
> > +
> > +static int __init lmp92001_adc_init(void)
> > +{
> > +        return platform_driver_register(&lmp92001_adc_driver);
> > +}
> > +subsys_initcall(lmp92001_adc_init);
> > +
> > +static void __exit lmp92001_adc_exit(void)
> > +{
> > +        platform_driver_unregister(&lmp92001_adc_driver);
> > +}
> > +module_exit(lmp92001_adc_exit);
> > +
> > +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> > +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:lmp92001-adc");
> >
>
> --
>
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418
>

--001a1140541842f0420555fa5786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Peter,<div><br></div><div>Thank you for your suggestion=
 and reply, could you find my comment.</div><div><br></div><div>Thank you,<=
/div><div>Abhisit S.<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Aug 3, 2017 at 5:40 PM, Peter Meerwald-Stadler <span dir=3D"=
ltr">&lt;<a href=3D"mailto:pmeerw@pmeerw.net" target=3D"_blank">pmeerw@pmee=
rw.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex"><br>
&gt; From: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail.com">s.abh=
isit@gmail.com</a>&gt;<br>
<br>
some more comments in addition to Jonathan&#39;s<br>
<div><div class=3D"gmail-h5"><br>
&gt; ---<br>
&gt;=C2=A0 drivers/iio/adc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 10 +<=
br>
&gt;=C2=A0 drivers/iio/adc/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A01 +<br>
&gt;=C2=A0 drivers/iio/adc/lmp92001-adc.c | 479 +++++++++++++++++++++++++++=
+++<wbr>+++++++++++<br>
&gt;=C2=A0 3 files changed, 490 insertions(+)<br>
&gt;=C2=A0 create mode 100644 drivers/iio/adc/lmp92001-adc.c<br>
&gt;<br>
&gt; diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig<br>
&gt; index 614fa41..b623b4d 100644<br>
&gt; --- a/drivers/iio/adc/Kconfig<br>
&gt; +++ b/drivers/iio/adc/Kconfig<br>
&gt; @@ -857,4 +857,14 @@ config XILINX_XADC<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0The driver can also be build as a mod=
ule. If so, the module will be called<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xilinx-xadc.<br>
&gt;<br>
&gt; +config LMP92001_ADC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0tristate &quot;TI LMP92001 ADC Driver&quot=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0depends on MFD_LMP92001<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0If you say yes here you get support=
 for TI LMP92001 ADCs<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0conversion.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0This driver can also be built as a =
module. If so, the module will<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be called lmp92001_adc.<br>
&gt; +<br>
&gt;=C2=A0 endmenu<br>
&gt; diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile<br>
&gt; index b546736a..75b24b1 100644<br>
&gt; --- a/drivers/iio/adc/Makefile<br>
&gt; +++ b/drivers/iio/adc/Makefile<br>
&gt; @@ -78,3 +78,4 @@ obj-$(CONFIG_VF610_ADC) +=3D vf610_adc.o<br>
&gt;=C2=A0 obj-$(CONFIG_VIPERBOARD_ADC) +=3D viperboard_adc.o<br>
&gt;=C2=A0 xilinx-xadc-y :=3D xilinx-xadc-core.o xilinx-xadc-events.o<br>
&gt;=C2=A0 obj-$(CONFIG_XILINX_XADC) +=3D xilinx-xadc.o<br>
&gt; +obj-$(CONFIG_LMP92001_ADC) +=3D lmp92001-adc.o<br>
&gt; diff --git a/drivers/iio/adc/lmp92001-<wbr>adc.c b/drivers/iio/adc/lmp=
92001-<wbr>adc.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..909ff47<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/adc/lmp92001-<wbr>adc.c<br>
&gt; @@ -0,0 +1,479 @@<br>
&gt; +/*<br>
&gt; + * lmp92001-adc.c - Support for TI LMP92001 ADCs<br>
&gt; + *<br>
&gt; + * Copyright 2016-2017 Celestica Ltd.<br>
&gt; + *<br>
&gt; + * Author: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail.com"=
>s.abhisit@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * Inspired by wm831x and ad5064 drivers.<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the=
<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/mfd/core.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +<br>
&gt; +#include &lt;linux/mfd/lmp92001/core.h&gt;<br>
&gt; +<br>
&gt; +static int lmp92001_read_raw(struct iio_dev *indio_dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_chan_spec const *chan=
nel, int *val,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *val2, long mask)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int code, cgen, sgen, try;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap, =
LMP92001_CGEN, &amp;cgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Is not continuous conversion?<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers (if needed).<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Triggering single-short conversio=
n.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Waiting for conversion successful=
ly.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cgen &amp; 1))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cgen &a=
mp; 2))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<wbr>regmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CGEN, 2, 2);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regma=
p_write(lmp92001-&gt;regmap, LMP92001_CTRIG, 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; =
0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try =3D 10;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_SGEN, &amp;sgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if(ret &lt; 0)<br>
<br>
</div></div>style, space after if, space around operators<br>
<span class=3D"gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while ((sge=
n &amp; 1&lt;&lt;7) &amp;&amp; (--try &gt; 0));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return -ETIME;<br>
<br>
</span>most drivers use ETIMEOUT<br>
<div><div class=3D"gmail-h5"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap, =
0x1F + channel-&gt;channel, &amp;code);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (mask)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (chann=
el-&gt;type) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_VOLT=
AGE:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case IIO_TEMP=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 *val =3D code;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return IIO_VAL_INT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * TODO: do your attributes even handler for<br>
&gt; + * Current limit low/high for CH 1-3, 9-11!<br>
&gt; + * In case INT1 and INT2 were connected to i.MX6.<br>
&gt; + */<br>
&gt; +static const struct iio_info lmp92001_info =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .read_raw =3D lmp92001_read_raw,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver_module =3D THIS_MODULE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev, uintptr=
_t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cref;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap, =
LMP92001_CREF, &amp;cref);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;, cre=
f &amp; 2 ? &quot;external&quot; : &quot;internal&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev, uintpt=
r_t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char *buf,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cref;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;external\n&quot;, buf) =
=3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cref =3D 2;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;internal\n&quot;, b=
uf) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cref =3D 0;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CREF, 2, cref);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev, uintpt=
r_t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int reg, cad;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt;channel)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1 ... 8:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 9 ... 16:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap, =
reg, &amp;cad);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (channel-&gt;channel &lt;=3D 8)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;&gt;=
=3D channel-&gt;channel - 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if(channel-&gt;channel &gt; 8)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;&gt;=
=3D channel-&gt;channel - 9;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if(channel-&gt;channel &gt; 16)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad &gt;&gt;=
=3D channel-&gt;channel - 17;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;, cad=
 &amp; 1 ? &quot;enable&quot; : &quot;disable&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev, uintp=
tr_t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char *buf,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int reg, enable, shif, mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (channel-&gt;channel)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1 ... 8:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D (cha=
nnel-&gt;channel - 1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 9 ... 16:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD2;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D (cha=
nnel-&gt;channel - 9);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 17:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D LMP92=
001_CAD3;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shif =3D (cha=
nnel-&gt;channel - 17);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;enable\n&quot;, buf) =3D=
=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable =3D 1;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;disable\n&quot;, bu=
f) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable =3D 0;=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 enable &lt;&lt;=3D shif;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mask =3D 1 &lt;&lt; shif;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, reg, mask, enable);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev, uintptr_=
t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 struct iio_chan_spec const *channel, char *buf)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap, =
LMP92001_CGEN, &amp;cgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return sprintf(buf, &quot;%s\n&quot;, cge=
n &amp; 1 ? &quot;continuous&quot; : &quot;single-shot&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev, uintptr=
_t private,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0struct iio_chan_spec const *channel, const char *buf,<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_<wbr>dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&quot;continuous\n&quot;, buf)=
 =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgen =3D 1;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strcmp(&quot;single-shot\n&quot;=
, buf) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cgen =3D 0;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVA=
L;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Unlock the registers.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Set conversion mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CGEN, 2, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CGEN, 1, cgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CGEN, 2, 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] =3D {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &qu=
ot;vref&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =3D lmp=
92001_avref_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =3D lm=
p92001_avref_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =3D I=
IO_SHARED_BY_ALL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &qu=
ot;en&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =3D lmp=
92001_enable_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =3D lm=
p92001_enable_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =3D I=
IO_SEPARATE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D &qu=
ot;mode&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =3D lmp=
92001_mode_read,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .write =3D lm=
p92001_mode_write,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .shared =3D I=
IO_SHARED_BY_ALL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_event_spec lmp92001_events[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IIO=
_EV_TYPE_THRESH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dir =3D IIO_=
EV_DIR_RISING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_separat=
e =3D BIT(IIO_EV_INFO_ENABLE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 BIT(IIO_EV_INFO_VALUE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D IIO=
_EV_TYPE_THRESH,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dir =3D IIO_=
EV_DIR_FALLING,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .mask_separat=
e =3D BIT(IIO_EV_INFO_ENABLE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 BIT(IIO_EV_INFO_VALUE),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 { },<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \<br>
&gt; +{ \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .channel =3D _ch, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scan_index =3D _ch, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .scan_type =3D { \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .sign =3D &#39;u&#39;, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .realbits =3D 12, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .storagebits =3D 16, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .repeat =3D 1, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 .endianness =3D IIO_BE, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .type =3D _type, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .indexed =3D 1, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO=
_RAW), \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .event_spec =3D _event, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .num_event_specs =3D _nevent, \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .ext_info =3D lmp92001_ext_info, \<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * TODO: do your ext_info for current low/high limit.<br>
&gt; + * Example driver/iio/dac/ad5064.c<br>
&gt; + */<br>
&gt; +static const struct iio_chan_spec lmp92001_adc_channels[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92=
001_events, ARRAY_SIZE(lmp92001_events)),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL,=
 0),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CHAN_SPEC(17,=C2=A0 =C2=A0 IIO_T=
EMP, NULL, 0),<br>
<br>
</div></div>wondering in what unit the drivers reports _TEMP, probably _SCA=
LE needed<br></blockquote><div><br></div><div>Abhisit: Do you mean like a b=
lue highlight?</div><div><br></div><div>{ \<br></div><div><span style=3D"wh=
ite-space:pre">	</span>.channel =3D 17, \</div><div><span style=3D"white-sp=
ace:pre">	</span>.type =3D IIO_TEMP, \</div><div><span style=3D"white-space=
:pre">	</span>.indexed =3D 1, \</div><div><span style=3D"white-space:pre">	=
</span>.info_mask_separate =3D (1UL &lt;&lt; (IIO_CHAN_INFO_RAW)), \</div><=
div><span style=3D"white-space:pre">	</span><font color=3D"#0000ff">.info_m=
ask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \</font><br></div></div></=
div><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div><span style=
=3D"white-space:pre">	</span>.event_spec =3D ((void *)0), \</div><div><span=
 style=3D"white-space:pre">	</span>.num_event_specs =3D 0, \</div><div><spa=
n style=3D"white-space:pre">	</span>.ext_info =3D lmp92001_ext_info, \</div=
><div>}=C2=A0</div><div><br></div><div>It is depend on vref, the vref is nu=
mber of voltage is bias to hardware, the chip does not know a number. Appli=
cation is needed to replace a number in its equation.=C2=A0 So, I thought, =
should be raw, no scale.</div><div>The equation should be T=3D (VREF*CODE)/=
......</div><div>Could you help me to clear this.</div><div><br></div><div>=
<img src=3D"cid:ii_15db0af9ac70bcfd" alt=3D"Inline image 1" style=3D"margin=
-right: 0px;" width=3D"562" height=3D"166"><br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt; +};<br>
&gt; +<br>
&gt; +static int lmp92001_adc_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D dev_get_drv=
data(pdev-&gt;dev.<wbr>parent);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct device_node *np =3D pdev-&gt;dev.o=
f_node;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *conversion;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int cgen =3D 0, cad1, cad2, cad3=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 u32 mask;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 int ret;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev =3D devm_iio_device_alloc(&amp;=
pdev-&gt;<wbr>dev, sizeof(*lmp92001));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!indio_dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOME=
M;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_set_drvdata(indio_<wbr>dev, lm=
p92001);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;name =3D pdev-&gt;name;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;dev.parent =3D &amp;pdev-&g=
t;dev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;modes =3D INDIO_DIRECT_MODE=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;info =3D &amp;lmp92001_info=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;channels =3D lmp92001_adc_c=
hannels;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indio_dev-&gt;num_channels =3D ARRAY_SIZE=
(lmp92001_adc_<wbr>channels);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CGEN, 0x80, 0x80);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev,&quot;failed to self reset all registers\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D of_property_read_u32(np, &quot;ti=
,lmp92001-adc-mask&quot;, &amp;mask);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad1 =3D cad2=
 =3D cad3 =3D 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&amp=
;pdev-&gt;dev, &quot;turn on all of channels by default\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad1 =3D mask=
 &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad2 =3D (mas=
k &gt;&gt; 8) &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cad3 =3D (mas=
k &gt;&gt; 16) &amp; 0xFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CAD1, 0xFF, cad1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev,&quot;failed to enable channels 1-8\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CAD2, 0xFF, cad2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev, &quot;failed to enable channels 9-16\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap, LMP92001_CAD3, 1, cad3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev, &quot;failed to enable channel 17 (temperature)\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D of_property_read_string_index(<wb=
r>np, &quot;ti,lmp92001-adc-mode&quot;, 0,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 &amp;conversion);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ret)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(&q=
uot;continuous&quot;, conversion) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 cgen |=3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (strc=
mp(&quot;single-shot&quot;, conversion) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 { /* Okay */ }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 dev_warn(&amp;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 &quot;wrong adc mode! set to single-short conversion\n&quot;=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_info(&amp=
;pdev-&gt;dev,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;single-=
short conversion was chosen by default\n&quot;);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Lock the registers and set conver=
sion mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;<=
wbr>regmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP9=
2001_CGEN, 3, cgen | 2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, indio_dev);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return iio_device_register(indio_dev)<wbr=
>;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int lmp92001_adc_remove(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct iio_dev *indio_dev =3D platform_ge=
t_drvdata(pdev);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(indio_<wbr>dev);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct platform_driver lmp92001_adc_driver =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .<a href=3D"http://driver.name" rel=3D"no=
referrer" target=3D"_blank">driver.name</a>=C2=A0 =C2=A0 =3D &quot;lmp92001=
-adc&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .driver.owner=C2=A0 =C2=A0=3D THIS_MODULE=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .probe=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D lmp92001_adc_probe,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .remove=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D lmp92001_adc_remove,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int __init lmp92001_adc_init(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&amp;<wbr=
>lmp92001_adc_driver);<br>
&gt; +}<br>
&gt; +subsys_initcall(lmp92001_adc_<wbr>init);<br>
&gt; +<br>
&gt; +static void __exit lmp92001_adc_exit(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&amp;<wbr>lmp9=
2001_adc_driver);<br>
&gt; +}<br>
&gt; +module_exit(lmp92001_adc_<wbr>exit);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@g=
mail.com">s.abhisit@gmail.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;IIO ADC interface for TI LMP92001&quot;);<br=
>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; +MODULE_ALIAS(&quot;platform:<wbr>lmp92001-adc&quot;);<br>
&gt;<br>
<br>
--<br>
<br>
</div></div><span class=3D"gmail-HOEnZb"><font color=3D"#888888">Peter Meer=
wald-Stadler<br>
Mobile: +43 664 24 44 418<br>
</font></span></blockquote></div><br></div></div></div>

--001a1140541842f0420555fa5786--

--001a1140541842f0450555fa5787
Content-Type: image/png; name="image.png"
Content-Disposition: inline; filename="image.png"
Content-Transfer-Encoding: base64
Content-ID: <ii_15db0af9ac70bcfd>
X-Attachment-Id: ii_15db0af9ac70bcfd

iVBORw0KGgoAAAANSUhEUgAABU4AAAGRCAYAAAC64ikRAAAgAElEQVR4AeydCfwO1f7Hj53s+1YK
pWRLuRRppQUhKbmIUCopypVSWpTqRiR0XS26InGLtJDKWvYsyZpkSfatH1fW+b8+5/7P3Jl5ZuaZ
7Xl+z+/5fc7r9fvNzFm/532W58x3zpJD0zRN0JAACZAACZAACZAACZAACZAACZAACZAACZAACZAA
CegEcup3vCEBEiABEiABEiABEiABEiABEiABEiABEiABEiABEpAEqDhlRSABEiABEiABEiABEiAB
EiABEiABEiABEiABEiABCwEqTi1A+EgCJEACJEACJEACJEACJEACJEACJEACJEACJEACVJyyDpAA
CZAACZAACZAACZAACZAACZAACZAACZAACZCAhQAVpxYgfCQBEiABEiABEiABEiABEiABEiABEiAB
EiABEiABKk5ZB0iABEiABEiABEiABEiABEiABEiABEiABEiABEjAQoCKUwsQPpIACZAACZAACZAA
CZAACZAACZAACZAACZAACZBAbjcEixYtEhs3bnTzEtetVq1a4oorrpD+Zs+eLbZv3x43jJ2HMmXK
iGbNmkmnkydPiokTJ9p5EzVr1hT16tWzdYPlhx9+KE6cOBHjboxfOX755Zdi79696tH2mjNnTlGp
UiVRrVo1Ub58eZEjRw5bf1HlXUU+b9488euvv6rHuNeKFStKGc877zwBmf2Yr7/+WuzcudMU5MYb
bxSIy8lEXXesZXHhhReKq6++2il5sW/fPvHFF1+Y3Fu2bClKlChhsksEx6jL2iRwnAe0rwULFsi6
gfqxa9cuUaRIEVG2bFlx5ZVXiuuvv16UK1fONZYo5R83bpwprXjldvbsWfGvf/3LFKZhw4ay7pos
//8hivzaxfvHH3+Ib7/9VsyfP1/s3r1bHD58WNYdsLv22mslx8KFC9sFNdklon6ZEuADCZAACZAA
CZAACZAACZAACZAACZBA4ghoLqZHjx6aECLU3xNPPKGn0KpVq8BxNWrUSI/n0KFDjvG0aNFC92e9
2b9/v2M4Y/wqHOz85L9YsWJav379tIyMDBWFfo0q7yrCdu3a+ZJN5aNOnTra0qVLVTRxr3/++aeG
fKnw6op8upmo6461LDp37uyWvLZo0aIYmVeuXBkTJhEcoy7rGKFtLHbs2KHdcccdWo4cOWLyrcoM
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
0yMJkAAJkAAJkAAJkAAJkAAJkAAJkECWIEDFaZYoJgpJAiRAAiRAAiRAAiRAAiRAAiRAAiRAAiRA
AiSQTAJpuVQ/mQCZFgmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQQPoRoOI0/cqUOSIBEiABEiAB
EiABEiABEiABEiABEiABEiABEghJgIrTkAAZnARIgARIgARIgARIgARIgARIgARIgARIgARIIP0I
UHGafmXKHJEACZAACZAACZAACZAACZAACZAACZAACZAACYQkQMVpSIAMTgIkQAIkQAIkQAIkQAIk
QAIkQAIkQAIkQAIkkH4EqDhNvzJljkiABEiABEiABEiABEiABEiABEiABEiABEiABEISoOI0JEAG
JwESIAESIAESIAESIAESIAESIAESIAESIAESSD8CVJymX5kyRyRAAiRAAiRAAiRAAiRAAiRAAiRA
AiRAAiRAAiEJUHEaEiCDkwAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJpB8BKk7Tr0yZIxIgARIg
ARIgARIgARIgARIgARIgARIgARIggZAEqDgNCZDBSYAESIAESIAESIAESIAESIAESIAESIAESIAE
0o8AFafpV6bMEQmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQQEgCVJyGBMjgJEACJEACJEACJEAC
JEACJEACJEACJEACJEAC6UeAitP0K1PmiARIgARIgARIgARIgARIgARIgARIgARIgARIICQBKk5D
AmRwEiABEiABEiABEiABEiABEiABEiABEiABEiCB9CNAxWn6lSlzRAIkQAIkQAIkQAIkQAIkQAIk
QAIkQAIkQAIkEJIAFachATI4CZAACZAACZAACZAACZAACZAACZAACZAACZBA+hGg4jT9ypQ5IgES
IAESIAESIAESIAESIAESIAESIAESIAESCEmAitOQABmcBEiABEiABEiABEiABEiABEiABEiABEiA
BEgg/QhQcZp+ZcockQAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJhCRAxWlIgAxOAiRAAiRAAiRA
AiRAAiRAAiRAAiRAAiRAAiSQfgSoOE2/MmWOSIAESIAESIAESIAESIAESIAESIAESIAESIAEQhKg
4jQkQAYnARIgARIgARIgARIgARIgARIgARIgARIgARJIPwK53bK0cuVKMW/ePDcvjm6lS5cWHTp0
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
S0lx0AaWImJZ/g033CAaNWqUkJOd7WTwagf5sFcfls1mZGQInL5cq1YtuVQ2Z864uxq4JrN//37x
xRdfCCydxUEqFSpUkMv+sfy3aNGirmHtHLMS16jzDh5B4kRV//zzz+WhXNjXEPvPqm0YFONEcw1a
x3766ScpO9pgwYIFBfY/xJ69aIdZyXgpgzD5Cco3TJqpEBZbjSxYsEAuyceWINjKoWTJkgJ7eV5/
/fUCWw2kswlT7lu2bBHz5s2TWydg25Y77rhDbpsyfvx4eYgf9uBesWKFZ3x++yYvbSJM/jwLTo8k
QAIkQAIkQAIkQAIkQAIkQAIxBHwpTmNC04IESIAESIAEshiBL7/8Umzfvl1+GMNHPDuDPYTfeOMN
eZgWPrjQkAAJkAAJkAAJkAAJkAAJkAAJZD8C4aZRZj9ezDEJkAAJkEAWJ7Bo0SLx4IMPil69epkO
PFTZwoGH48aNk49eDgVT4XglARIgARIgARIgARIgARIgARJILwKccZpe5cnckAAJkAAJxCGwYcMG
uY0BtjjAVgb9+/cXNWvWFEeOHBFLliwROG1+9+7d4vzzz5fbzGB7DBoSIAESIAESIAESIAESIAES
IIHsR4CK0+xX5swxCZAACWR7Ath7u2PHjuKPP/6wZYE9rqdPny4VqrYeaEkCJEACJEACJEACJEAC
JEACJJD2BKg4TfsiZgZJgARIgATsCBw6dEiMHTtWHgy1bds2UaJECVGjRg2BA6Fuv/12kTdvXrtg
tCMBEiABEiABEiABEiABEiABEsgmBKg4zSYFzWySAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAl4
J8DDobyzok8SIAESIAESIAESIAESIAESIAESIAESIAESIIFsQoCK02xS0MwmCZAACZAACZAACZAA
CZAACZAACZAACZAACZCAdwJUnHpnRZ8kQAIkQAIkQAIkQAIkQAIkQAIkQAIkQAIkQALZhAAVp9mk
oJlNEiABEiABEiABEiABEiABEiABEiABEiABEiAB7wSoOPXOij5JgARIgARIgARIgARIgARIgARI
gARIgARIgASyCQEqTrNJQTObJEACJEACJEACJEACJEACJEACJEACJEACJEAC3glQceqdFX2SAAmQ
AAmQAAmQAAmQAAmQAAmQAAmQAAmQAAlkEwJUnGaTgmY2SYAESIAESIAESIAESIAESIAESIAESIAE
SIAEvBOg4tQ7K/okARIgARJT7+d3AAAgAElEQVQgARIgARIgARIgARIgARIgARIgARLIJgSoOM0m
Bc1skgAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJeCdAxal3VvRJAiRAAiRAAiRAAiRAAiRAAiRA
AiRAAiRAAiSQTQhQcZpNCprZJAESIAESIAESIAESIAESIAESIAESIAESIAES8E6AilPvrOiTBEiA
BEiABEiABEiABEiABEiABEiABEiABEggmxCg4jSbFDSzSQIkQAIkQAIkQAIkQAIkQAIkQAIkQAIk
QAIk4J0AFafeWdEnCZAACZAACZAACZAACZAACZAACZAACZAACZBANiFAxWk2KWhmkwRIgARIgARI
gARIgARIgARIgARIgARIgARIwDsBKk69s6JPEiABEiABEiABEiABEiABEiABEiABEiABEiCBbEKA
itNsUtDMJgmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQgHcCVJx6Z0WfJEACJEACJEACJEACJEAC
JEACJEACJEACJEAC2YQAFafZpKCZTRIgARIgARIgARIgARIgARIgARIgARIgARIgAe8EqDj1zoo+
SYAESIAESIAESIAESIAESIAESIAESIAESIAEsgkBKk6zSUEzmyRAAiRAAiRAAiRAAiRAAiRAAiRA
AiRAAiRAAt4JUHHqnRV9kgAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJZBMCVJxmk4JmNkmABEiA
BEiABEiABEiABEiABEiABEiABEiABLwToOLUOyv6JAESIAESIAESIAESIAESIAESIAESIAESIAES
yCYEqDjNJgXNbJIACZAACZAACZAACZAACZAACZAACZAACZAACXgnQMWpd1b0SQIkQAIkQAIkQAIk
QAIkQAIkQAIkQAIkQAIkkE0IUHGaTQqa2SQBEiABEiABEiABEiABEiABEiABEiABEiABEvBOgIpT
76zokwRIgARIgARIgARIgARIgARIgARIgARIgARIIJsQoOI0mxQ0s0kCJEACJEACJEACJEACJEAC
JEACJEACJEACJOCdABWn3lnRJwmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQQDYhQMVpNiloZpME
SIAESIAESIAESIAESIAESIAESIAESIAESMA7ASpOvbOiTxIgARIgARIgARIgARIgARIgARIgARIg
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
5cqV09asWROqurZhbnLlrLwAACAASURBVMcwBL777ru2/RCK3DfffDPkBwerQnkpj5U8o18oRZvb
fhhOUYb81b3XSnHqph/ajUeVD/qQlXPTd73Wz6ocZj835YKMUO1pzsN8bcfQGM/NmAvHy/iO4EZx
Gulz30t9nCogvYzZcO3gZlw6LTfYuGljpKPi1NizeE4CJEACJEACJEACJJBSCaRCxZPK1BbrlmGj
oSNHjgisUdm9e3fbrDGt9/3335drb86aNUumwdqUmKKfOnVqOS22efPmcnqvrRCbgH379onZs2cL
TCnGzvVYwxAbGKkNpKySbdu2Te4S//vvv8s0WDusSZMmIlOmTDI65GE6f/bs2UWXLl3k+q1WchLF
D+s5Yn3Zn376SU5hxlRs1L18+fJy3VosNeCHw8ZgWBoAm3phmiOm5deuXVtUrVo1aJMuY36Y5v/V
V1/JdFhSIX/+/KJly5ZyJ2ljPOM5hsK3334rN/25du2aXN9STQ/3oz/6XSZj2cOdu+nzbtmjLFu2
bJEskW/mzJkFxgs2O8N4C+fQzt9//71cOxhTRbEUR6lSpeQSEhj7bp2XMXzs2DG5XAiWosD9K0+e
PHK5ACynccMNN7gqkpfyuMrwv0Ru+qGX/IxpI+mHocajUabVuZe+ayXPL7+kLpdThtEac5Fy8+M+
izyjVR+3Y9ZJO0R7XEaLSaRtzPgkQAIkQAIkQAIkQAIkEG8EklRxirUpsQkR1hE9cOCAuPnmm215
mX9A2UZkAAkkAQH2xySAzCxIgARSNAHeZ1N087PyJEACJEACJEACJEACJBCTBNybb0VYHVjwqQ19
YKUVSmkaoWhGJwESIAESIAESIAESIAESIAESIAESIAESIAESIAFfCaT1VZqFsPnz54tdu3aJpUuX
imXLlskYsCqhIwESIAESIAESIAESIAESIAESIAESIAESIAESIIFYJRB1xem8efPkWqUKQMeOHeV6
ouqaRxIgARIgARIgARIgARIgARIgARIgARIgARIgARKINQJRV5zWqVNHbuiEzYOwOc9jjz0WclMf
BShv3rzirrvukhvDKD8eSSC5CLA/Jhd55ksCJJBSCPA+m1JamvUkARIgARIgARIgARIggfghkKSb
Q8UPFpaUBEiABEiABEiABEiABEiABEiABEiABEiABEggJRNIss2hUjJk1p0ESIAESIAESIAESIAE
SIAESIAESIAESIAESCC+CFBxGl/txdKSAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAkkAQEqTpMA
MrMgARIgARIgARIgARIgARIgARIgARIgARIgARKILwJUnMZXe7G0JEACJEACJEACJEACJEACJEAC
JEACJEACJEACSUCAitMkgMwsSIAESIAESIAESIAESIAESIAESIAESIAESIAE4osAFafx1V4sLQmQ
AAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQQBIQoOI0CSAzCxIgARIgARIgARIgARIgARIgARIgARIg
ARIggfgiQMVpfLUXS0sCJEACJEACJEACJEACJEACJEACJEACJEACJJAEBKg4TQLIzIIE/CJw7do1
cebMGb/EUQ4JkAAJkAAJkAAJkIAQYuHChaJZs2Zi5cqV5EECJEACJEACJEACOgEqTnUUPCGB2CWg
aZqYOnWqqFmzpvj5559jt6AsGQmQAAmQAAmQAAnEIYF69eqJwYMHi27duokOHTqIkydPxmEtWGQS
IAESIAESIAG/CaTSoJGhIwESiFkCv//+u3jooYdE2rRppfI0b968MVtWFowESIAESIAESIAE4pnA
6dOnRevWrcWWLVvEtGnTRNWqVeO5Oiw7CZAACZAACZCARwK0OPUIkMlJIJoEvvjiC1G2bFlRpEgR
sWTJEkGlaTRpUzYJkAAJkAAJkEBKJ5A1a1bx3Xffibp168q/r7/+OqUjYf1JgARIgARIIEUToOI0
RTc/Kx/LBN58801padq5c2fx+eefS4vTWC4vy0YCJEACJEACJEACiUAAs3zGjx8vWrRoIa1PsVwS
HQmQAAmQAAmQQMokwKn6KbPdWesYJzBkyBDRv39/0bNnTzF8+PAYLy2LRwIkQAIkQAIkQAKJR+Dq
1auiUaNGctbP3LlzRZ06dRKvkqwRCZAACZAACZBASAJUnIbEw0ASSHoCn332mXj00Ud1C4dUqVIl
fSGYIwmQAAmQAAmQAAmQgDh16pS45557xJEjR8TmzZvFbbfdRiokQAIkQAIkQAIpiAAVpymosVnV
2CewadMmUaVKFVGiRAmxcuVKkSFDhtgvNEtIAiRAAiRAAiRAAglMYP369aJy5cpSgbps2TKRJk2a
BK4tq0YCJEACJEACJGAkkGbgwIEDjR48JwESSB4CFy5ckJsQnD17VixYsEDccsstyVMQ5koCJEAC
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
G5DFTzkEYH367rvviu7du4u6deumnIqzpiRAAiRAAiRAAiSQBAT2798v2rVrJ6A8hdK0cOHCSZAr
syABEiABEiABEohlAlScxnLrsGwkYEEAGxVg3VM6EiABEiABEiABEiABfwisWLFC9O/fXzz99NNy
maRUqVL5I5hSSIAESIAESIAE4poAFadx3XwsPAmQAAmQAAmQAAmQAAmQgFcCZ86cEZkzZ+bHaa8g
mZ4ESIAESIAEEowAFacJ1qCsDgmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQgHcCnO/rnSElkAAJ
kAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJJBgBKk4TrEFZHRIgARIgARIgARIgARIgARIgARIgARIg
ARIgAe8EqDj1zpASSIAESIAESIAESIAESIAESIAESIAESIAESIAEEowAFacJ1qCsDgmQAAmQAAmQ
AAmQAAmQAAmQAAmQAAmQAAmQgHcCVJx6Z0gJJEACJEACJEACJEACJEACJEACJEACJEACJEACCUaA
itMEa1BWhwRIgARIgARIgARIgARIgARIgARIgARIgARIwDsBKk69M6QEEiABEiABEiABEiABEiAB
EiABEiABEiABEiCBBCNAxWmCNSirQwIkQAIkQAIkQAIkQAIkQAIkQAIkQAIkQAIk4J0AFafeGVIC
CZAACZAACZAACZAACZAACZAACZAACZAACZBAghGg4jTBGpTVIQESIAESIAESIAESIAESIAESIAES
IAESIAES8E6AilPvDCmBBEiABEiABEiABEiABEiABEiABEiABEiABEggwQhQcZpgDcrqkAAJkAAJ
kAAJkAAJkAAJkAAJkAAJkAAJkAAJeCdAxal3hpRAAiRAAiRAAiRAAiRAAiRAAiRAAiRAAiRAAiSQ
YASoOE2wBmV1SIAESIAESIAESIAESIAESIAESIAESIAESIAEvBOg4tQ7Q0ogARIgARIgARIgARIg
ARIgARIgARIgARIgARJIMAJUnCZYg7I6JEACJEACJEACJEACJEACJEACJEACJEACJEAC3glQceqd
ISWQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAkkGAEqThOsQVkdEiABEiABEiABEiABEiABEiAB
EiABEiABEiAB7wSoOPXOkBJIgARIgARIgARIgARIgARIgARIgARIgARIgAQSjAAVpwnWoKwOCZAA
CZAACZA7agn1AAAgAElEQVQACZAACZAACZAACZAACZAACZCAdwJUnHpnSAkkQAIkQAIkQAIkQAIk
QAIkQAIkQAIkQAIkQAIJRoCK0wRrUFaHBEiABEiABEiABEiABEiABEiABEiABEiABEjAOwEqTr0z
pAQSIAESIAESIAESIAESIAESIAESIAESIAESIIEEI0DFaYI1KKtDAiRAAiRAAiRAAiRAAiRAAiRA
AiRAAiRAAiTgnQAVp94ZUgIJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkECCEaDiNMEalNUhARIg
ARIgARIgARIgARIgARIgARIgARIgARLwToCKU+8MKYEESIAESIAESIAESIAESIAESIAESIAESIAE
SCDBCFBxmmANyuqQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAmQAAl4J0DFqXeGlEACJEACJEACJEAC
JEACJEACJEACJEACJEACJJBgBKg4TbAGZXVIgARIgARIgARIgARIgARIgARIgARIgARIgAS8E6Di
1DtDSiABEiABEiABEiABEiABEiABEiABEiABEiABEkgwAlScJliDsjokQAIkQAIkQAIkQAIkQAIk
QAIkQAIkQAIkQALeCVBx6p0hJZAACZAACZAACZAACZAACZAACZAACZAACZAACSQYASpOE6xBWR0S
IAESIAESIAESIAESIAESIAESIAESIAESIAHvBKg49c6QEkiABEiABEiABEiABEiABEiABEiABEiA
BEiABBKMABWnCdagrA4JkAAJkAAJkAAJkAAJkAAJkAAJkAAJkAAJkIB3AlScemdICSRAAiRAAiRA
AiRAAiRAAiRAAiRAAiRAAiRAAglGgIrTBGtQVocESIAESIAESIAESIAESIAESIAESIAESIAESMA7
ASpOvTOkBBIgARIgARIgARIgARIgARIgARIgARIgARIggQQjQMVpgjUoq0MCJEACJEACJEACJEAC
JEACJEACJEACJEACJOCdQFonInbt2iW+++47GfXhhx8WOXLkcJIsqnFOnTolJkyYIPPo1q2byJQp
U1Tzo/DYJfD333+L6dOnywL26tUrdgvqsWRLly4VmzZtEkWLFhWNGjXyKC0+k58+fVqMGzdOFr58
+fKievXqjiqyatUq8dNPP8m4nTp1EjfccIM8N/rbCUqXLp247bbbROHChSX71Kmtvzf98MMP4tdf
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
--001a1140541842f0450555fa5787--
