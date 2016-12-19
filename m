Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:50936 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754122AbcLSJ1E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2016 04:27:04 -0500
Date: Mon, 19 Dec 2016 10:26:33 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Subject: Re: [PATCH 2/2] iio: adc: hx711: Add IIO driver for AVIA HX711
Message-ID: <20161219092633.GA6103@andreas>
References: <20161213180254.GA3185@andreas>
 <CAJCx=g=--vuGHRi1HUjJgzV_Hwj0-6bO+oakCNN_LZQVbwn5_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJCx=g=--vuGHRi1HUjJgzV_Hwj0-6bO+oakCNN_LZQVbwn5_A@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Matt,

thank you for your suggestions. See below.


Matt Ranostay <matt.ranostay@konsulko.com> schrieb am Sat, 17. Dec 00:53:
> On Tue, Dec 13, 2016 at 10:02 AM, Andreas Klinger <ak@it-klinger.de> wrote:
> > This is the IIO driver for AVIA HX711 ADC which ist mostly used in weighting
> > cells.
> 
> First off cool that this is finally getting a driver... I'll have to
> get the SparkFun breakout and really cheap scale to test :).
> 
> >
> > The protocol is quite simple and using GPIO's:
> > One GPIO is used as clock (SCK) while another GPIO is read (DOUT)
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  drivers/iio/adc/Kconfig  |  13 +++
> >  drivers/iio/adc/Makefile |   1 +
> >  drivers/iio/adc/hx711.c  | 269 +++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 283 insertions(+)
> >  create mode 100644 drivers/iio/adc/hx711.c
> >
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 932de1f9d1e7..7902b50fcf32 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -205,6 +205,19 @@ config HI8435
> >           This driver can also be built as a module. If so, the module will be
> >           called hi8435.
> >
> > +config HX711
> > +       tristate "AVIA HX711 ADC for weight cells"
> > +       depends on GPIOLIB
> > +       help
> > +         If you say yes here you get support for AVIA HX711 ADC which is used
> > +         for weight cells
> > +
> > +         This driver uses two GPIO's, one for setting the clock and the other
> > +         one for getting the data
> > +
> > +         This driver can also be built as a module. If so, the module will be
> > +         called hx711.
> > +
> >  config INA2XX_ADC
> >         tristate "Texas Instruments INA2xx Power Monitors IIO driver"
> >         depends on I2C && !SENSORS_INA2XX
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index b1aa456e6af3..d46e289900ef 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_CC10001_ADC) += cc10001_adc.o
> >  obj-$(CONFIG_DA9150_GPADC) += da9150-gpadc.o
> >  obj-$(CONFIG_EXYNOS_ADC) += exynos_adc.o
> >  obj-$(CONFIG_HI8435) += hi8435.o
> > +obj-$(CONFIG_HX711) += hx711.o
> >  obj-$(CONFIG_IMX7D_ADC) += imx7d_adc.o
> >  obj-$(CONFIG_INA2XX_ADC) += ina2xx-adc.o
> >  obj-$(CONFIG_LP8788_ADC) += lp8788_adc.o
> > diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> > new file mode 100644
> > index 000000000000..cbc89e467985
> > --- /dev/null
> > +++ b/drivers/iio/adc/hx711.c
> > @@ -0,0 +1,269 @@
> > +/*
> > + * HX711: analog to digital converter for weight sensor module
> > + *
> > + * Copyright (c) Andreas Klinger <ak@it-klinger.de>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/property.h>
> > +#include <linux/slab.h>
> > +#include <linux/sched.h>
> > +#include <linux/delay.h>
> > +#include <linux/iio/iio.h>
> > +
> > +#define HX711_GAIN_32          2       /* gain = 32 for channel B  */
> > +#define HX711_GAIN_64          3       /* gain = 64 for channel A  */
> > +#define HX711_GAIN_128         1       /* gain = 128 for channel A */
> > +
> > +
> > +struct hx711_data {
> > +       struct device           *dev;
> > +       dev_t                   devt;
> > +       struct gpio_desc        *gpiod_sck;
> > +       struct gpio_desc        *gpiod_dout;
> > +       int                     gain_pulse;
> > +       struct mutex            lock;
> > +};
> > +
> > +static void hx711_reset(struct hx711_data *hx711_data)
> > +{
> > +       int val;
> > +       int i;
> > +
> > +       val = gpiod_get_value(hx711_data->gpiod_dout);
> 
> could move the val assignment here to the initialization don't think
> it will hit 80 chars
> 

I'll change this.

> > +       if (val) {
> 
> move "int i" here to avoid compiler initialization warnings
> 
> > +               dev_warn(hx711_data->dev, "RESET-HX711\n");
> > +
> > +               gpiod_set_value(hx711_data->gpiod_sck, 1);
> > +               udelay(80);
> 
> IIRC this chip has quite a bit of latency thresholds, can't use
> usleep_range? Single core embedded systems could have an issue with
> continuous  polling.
>

That's a good suggestion. We don't need udelay so i'll change to usleep_range
for the next version

> > +               gpiod_set_value(hx711_data->gpiod_sck, 0);
> > +
> > +               for (i = 0; i < 1000; i++) {
> > +                       val = gpiod_get_value(hx711_data->gpiod_dout);
> > +                       if (!val)
> > +                               break;
> > +                       /* sleep at least 1 ms*/
> > +                       msleep(1);
> > +               }
> > +       }
> > +}
> > +
> > +static int hx711_cycle(struct hx711_data *hx711_data)
> > +{
> > +       int val;
> > +
> > +       /* if preempted for more then 60us while SCK is high:
> > +        * hx711 is going in reset
> > +        * ==> measuring is false
> > +        */
> > +       preempt_disable();
> > +       gpiod_set_value(hx711_data->gpiod_sck, 1);
> > +       val = gpiod_get_value(hx711_data->gpiod_dout);
> > +       gpiod_set_value(hx711_data->gpiod_sck, 0);
> > +       preempt_enable();
> > +
> > +       return val;
> > +}
> > +
> > +static unsigned int hx711_read(struct hx711_data *hx711_data)
> > +{
> > +       int i;
> > +       int ret;
> > +       int wert = 0;
> > +
> > +       hx711_reset(hx711_data);
> > +
> > +       for (i = 0; i < 24; i++) {
> > +               wert <<= 1;
> > +               ret = hx711_cycle(hx711_data);
> > +               if (ret)
> > +                       wert++;
> > +       }
> > +
> > +       wert ^= 0x800000;
> > +
> > +       for (i = 0; i < hx711_data->gain_pulse; i++)
> > +               ret = hx711_cycle(hx711_data);
> 
> What is ret used for here?
> > +
> > +       return wert;
> > +}
> > +
> > +
> > +static int hx711_read_raw(struct iio_dev *iio_dev,
> > +                               const struct iio_chan_spec *chan,
> > +                               int *val, int *val2, long mask)
> > +{
> > +       struct hx711_data *hx711_data = iio_priv(iio_dev);
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               switch (chan->type) {
> > +               case IIO_VOLTAGE:
> > +                       mutex_lock(&hx711_data->lock);
> > +                       *val = (int)hx711_read(hx711_data);
> > +                       mutex_unlock(&hx711_data->lock);
> > +                       ret = IIO_VAL_INT;
> > +                       break;
> > +               default:
> > +                       return -EINVAL;
> > +               }
> > +               return ret;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static const struct iio_info hx711_iio_info = {
> > +       .driver_module          = THIS_MODULE,
> > +       .read_raw               = hx711_read_raw,
> > +};
> > +
> > +static const struct iio_chan_spec hx711_chan_spec[] = {
> > +       { .type = IIO_VOLTAGE,
> > +               .channel = 0,
> > +               .info_mask_separate =
> > +                       BIT(IIO_CHAN_INFO_RAW),
> > +               .scan_type = {
> > +                       .sign = 'u',
> > +                       .realbits = 24,
> > +                       .storagebits = 32,
> > +                       .shift = 0,
> > +               }
> > +       },
> > +};
> > +
> > +static int hx711_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct device_node *node = dev->of_node;
> > +       struct hx711_data *hx711_data = NULL;
> > +       struct iio_dev *iio;
> > +       int ret = 0, ival;
> > +
> > +       iio = devm_iio_device_alloc(dev, sizeof(struct hx711_data));
> > +       if (!iio) {
> > +               dev_err(dev, "failed to allocate IIO device\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       hx711_data = iio_priv(iio);
> > +       hx711_data->dev = dev;
> > +
> > +       mutex_init(&hx711_data->lock);
> > +
> > +       hx711_data->gpiod_sck = devm_gpiod_get(dev, "sck", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(hx711_data->gpiod_sck)) {
> > +               ret = PTR_ERR(hx711_data->gpiod_sck);
> > +               goto err;
> > +       }
> > +
> > +       hx711_data->gpiod_dout = devm_gpiod_get(dev, "dout", GPIOD_OUT_HIGH);
> > +       if (IS_ERR(hx711_data->gpiod_dout)) {
> > +               ret = PTR_ERR(hx711_data->gpiod_dout);
> > +               goto err;
> > +       }
> > +
> > +       ret = of_property_read_u32 (node, "gain", &ival);
> > +       if (!ret) {
> > +               switch (ival) {
> > +               case 32:
> > +                       hx711_data->gain_pulse = HX711_GAIN_32;
> > +                       break;
> > +               case 64:
> > +                       hx711_data->gain_pulse = HX711_GAIN_64;
> > +                       break;
> > +               case 128:
> > +                       hx711_data->gain_pulse = HX711_GAIN_128;
> > +                       break;
> > +               default:
> > +                       hx711_data->gain_pulse = HX711_GAIN_128;
> > +               }
> > +       } else
> > +               hx711_data->gain_pulse = HX711_GAIN_128;
> > +       dev_dbg(hx711_data->dev, "gain: %d\n", hx711_data->gain_pulse);
> > +
> > +       ret = gpiod_direction_input(hx711_data->gpiod_dout);
> > +       if (ret < 0) {
> > +               dev_err(hx711_data->dev, "gpiod_direction_input: %d\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       ret = gpiod_direction_output(hx711_data->gpiod_sck, 0);
> > +       if (ret < 0) {
> > +               dev_err(hx711_data->dev, "gpiod_direction_output: %d\n", ret);
> > +               goto err;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, iio);
> > +
> > +       iio->name = pdev->name;
> > +       iio->dev.parent = &pdev->dev;
> > +       iio->info = &hx711_iio_info;
> > +       iio->modes = INDIO_DIRECT_MODE;
> > +       iio->channels = hx711_chan_spec;
> > +       iio->num_channels = ARRAY_SIZE(hx711_chan_spec);
> > +
> > +       dev_err(hx711_data->dev, "initialized\n");
> > +
> > +       return devm_iio_device_register(dev, iio);
> > +
> > +err:
> > +       return ret;
> > +}
> > +
> > +
> > +static int hx711_suspend(struct device *dev)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int hx711_resume(struct device *dev)
> > +{
> > +       return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(hx711_pm_ops, hx711_suspend, hx711_resume);
> > +
> > +
> > +static const struct of_device_id of_hx711_match[] = {
> > +       { .compatible = "avia,hx711", },
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, of_hx711_match);
> > +
> > +static struct platform_driver hx711_driver = {
> > +       .probe          = hx711_probe,
> > +       .driver         = {
> > +               .name           = "hx711-gpio",
> > +               .pm             = &hx711_pm_ops,
> > +               .of_match_table = of_hx711_match,
> > +       },
> > +};
> > +
> > +module_platform_driver(hx711_driver);
> > +
> > +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> > +MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:hx711-gpio");
> > +
> > --
> > 2.1.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
