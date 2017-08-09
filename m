Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751945AbdHIOWb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 10:22:31 -0400
Date: Wed, 9 Aug 2017 15:22:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abhisit Sangjan <s.abhisit@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        fabrice.gasnier@st.com, Lee Jones <lee.jones@linaro.org>,
        robh@kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        marek.vasut+renesas@gmail.com, jacopo+renesas@jmondi.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Add support for LMP92001 ADC
Message-ID: <20170809152214.6a2dbc56@archlinux>
In-Reply-To: <CAMV_pUYOMdb_e1xYEkhhuO2GN4FDFSRy6BpHUK5GqO0o8yO1fA@mail.gmail.com>
References: <1501578742-4501-1-git-send-email-s.abhisit@gmail.com>
        <20170801111055.00001127@huawei.com>
        <CAMV_pUaV54qUc1wOhL5cAP8mEX1k0VsL3aEGG+wziqPPnZGHWg@mail.gmail.com>
        <CAMV_pUYOMdb_e1xYEkhhuO2GN4FDFSRy6BpHUK5GqO0o8yO1fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2 Aug 2017 14:06:50 +0700
Abhisit Sangjan <s.abhisit@gmail.com> wrote:

> Hi Jonathan,
> 
> Please find my comment on in line.
> 
> Thank you.
> Abhisit S.
> 
<snip>
> >> > +#include <linux/kernel.h>
> >> > +#include <linux/module.h>
> >> > +#include <linux/iio/iio.h>
> >> > +#include <linux/mfd/core.h>
> >> > +#include <linux/platform_device.h>
> >> > +#include <linux/interrupt.h>
> >> > +
> >> > +#include <linux/mfd/lmp92001/core.h>
> >> > +
> >> > +static int lmp92001_read_raw(struct iio_dev *indio_dev,
> >> > +                                struct iio_chan_spec const *channel,  
> >> int *val,  
> >> > +                                int *val2, long mask)
> >> > +{  
> >> Nothing prevents multiple simultaneous runs of this function.
> >> Given the write then read cycles below, I'm guessing you'll be wanting
> >> a local lock in your lmp92001 structure.
> >>  
> >
> > Abhisit: It is hardware lock register to prevent multiple access.
> >  
> 
> Abhisit: I thought, the function regmap_read(), regmap_update_bits()
> and regmap_write() are managed the lock access.
> Do I need to lock it by myself?
Because it's not locked between the two functions.
You could read the first thing that lets you know that
you should expect the status bit to be set.  Then before
you actually read the status bit the state could change.
Then you would be waiting for something that is never going
to happen.
> 
> Example function regmap_read().
> 
> /**
>  * regmap_read() - Read a value from a single register
>  *
>  * @map: Register map to read from
>  * @reg: Register to be read from
>  * @val: Pointer to store read value
>  *
>  * A value of zero will be returned on success, a negative errno will
>  * be returned in error cases.
>  */
> int regmap_read(struct regmap *map, unsigned int reg, unsigned int *val)
> {
> int ret;
> 
> if (!IS_ALIGNED(reg, map->reg_stride))
> return -EINVAL;
> 
> map->lock(map->lock_arg);
> 
> ret = _regmap_read(map, reg, val);
> 
> map->unlock(map->lock_arg);
> 
> return ret;
> }
> 
> 
> 
> >
> >  
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int code, cgen, sgen, try;
> >> > +        int ret;
> >> > +
> >> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        /*
> >> > +         * Is not continuous conversion?
> >> > +         * Lock the registers (if needed).
> >> > +         * Triggering single-short conversion.
> >> > +         * Waiting for conversion successfully.
> >> > +         */
> >> > +        if (!(cgen & 1))  
> >> Kernel goes with K&R style on if statements and brackets.
> >> if (!(cgen & 1)) {
> >>
> >> 1 is a magic value - so please add a define telling us what it
> >> represents.
> >>  
> >
> > Abhisit: I will double check again for all my source code for K&R and no
> > magic number.
> >
> >  
> >>  
> >> > +        {
> >> > +                if (!(cgen & 2))
> >> > +                {
> >> > +                        ret = regmap_update_bits(lmp92001->regmap,
> >> > +                                                        LMP92001_CGEN,  
> >> 2, 2);
> >> Register field values and masks should use defined constants so the code
> >> lets
> >> us know what they are without consulting the datasheet.
> >>  
> >
> > Abhisit: I will give them to be defined.
> >
> >  
> >>  
> >> > +                        if (ret < 0)
> >> > +                                return ret;
> >> > +                }
> >> > +
> >> > +                ret = regmap_write(lmp92001->regmap, LMP92001_CTRIG,  
> >> 1);  
> >> > +                if (ret < 0)
> >> > +                        return ret;
> >> > +
> >> > +                try = 10;  
> >> Why - a try look doing repeats like this need an explanatory comment.
> >>  
> >
> > Abhisit: Do you think, should be jiffies time?
Just explain why you need to retry at all. If we are waiting
for something to happen (some devices will have read fail while they
are busy) then say so and say how long this will be.
In that case you'd want a sleep, but presumably something fairly
short.

This code isn't obvious to a reviewer so it is a classic
case where you need and explanatory comment.

> >
> >  
> >> > +                do {
> >> > +                        ret = regmap_read(lmp92001->regmap,
> >> > +                                                LMP92001_SGEN, &sgen);
> >> > +                        if(ret < 0)
> >> > +                                return ret;
> >> > +                } while ((sgen & 1<<7) && (--try > 0));
> >> > +
> >> > +                if (!try)
> >> > +                        return -ETIME;
> >> > +        }
> >> > +
> >> > +        ret = regmap_read(lmp92001->regmap, 0x1F + channel->channel,  
> >> &code);  
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        switch (mask)
> >> > +        {  
> >> switch (mask) {
> >>
> >> Please run checkpatch over this - preferably with --strict
> >> and fix everything it comes up with.  Saves everyone time in reviews!
> >>  
> >
> > Abhisit: Thank you for your suggestion. It is my first driver :)
> >
> >  
> >> > +        case IIO_CHAN_INFO_RAW:
> >> > +                switch (channel->type) {
> >> > +                case IIO_VOLTAGE:
> >> > +                case IIO_TEMP:
> >> > +                        *val = code;
> >> > +                        return IIO_VAL_INT;
> >> > +                default:  
> >>         return directly here if still possible after considering locking.  
> >> > +                        break;
> >> > +                }
> >> > +                break;
> >> > +        default:
> >> > +                break;
> >> > +        }
> >> > +
> >> > +        return -EINVAL;
> >> > +}
> >> > +
> >> > +/*
> >> > + * TODO: do your attributes even handler for
> >> > + * Current limit low/high for CH 1-3, 9-11!
> >> > + * In case INT1 and INT2 were connected to i.MX6.
> >> > + */
> >> > +static const struct iio_info lmp92001_info = {
> >> > +        .read_raw = lmp92001_read_raw,
> >> > +        .driver_module = THIS_MODULE,
> >> > +};
> >> > +
> >> > +static ssize_t lmp92001_avref_read(struct iio_dev *indio_dev,  
> >> uintptr_t private,  
> >> > +                        struct iio_chan_spec const *channel, char *buf)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int cref;
> >> > +        int ret;
> >> > +
> >> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CREF, &cref);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        return sprintf(buf, "%s\n", cref & 2 ? "external" :  
> >> "internal");
> >> This looks like new ABI. Please add ABI docs so that we can discuss this
> >> interface
> >> without having to pull it from the code.
> >>
> >> Docuentation/ABI/testing/sysfs-bus-iio-lmp920001 is probably the right
> >> place.
> >>  
> >
> > Abhisit: I will do.
> >
> >  
> >>
> >> Note IIO also has some nice utility functions to deal with enums like
> >> this.
> >>  
> >
> > Abhisit: I have my enums version. No compile error, no work!  Lets me add
> > it later on, after this once is working.
> >
> >  
> >> > +}
> >> > +
> >> > +static ssize_t lmp92001_avref_write(struct iio_dev *indio_dev,  
> >> uintptr_t private,  
> >> > +                         struct iio_chan_spec const *channel, const  
> >> char *buf,  
> >> > +                         size_t len)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int cref;
> >> > +        int ret;
> >> > +
> >> > +        if (strcmp("external\n", buf) == 0)
> >> > +                cref = 2;
> >> > +        else if (strcmp("internal\n", buf) == 0)
> >> > +                cref = 0;
> >> > +        else
> >> > +                return -EINVAL;
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CREF, 2,  
> >> cref);  
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        return len;
> >> > +}
> >> > +
> >> > +static ssize_t lmp92001_enable_read(struct iio_dev *indio_dev,  
> >> uintptr_t private,  
> >> > +                        struct iio_chan_spec const *channel, char *buf)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int reg, cad;
> >> > +        int ret;
> >> > +
> >> > +        switch (channel->channel)
> >> > +        {
> >> > +        case 1 ... 8:
> >> > +                reg = LMP92001_CAD1;
> >> > +                break;
> >> > +        case 9 ... 16:
> >> > +                reg = LMP92001_CAD2;
> >> > +                break;
> >> > +        case 17:
> >> > +                reg = LMP92001_CAD3;
> >> > +                break;
> >> > +        default:
> >> > +                return -EINVAL;
> >> > +        }
> >> > +
> >> > +        ret = regmap_read(lmp92001->regmap, reg, &cad);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        if (channel->channel <= 8)
> >> > +                cad >>= channel->channel - 1;
> >> > +        else if(channel->channel > 8)
> >> > +                cad >>= channel->channel - 9;
> >> > +        else if(channel->channel > 16)
> >> > +                cad >>= channel->channel - 17;
> >> > +        else
> >> > +                return -EINVAL;
> >> > +
> >> > +        return sprintf(buf, "%s\n", cad & 1 ? "enable" : "disable");  
> >> Again this is new ABI.  Need documenting in this series and detailed
> >> discussion.
> >>  
> >
> > Abhisit: I will do.
> >
> >  
> >> > +}
> >> > +
> >> > +static ssize_t lmp92001_enable_write(struct iio_dev *indio_dev,  
> >> uintptr_t private,  
> >> > +                         struct iio_chan_spec const *channel, const  
> >> char *buf,  
> >> > +                         size_t len)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int reg, enable, shif, mask;
> >> > +        int ret;
> >> > +
> >> > +        switch (channel->channel)
> >> > +        {
> >> > +        case 1 ... 8:
> >> > +                reg = LMP92001_CAD1;
> >> > +                shif = (channel->channel - 1);
> >> > +                break;
> >> > +        case 9 ... 16:
> >> > +                reg = LMP92001_CAD2;
> >> > +                shif = (channel->channel - 9);
> >> > +                break;
> >> > +        case 17:
> >> > +                reg = LMP92001_CAD3;
> >> > +                shif = (channel->channel - 17);
> >> > +                break;
> >> > +        default:
> >> > +                return -EINVAL;
> >> > +        }
> >> > +
> >> > +        if (strcmp("enable\n", buf) == 0)
> >> > +                enable = 1;
> >> > +        else if (strcmp("disable\n", buf) == 0)
> >> > +                enable = 0;
> >> > +        else
> >> > +                return -EINVAL;
> >> > +
> >> > +        enable <<= shif;
> >> > +        mask = 1 << shif;
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, reg, mask, enable);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        return len;
> >> > +}
> >> > +
> >> > +static ssize_t lmp92001_mode_read(struct iio_dev *indio_dev, uintptr_t  
> >> private,  
> >> > +                        struct iio_chan_spec const *channel, char *buf)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int cgen;
> >> > +        int ret;
> >> > +
> >> > +        ret = regmap_read(lmp92001->regmap, LMP92001_CGEN, &cgen);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        return sprintf(buf, "%s\n", cgen & 1 ? "continuous" :  
> >> "single-shot");
> >> Again, documentation. Note that exposing explicit controls for single-shot
> >> or continuous capture hasn't yet made sense in any other drivers.
> >> Normally this is something that can be optimized in driver.
> >>
> >> There is always a trade off between flexibility and keeping the userspace
> >> ABI
> >> short and clean.
> >>  
> >
> > Abhisit: Basically, It is hardware conversion mode operation. I will take
> > a look on how to optimize.
> >
> >  
> >> > +}
> >> > +
> >> > +static ssize_t lmp92001_mode_write(struct iio_dev *indio_dev,  
> >> uintptr_t private,  
> >> > +                         struct iio_chan_spec const *channel, const  
> >> char *buf,  
> >> > +                         size_t len)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = iio_device_get_drvdata(indio_dev);
> >> > +        unsigned int cgen;
> >> > +        int ret;
> >> > +
> >> > +        if (strcmp("continuous\n", buf) == 0)
> >> > +                cgen = 1;
> >> > +        else if (strcmp("single-shot\n", buf) == 0)
> >> > +                cgen = 0;
> >> > +        else
> >> > +                return -EINVAL;
> >> > +
> >> > +        /*
> >> > +         * Unlock the registers.
> >> > +         * Set conversion mode.
> >> > +         * Lock the registers.
> >> > +         */
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,  
> >> 0);  
> >> > +        if (ret < 0)
> >> > +                return ret;  
> >> What stops a race with this lock? You need a driver lock to prevent
> >> multiple
> >> simultaneous sysfs actions from messing things up.
> >>  
> >
> > Abhisit: The lock is hardware register function for prevent multiple
> > access to change the chip configuration.
> >
> >  
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 1,  
> >> cgen);  
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN, 2,  
> >> 2);  
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        return len;
> >> > +}
> >> > +
> >> > +static const struct iio_chan_spec_ext_info lmp92001_ext_info[] = {
> >> > +        {
> >> > +                .name = "vref",
> >> > +                .read = lmp92001_avref_read,
> >> > +                .write = lmp92001_avref_write,
> >> > +                .shared = IIO_SHARED_BY_ALL,
> >> > +        },
> >> > +        {
> >> > +                .name = "en",
> >> > +                .read = lmp92001_enable_read,
> >> > +                .write = lmp92001_enable_write,
> >> > +                .shared = IIO_SEPARATE,
> >> > +        },
> >> > +        {
> >> > +                .name = "mode",
> >> > +                .read = lmp92001_mode_read,
> >> > +                .write = lmp92001_mode_write,
> >> > +                .shared = IIO_SHARED_BY_ALL,  
> >> All of this must be defined in the documentation.
> >>
> >> Vref is almost always a board specific element.
> >> You don't fit an external reference if you are intending to
> >> use the internal one.
> >>
> >> If necessary we can use differential channels to represent the two
> >> possible voltage references, but that is rather ugly.
> >>  
> >
> > Abhisit: I would like to design for changeable vref source.
> >
> >  
> >> > +        },
> >> > +        { },
> >> > +};
> >> > +
> >> > +static const struct iio_event_spec lmp92001_events[] = {
> >> > +        {
> >> > +                .type = IIO_EV_TYPE_THRESH,
> >> > +                .dir = IIO_EV_DIR_RISING,
> >> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> >> > +                        BIT(IIO_EV_INFO_VALUE),
> >> > +        },
> >> > +        {
> >> > +                .type = IIO_EV_TYPE_THRESH,
> >> > +                .dir = IIO_EV_DIR_FALLING,
> >> > +                .mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> >> > +                        BIT(IIO_EV_INFO_VALUE),
> >> > +        },
> >> > +        { },
> >> > +};
> >> > +
> >> > +#define LMP92001_CHAN_SPEC(_ch, _type, _event, _nevent) \
> >> > +{ \
> >> > +        .channel = _ch, \
> >> > +        .scan_index = _ch, \
> >> > +        .scan_type = { \
> >> > +                        .sign = 'u', \
> >> > +                        .realbits = 12, \
> >> > +                        .storagebits = 16, \
> >> > +                        .repeat = 1, \
> >> > +                        .endianness = IIO_BE, \  
> >> Don't specify stuff you aren't using.  The scan stuff only
> >> typically becomes relevant when you providing the 'push'
> >> or buffered interfaces.  This driver isn't yet.
> >>  
> >
> > Abhisit: Could you help me to coding this, I have no idea, what is your
> > point. This is my first iio driver.
> >
> >  
> >> > +        }, \
> >> > +        .type = _type, \
> >> > +        .indexed = 1, \
> >> > +        .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> >> > +        .event_spec = _event, \
> >> > +        .num_event_specs = _nevent, \
> >> > +        .ext_info = lmp92001_ext_info, \
> >> > +}
> >> > +
> >> > +/*
> >> > + * TODO: do your ext_info for current low/high limit.
> >> > + * Example driver/iio/dac/ad5064.c
> >> > + */
> >> > +static const struct iio_chan_spec lmp92001_adc_channels[] = {
> >> > +        LMP92001_CHAN_SPEC( 1, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC( 2, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC( 3, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC( 4, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC( 5, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC( 6, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC( 7, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC( 8, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC( 9, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC(10, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC(11, IIO_VOLTAGE, lmp92001_events,  
> >> ARRAY_SIZE(lmp92001_events)),  
> >> > +        LMP92001_CHAN_SPEC(12, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC(13, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC(14, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC(15, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC(16, IIO_VOLTAGE, NULL, 0),
> >> > +        LMP92001_CHAN_SPEC(17,    IIO_TEMP, NULL, 0),
> >> > +};
> >> > +
> >> > +static int lmp92001_adc_probe(struct platform_device *pdev)
> >> > +{
> >> > +        struct lmp92001 *lmp92001 = dev_get_drvdata(pdev->dev.parent);
> >> > +        struct iio_dev *indio_dev;
> >> > +        struct device_node *np = pdev->dev.of_node;
> >> > +        const char *conversion;
> >> > +        unsigned int cgen = 0, cad1, cad2, cad3;
> >> > +        u32 mask;
> >> > +        int ret;
> >> > +
> >> > +        indio_dev = devm_iio_device_alloc(&pdev->dev,  
> >> sizeof(*lmp92001));  
> >> > +        if (!indio_dev)
> >> > +                return -ENOMEM;
> >> > +
> >> > +        iio_device_set_drvdata(indio_dev, lmp92001);
> >> > +
> >> > +        indio_dev->name = pdev->name;
> >> > +        indio_dev->dev.parent = &pdev->dev;
> >> > +        indio_dev->modes = INDIO_DIRECT_MODE;
> >> > +        indio_dev->info = &lmp92001_info;
> >> > +        indio_dev->channels = lmp92001_adc_channels;
> >> > +        indio_dev->num_channels = ARRAY_SIZE(lmp92001_adc_channels);
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CGEN,  
> >> 0x80, 0x80);  
> >> > +        if (ret < 0)  
> >> 0x80 is a magic number. Use a #define to give it meaning to someone who
> >> can't be bothered to find the datasheet (i.e. me ;)
> >>  
> >
> > Abhisit: I will defined it.
> >
> >  
> >> > +        {
> >> > +                dev_err(&pdev->dev,"failed to self reset all  
> >> registers\n");  
> >> > +                return ret;
> >> > +        }
> >> > +
> >> > +        ret = of_property_read_u32(np, "ti,lmp92001-adc-mask", &mask);
> >> > +        if (ret < 0)
> >> > +        {
> >> > +                cad1 = cad2 = cad3 = 0xFF;
> >> > +                dev_info(&pdev->dev, "turn on all of channels by  
> >> default\n");
> >> Talk me through this - why can we not turn them on when we want a reading?
> >> Just how slow is this device to start up?
> >> Or are we looking at stopping certain channels from being used because
> >> the pin
> >> is in use for something else?
> >>  
> >
> > Abhisit: I would like to design to support initialization on start-up.
> >
> >  
> >>  
> >> > +        }
> >> > +        else
> >> > +        {
> >> > +                cad1 = mask & 0xFF;
> >> > +                cad2 = (mask >> 8) & 0xFF;
> >> > +                cad3 = (mask >> 16) & 0xFF;
> >> > +        }
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD1,  
> >> 0xFF, cad1);  
> >> > +        if (ret < 0)
> >> > +        {
> >> > +                dev_err(&pdev->dev,"failed to enable channels 1-8\n");
> >> > +                return ret;
> >> > +        }
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD2,  
> >> 0xFF, cad2);  
> >> > +        if (ret < 0)
> >> > +        {
> >> > +                dev_err(&pdev->dev, "failed to enable channels  
> >> 9-16\n");  
> >> > +                return ret;
> >> > +        }
> >> > +
> >> > +        ret = regmap_update_bits(lmp92001->regmap, LMP92001_CAD3, 1,  
> >> cad3);  
> >> > +        if (ret < 0)
> >> > +        {
> >> > +                dev_err(&pdev->dev, "failed to enable channel 17  
> >> (temperature)\n");  
> >> > +                return ret;  
> >> These presumably need disabling again on remove or error to save power?
> >>
> >> Basic rule of thumb is that if something is setup in the probe routine, we
> >> expect it to be reversed in the remove and any error path in probe.
> >>  
> >
> > Abhisit: This chip can not stop. We have no to do remove or disable it.
> >
> >  
> >> > +        }
> >> > +
> >> > +        ret = of_property_read_string_index(np,  
> >> "ti,lmp92001-adc-mode", 0,  
> >> > +                                                &conversion);
> >> > +        if (!ret)
> >> > +        {
> >> > +                if (strcmp("continuous", conversion) == 0)
> >> > +                        cgen |= 1;
> >> > +                else if (strcmp("single-shot", conversion) == 0)
> >> > +                        { /* Okay */ }
> >> > +                else
> >> > +                        dev_warn(&pdev->dev,
> >> > +                        "wrong adc mode! set to single-short  
> >> conversion\n");
> >> Is this a characteristic of the hardware?   Don't think so and isn't a
> >> policy
> >> that makes much sense to push into the devicetree.  Just pick one as
> >> the default and let the driver figure out when to change.
> >>  
> >
> > Abhisit: I will set continuous mode as default.
> >
> >  
> >>  
> >> > +        }
> >> > +        else
> >> > +                dev_info(&pdev->dev,
> >> > +                "single-short conversion was chosen by default\n");
> >> > +
> >> > +        /*
> >> > +         * Lock the registers and set conversion mode.
> >> > +         */
> >> > +        ret = regmap_update_bits(lmp92001->regmap,
> >> > +                                        LMP92001_CGEN, 3, cgen | 2);
> >> > +        if (ret < 0)
> >> > +                return ret;
> >> > +
> >> > +        platform_set_drvdata(pdev, indio_dev);
> >> > +
> >> > +        return iio_device_register(indio_dev);
> >> > +}
> >> > +
> >> > +static int lmp92001_adc_remove(struct platform_device *pdev)
> >> > +{
> >> > +        struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> >> > +
> >> > +        iio_device_unregister(indio_dev);  
> >> No disabling of the device to be done?
> >>  
> >
> > Abhisit: HW is no way to stop.
> >
> >  
> >> > +
> >> > +        return 0;
> >> > +}
> >> > +
> >> > +static struct platform_driver lmp92001_adc_driver = {
> >> > +        .driver.name    = "lmp92001-adc",
> >> > +        .driver.owner   = THIS_MODULE,
> >> > +        .probe          = lmp92001_adc_probe,
> >> > +        .remove         = lmp92001_adc_remove,
> >> > +};
> >> > +
> >> > +static int __init lmp92001_adc_init(void)
> >> > +{
> >> > +        return platform_driver_register(&lmp92001_adc_driver);
> >> > +}
> >> > +subsys_initcall(lmp92001_adc_init);
> >> > +
> >> > +static void __exit lmp92001_adc_exit(void)
> >> > +{
> >> > +        platform_driver_unregister(&lmp92001_adc_driver);
> >> > +}
> >> > +module_exit(lmp92001_adc_exit);
> >> > +
> >> > +MODULE_AUTHOR("Abhisit Sangjan <s.abhisit@gmail.com>");
> >> > +MODULE_DESCRIPTION("IIO ADC interface for TI LMP92001");
> >> > +MODULE_LICENSE("GPL");
> >> > +MODULE_ALIAS("platform:lmp92001-adc");  
> >>
> >>  
> >  

