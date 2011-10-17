Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 17 Oct 2011 15:12:59 +0100
Subject: RE: [PATCH v2] staging:iio:dac: Add AD5360 driver
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7566E4D@LIMKCMBX1.ad.analog.com>
References: <1318850387-26268-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1318850387-26268-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen wrote on 2011-10-17:
> This patch adds support for the Analog Devices AD5360, AD5361, AD5362,
> AD5363, AD5370, AD5371, AD5372, AD5373 multi-channel digital-to-analog
> converters.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Looks good!
Acked-by: Michael Hennerich <michael.hennerich@analog.com>

>
> ---
> Changes since v1:
>       * Minor code cleanups
>       * List full part names in Kconfig
> ---
>  drivers/staging/iio/dac/Kconfig  |   11 +
>  drivers/staging/iio/dac/Makefile |    1 +
>  drivers/staging/iio/dac/ad5360.c |  580
>  ++++++++++++++++++++++++++++++++++++++ 3 files changed, 592
>  insertions(+), 0 deletions(-) create mode 100644
>  drivers/staging/iio/dac/ad5360.c
> diff --git a/drivers/staging/iio/dac/Kconfig
> b/drivers/staging/iio/dac/Kconfig index 3000156..9211a39 100644 ---
> a/drivers/staging/iio/dac/Kconfig +++ b/drivers/staging/iio/dac/Kconfig
> @@ -3,6 +3,17 @@
>  #
>  menu "Digital to analog convertors"
> +config AD5360 +      tristate "Analog Devices Analog Devices
> AD5360/61/62/63/70/71/73 DAC driver" +        depends on SPI +        hel=
p +    Say yes
> here to build support for Analog Devices AD5360, AD5361, +      AD5362,
> AD5363, AD5370, AD5371, AD5373 multi-channel +          Digital to Analog
> Converters (DAC). + +   To compile this driver as module choose M here:
> the module will be called +     ad5360. +
>  config AD5624R_SPI
>       tristate "Analog Devices AD5624/44/64R DAC spi driver"
>       depends on SPI
> diff --git a/drivers/staging/iio/dac/Makefile
> b/drivers/staging/iio/dac/Makefile index 7f4f2ed..e0a8c97 100644 ---
> a/drivers/staging/iio/dac/Makefile +++
> b/drivers/staging/iio/dac/Makefile @@ -2,6 +2,7 @@
>  # Makefile for industrial I/O DAC drivers
>  #
> +obj-$(CONFIG_AD5360) +=3D ad5360.o
>  obj-$(CONFIG_AD5624R_SPI) +=3D ad5624r_spi.o
>  obj-$(CONFIG_AD5504) +=3D ad5504.o
>  obj-$(CONFIG_AD5446) +=3D ad5446.o
> diff --git a/drivers/staging/iio/dac/ad5360.c
> b/drivers/staging/iio/dac/ad5360.c new file mode 100644 index
> 0000000..fdbfb48 --- /dev/null +++ b/drivers/staging/iio/dac/ad5360.c @@
> -0,0 +1,580 @@ +/* + * Analog devices AD5360, AD5361, AD5362, AD5363,
> AD5370, AD5371, AD5373 + * multi-channel Digital to Analog Converters
> driver + * + * Copyright 2011 Analog Devices Inc. + * + * Licensed under
> the GPL-2. + */ + +#include <linux/device.h> +#include <linux/err.h>
> +#include <linux/module.h> +#include <linux/kernel.h> +#include
> <linux/spi/spi.h> +#include <linux/slab.h> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h> + +#include "../iio.h" +#include
> "../sysfs.h" +#include "dac.h" + +#define AD5360_CMD(x)                  =
             ((x) << 22)
> +#define AD5360_ADDR(x)                               ((x) << 16) + +#def=
ine
> AD5360_READBACK_TYPE(x)                       ((x) << 13) +#define
> AD5360_READBACK_ADDR(x)                       ((x) << 7) + +#define
> AD5360_CHAN_ADDR(chan)                        ((chan) + 0x8) + +#define
> AD5360_CMD_WRITE_DATA                 0x3 +#define AD5360_CMD_WRITE_OFFSE=
T                    0x2
> +#define AD5360_CMD_WRITE_GAIN                        0x1 +#define
> AD5360_CMD_SPECIAL_FUNCTION           0x0 + +/* Special function register
> addresses */ +#define AD5360_REG_SF_NOP                       0x0 +#defin=
e
> AD5360_REG_SF_CTRL                    0x1 +#define AD5360_REG_SF_OFS(x)  =
                     (0x2 + (x))
> +#define AD5360_REG_SF_READBACK                       0x5 + +#define
> AD5360_SF_CTRL_PWR_DOWN                       BIT(0) + +#define AD5360_RE=
ADBACK_X1A                   0x0
> +#define AD5360_READBACK_X1B                  0x1 +#define AD5360_READBAC=
K_OFFSET                     0x2
> +#define AD5360_READBACK_GAIN                 0x3 +#define AD5360_READBAC=
K_SF                 0x4 +
> + +/** + * struct ad5360_chip_info - chip specific information + *
> @channel_template:    channel specification template + *
> @num_channels:        number of channels + * @channels_per_group:     num=
ber of
> channels per group + * @num_vrefs:            number of vref supplies for=
 the chip
> +*/ + +struct ad5360_chip_info { +    struct
> iio_chan_spec channel_template; +     unsigned int            num_channel=
s; + unsigned
> int           channels_per_group; +   unsigned int            num_vrefs; =
+}; + +/** + *
> struct ad5360_state - driver instance specific data + *
> @spi:         spi_device + * @chip_info:              chip model specific=
 constants,
> available modes etc + * @vref_reg:            vref supply regulators + *
> @ctrl:                control register cache + * @data:               spi=
 transfer buffers + */ +
> +struct ad5360_state { +      struct spi_device               *spi; + con=
st struct
> ad5360_chip_info      *chip_info; +   struct regulator_bulk_data      vre=
f_reg[3];
> +     unsigned int                    ctrl; + +       /* +     * DMA (thu=
s cache coherency
> maintenance) requires the +    * transfer buffers to live in their own
> cache lines. +         */ +   union { +               __be32 d32; +      =
     u8 d8[4]; +     } data[2]
> ____cacheline_aligned; +}; + +enum ad5360_type { +    ID_AD5360,
> +     ID_AD5361, +    ID_AD5362, +    ID_AD5363, +    ID_AD5370, +    ID_=
AD5371,
> +     ID_AD5372, +    ID_AD5373, +}; + +#define AD5360_CHANNEL(bits) {   =
                                     \
> +     .type =3D IIO_VOLTAGE,                                    \ +     .=
indexed =3D 1,                                           \ +     .output =
=3D
> 1,                                            \ +     .info_mask =3D (1 <=
< IIO_CHAN_INFO_SCALE_SEPARATE) |      \ +             (1
> << IIO_CHAN_INFO_OFFSET_SEPARATE) |           \ +             (1 <<
> IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |  \ +             (1 <<
> IIO_CHAN_INFO_CALIBBIAS_SEPARATE),    \ +     .scan_type =3D IIO_ST('u', =
(bits),
> 16, 16 - (bits))      \ +} + +static const struct ad5360_chip_info
> ad5360_chip_info_tbl[] =3D { +  [ID_AD5360] =3D { +               .channe=
l_template =3D
> AD5360_CHANNEL(16), +         .num_channels =3D 16, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5361] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(14), +         .num_channels =3D 16, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5362] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(16), +         .num_channels =3D 8, +            .channels=
_per_group =3D 4,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5363] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(14), +         .num_channels =3D 8, +            .channels=
_per_group =3D 4,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5370] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(16), +         .num_channels =3D 40, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5371] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(14), +         .num_channels =3D 40, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 3, +       }, +    [ID_AD5372] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(16), +         .num_channels =3D 32, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 2, +       }, +    [ID_AD5373] =3D { +      =
         .channel_template =3D
> AD5360_CHANNEL(14), +         .num_channels =3D 32, +           .channels=
_per_group =3D 8,
> +             .num_vrefs =3D 2, +       }, +}; + +static unsigned int
> ad5360_get_channel_vref_index(struct ad5360_state *st, +      unsigned in=
t
> channel) +{ + unsigned int i; + +     /* The first groups have their own
> vref, while the remaining groups +     * share the last vref */ +     i =
=3D
> channel / st->chip_info->channels_per_group; +        if (i >=3D
> st->chip_info->num_vrefs) +           i =3D st->chip_info->num_vrefs - 1;=
 +
> +     return i; +} + +static int ad5360_get_channel_vref(struct ad5360_st=
ate
> *st, +        unsigned int channel) +{ +      unsigned int i =3D
> ad5360_get_channel_vref_index(st, channel); + +       return
> regulator_get_voltage(st->vref_reg[i].consumer); +} + + +static int
> ad5360_write_unlocked(struct iio_dev *indio_dev, +    unsigned int cmd,
> unsigned int addr, unsigned int val, +        unsigned int shift) +{ +   =
     struct
> ad5360_state *st =3D iio_priv(indio_dev); + +   val <<=3D shift; +       =
 val |=3D
> AD5360_CMD(cmd) | AD5360_ADDR(addr); +        st->data[0].d32 =3D
> cpu_to_be32(val); + + return spi_write(st->spi, &st->data[0].d8[1], 3);
> +} + +static int ad5360_write(struct iio_dev *indio_dev, unsigned int
> cmd, +        unsigned int addr, unsigned int val, unsigned int shift) +{=
 +   int
> ret; + +      mutex_lock(&indio_dev->mlock); +        ret =3D
> ad5360_write_unlocked(indio_dev, cmd, addr, val, shift);
> +     mutex_unlock(&indio_dev->mlock); + +    return ret; +} + +static in=
t
> ad5360_read(struct iio_dev *indio_dev, unsigned int type, +   unsigned in=
t
> addr) +{ +    struct ad5360_state *st =3D iio_priv(indio_dev); +        s=
truct
> spi_message m; +      int ret; +      struct spi_transfer t[] =3D { +    =
       { +                     .tx_buf
> =3D &st->data[0].d8[1], +                       .len =3D 3, +            =
         .cs_change =3D 1, +               }, {
> +                     .rx_buf =3D &st->data[1].d8[1], +                 .=
len =3D 3, +             }, +    }; +
> +     spi_message_init(&m); + spi_message_add_tail(&t[0], &m);
> +     spi_message_add_tail(&t[1], &m); + +    mutex_lock(&indio_dev->mloc=
k); +
> +     st->data[0].d32 =3D cpu_to_be32(AD5360_CMD(AD5360_CMD_SPECIAL_FUNCT=
ION)
> | +           AD5360_ADDR(AD5360_REG_SF_READBACK) | +         AD5360_READ=
BACK_TYPE(type)
> | +           AD5360_READBACK_ADDR(addr)); + +        ret =3D spi_sync(st=
->spi, &m); +  if
> (ret >=3D 0) +          ret =3D be32_to_cpu(st->data[1].d32) & 0xffff; +
> +     mutex_unlock(&indio_dev->mlock); + +    return ret; +} + +static ss=
ize_t
> ad5360_read_dac_powerdown(struct device *dev, +                          =
                struct
> device_attribute *attr, +                                        char *bu=
f) +{ +      struct iio_dev
> *indio_dev =3D dev_get_drvdata(dev); +  struct ad5360_state *st =3D
> iio_priv(indio_dev); + +      return sprintf(buf, "%d\n", (bool)(st->ctrl=
 &
> AD5360_SF_CTRL_PWR_DOWN)); +} + +static int ad5360_update_ctrl(struct
> iio_dev *indio_dev, unsigned int set, +       unsigned int clr) +{ +  str=
uct
> ad5360_state *st =3D iio_priv(indio_dev); +     unsigned int ret; +
> +     mutex_lock(&indio_dev->mlock); + +      st->ctrl |=3D set; +      s=
t->ctrl &=3D
> ~clr; + +     ret =3D ad5360_write_unlocked(indio_dev,
> AD5360_CMD_SPECIAL_FUNCTION, +                        AD5360_REG_SF_CTRL,=
 st->ctrl, 0); +
> +     mutex_unlock(&indio_dev->mlock); + +    return ret; +} + +static ss=
ize_t
> ad5360_write_dac_powerdown(struct device *dev, +      struct device_attri=
bute
> *attr, const char *buf, size_t len) +{ +      struct iio_dev *indio_dev =
=3D
> dev_get_drvdata(dev); +       bool pwr_down; +        int ret; + +    ret=
 =3D
> strtobool(buf, &pwr_down); +  if (ret) +              return ret; + + if =
(pwr_down)
> +             ret =3D ad5360_update_ctrl(indio_dev, AD5360_SF_CTRL_PWR_DO=
WN, 0);
> +     else +          ret =3D ad5360_update_ctrl(indio_dev, 0,
> AD5360_SF_CTRL_PWR_DOWN); + + return ret ? ret : len; +} + +static
> IIO_DEVICE_ATTR(out_voltage_powerdown, +                      S_IRUGO | S=
_IWUSR,
> +                     ad5360_read_dac_powerdown, +                    ad5=
360_write_dac_powerdown, 0); +
> +static struct attribute *ad5360_attributes[] =3D {
> +     &iio_dev_attr_out_voltage_powerdown.dev_attr.attr, +    NULL, +}; +
> +static const struct attribute_group ad5360_attribute_group =3D { +     .=
attrs
> =3D ad5360_attributes, +}; + +static int ad5360_write_raw(struct iio_dev
> *indio_dev, +                        struct iio_chan_spec const *chan, + =
                            int
> val, +                               int val2, +                         =
    long mask) +{ +  struct ad5360_state
> *st =3D iio_priv(indio_dev); +  int max_val =3D (1 <<
> chan->scan_type.realbits); +  unsigned int ofs_index; + +     switch (mas=
k) {
> +     case 0: +               if (val >=3D max_val || val < 0) +         =
               return -EINVAL; +
> +             return ad5360_write(indio_dev, AD5360_CMD_WRITE_DATA, +
> chan->address, val, +                          chan->scan_type.shift); + =
     case (1 <<
> IIO_CHAN_INFO_CALIBBIAS_SEPARATE): +          if (val >=3D max_val || val=
 < 0)
> +                     return -EINVAL; + +             return ad5360_write=
(indio_dev,
> AD5360_CMD_WRITE_OFFSET, +                             chan->address, val=
, +
> chan->scan_type.shift); +     case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARAT=
E):
> +             if (val >=3D max_val || val < 0) +                        r=
eturn -EINVAL; + +             return
> ad5360_write(indio_dev, AD5360_CMD_WRITE_GAIN, +                         =
      chan->address, val,
> +                              chan->scan_type.shift); +      case (1 <<
> IIO_CHAN_INFO_OFFSET_SEPARATE): +             if (val <=3D -max_val || va=
l > 0)
> +                     return -EINVAL; + +             val =3D -val; + +  =
       /* offset is supposed to have
> the same scale as raw, but it +                * is always 14bits wide, s=
o on a chip
> where the raw value has +              * more bits, we need to shift offs=
et. */
> +             val >>=3D (chan->scan_type.realbits - 14); + +            /=
* There is one DAC
> offset register per vref. Changing one +               * channels offset =
will also
> change the offset for all other +              * channels which share the=
 same vref
> supply. */ +          ofs_index =3D ad5360_get_channel_vref_index(st, cha=
n-
>> channel);
> +             return ad5360_write(indio_dev, AD5360_CMD_SPECIAL_FUNCTION,=
 +
> AD5360_REG_SF_OFS(ofs_index), val, 0); +      default: +              bre=
ak; +        } +
> +     return -EINVAL; +} + +static int ad5360_read_raw(struct iio_dev
> *indio_dev, +                    struct iio_chan_spec const *chan, +     =
                int *val,
> +                        int *val2, +                    long m) +{ + str=
uct ad5360_state *st =3D
> iio_priv(indio_dev); +        unsigned long scale_uv; +       unsigned in=
t ofs_index;
> +     int ret; + +    switch (m) { +  case 0: +               ret =3D ad5=
360_read(indio_dev,
> AD5360_READBACK_X1A, +                        chan->address); +          =
     if (ret < 0) +                  return ret;
> +             *val =3D ret >> chan->scan_type.shift; +          return II=
O_VAL_INT; +   case (1
> << IIO_CHAN_INFO_SCALE_SEPARATE): +           /* vout =3D 4 * vref * dac_=
code */
> +             scale_uv =3D ad5360_get_channel_vref(st, chan->channel) * 4=
 * 100;
> +             if (scale_uv < 0) +                     return scale_uv; + =
+            scale_uv >>=3D
> (chan->scan_type.realbits); +         *val =3D  scale_uv / 100000; +     =
       *val2 =3D
> (scale_uv % 100000) * 10; +           return IIO_VAL_INT_PLUS_MICRO; +   =
     case (1 <<
> IIO_CHAN_INFO_CALIBBIAS_SEPARATE): +          ret =3D ad5360_read(indio_d=
ev,
> AD5360_READBACK_OFFSET, +                     chan->address); +          =
     if (ret < 0) +                  return
> ret; +                *val =3D ret; +           return IIO_VAL_INT; +   c=
ase (1 <<
> IIO_CHAN_INFO_CALIBSCALE_SEPARATE): +         ret =3D ad5360_read(indio_d=
ev,
> AD5360_READBACK_GAIN, +                       chan->address); +          =
     if (ret < 0) +                  return
> ret; +                *val =3D ret; +           return IIO_VAL_INT; +   c=
ase (1 <<
> IIO_CHAN_INFO_OFFSET_SEPARATE): +             ofs_index =3D
> ad5360_get_channel_vref_index(st, chan-
>> channel);
> +             ret =3D ad5360_read(indio_dev, AD5360_READBACK_SF,
> +                     AD5360_REG_SF_OFS(ofs_index)); +                if =
(ret < 0) +                  return ret; +
> +             ret <<=3D (chan->scan_type.realbits - 14); +              *=
val =3D -ret; +          return
> IIO_VAL_INT; +        } + +   return -EINVAL; +} + +static const struct i=
io_info
> ad5360_info =3D { +     .read_raw =3D ad5360_read_raw, +  .write_raw =3D
> ad5360_write_raw, +   .attrs =3D &ad5360_attribute_group, +     .driver_m=
odule =3D
> THIS_MODULE, +}; + +static const char * const ad5360_vref_name[] =3D { +
> "vref0", "vref1", "vref2" +}; + +static int __devinit
> ad5360_alloc_channels(struct iio_dev *indio_dev) +{ + struct
> ad5360_state *st =3D iio_priv(indio_dev); +     struct iio_chan_spec
> *channels; +  unsigned int i; + +     channels =3D kcalloc(sizeof(struct
> iio_chan_spec), +                     st->chip_info->num_channels, GFP_KE=
RNEL); + +   if
> (!channels) +         return -ENOMEM; + +     for (i =3D 0; i <
> st->chip_info->num_channels; ++i) { +         channels[i] =3D
> st->chip_info->channel_template; +            channels[i].channel =3D i;
> +             channels[i].address =3D AD5360_CHAN_ADDR(i); +    } +
> +     indio_dev->channels =3D channels; + +     return 0; +} + +static in=
t
> __devinit ad5360_probe(struct spi_device *spi) +{ +   enum ad5360_type
> type =3D spi_get_device_id(spi)->driver_data; + struct iio_dev *indio_dev=
;
> +     struct ad5360_state *st; +      unsigned int i; +       int ret; + =
+    indio_dev =3D
> iio_allocate_device(sizeof(*st)); +   if (indio_dev =3D=3D NULL) {
> +             dev_err(&spi->dev, "Failed to allocate iio device\n"); +   =
             return
> -ENOMEM; +    } + +   st =3D iio_priv(indio_dev); +     spi_set_drvdata(s=
pi,
> indio_dev); + +       st->chip_info =3D &ad5360_chip_info_tbl[type]; +  s=
t->spi =3D
> spi; + +      indio_dev->dev.parent =3D &spi->dev; +    indio_dev->name =
=3D
> spi_get_device_id(spi)->name; +       indio_dev->info =3D &ad5360_info;
> +     indio_dev->modes =3D INDIO_DIRECT_MODE; + indio_dev->num_channels =
=3D
> st->chip_info->num_channels; + +      ret =3D ad5360_alloc_channels(indio=
_dev);
> +     if (ret) { +            dev_err(&spi->dev, "Failed to allocate chan=
nel spec:
> %d\n", ret); +                goto error_free; +      } + +   for (i =3D =
0; i <
> st->chip_info->num_vrefs; ++i) +              st->vref_reg[i].supply =3D
> ad5360_vref_name[i]; + +      ret =3D regulator_bulk_get(&st->spi->dev,
> st->chip_info->num_vrefs, +           st->vref_reg); +        if (ret) {
> +             dev_err(&spi->dev, "Failed to request vref regulators: %d\n=
", ret);
> +             goto error_free_channels; +     } + +   ret =3D
> regulator_bulk_enable(st->chip_info->num_vrefs, st-
>> vref_reg);
 +      if (ret) { +            dev_err(&spi->dev, "Failed to enable vref r=
egulators:
 %d\n", ret); +         goto error_free_reg; +  } + +   ret =3D
 iio_device_register(indio_dev); +      if (ret) { +            dev_err(&sp=
i->dev,
 "Failed to register iio device: %d\n", ret); +         goto error_disable_=
reg;
 +      } + +   return 0; + +error_disable_reg:
 +      regulator_bulk_disable(st->chip_info->num_vrefs, st->vref_reg);
 +error_free_reg: +     regulator_bulk_free(st->chip_info->num_vrefs,
 st->vref_reg); +error_free_channels: + kfree(indio_dev->channels);
 +error_free: + iio_free_device(indio_dev); + + return ret; +} + +static
 int __devexit ad5360_remove(struct spi_device *spi) +{ +       struct iio_=
dev
 *indio_dev =3D spi_get_drvdata(spi); +   struct ad5360_state *st =3D
 iio_priv(indio_dev); + +       iio_device_unregister(indio_dev); +
 +      kfree(indio_dev->channels); +
 +      regulator_bulk_disable(st->chip_info->num_vrefs, st->vref_reg);
 +      regulator_bulk_free(st->chip_info->num_vrefs, st->vref_reg); +
 +      iio_free_device(indio_dev); + + return 0; +} + +static const struct
 spi_device_id ad5360_ids[] =3D { +       { "ad5360", ID_AD5360 }, +      {=
 "ad5361",
 ID_AD5361 }, + { "ad5362", ID_AD5362 }, +      { "ad5363", ID_AD5363 }, + =
     {
 "ad5370", ID_AD5370 }, +       { "ad5371", ID_AD5371 }, +      { "ad5372",=
 ID_AD5372
 }, +   { "ad5373", ID_AD5373 }, +      {} +}; + +static struct spi_driver
 ad5360_driver =3D { +    .driver =3D { +              .name =3D "ad5360", =
+             .owner =3D
 THIS_MODULE, + }, +    .probe =3D ad5360_probe, +        .remove =3D
 __devexit_p(ad5360_remove), +  .id_table =3D ad5360_ids, +}; + +static
 __init int ad5360_spi_init(void) +{ +  return
 spi_register_driver(&ad5360_driver); +} +module_init(ad5360_spi_init); +
 +static __exit void ad5360_spi_exit(void) +{
 +      spi_unregister_driver(&ad5360_driver); +}
 +module_exit(ad5360_spi_exit); + +MODULE_AUTHOR("Lars-Peter Clausen
 <lars@metafoo.de>"); +MODULE_DESCRIPTION("Analog Devices
 AD5360/61/62/63/70/71/72/73 DAC"); +MODULE_LICENSE("GPL v2");

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
