Return-Path: <SRS0=T9as=4I=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
References: <c0fa84e3-1016-212f-280c-40bb83706895@siemens.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 May 2017 23:53:39 +0300
Message-ID: <CAHp75VcG4qQktEOCXKc2saTNzpWo2sjneA4Afb7rHoEqkP8FtQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: Add support for TI ADC1x8s102
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sascha Weisenberger <sascha.weisenberger@siemens.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, May 2, 2017 at 11:02 PM, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> This is an upstream port of an IIO driver for the TI ADC108S102 and
> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
> included.
>
> Original author: Bogdan Pricop <bogdan.pricop@emutex.com>
> Ported from Intel Galileo Gen2 BSP to Intel Yocto kernel:
> Todor Minchev <todor@minchev.co.uk>.

There are several nitpicks, and one concern about regulator.
After addressing at least the latter

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> +#include <linux/acpi.h>

> +#include <linux/gpio.h>

Redundant I beleive.

> +static int adc108s102_update_scan_mode(struct iio_dev *indio_dev,
> +               unsigned long const *active_scan_mask)
> +{
> +       struct adc108s102_state *st;
> +       unsigned int bit, cmds;

> +
> +       st = iio_priv(indio_dev);
> +

I think it's a quite good pattern to assign such variables above at
definition block.
This also would be done in several functions below (except ->probe() call)

> +       /*
> +        * Fill in the first x shorts of tx_buf with the number of channels
> +        * enabled for sampling by the triggered buffer
> +        */

Usually in multiline comments even for one sentence we use period at the end.

> +       cmds = 0;
> +       for_each_set_bit(bit, active_scan_mask, ADC108S102_MAX_CHANNELS)
> +               st->tx_buf[cmds++] = cpu_to_be16(ADC108S102_CMD(bit));
> +
> +       /* One dummy command added, to clock in the last response */
> +       st->tx_buf[cmds++] = 0x00;
> +
> +       /* build SPI ring message */

> +       st->ring_xfer.tx_buf = &st->tx_buf[0];
> +       st->ring_xfer.rx_buf = &st->rx_buf[0];

&pointer[0] -> pointer

> +       st->ring_xfer.len = cmds * sizeof(st->tx_buf[0]);
> +
> +       spi_message_init_with_transfers(&st->ring_msg, &st->ring_xfer, 1);
> +
> +       return 0;
> +}
> +
> +static irqreturn_t adc108s102_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev;
> +       struct adc108s102_state *st;
> +       int ret;
> +

> +       indio_dev = pf->indio_dev;
> +       st = iio_priv(indio_dev);

Assign them above.

> +out:

I would name it out_notify.

> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}

> +static int adc108s102_read_raw(struct iio_dev *indio_dev,
> +                              struct iio_chan_spec const *chan,
> +                              int *val, int *val2, long m)
> +{

> +       int ret;
> +       struct adc108s102_state *st;

Reversed tree order.

> +
> +       st = iio_priv(indio_dev);
> +

Assign it above.

> +       switch (m) {
> +       case IIO_CHAN_INFO_RAW:
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +
> +               ret = adc108s102_scan_direct(st, chan->address);
> +
> +               iio_device_release_direct_mode(indio_dev);
> +
> +               if (ret < 0)
> +                       return ret;
> +
> +               *val = ADC108S102_RES_DATA(ret);
> +
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               switch (chan->type) {
> +               case IIO_VOLTAGE:
> +                       if (st->reg)
> +                               *val = regulator_get_voltage(st->reg) / 1000;
> +                       else
> +                               *val = st->ext_vin_mv;
> +
> +                       *val2 = chan->scan_type.realbits;
> +                       return IIO_VAL_FRACTIONAL_LOG2;

> +               default:
> +                       return -EINVAL;

Switch-case for one case? Are you expecting more in the future?
Here I have no strong opinion, so, leave what you / maintainers prefer.

> +               }
> +       default:
> +               return -EINVAL;
> +       }
> +}

> +static int adc108s102_probe(struct spi_device *spi)
> +{
> +       struct adc108s102_state *st;
> +       struct iio_dev *indio_dev;
> +       u32 val;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       st = iio_priv(indio_dev);
> +

> +       ret = device_property_read_u32(&spi->dev, "ext-vin-microvolt", &val);

Why not to read u16 here?


> +       if (ret < 0) {
> +               dev_err(&spi->dev,
> +                       "Missing ext-vin-microvolt device property\n");
> +               return -ENODEV;
> +       }

> +       st->ext_vin_mv = (u16)val;

Casting is not needed.

> +
> +       /* Use regulator, if available. */
> +       st->reg = devm_regulator_get(&spi->dev, "vref");

Here is most important concern, how you get this regulator in ACPI
case in the future? To me it sounds more like
devm_regulator_get_optional();

> +       if (IS_ERR(st->reg)) {
> +               dev_err(&spi->dev, "Cannot get 'vref' regulator\n");
> +               return PTR_ERR(st->reg);
> +       }
> +       ret = regulator_enable(st->reg);
> +       if (ret < 0) {
> +               dev_err(&spi->dev, "Cannot enable vref regulator\n");
> +               return ret;
> +       }
> +
> +       spi_set_drvdata(spi, indio_dev);
> +       st->spi = spi;
> +
> +       indio_dev->name = spi->modalias;
> +       indio_dev->dev.parent = &spi->dev;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->channels = adc108s102_channels;
> +       indio_dev->num_channels = ARRAY_SIZE(adc108s102_channels);
> +       indio_dev->info = &adc108s102_info;
> +
> +       /* Setup default message */
> +       st->scan_single_xfer.tx_buf = st->tx_buf;
> +       st->scan_single_xfer.rx_buf = st->rx_buf;
> +       st->scan_single_xfer.len = 2 * sizeof(st->tx_buf[0]);
> +
> +       spi_message_init_with_transfers(&st->scan_single_msg,
> +                                       &st->scan_single_xfer, 1);
> +

> +       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +                       &adc108s102_trigger_handler, NULL);
> +       if (ret)
> +               goto error_disable_reg;
> +
> +       ret = iio_device_register(indio_dev);

I suppose some of above is already under devres API (implicitly when
devm_iio_..._alloc() is in use)


> +       if (ret) {
> +               dev_err(&spi->dev, "Failed to register IIO device\n");
> +               goto error_cleanup_ring;
> +       }
> +       return 0;

> +
> +error_cleanup_ring:
> +       iio_triggered_buffer_cleanup(indio_dev);

Do you need it when devm_ used?

> +error_disable_reg:
> +       regulator_disable(st->reg);

Ditto.

> +
> +       return ret;
> +}
> +
> +static int adc108s102_remove(struct spi_device *spi)
> +{
> +       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +       struct adc108s102_state *st = iio_priv(indio_dev);
> +

> +       iio_device_unregister(indio_dev);
> +       iio_triggered_buffer_cleanup(indio_dev);
> +
> +       regulator_disable(st->reg);

Ditto.

> +
> +       return 0;
> +}
> +

> +static struct spi_driver adc108s102_driver = {
> +       .driver = {
> +               .name   = "adc108s102",

> +               .owner  = THIS_MODULE,

This is redundant I'm pretty sure.

> +               .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
> +       },
> +       .probe          = adc108s102_probe,
> +       .remove         = adc108s102_remove,
> +       .id_table       = adc108s102_id,
> +};

-- 
With Best Regards,
Andy Shevchenko
