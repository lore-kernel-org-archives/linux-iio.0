Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0110.outbound.protection.outlook.com ([104.47.34.110]:24217
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750855AbdISGY4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Sep 2017 02:24:56 -0400
From: Ismail Kose <Ismail.Kose@maximintegrated.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: "ihkose@gmail.com" <ihkose@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Peter Rosin <peda@axentia.se>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] iio: dac: ds4422/ds4424 dac driver
Date: Tue, 19 Sep 2017 06:24:52 +0000
Message-ID: <DM5PR11MB18650DDCB6E1D4D2EA0C327AFD600@DM5PR11MB1865.namprd11.prod.outlook.com>
References: <20170623230404.2283-1-Ismail.Kose@maximintegrated.com>
 <20170918221029.3610-1-Ismail.Kose@maximintegrated.com>
 <alpine.DEB.2.20.1709190640130.27278@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.20.1709190640130.27278@vps.pmeerw.net>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

You can find my reply to one of your comments below.=20

> -----Original Message-----
> From: Peter Meerwald-Stadler [mailto:pmeerw@pmeerw.net]
> Sent: Monday, September 18, 2017 9:49 PM
> To: Ismail Kose <Ismail.Kose@maximintegrated.com>
> Cc: ihkose@gmail.com; Jonathan Cameron <jic23@kernel.org>; Hartmut
> Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Rob
> Herring <robh+dt@kernel.org>; Mark Rutland <mark.rutland@arm.com>;
> Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>; Mike
> Looijmans <mike.looijmans@topic.nl>; Peter Rosin <peda@axentia.se>;
> Fabrice Gasnier <fabrice.gasnier@st.com>; Jean-Francois Dagenais
> <jeff.dagenais@gmail.com>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] iio: dac: ds4422/ds4424 dac driver
>=20
> EXTERNAL EMAIL
>=20
>=20
>=20
> > This patch provides an iio device driver for DS4422/DS4424 chips that
> > support two/four channel 7-bit Sink/Source Current DAC.
>=20
> some more minor comments below
>=20
> > Signed-off-by: Ismail Kose <Ismail.Kose@maximintegrated.com>
> > ---
> > v3:
> >       * Removed iio-map and platform file support
> >       * Removed ds4424.h file
> >       * Fixed ADC value read bug
> >       * Removed confused comments
> >       * Added device tree binding file
> >       * Fixed bugs in probe and read function
> >
> > v2:
> (https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkml.
> org%2Flkml%2F2017%2F9%2F14%2F546&data=3D01%7C01%7CIsmail.Kose%40
> maximintegrated.com%7C1bb4c28e4d3642f3ccc508d4ff19aecb%7Cfbd909dfe
> a694788a554f24b7854ad03%7C0&sdata=3DICps6DntgtUajBSjXi%2BH4oM1iFq3ia
> Wdq9aubdpU2wI%3D&reserved=3D0)
> >       * Fixed coding style and removed unncessary code
> >       * Removed min/max rfs, ifs-scale, etc values from device tree
> >       * Removed unused code, definitions and some comments
> >       * Removed regulator control and made standard structure
> >       * Removed data processing and channel scale
> >       * Removed device tree binding file
> >
> >  .../devicetree/bindings/iio/dac/ds4424.txt         |  20 ++
> >  drivers/iio/dac/Kconfig                            |   9 +
> >  drivers/iio/dac/Makefile                           |   1 +
> >  drivers/iio/dac/ds4424.c                           | 399 +++++++++++++=
++++++++
> >  4 files changed, 429 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/iio/dac/ds4424.txt
> >  create mode 100644 drivers/iio/dac/ds4424.c
> >
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> > b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> > new file mode 100644
> > index 000000000000..840b11e1d813
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/ds4424.txt
> > @@ -0,0 +1,20 @@
> > +Maxim Integrated DS4422/DS4424 7-bit Sink/Source Current DAC Device
> > +Driver
> > +
> > +Datasheet publicly available at:
> >
> +https://na01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdata
> > +sheets.maximintegrated.com%2Fen%2Fds%2FDS4422-
> DS4424.pdf&data=3D01%7C01
> >
> +%7CIsmail.Kose%40maximintegrated.com%7C1bb4c28e4d3642f3ccc508d4ff
> 19ae
> >
> +cb%7Cfbd909dfea694788a554f24b7854ad03%7C0&sdata=3DQhkGknhcRzCmek
> %2B4Vul
> > +6gCOO8QVNMWSAzz71tP5boTc%3D&reserved=3D0
> > +
> > +Required properties:
> > +     - compatible: Must be "maxim,ds4422" or "maxim,ds4424"
> > +     - reg: Should contain the DAC I2C address
> > +     - maxim,rfs-resistors-ohms: Should contain reference resistor
> > +
> > +Optional properties:
> > +     - vcc-supply: Power supply is optional. If not defined, driver wi=
ll ignore
> it.
> > +
> > +Example:
> > +     ds4224@10 {
> > +             compatible =3D "maxim,ds4424";
> > +             reg =3D <0x10>; /* When A0, A1 pins are ground */
> > +             vcc-supply =3D "dac_vcc_3v3";
> > +             maxim,rfs-resistors-ohms =3D <400 800 1000 1600>;
> > +     };
> > diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig index
> > 25bed2d7d2b9..db6ceba1c76f 100644
> > --- a/drivers/iio/dac/Kconfig
> > +++ b/drivers/iio/dac/Kconfig
> > @@ -310,4 +310,13 @@ config VF610_DAC
> >         This driver can also be built as a module. If so, the module wi=
ll
> >         be called vf610_dac.
> >
> > +config DS4424
> > +     tristate "Maxim Integrated DS4422/DS4424 DAC driver"
> > +     depends on I2C
> > +     help
> > +       If you say yes here you get support for Maxim chips DS4422, DS4=
424.
> > +
> > +       This driver can also be built as a module.  If so, the module
> > +       will be called ds4424.
>=20
> alphabetic order please
>=20
>  +
> >  endmenu
> > diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile index
> > 603587cc2f07..f29f929a0587 100644
> > --- a/drivers/iio/dac/Makefile
> > +++ b/drivers/iio/dac/Makefile
> > @@ -33,3 +33,4 @@ obj-$(CONFIG_MCP4922) +=3D mcp4922.o
> >  obj-$(CONFIG_STM32_DAC_CORE) +=3D stm32-dac-core.o
> >  obj-$(CONFIG_STM32_DAC) +=3D stm32-dac.o
> >  obj-$(CONFIG_VF610_DAC) +=3D vf610_dac.o
> > +obj-$(CONFIG_DS4424) +=3D ds4424.o
>=20
> alphabetic order please
>=20
> > diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c new
> > file mode 100644 index 000000000000..46ae28081cf0
> > --- /dev/null
> > +++ b/drivers/iio/dac/ds4424.c
> > @@ -0,0 +1,399 @@
> > +/*
> > + * Maxim Integrated
> > + * 7-bit, Multi-Channel Sink/Source Current DAC Driver
> > + * Copyright (C) 2017 Maxim Integrated
> > + *
> > + * This program is free software; you can redistribute it and/or
> > +modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regulator/consumer.h> #include <linux/err.h> #include
> > +<linux/delay.h> #include <linux/iio/iio.h> #include
> > +<linux/iio/driver.h> #include <linux/iio/machine.h> #include
> > +<linux/iio/consumer.h>
> > +
> > +#define DS4422_MAX_DAC_CHANNELS              2
> > +#define DS4424_MAX_DAC_CHANNELS              4
> > +
> > +#define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
> > +#define DS4424_SOURCE_I              1
> > +#define DS4424_SINK_I                0
> > +
> > +#define DS4424_CHANNEL(chan) { \
> > +     .type =3D IIO_CURRENT, \
> > +     .indexed =3D 1, \
> > +     .output =3D 1, \
> > +     .channel =3D chan, \
> > +     .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
> > +     .address =3D DS4424_DAC_ADDR(chan), \
>=20
> .address is not used
>=20
> > +}
> > +
> > +/*
> > + * DS4424 DAC control register 8 bits
> > + * [7]               0: to sink; 1: to source
> > + * [6:0]     steps to sink/source
> > + * bit[7] looks like a sign bit, but the value of the register is
> > + * not a two's complement code considering the bit[6:0] is a absolute
> > + * distance from the zero point.
> > + */
> > +union ds4424_raw_data {
> > +     struct {
> > +             u8 dx:7;
> > +             u8 source_bit:1;
> > +     };
> > +     u8 bits;
> > +};
> > +
> > +enum ds4424_device_ids {
> > +     ID_DS4422,
> > +     ID_DS4424,
> > +};
> > +
> > +struct ds4424_data {
> > +     struct i2c_client *client;
> > +     struct mutex lock;
> > +     __maybe_unused uint16_t save[DS4424_MAX_DAC_CHANNELS];
>=20
> save should ba uint8_t as well (to match raw)
>=20
> > +     uint32_t rfs_res[DS4424_MAX_DAC_CHANNELS];
> > +     struct regulator *vcc_reg;
> > +     uint8_t raw[DS4424_MAX_DAC_CHANNELS]; };
> > +
> > +static const struct iio_chan_spec ds4424_channels[] =3D {
> > +     DS4424_CHANNEL(0),
> > +     DS4424_CHANNEL(1),
> > +     DS4424_CHANNEL(2),
> > +     DS4424_CHANNEL(3),
> > +};
> > +
> > +static int ds4424_get_value(struct iio_dev *indio_dev,
> > +                          int *val, int channel) {
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D i2c_smbus_read_byte_data(data->client,
> DS4424_DAC_ADDR(channel));
> > +     if (ret < 0)
> > +             goto fail;
> > +
> > +     *val =3D ret;
> > +     mutex_unlock(&data->lock);
> > +     return 0;
> > +
> > +fail:
> > +     mutex_unlock(&data->lock);
> > +     return ret;
> > +}
> > +
> > +static int ds4424_set_value(struct iio_dev *indio_dev,
> > +                          int val, struct iio_chan_spec const *chan)
> > +{
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (val < 0 || val > U8_MAX)
> > +             return -EINVAL;
>=20
> the check here is not necessary, _write_raw() already does the check
>=20
> > +
> > +     mutex_lock(&data->lock);
> > +     ret =3D i2c_smbus_write_byte_data(data->client,
> > +                     DS4424_DAC_ADDR(chan->channel), val);
> > +     if (ret < 0) {
> > +             mutex_unlock(&data->lock);
> > +             return ret;
> > +     }
> > +
> > +     data->raw[chan->channel] =3D val;
> > +     mutex_unlock(&data->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ds4424_read_raw(struct iio_dev *indio_dev,
> > +                        struct iio_chan_spec const *chan,
> > +                        int *val, int *val2, long mask) {
> > +     union ds4424_raw_data raw;
> > +     int ret;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             ret =3D ds4424_get_value(indio_dev, val, chan->channel);
> > +             if (ret < 0) {
> > +                     pr_err("%s : ds4424_get_value returned %d\n",
> > +                                                     __func__, ret);
> > +                     return ret;
> > +             }
> > +             raw.bits =3D *val;
> > +             *val =3D raw.dx;
> > +             if (raw.source_bit =3D=3D DS4424_SINK_I)
> > +                     *val =3D -*val;
> > +             return IIO_VAL_INT;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int ds4424_write_raw(struct iio_dev *indio_dev,
> > +                          struct iio_chan_spec const *chan,
> > +                          int val, int val2, long mask) {
> > +     union ds4424_raw_data raw;
> > +
> > +     if (val2 !=3D 0)
> > +             return -EINVAL;
> > +
> > +     switch (mask) {
> > +     case IIO_CHAN_INFO_RAW:
> > +             if (val < S8_MIN || val > S8_MAX)
>=20
> no, S8_MAX and S8_MIN is 127 and -128, resp.
> -128 is wront, should be -127 I think

-128 is acceptable input for the function.
0 and -128 both will have output current zero.
This should be right.

>=20
>=20
> > +                     return -EINVAL;
> > +
> > +             if (val > 0) {
> > +                     raw.source_bit =3D DS4424_SOURCE_I;
> > +                     raw.dx =3D val;
> > +             } else {
> > +                     raw.source_bit =3D DS4424_SINK_I;
> > +                     raw.dx =3D -val;
> > +             }
> > +
> > +             return ds4424_set_value(indio_dev, raw.bits, chan);
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +}
> > +
> > +static int ds4424_verify_chip(struct iio_dev *indio_dev) {
> > +     int ret =3D 0, val;
>=20
> no need to init ret
>=20
> > +
> > +     ret =3D ds4424_get_value(indio_dev, &val, DS4424_DAC_ADDR(0));
> > +     if (ret < 0)
> > +             dev_err(&indio_dev->dev,
> > +                             "%s failed. ret: %d\n", __func__, ret);
> > +
> > +     return ret;
> > +}
> > +
> > +static int __maybe_unused ds4424_suspend(struct device *dev) {
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < indio_dev->num_channels; i++) {
> > +             data->save[i] =3D data->raw[i];
> > +             ret =3D ds4424_set_value(indio_dev, 0,
> > +                             &indio_dev->channels[i]);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static int __maybe_unused ds4424_resume(struct device *dev) {
> > +     struct i2c_client *client =3D to_i2c_client(dev);
> > +     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < indio_dev->num_channels; i++) {
> > +             ret =3D ds4424_set_value(indio_dev, data->save[i],
> > +                             &indio_dev->channels[i]);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +     return ret;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(ds4424_pm_ops, ds4424_suspend,
> > +ds4424_resume);
> > +
> > +static const struct iio_info ds4424_info =3D {
> > +     .read_raw =3D ds4424_read_raw,
> > +     .write_raw =3D ds4424_write_raw,
> > +};
> > +
> > +#ifdef CONFIG_OF
> > +static int ds4424_parse_dt(struct iio_dev *indio_dev) {
> > +     int ret;
> > +     int len;
> > +     int count;
> > +     struct property *prop;
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +     struct device_node *node =3D indio_dev->dev.of_node;
> > +
> > +     if (!node) {
> > +             pr_info("%s:%d ds4424 DT not found\n", __func__, __LINE__=
);
> > +             return -ENODEV;
> > +     }
> > +
> > +     prop =3D of_find_property(node, "maxim,rfs-resistors-ohms", &len)=
;
> > +     if (!prop) {
> > +             pr_err("ds4424 maxim,rfs-resistor not found in DT.\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (len !=3D (DS4424_MAX_DAC_CHANNELS * sizeof(uint32_t))) {
> > +             pr_err("ds4424 maxim,rfs-resistor length in DT not valid.=
\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     ret =3D of_property_read_u32_array(node, "maxim,rfs-resistors-ohm=
s",
> > +                              data->rfs_res, DS4424_MAX_DAC_CHANNELS);
> > +     if (ret < 0) {
> > +             pr_err("ds4424 reading maxim,rfs-resistors from DT failed=
.\n");
> > +             return ret;
> > +     }
> > +
> > +     pr_info("ds4424 maxim,rfs-resistors: %d, %d, %d, %d\n",
> > +                     data->rfs_res[0], data->rfs_res[1],
> > +                     data->rfs_res[2], data->rfs_res[3]);
> > +
> > +     return 0;
> > +}
> > +#else
> > +static int ds4424_parse_dt(struct iio_dev *indio_dev) {
> > +     return -ENODEV;
> > +}
> > +#endif
> > +
> > +static int ds4424_probe(struct i2c_client *client,
> > +                     const struct i2c_device_id *id) {
> > +     struct ds4424_data *data;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +     if (!indio_dev) {
> > +             dev_err(&client->dev, "iio dev alloc failed.\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     data =3D iio_priv(indio_dev);
> > +     i2c_set_clientdata(client, indio_dev);
> > +     data->client =3D client;
> > +     indio_dev->name =3D id->name;
> > +     indio_dev->dev.of_node =3D client->dev.of_node;
> > +     indio_dev->dev.parent =3D &client->dev;
> > +
> > +     if (!client->dev.of_node) {
> > +             dev_err(&client->dev,
> > +                             "Not found DT.\n");
> > +             return -EPERM;
> > +     }
> > +
> > +     indio_dev->dev.of_node =3D client->dev.of_node;
> > +     ret =3D ds4424_parse_dt(indio_dev);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev,
> > +                             "%s - of_node error\n", __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     data->vcc_reg =3D devm_regulator_get(&client->dev, "vcc");
> > +     if (IS_ERR(data->vcc_reg)) {
> > +             ret =3D PTR_ERR(data->vcc_reg);
> > +             dev_err(&client->dev,
> > +                     "Failed to get vcc-supply regulator: %d\n", ret);
> > +             return ret;
> > +     }
> > +
> > +     mutex_init(&data->lock);
> > +     ret =3D regulator_enable(data->vcc_reg);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev,
> > +                             "Unable to enable the regulator.\n");
> > +             return ret;
> > +     }
> > +
> > +     usleep_range(1000, 1200);
> > +     ret =3D ds4424_verify_chip(indio_dev);
> > +     if (ret < 0)
> > +             return -ENXIO;
> > +
> > +     switch (id->driver_data) {
> > +     case ID_DS4422:
> > +             indio_dev->num_channels =3D DS4422_MAX_DAC_CHANNELS;
> > +             break;
> > +     case ID_DS4424:
> > +             indio_dev->num_channels =3D DS4424_MAX_DAC_CHANNELS;
> > +             break;
> > +     default:
> > +             dev_err(&client->dev,
> > +                             "ds4424: Invalid chip id.\n");
> > +             regulator_disable(data->vcc_reg);
> > +             return -ENXIO;
> > +     }
> > +
> > +     indio_dev->channels =3D ds4424_channels;
> > +     indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     indio_dev->info =3D &ds4424_info;
> > +
> > +     ret =3D iio_device_register(indio_dev);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev,
> > +                             "iio_device_register failed. ret: %d\n", =
ret);
> > +             regulator_disable(data->vcc_reg);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +static int ds4424_remove(struct i2c_client *client) {
> > +     struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +     struct ds4424_data *data =3D iio_priv(indio_dev);
> > +
> > +     iio_device_unregister(indio_dev);
> > +     regulator_disable(data->vcc_reg);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id ds4424_id[] =3D {
> > +     { "ds4422", ID_DS4422 },
> > +     { "ds4424", ID_DS4424 },
> > +     { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, ds4424_id);
> > +
> > +static const struct of_device_id ds4424_of_match[] =3D {
> > +     { .compatible =3D "maxim,ds4422" },
> > +     { .compatible =3D "maxim,ds4424" },
> > +     { },
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, ds4424_of_match);
> > +
> > +static struct i2c_driver ds4424_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "ds4424",
> > +             .of_match_table =3D ds4424_of_match,
> > +             .pm     =3D &ds4424_pm_ops,
> > +     },
> > +     .probe          =3D ds4424_probe,
> > +     .remove         =3D ds4424_remove,
> > +     .id_table       =3D ds4424_id,
> > +};
> > +module_i2c_driver(ds4424_driver);
> > +
> > +MODULE_DESCRIPTION("Maxim DS4424 DAC Driver");
> MODULE_AUTHOR("Ismail
> > +H. Kose <ismail.kose@maximintegrated.com>");
> > +MODULE_AUTHOR("Vishal Sood <vishal.sood@maximintegrated.com>");
> > +MODULE_AUTHOR("David Jung <david.jung@maximintegrated.com>");
> > +MODULE_LICENSE("GPL v2");
> >
>=20
> --
>=20
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418
