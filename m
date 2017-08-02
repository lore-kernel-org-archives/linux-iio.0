Return-Path: <SRS0=995S=7E=gmail.com=s.abhisit@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAMV_pUaV54qUc1wOhL5cAP8mEX1k0VsL3aEGG+wziqPPnZGHWg@mail.gmail.com>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
 <20170801111055.00001127@huawei.com> <CAMV_pUaV54qUc1wOhL5cAP8mEX1k0VsL3aEGG+wziqPPnZGHWg@mail.gmail.com>
From: Abhisit Sangjan <s.abhisit@gmail.com>
Date: Wed, 2 Aug 2017 14:06:50 +0700
Message-ID: <CAMV_pUYOMdb_e1xYEkhhuO2GN4FDFSRy6BpHUK5GqO0o8yO1fA@mail.gmail.com>
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, fabrice.gasnier@st.com,
	Lee Jones <lee.jones@linaro.org>, robh@kernel.org,
	Akinobu Mita <akinobu.mita@gmail.com>, marek.vasut+renesas@gmail.com,
	jacopo+renesas@jmondi.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a113f995c823d260555bfe8f8"
List-ID: <linux-iio@vger.kernel.org>

--001a113f995c823d260555bfe8f8
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

Please find my comment on in line.

Thank you.
Abhisit S.

On Wed, Aug 2, 2017 at 11:43 AM, Abhisit Sangjan <s.abhisit@gmail.com>
wrote:

> Hi Jonathan,
>
> Thank you for your review and good suggestion. This is my first driver,
> first work for Linux.  I will be follow your advice and send new once in
> soon. Please help me to review.
>
> Thank you,
> Abhisit S.
>
> On Tue, Aug 1, 2017 at 5:10 PM, Jonathan Cameron <
> Jonathan.Cameron@huawei.com> wrote:
>
>> On Tue, 1 Aug 2017 16:12:22 +0700
>> <s.abhisit@gmail.com> wrote:
>>
>> > From: Abhisit Sangjan <s.abhisit@gmail.com>
>> Hi,
>>
>> A very quick initial review covering stuff you'll want to clean up before
>> you get some in depth reviews.
>>
>
> Abhisit: OK, I will do.
>
>
>> 1) Please cc linux-iio on the whole series - it's useful to see the mfd
>> driver and review it as well.
>>
>
> Abhisit: OK.
>
>
>> 2) Description of the patch is needed. For a new driver, a quick run down
>> of what it is and what is supported.
>
>
> Abhisit: I will do.
>
>
>>
> More comments inline.
>>
>> Note this is not a full review by any means, just a starting point whilst
>> I'm waiting for a board to boot...  Will do a full review once these bits
>> are tidied up.
>>
>> Fundamental code looks fine, it's docs and coding style that need work
>> (plus locking ;)
>>
>> Jonathan
>> >
>> > ---
>> >  drivers/iio/adc/Kconfig        |  10 +
>> >  drivers/iio/adc/Makefile       |   1 +
>> >  drivers/iio/adc/lmp92001-adc.c | 479 ++++++++++++++++++++++++++++++
>> +++++++++++
>> >  3 files changed, 490 insertions(+)
>> >  create mode 100644 drivers/iio/adc/lmp92001-adc.c
>> >
>> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> > index 614fa41..b623b4d 100644
>> > --- a/drivers/iio/adc/Kconfig
>> > +++ b/drivers/iio/adc/Kconfig
>> > @@ -857,4 +857,14 @@ config XILINX_XADC
>> >         The driver can also be build as a module. If so, the module
>> will be called
>> >         xilinx-xadc.
>> >
>> > +config LMP92001_ADC
>> Alphabetical order please.
>>
>
> Abhisit: I got you.
>
>
>> > +       tristate "TI LMP92001 ADC Driver"
>> > +       depends on MFD_LMP92001
>> > +       help
>> > +         If you say yes here you get support for TI LMP92001 ADCs
>> > +         conversion.
>> > +
>> > +         This driver can also be built as a module. If so, the module
>> will
>> > +         be called lmp92001_adc.
>> > +
>> >  endmenu
>> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
>> > index b546736a..75b24b1 100644
>> > --- a/drivers/iio/adc/Makefile
>> > +++ b/drivers/iio/adc/Makefile
>> > @@ -78,3 +78,4 @@ obj-$(CONFIG_VF610_ADC) += vf610_adc.o
>> >  obj-$(CONFIG_VIPERBOARD_ADC) += viperboard_adc.o
>> >  xilinx-xadc-y := xilinx-xadc-core.o xilinx-xadc-events.o
>> >  obj-$(CONFIG_XILINX_XADC) += xilinx-xadc.o
>> > +obj-$(CONFIG_LMP92001_ADC) += lmp92001-adc.o
>> Alphabetical order please.
>>
>
> Abhisit: I got you.
>
>
>>
>> > diff --git a/drivers/iio/adc/lmp92001-adc.c
>> b/drivers/iio/adc/lmp92001-adc.c
>> > new file mode 100644
>> > index 0000000..909ff47
>> > --- /dev/null
>> > +++ b/drivers/iio/adc/lmp92001-adc.c
>> > @@ -0,0 +1,479 @@
>> > +/*
>> > + * lmp92001-adc.c - Support for TI LMP92001 ADCs
>> > + *
>> > + * Copyright 2016-2017 Celestica Ltd.
>> > + *
>> > + * Author: Abhisit Sangjan <s.abhisit@gmail.com>
>> > + *
>> > + * Inspired by wm831x and ad5064 drivers.
>> > + *
>> > + * This program is free software; you can redistribute it and/or modify
>> > + * it under the terms of the GNU General Public License as published by
>> > + * the Free Software Foundation; either version 2 of the License, or
>> > + * (at your option) any later version.
>> > + *
>> > + * This program is distributed in the hope that it will be useful,
>> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> > + * GNU General Public License for more details.
>> > + *
>> > + */
>> > +
>> > +#include <linux/kernel.h>
>> > +#include <linux/module.h>
>> > +#include <linux/iio/iio.h>
>> > +#include <linux/mfd/core.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/interrupt.h>
>> > +
>> > +#include <linux/mfd/lmp92001/core.h>
>> > +
>> > +static int lmp92001_read_raw(struct iio_dev *indio_dev,
>> > +                                struct iio_chan_spec const *channel,
>> int *val,
>> > +                                int *val2, long mask)
>> > +{
>> Nothing prevents multiple simultaneous runs of this function.
>> Given the write then read cycles below, I'm guessing you'll be wanting
>> a local lock in your lmp92001 structure.
>>
>
> Abhisit: It is hardware lock register to prevent multiple access.
>

Abhisit: I thought, the function regmap_read(), regmap_update_bits()
and regmap_write() are managed the lock access.
Do I need to lock it by myself?

Example function regmap_read().

/**
 * regmap_read() - Read a value from a single register
 *
 * @map: Register map to read from
 * @reg: Register to be read from
 * @val: Pointer to store read value
 *
 * A value of zero will be returned on success, a negative errno will
 * be returned in error cases.
 */
int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val)
{
int ret;

if (!IS_ALIGNED(reg, map->reg_stride))
return -EINVAL;

map->lock(map->lock_arg);

ret = _regmap_read(map, reg, val);

map->unlock(map->lock_arg);

return ret;
}



>
>
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int code, cgen, sgen, try;
>> > +        int ret;
>> > +
>> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        /*
>> > +         * Is not continuous conversion?
>> > +         * Lock the registers (if needed).
>> > +         * Triggering single-short conversion.
>> > +         * Waiting for conversion successfully.
>> > +         */
>> > +        if (!(cgen & 1))
>> Kernel goes with K&R style on if statements and brackets.
>> if (!(cgen & 1)) {
>>
>> 1 is a magic value - so please add a define telling us what it
>> represents.
>>
>
> Abhisit: I will double check again for all my source code for K&R and no
> magic number.
>
>
>>
>> > +        {
>> > +                if (!(cgen & 2))
>> > +                {
>> > +                        ret = regmap_update_bits(lmp92001->regmap,
>> > +                                                        LMP92001_CGEN,
>> 2, 2);
>> Register field values and masks should use defined constants so the code
>> lets
>> us know what they are without consulting the datasheet.
>>
>
> Abhisit: I will give them to be defined.
>
>
>>
>> > +                        if (ret < 0)
>> > +                                return ret;
>> > +                }
>> > +
>> > +                ret = regmap_write(lmp92001->regmap, LMP92001_CTRIG,
>> 1);
>> > +                if (ret < 0)
>> > +                        return ret;
>> > +
>> > +                try = 10;
>> Why - a try look doing repeats like this need an explanatory comment.
>>
>
> Abhisit: Do you think, should be jiffies time?
>
>
>> > +                do {
>> > +                        ret = regmap_read(lmp92001->regmap,
>> > +                                                LMP92001_SGEN, &sgen);
>> > +                        if(ret < 0)
>> > +                                return ret;
>> > +                } while ((sgen & 1<<7) && (--try > 0));
>> > +
>> > +                if (!try)
>> > +                        return -ETIME;
>> > +        }
>> > +
>> > +        ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel,
>> &code);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        switch (mask)
>> > +        {
>> switch (mask) {
>>
>> Please run checkpatch over this - preferably with --strict
>> and fix everything it comes up with.  Saves everyone time in reviews!
>>
>
> Abhisit: Thank you for your suggestion. It is my first driver :)
>
>
>> > +        case IIO_CHAN_INFO_RAW:
>> > +                switch (channel->type) {
>> > +                case IIO_VOLTAGE:
>> > +                case IIO_TEMP:
>> > +                        *val = code;
>> > +                        return IIO_VAL_INT;
>> > +                default:
>>         return directly here if still possible after considering locking.
>> > +                        break;
>> > +                }
>> > +                break;
>> > +        default:
>> > +                break;
>> > +        }
>> > +
>> > +        return -EINVAL;
>> > +}
>> > +
>> > +/*
>> > + * TODO: do your attributes even handler for
>> > + * Current limit low/high for CH 1-3, 9-11!
>> > + * In case INT1 and INT2 were connected to i.MX6.
>> > + */
>> > +static const struct iio_info lmp92001_info = {
>> > +        .read_raw = lmp92001_read_raw,
>> > +        .driver_module = THIS_MODULE,
>> > +};
>> > +
>> > +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev,
>> uintptr_t private,
>> > +                        struct iio_chan_spec const *channel, char *buf)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int cref;
>> > +        int ret;
>> > +
>> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        return sprintf(buf, "%s\n", cref & 2 ? "external" :
>> "internal");
>> This looks like new ABI. Please add ABI docs so that we can discuss this
>> interface
>> without having to pull it from the code.
>>
>> Docuentation/ABI/testing/sysfs-bus-iio-lmp920001 is probably the right
>> place.
>>
>
> Abhisit: I will do.
>
>
>>
>> Note IIO also has some nice utility functions to deal with enums like
>> this.
>>
>
> Abhisit: I have my enums version. No compile error, no work!  Lets me add
> it later on, after this once is working.
>
>
>> > +}
>> > +
>> > +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev,
>> uintptr_t private,
>> > +                         struct iio_chan_spec const *channel, const
>> char *buf,
>> > +                         size_t len)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int cref;
>> > +        int ret;
>> > +
>> > +        if (strcmp("external\n", buf) == 0)
>> > +                cref = 2;
>> > +        else if (strcmp("internal\n", buf) == 0)
>> > +                cref = 0;
>> > +        else
>> > +                return -EINVAL;
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, 2,
>> cref);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        return len;
>> > +}
>> > +
>> > +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev,
>> uintptr_t private,
>> > +                        struct iio_chan_spec const *channel, char *buf)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int reg, cad;
>> > +        int ret;
>> > +
>> > +        switch (channel->channel)
>> > +        {
>> > +        case 1 ... 8:
>> > +                reg = LMP92001_CAD1;
>> > +                break;
>> > +        case 9 ... 16:
>> > +                reg = LMP92001_CAD2;
>> > +                break;
>> > +        case 17:
>> > +                reg = LMP92001_CAD3;
>> > +                break;
>> > +        default:
>> > +                return -EINVAL;
>> > +        }
>> > +
>> > +        ret = regmap_read(lmp92001->regmap, reg, &cad);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        if (channel->channel <= 8)
>> > +                cad >>= channel->channel - 1;
>> > +        else if(channel->channel > 8)
>> > +                cad >>= channel->channel - 9;
>> > +        else if(channel->channel > 16)
>> > +                cad >>= channel->channel - 17;
>> > +        else
>> > +                return -EINVAL;
>> > +
>> > +        return sprintf(buf, "%s\n", cad & 1 ? "enable" : "disable");
>> Again this is new ABI.  Need documenting in this series and detailed
>> discussion.
>>
>
> Abhisit: I will do.
>
>
>> > +}
>> > +
>> > +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev,
>> uintptr_t private,
>> > +                         struct iio_chan_spec const *channel, const
>> char *buf,
>> > +                         size_t len)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int reg, enable, shif, mask;
>> > +        int ret;
>> > +
>> > +        switch (channel->channel)
>> > +        {
>> > +        case 1 ... 8:
>> > +                reg = LMP92001_CAD1;
>> > +                shif = (channel->channel - 1);
>> > +                break;
>> > +        case 9 ... 16:
>> > +                reg = LMP92001_CAD2;
>> > +                shif = (channel->channel - 9);
>> > +                break;
>> > +        case 17:
>> > +                reg = LMP92001_CAD3;
>> > +                shif = (channel->channel - 17);
>> > +                break;
>> > +        default:
>> > +                return -EINVAL;
>> > +        }
>> > +
>> > +        if (strcmp("enable\n", buf) == 0)
>> > +                enable = 1;
>> > +        else if (strcmp("disable\n", buf) == 0)
>> > +                enable = 0;
>> > +        else
>> > +                return -EINVAL;
>> > +
>> > +        enable <<= shif;
>> > +        mask = 1 << shif;
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, reg, mask, enable);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        return len;
>> > +}
>> > +
>> > +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev, uintptr_t
>> private,
>> > +                        struct iio_chan_spec const *channel, char *buf)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int cgen;
>> > +        int ret;
>> > +
>> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        return sprintf(buf, "%s\n", cgen & 1 ? "continuous" :
>> "single-shot");
>> Again, documentation. Note that exposing explicit controls for single-shot
>> or continuous capture hasn't yet made sense in any other drivers.
>> Normally this is something that can be optimized in driver.
>>
>> There is always a trade off between flexibility and keeping the userspace
>> ABI
>> short and clean.
>>
>
> Abhisit: Basically, It is hardware conversion mode operation. I will take
> a look on how to optimize.
>
>
>> > +}
>> > +
>> > +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev,
>> uintptr_t private,
>> > +                         struct iio_chan_spec const *channel, const
>> char *buf,
>> > +                         size_t len)
>> > +{
>> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
>> > +        unsigned int cgen;
>> > +        int ret;
>> > +
>> > +        if (strcmp("continuous\n", buf) == 0)
>> > +                cgen = 1;
>> > +        else if (strcmp("single-shot\n", buf) == 0)
>> > +                cgen = 0;
>> > +        else
>> > +                return -EINVAL;
>> > +
>> > +        /*
>> > +         * Unlock the registers.
>> > +         * Set conversion mode.
>> > +         * Lock the registers.
>> > +         */
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
>> 0);
>> > +        if (ret < 0)
>> > +                return ret;
>> What stops a race with this lock? You need a driver lock to prevent
>> multiple
>> simultaneous sysfs actions from messing things up.
>>
>
> Abhisit: The lock is hardware register function for prevent multiple
> access to change the chip configuration.
>
>
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 1,
>> cgen);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,
>> 2);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        return len;
>> > +}
>> > +
>> > +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
>> > +        {
>> > +                .name = "vref",
>> > +                .read = lmp92001_avref_read,
>> > +                .write = lmp92001_avref_write,
>> > +                .shared = IIO_SHARED_BY_ALL,
>> > +        },
>> > +        {
>> > +                .name = "en",
>> > +                .read = lmp92001_enable_read,
>> > +                .write = lmp92001_enable_write,
>> > +                .shared = IIO_SEPARATE,
>> > +        },
>> > +        {
>> > +                .name = "mode",
>> > +                .read = lmp92001_mode_read,
>> > +                .write = lmp92001_mode_write,
>> > +                .shared = IIO_SHARED_BY_ALL,
>> All of this must be defined in the documentation.
>>
>> Vref is almost always a board specific element.
>> You don't fit an external reference if you are intending to
>> use the internal one.
>>
>> If necessary we can use differential channels to represent the two
>> possible voltage references, but that is rather ugly.
>>
>
> Abhisit: I would like to design for changeable vref source.
>
>
>> > +        },
>> > +        { },
>> > +};
>> > +
>> > +static const struct iio_event_spec lmp92001_events[] = {
>> > +        {
>> > +                .type = IIO_EV_TYPE_THRESH,
>> > +                .dir = IIO_EV_DIR_RISING,
>> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
>> > +                        BIT(IIO_EV_INFO_VALUE),
>> > +        },
>> > +        {
>> > +                .type = IIO_EV_TYPE_THRESH,
>> > +                .dir = IIO_EV_DIR_FALLING,
>> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
>> > +                        BIT(IIO_EV_INFO_VALUE),
>> > +        },
>> > +        { },
>> > +};
>> > +
>> > +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
>> > +{ \
>> > +        .channel = _ch, \
>> > +        .scan_index = _ch, \
>> > +        .scan_type = { \
>> > +                        .sign = 'u', \
>> > +                        .realbits = 12, \
>> > +                        .storagebits = 16, \
>> > +                        .repeat = 1, \
>> > +                        .endianness = IIO_BE, \
>> Don't specify stuff you aren't using.  The scan stuff only
>> typically becomes relevant when you providing the 'push'
>> or buffered interfaces.  This driver isn't yet.
>>
>
> Abhisit: Could you help me to coding this, I have no idea, what is your
> point. This is my first iio driver.
>
>
>> > +        }, \
>> > +        .type = _type, \
>> > +        .indexed = 1, \
>> > +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>> > +        .event_spec = _event, \
>> > +        .num_event_specs = _nevent, \
>> > +        .ext_info = lmp92001_ext_info, \
>> > +}
>> > +
>> > +/*
>> > + * TODO: do your ext_info for current low/high limit.
>> > + * Example driver/iio/dac/ad5064.c
>> > + */
>> > +static const struct iio_chan_spec lmp92001_adc_channels[] = {
>> > +        LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92001_events,
>> ARRAY_SIZE(lmp92001_events)),
>> > +        LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL, 0),
>> > +        LMP92001_CHAN_SPEC(17,    IIO_TEMP, NULL, 0),
>> > +};
>> > +
>> > +static int lmp92001_adc_probe(struct platform_device *pdev)
>> > +{
>> > +        struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
>> > +        struct iio_dev *indio_dev;
>> > +        struct device_node *np = pdev->dev.of_node;
>> > +        const char *conversion;
>> > +        unsigned int cgen = 0, cad1, cad2, cad3;
>> > +        u32 mask;
>> > +        int ret;
>> > +
>> > +        indio_dev = devm_iio_device_alloc(&pdev->dev,
>> sizeof(*lmp92001));
>> > +        if (!indio_dev)
>> > +                return -ENOMEM;
>> > +
>> > +        iio_device_set_drvdata(indio_dev, lmp92001);
>> > +
>> > +        indio_dev->name = pdev->name;
>> > +        indio_dev->dev.parent = &pdev->dev;
>> > +        indio_dev->modes = INDIO_DIRECT_MODE;
>> > +        indio_dev->info = &lmp92001_info;
>> > +        indio_dev->channels = lmp92001_adc_channels;
>> > +        indio_dev->num_channels = ARRAY_SIZE(lmp92001_adc_channels);
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN,
>> 0x80, 0x80);
>> > +        if (ret < 0)
>> 0x80 is a magic number. Use a #define to give it meaning to someone who
>> can't be bothered to find the datasheet (i.e. me ;)
>>
>
> Abhisit: I will defined it.
>
>
>> > +        {
>> > +                dev_err(&pdev->dev,"failed to self reset all
>> registers\n");
>> > +                return ret;
>> > +        }
>> > +
>> > +        ret = of_property_read_u32(np, "ti,lmp92001-adc-mask", &mask);
>> > +        if (ret < 0)
>> > +        {
>> > +                cad1 = cad2 = cad3 = 0xFF;
>> > +                dev_info(&pdev->dev, "turn on all of channels by
>> default\n");
>> Talk me through this - why can we not turn them on when we want a reading?
>> Just how slow is this device to start up?
>> Or are we looking at stopping certain channels from being used because
>> the pin
>> is in use for something else?
>>
>
> Abhisit: I would like to design to support initialization on start-up.
>
>
>>
>> > +        }
>> > +        else
>> > +        {
>> > +                cad1 = mask & 0xFF;
>> > +                cad2 = (mask >> 8) & 0xFF;
>> > +                cad3 = (mask >> 16) & 0xFF;
>> > +        }
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD1,
>> 0xFF, cad1);
>> > +        if (ret < 0)
>> > +        {
>> > +                dev_err(&pdev->dev,"failed to enable channels 1-8\n");
>> > +                return ret;
>> > +        }
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD2,
>> 0xFF, cad2);
>> > +        if (ret < 0)
>> > +        {
>> > +                dev_err(&pdev->dev, "failed to enable channels
>> 9-16\n");
>> > +                return ret;
>> > +        }
>> > +
>> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD3, 1,
>> cad3);
>> > +        if (ret < 0)
>> > +        {
>> > +                dev_err(&pdev->dev, "failed to enable channel 17
>> (temperature)\n");
>> > +                return ret;
>> These presumably need disabling again on remove or error to save power?
>>
>> Basic rule of thumb is that if something is setup in the probe routine, we
>> expect it to be reversed in the remove and any error path in probe.
>>
>
> Abhisit: This chip can not stop. We have no to do remove or disable it.
>
>
>> > +        }
>> > +
>> > +        ret = of_property_read_string_index(np,
>> "ti,lmp92001-adc-mode", 0,
>> > +                                                &conversion);
>> > +        if (!ret)
>> > +        {
>> > +                if (strcmp("continuous", conversion) == 0)
>> > +                        cgen |= 1;
>> > +                else if (strcmp("single-shot", conversion) == 0)
>> > +                        { /* Okay */ }
>> > +                else
>> > +                        dev_warn(&pdev->dev,
>> > +                        "wrong adc mode! set to single-short
>> conversion\n");
>> Is this a characteristic of the hardware?   Don't think so and isn't a
>> policy
>> that makes much sense to push into the devicetree.  Just pick one as
>> the default and let the driver figure out when to change.
>>
>
> Abhisit: I will set continuous mode as default.
>
>
>>
>> > +        }
>> > +        else
>> > +                dev_info(&pdev->dev,
>> > +                "single-short conversion was chosen by default\n");
>> > +
>> > +        /*
>> > +         * Lock the registers and set conversion mode.
>> > +         */
>> > +        ret = regmap_update_bits(lmp92001->regmap,
>> > +                                        LMP92001_CGEN, 3, cgen | 2);
>> > +        if (ret < 0)
>> > +                return ret;
>> > +
>> > +        platform_set_drvdata(pdev, indio_dev);
>> > +
>> > +        return iio_device_register(indio_dev);
>> > +}
>> > +
>> > +static int lmp92001_adc_remove(struct platform_device *pdev)
>> > +{
>> > +        struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> > +
>> > +        iio_device_unregister(indio_dev);
>> No disabling of the device to be done?
>>
>
> Abhisit: HW is no way to stop.
>
>
>> > +
>> > +        return 0;
>> > +}
>> > +
>> > +static struct platform_driver lmp92001_adc_driver = {
>> > +        .driver.name    = "lmp92001-adc",
>> > +        .driver.owner   = THIS_MODULE,
>> > +        .probe          = lmp92001_adc_probe,
>> > +        .remove         = lmp92001_adc_remove,
>> > +};
>> > +
>> > +static int __init lmp92001_adc_init(void)
>> > +{
>> > +        return platform_driver_register(&lmp92001_adc_driver);
>> > +}
>> > +subsys_initcall(lmp92001_adc_init);
>> > +
>> > +static void __exit lmp92001_adc_exit(void)
>> > +{
>> > +        platform_driver_unregister(&lmp92001_adc_driver);
>> > +}
>> > +module_exit(lmp92001_adc_exit);
>> > +
>> > +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
>> > +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
>> > +MODULE_LICENSE("GPL");
>> > +MODULE_ALIAS("platform:lmp92001-adc");
>>
>>
>

--001a113f995c823d260555bfe8f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Jonathan,<div><br></div><div>Please find my commen=
t on in line.</div><div><br></div><div>Thank you.</div><div>Abhisit S.<br><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Aug 2, 201=
7 at 11:43 AM, Abhisit Sangjan <span dir=3D"ltr">&lt;<a href=3D"mailto:s.ab=
hisit@gmail.com" target=3D"_blank">s.abhisit@gmail.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi=
=C2=A0Jonathan,<div><br></div><div>Thank you for your review and good sugge=
stion. This is my first driver, first work for Linux.=C2=A0 I will be follo=
w your advice and send new once in soon. Please help me to review.</div><di=
v><br></div><div>Thank you,</div><div>Abhisit S.<br><div class=3D"gmail_ext=
ra"><br><div class=3D"gmail_quote"><span class=3D"gmail-">On Tue, Aug 1, 20=
17 at 5:10 PM, Jonathan Cameron <span dir=3D"ltr">&lt;<a href=3D"mailto:Jon=
athan.Cameron@huawei.com" target=3D"_blank">Jonathan.Cameron@huawei.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On =
Tue, 1 Aug 2017 16:12:22 +0700<br>
&lt;<a href=3D"mailto:s.abhisit@gmail.com" target=3D"_blank">s.abhisit@gmai=
l.com</a>&gt; wrote:<br>
<br>
&gt; From: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail.com" targe=
t=3D"_blank">s.abhisit@gmail.com</a>&gt;<br>
Hi,<br>
<br>
A very quick initial review covering stuff you&#39;ll want to clean up befo=
re<br>
you get some in depth reviews.<br></blockquote><div>=C2=A0</div></span><div=
>Abhisit: OK, I will do.<br></div><span class=3D"gmail-"><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<br>
1) Please cc linux-iio on the whole series - it&#39;s useful to see the mfd=
<br>
driver and review it as well.<br></blockquote><div>=C2=A0</div></span><div>=
Abhisit: OK.</div><span class=3D"gmail-"><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
2) Description of the patch is needed. For a new driver, a quick run down<b=
r>
of what it is and what is supported.</blockquote><div>=C2=A0</div></span><d=
iv>Abhisit:=C2=A0I will do.</div><span class=3D"gmail-"><div><br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">=C2=A0<br></blockquote><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
More comments inline.<br>
<br>
Note this is not a full review by any means, just a starting point whilst<b=
r>
I&#39;m waiting for a board to boot...=C2=A0 Will do a full review once the=
se bits<br>
are tidied up.<br>
<br>
Fundamental code looks fine, it&#39;s docs and coding style that need work<=
br>
(plus locking ;)<br>
<br>
Jonathan<br>
<span class=3D"gmail-m_1970762626708281490gmail-">&gt;<br>
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
</span>Alphabetical order please.<br></blockquote><div>=C2=A0</div></span><=
div>Abhisit:=C2=A0I got you.</div><span class=3D"gmail-"><div><br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-"><br>
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
</span>Alphabetical order please.<br></blockquote><div><br></div></span><di=
v>Abhisit: I got you.</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5"><br>
&gt; diff --git a/drivers/iio/adc/lmp92001-adc<wbr>.c b/drivers/iio/adc/lmp=
92001-adc<wbr>.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..909ff47<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/adc/lmp92001-adc<wbr>.c<br>
&gt; @@ -0,0 +1,479 @@<br>
&gt; +/*<br>
&gt; + * lmp92001-adc.c - Support for TI LMP92001 ADCs<br>
&gt; + *<br>
&gt; + * Copyright 2016-2017 Celestica Ltd.<br>
&gt; + *<br>
&gt; + * Author: Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@gmail.com"=
 target=3D"_blank">s.abhisit@gmail.com</a>&gt;<br>
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
</div></div>Nothing prevents multiple simultaneous runs of this function.<b=
r>
Given the write then read cycles below, I&#39;m guessing you&#39;ll be want=
ing<br>
a local lock in your lmp92001 structure.<br></blockquote><div><br></div></d=
iv></div><div>Abhisit: It is hardware lock register to prevent multiple acc=
ess.</div></div></div></div></div></blockquote><div><br></div><div>Abhisit:=
 I thought, the function=C2=A0regmap_read(),=C2=A0regmap_update_bits() and=
=C2=A0regmap_write() are managed the lock access.=C2=A0</div><div>Do I need=
 to lock it by myself?=C2=A0</div><div><br></div><div>Example function regm=
ap_read().</div><div><br></div><div><div>/**</div><div>=C2=A0* regmap_read(=
) - Read a value from a single register</div><div>=C2=A0*</div><div>=C2=A0*=
 @map: Register map to read from</div><div>=C2=A0* @reg: Register to be rea=
d from</div><div>=C2=A0* @val: Pointer to store read value</div><div>=C2=A0=
*</div><div>=C2=A0* A value of zero will be returned on success, a negative=
 errno will</div><div>=C2=A0* be returned in error cases.</div><div>=C2=A0*=
/</div><div>int regmap_read(struct regmap *map, unsigned int reg, unsigned =
int *val)</div><div>{</div><div><span style=3D"white-space:pre">	</span>int=
 ret;</div><div><br></div><div><span style=3D"white-space:pre">	</span>if (=
!IS_ALIGNED(reg, map-&gt;reg_stride))</div><div><span style=3D"white-space:=
pre">		</span>return -EINVAL;</div><div><br></div><div><span style=3D"white=
-space:pre">	</span><font color=3D"#0000ff">map-&gt;lock(map-&gt;lock_arg);=
</font></div><div><br></div><div><span style=3D"white-space:pre">	</span>re=
t =3D _regmap_read(map, reg, val);</div><div><br></div><div><span style=3D"=
white-space:pre">	</span><font color=3D"#0000ff">map-&gt;unlock(map-&gt;loc=
k_arg);</font></div><div><br></div><div><span style=3D"white-space:pre">	</=
span>return ret;</div><div>}</div></div><div><br></div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><span class=3D"gmail-"><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D=
"gmail-m_1970762626708281490gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D iio_device_=
get_drvdata(indio_d<wbr>ev);<br>
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
</span>Kernel goes with K&amp;R style on if statements and brackets.<br>
if (!(cgen &amp; 1)) {<br>
<br>
1 is a magic value - so please add a define telling us what it<br>
represents.<br></blockquote><div><br></div></span><div>Abhisit: I will doub=
le check again for all my source code for K&amp;R and no magic number.</div=
><span class=3D"gmail-"><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-"><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(cgen &a=
mp; 2))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r<wbr>egmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_CGEN, 2, 2);<=
br>
</span>Register field values and masks should use defined constants so the =
code lets<br>
us know what they are without consulting the datasheet.<br></blockquote><di=
v><br></div></span><div>Abhisit:=C2=A0I will give them to be defined.</div>=
<span class=3D"gmail-"><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-"><br>
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
</span>Why - a try look doing repeats like this need an explanatory comment=
.<br></blockquote><div><br></div></span><div>Abhisit: Do you think, should =
be=C2=A0jiffies time?</div><span class=3D"gmail-"><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-">&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 ret =3D regmap_read(lmp92001-&gt;regmap,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 LMP92001_SGEN, &amp;sgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 if(ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } while ((sge=
n &amp; 1&lt;&lt;7) &amp;&amp; (--try &gt; 0));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!try)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 return -ETIME;<br>
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
</span>switch (mask) {<br>
<br>
Please run checkpatch over this - preferably with --strict<br>
and fix everything it comes up with.=C2=A0 Saves everyone time in reviews!<=
br></blockquote><div><br></div></span><div>Abhisit: Thank you for your sugg=
estion. It is my first driver :)</div><div><div class=3D"gmail-h5"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-">&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 case IIO_CHAN_INFO_RAW:<br>
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
</span>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return directly here if still possible a=
fter considering locking.<br>
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brea=
k;<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
</div></div>This looks like new ABI. Please add ABI docs so that we can dis=
cuss this interface<br>
without having to pull it from the code.<br>
<br>
Docuentation/ABI/testing/sysfs<wbr>-bus-iio-lmp920001 is probably the right=
 place.<br></blockquote><div><br></div></div></div><div>Abhisit: I will do.=
</div><span class=3D"gmail-"><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Note IIO also has some nice utility functions to deal with enums like this.=
<br></blockquote><div><br></div></span><div>Abhisit: I have my enums versio=
n. No compile error, no work!=C2=A0 Lets me add it later on, after this onc=
e is working.</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +}<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CREF, 2, cref);<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
</div></div>Again this is new ABI.=C2=A0 Need documenting in this series an=
d detailed discussion.<br></blockquote><div><br></div></div></div><div>Abhi=
sit: I will do.</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +}<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, reg, mask, enable);<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
</div></div>Again, documentation. Note that exposing explicit controls for =
single-shot<br>
or continuous capture hasn&#39;t yet made sense in any other drivers.<br>
Normally this is something that can be optimized in driver.<br>
<br>
There is always a trade off between flexibility and keeping the userspace A=
BI<br>
short and clean.<br></blockquote><div><br></div></div></div><div>Abhisit: B=
asically, It is hardware conversion mode operation. I will take a look on h=
ow to optimize.</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +}<br>
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
get_drvdata(indio_d<wbr>ev);<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CGEN, 2, 0);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
</div></div>What stops a race with this lock? You need a driver lock to pre=
vent multiple<br>
simultaneous sysfs actions from messing things up.<br></blockquote><div><br=
></div></div></div><div>Abhisit: The lock is hardware register function for=
 prevent multiple access to change the chip configuration.</div><div><div c=
lass=3D"gmail-h5"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CGEN, 1, cgen);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CGEN, 2, 2);<br>
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
</div></div>All of this must be defined in the documentation.<br>
<br>
Vref is almost always a board specific element.<br>
You don&#39;t fit an external reference if you are intending to<br>
use the internal one.<br>
<br>
If necessary we can use differential channels to represent the two<br>
possible voltage references, but that is rather ugly.<br></blockquote><div>=
<br></div></div></div><div>Abhisit: I would like to design for changeable v=
ref source.</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 },<br>
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
</div></div>Don&#39;t specify stuff you aren&#39;t using.=C2=A0 The scan st=
uff only<br>
typically becomes relevant when you providing the &#39;push&#39;<br>
or buffered interfaces.=C2=A0 This driver isn&#39;t yet.<br></blockquote><d=
iv><br></div></div></div><div>Abhisit: Could you help me to coding this, I =
have no idea, what is your point. This is my first iio driver.</div><div><d=
iv class=3D"gmail-h5"><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5">&gt; +=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 }, \<br>
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
&gt; +};<br>
&gt; +<br>
&gt; +static int lmp92001_adc_probe(struct platform_device *pdev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct lmp92001 *lmp92001 =3D dev_get_drv=
data(pdev-&gt;dev.pare<wbr>nt);<br>
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
pdev-&gt;d<wbr>ev, sizeof(*lmp92001));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!indio_dev)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOME=
M;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_set_drvdata(indio_d<wbr>ev, lm=
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
(lmp92001_adc_channe<wbr>ls);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CGEN, 0x80, 0x80);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
</div></div>0x80 is a magic number. Use a #define to give it meaning to som=
eone who<br>
can&#39;t be bothered to find the datasheet (i.e. me ;)<br></blockquote><di=
v><br></div></div></div><div>Abhisit: I will defined it.</div><span class=
=3D"gmail-"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<span class=3D"gmail-m_1970762626708281490gmail-">&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 {<br>
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
</span>Talk me through this - why can we not turn them on when we want a re=
ading?<br>
Just how slow is this device to start up?<br>
Or are we looking at stopping certain channels from being used because the =
pin<br>
is in use for something else?<br></blockquote><div><br></div></span><div>Ab=
hisit: I would like to design to support initialization on start-up.</div><=
div><div class=3D"gmail-h5"><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<div><div class=3D"gmail-m_1970762626708281490gmail-h5"><br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CAD1, 0xFF, cad1);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev,&quot;failed to enable channels 1-8\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CAD2, 0xFF, cad2);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev, &quot;failed to enable channels 9-16\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap, LMP92001_CAD3, 1, cad3);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;=
pdev-&gt;dev, &quot;failed to enable channel 17 (temperature)\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<b=
r>
</div></div>These presumably need disabling again on remove or error to sav=
e power?<br>
<br>
Basic rule of thumb is that if something is setup in the probe routine, we<=
br>
expect it to be reversed in the remove and any error path in probe.<br></bl=
ockquote><div><br></div></div></div><div>Abhisit: This chip can not stop. W=
e have no to do remove or disable it.</div><span class=3D"gmail-"><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-">&gt; +=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 }<br>
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
</span>Is this a characteristic of the hardware?=C2=A0 =C2=A0Don&#39;t thin=
k so and isn&#39;t a policy<br>
that makes much sense to push into the devicetree.=C2=A0 Just pick one as<b=
r>
the default and let the driver figure out when to change.<br></blockquote><=
div><br></div></span><div>Abhisit: I will set continuous mode as default.</=
div><span class=3D"gmail-"><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<span class=3D"gmail-m_1970762626708281490gmail-"><br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D regmap_update_bits(lmp92001-&gt;r=
<wbr>egmap,<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 iio_device_unregister(indio_de<wbr>v);<br=
>
</span>No disabling of the device to be done?<br></blockquote><div><br></di=
v></span><div>Abhisit: HW is no way to stop.</div><div><div class=3D"gmail-=
h5"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<div class=3D"gmail-m_1970762626708281490gmail-HOEnZb"><div class=3D"gmail-=
m_1970762626708281490gmail-h5">&gt; +<br>
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
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return platform_driver_register(&amp;lmp9=
<wbr>2001_adc_driver);<br>
&gt; +}<br>
&gt; +subsys_initcall(lmp92001_adc_<wbr>init);<br>
&gt; +<br>
&gt; +static void __exit lmp92001_adc_exit(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 platform_driver_unregister(&amp;lm<wbr>p9=
2001_adc_driver);<br>
&gt; +}<br>
&gt; +module_exit(lmp92001_adc_exit<wbr>);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Abhisit Sangjan &lt;<a href=3D"mailto:s.abhisit@g=
mail.com" target=3D"_blank">s.abhisit@gmail.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;IIO ADC interface for TI LMP92001&quot;);<br=
>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; +MODULE_ALIAS(&quot;platform:lmp920<wbr>01-adc&quot;);<br>
<br>
</div></div></blockquote></div></div></div><br></div></div></div>
</blockquote></div><br></div></div></div>

--001a113f995c823d260555bfe8f8--
