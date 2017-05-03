Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:34150 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdECFf2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 May 2017 01:35:28 -0400
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
 <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <8e6a0016-175a-8374-76f9-8bef1815f66f@siemens.com>
Date: Wed, 3 May 2017 07:35:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-02 22:53, Andy Shevchenko wrote:
> On Tue, May 2, 2017 at 11:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.
>>
>> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
>> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
>> Todor Minchev <todor@minchev.co.uk>.
> 
> There are several nitpicks, and one concern about regulator.
> After addressing at least the latter
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
>> +#include <linux/acpi.h>
> 
>> +#include <linux/gpio.h>
> 
> Redundant I beleive.
> 
>> +static int adc108s102_update_scan_mode(struct iio_dev *indio_dev,
>> +               unsigned long const *active_scan_mask)
>> +{
>> +       struct adc108s102_state *st;
>> +       unsigned int bit, cmds;
> 
>> +
>> +       st = iio_priv(indio_dev);
>> +
> 
> I think it's a quite good pattern to assign such variables above at
> definition block.
> This also would be done in several functions below (except ->probe() call)
> 
>> +       /*
>> +        * Fill in the first x shorts of tx_buf with the number of channels
>> +        * enabled for sampling by the triggered buffer
>> +        */
> 
> Usually in multiline comments even for one sentence we use period at the end.
> 
>> +       cmds = 0;
>> +       for_each_set_bit(bit, active_scan_mask, ADC108S102_MAX_CHANNELS)
>> +               st->tx_buf[cmds++] = cpu_to_be16(ADC108S102_CMD(bit));
>> +
>> +       /* One dummy command added, to clock in the last response */
>> +       st->tx_buf[cmds++] = 0x00;
>> +
>> +       /* build SPI ring message */
> 
>> +       st->ring_xfer.tx_buf = &st->tx_buf[0];
>> +       st->ring_xfer.rx_buf = &st->rx_buf[0];
> 
> &pointer[0] -> pointer

This is following patterns in other drivers, expressing you want the
first element here. I'll keep it.

> 
>> +       st->ring_xfer.len = cmds * sizeof(st->tx_buf[0]);
>> +
>> +       spi_message_init_with_transfers(&st->ring_msg, &st->ring_xfer, 1);
>> +
>> +       return 0;
>> +}
>> +
>> +static irqreturn_t adc108s102_trigger_handler(int irq, void *p)
>> +{
>> +       struct iio_poll_func *pf = p;
>> +       struct iio_dev *indio_dev;
>> +       struct adc108s102_state *st;
>> +       int ret;
>> +
> 
>> +       indio_dev = pf->indio_dev;
>> +       st = iio_priv(indio_dev);
> 
> Assign them above.
> 
>> +out:
> 
> I would name it out_notify.
> 
>> +       iio_trigger_notify_done(indio_dev->trig);
>> +
>> +       return IRQ_HANDLED;
>> +}
> 
>> +static int adc108s102_read_raw(struct iio_dev *indio_dev,
>> +                              struct iio_chan_spec const *chan,
>> +                              int *val, int *val2, long m)
>> +{
> 
>> +       int ret;
>> +       struct adc108s102_state *st;
> 
> Reversed tree order.
> 
>> +
>> +       st = iio_priv(indio_dev);
>> +
> 
> Assign it above.
> 
>> +       switch (m) {
>> +       case IIO_CHAN_INFO_RAW:
>> +               ret = iio_device_claim_direct_mode(indio_dev);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = adc108s102_scan_direct(st, chan->address);
>> +
>> +               iio_device_release_direct_mode(indio_dev);
>> +
>> +               if (ret < 0)
>> +                       return ret;
>> +
>> +               *val = ADC108S102_RES_DATA(ret);
>> +
>> +               return IIO_VAL_INT;
>> +       case IIO_CHAN_INFO_SCALE:
>> +               switch (chan->type) {
>> +               case IIO_VOLTAGE:
>> +                       if (st->reg)
>> +                               *val = regulator_get_voltage(st->reg) / 1000;
>> +                       else
>> +                               *val = st->ext_vin_mv;
>> +
>> +                       *val2 = chan->scan_type.realbits;
>> +                       return IIO_VAL_FRACTIONAL_LOG2;
> 
>> +               default:
>> +                       return -EINVAL;
> 
> Switch-case for one case? Are you expecting more in the future?
> Here I have no strong opinion, so, leave what you / maintainers prefer.

I've no expectations on the code as I didn't write it in the first
place. There are both patterns around, but let's got for the more
compact if-else.

> 
>> +               }
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +}
> 
>> +static int adc108s102_probe(struct spi_device *spi)
>> +{
>> +       struct adc108s102_state *st;
>> +       struct iio_dev *indio_dev;
>> +       u32 val;
>> +       int ret;
>> +
>> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +       if (!indio_dev)
>> +               return -ENOMEM;
>> +
>> +       st = iio_priv(indio_dev);
>> +
> 
>> +       ret = device_property_read_u32(&spi->dev, "ext-vin-microvolt", &val);
> 
> Why not to read u16 here?
> 

Can I read a property with arbitrary width? Then this would simplify
things. Or do I have to follow how it was defined in the ACPI or device
tree world?

> 
>> +       if (ret < 0) {
>> +               dev_err(&spi->dev,
>> +                       "Missing ext-vin-microvolt device property\n");
>> +               return -ENODEV;
>> +       }
> 
>> +       st->ext_vin_mv = (u16)val;
> 
> Casting is not needed.

"Yes, I do want to cast this down." It's a recommended style for such
cases. But it will be gone if we can read u16 directly.

> 
>> +
>> +       /* Use regulator, if available. */
>> +       st->reg = devm_regulator_get(&spi->dev, "vref");
> 
> Here is most important concern, how you get this regulator in ACPI
> case in the future? To me it sounds more like
> devm_regulator_get_optional();

Actually, all it takes is CONFIG_REGULATOR=y and an access to
in_voltage*_scale to reveal that the code is already broken today. Will fix.

> 
>> +       if (IS_ERR(st->reg)) {
>> +               dev_err(&spi->dev, "Cannot get 'vref' regulator\n");
>> +               return PTR_ERR(st->reg);
>> +       }
>> +       ret = regulator_enable(st->reg);
>> +       if (ret < 0) {
>> +               dev_err(&spi->dev, "Cannot enable vref regulator\n");
>> +               return ret;
>> +       }
>> +
>> +       spi_set_drvdata(spi, indio_dev);
>> +       st->spi = spi;
>> +
>> +       indio_dev->name = spi->modalias;
>> +       indio_dev->dev.parent = &spi->dev;
>> +       indio_dev->modes = INDIO_DIRECT_MODE;
>> +       indio_dev->channels = adc108s102_channels;
>> +       indio_dev->num_channels = ARRAY_SIZE(adc108s102_channels);
>> +       indio_dev->info = &adc108s102_info;
>> +
>> +       /* Setup default message */
>> +       st->scan_single_xfer.tx_buf = st->tx_buf;
>> +       st->scan_single_xfer.rx_buf = st->rx_buf;
>> +       st->scan_single_xfer.len = 2 * sizeof(st->tx_buf[0]);
>> +
>> +       spi_message_init_with_transfers(&st->scan_single_msg,
>> +                                       &st->scan_single_xfer, 1);
>> +
> 
>> +       ret = iio_triggered_buffer_setup(indio_dev, NULL,
>> +                       &adc108s102_trigger_handler, NULL);
>> +       if (ret)
>> +               goto error_disable_reg;
>> +
>> +       ret = iio_device_register(indio_dev);
> 
> I suppose some of above is already under devres API (implicitly when
> devm_iio_..._alloc() is in use)

Indeed, there are devm variants for both functions.

> 
> 
>> +       if (ret) {
>> +               dev_err(&spi->dev, "Failed to register IIO device\n");
>> +               goto error_cleanup_ring;
>> +       }
>> +       return 0;
> 
>> +
>> +error_cleanup_ring:
>> +       iio_triggered_buffer_cleanup(indio_dev);
> 
> Do you need it when devm_ used?
> 
>> +error_disable_reg:
>> +       regulator_disable(st->reg);
> 
> Ditto.

I do not find traces that devm-created regulators are auto-disabled. So
this remains necessary.

> 
>> +
>> +       return ret;
>> +}
>> +
>> +static int adc108s102_remove(struct spi_device *spi)
>> +{
>> +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
>> +       struct adc108s102_state *st = iio_priv(indio_dev);
>> +
> 
>> +       iio_device_unregister(indio_dev);
>> +       iio_triggered_buffer_cleanup(indio_dev);
>> +
>> +       regulator_disable(st->reg);
> 
> Ditto.
> 
>> +
>> +       return 0;
>> +}
>> +
> 
>> +static struct spi_driver adc108s102_driver = {
>> +       .driver = {
>> +               .name   = "adc108s102",
> 
>> +               .owner  = THIS_MODULE,
> 
> This is redundant I'm pretty sure.

Even in 2017, drivers keep being added that carry such assignments. Can
you explain when it is needed and when not? Otherwise, I will leave it in.

> 
>> +               .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
>> +       },
>> +       .probe          = adc108s102_probe,
>> +       .remove         = adc108s102_remove,
>> +       .id_table       = adc108s102_id,
>> +};
> 

The rest makes sense.

Thanks,
Jan
