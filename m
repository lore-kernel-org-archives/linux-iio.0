Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1321865615-16681-1-git-send-email-lars@metafoo.de>
References: <1321865615-16681-1-git-send-email-lars@metafoo.de>
Date: Mon, 21 Nov 2011 14:34:08 +0530
Message-ID: <CAM=Q2cv2kbpLxtgmJ=zSGRnmd6MyxuqRb3ErMjKmLbUitm4+bg@mail.gmail.com>
Subject: Re: [PATCH] staging:iio:dac: Add AD5764 driver
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
	drivers@analog.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

On Mon, Nov 21, 2011 at 2:23 PM, Lars-Peter Clausen <lars@metafoo.de> wrote=
:
>
> This patch adds support for the Analog Devices AD5764, AD5764R, AD5744, A=
D5744R
> quad channel analog-to-digital converter.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> =A0drivers/staging/iio/dac/Kconfig =A0| =A0 10 +
> =A0drivers/staging/iio/dac/Makefile | =A0 =A01 +
> =A0drivers/staging/iio/dac/ad5764.c | =A0394 ++++++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 405 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/staging/iio/dac/ad5764.c
>
> diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kc=
onfig
> index 0e8a814..bbc33dd 100644
> --- a/drivers/staging/iio/dac/Kconfig
> +++ b/drivers/staging/iio/dac/Kconfig
> @@ -75,6 +75,16 @@ config AD5504
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here: the
> =A0 =A0 =A0 =A0 =A0module will be called ad5504.
>
> +config AD5764
> + =A0 =A0 =A0 tristate "Analog Devices AD5764/64R/44/44R DAC driver"
> + =A0 =A0 =A0 depends on SPI_MASTER
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say yes here to build support for Analog Devices AD5764=
, AD5764R, AD5744,
> + =A0 =A0 =A0 =A0 AD5744R Digital to Analog Converter.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: the
> + =A0 =A0 =A0 =A0 module will be called ad5764.
> +
> =A0config AD5791
> =A0 =A0 =A0 =A0tristate "Analog Devices AD5760/AD5780/AD5781/AD5791 DAC S=
PI driver"
> =A0 =A0 =A0 =A0depends on SPI
> diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/M=
akefile
> index 840e94e..8ab1d26 100644
> --- a/drivers/staging/iio/dac/Makefile
> +++ b/drivers/staging/iio/dac/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_AD5624R_SPI) +=3D ad5624r_spi.o
> =A0obj-$(CONFIG_AD5064) +=3D ad5064.o
> =A0obj-$(CONFIG_AD5504) +=3D ad5504.o
> =A0obj-$(CONFIG_AD5446) +=3D ad5446.o
> +obj-$(CONFIG_AD5764) +=3D ad5764.o
> =A0obj-$(CONFIG_AD5791) +=3D ad5791.o
> =A0obj-$(CONFIG_AD5686) +=3D ad5686.o
> =A0obj-$(CONFIG_MAX517) +=3D max517.o
> diff --git a/drivers/staging/iio/dac/ad5764.c b/drivers/staging/iio/dac/a=
d5764.c
> new file mode 100644
> index 0000000..50c1ec62
> --- /dev/null
> +++ b/drivers/staging/iio/dac/ad5764.c
> @@ -0,0 +1,394 @@
> +/*
> + * Analog devices AD5764, AD5764R, AD5744, AD5744R quad-channel
> + * Digital to Analog Converters driver
> + *
> + * Copyright 2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/spi/spi.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include "../iio.h"
> +#include "../sysfs.h"
> +#include "dac.h"
> +
> +#define AD5764_REG_SF_NOP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0
> +#define AD5764_REG_SF_CONFIG =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x1
> +#define AD5764_REG_SF_CLEAR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x4
> +#define AD5764_REG_SF_LOAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x5
> +#define AD5764_REG_DATA(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((2 <=
< 3) | (x))
> +#define AD5764_REG_COARSE_GAIN(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0((3 << 3) |=
 (x))
> +#define AD5764_REG_FINE_GAIN(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0((4 << 3) | (x))
> +#define AD5764_REG_OFFSET(x) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((5 << =
3) | (x))
> +
> +#define AD5764_NUM_CHANNELS 4
> +
> +/**
> + * struct ad5764_chip_info - chip specific information
> + * @int_vref: =A0Value of the internal reference voltage in uV - 0 if ex=
ternal
> + * =A0 =A0 =A0 =A0 =A0 =A0 reference voltage is used
> + * @channel =A0 =A0channel specification
> +*/
> +
> +struct ad5764_chip_info {
> + =A0 =A0 =A0 unsigned long int_vref;
> + =A0 =A0 =A0 const struct iio_chan_spec *channels;
> +};
> +
> +/**
> + * struct ad5764_state - driver instance specific data
> + * @spi: =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_device
> + * @chip_info: =A0 =A0 =A0 =A0 chip info
> + * @vref_reg: =A0 =A0 =A0 =A0 =A0vref supply regulators
> + * @data: =A0 =A0 =A0 =A0 =A0 =A0 =A0spi transfer buffers
> + */
> +
> +struct ad5764_state {
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 *spi;
> + =A0 =A0 =A0 const struct ad5764_chip_info =A0 *chip_info;
> + =A0 =A0 =A0 struct regulator_bulk_data =A0 =A0 =A0vref_reg[2];
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* DMA (thus cache coherency maintenance) requires the
> + =A0 =A0 =A0 =A0* transfer buffers to live in their own cache lines.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 union {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __be32 d32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 d8[4];
> + =A0 =A0 =A0 } data[2] ____cacheline_aligned;
> +};
> +
> +enum ad5764_type {
> + =A0 =A0 =A0 ID_AD5744,
> + =A0 =A0 =A0 ID_AD5744R,
> + =A0 =A0 =A0 ID_AD5764,
> + =A0 =A0 =A0 ID_AD5764R,
> +};
> +
> +#define AD5764_CHANNEL(_chan, _bits) { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .type =3D IIO_VOLTAGE, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 .indexed =3D 1, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .output =3D 1, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 .channel =3D (_chan), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .address =3D (_chan), =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .info_mask =3D IIO_CHAN_INFO_OFFSET_SHARED_BIT | =A0 =A0 =
=A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_CHAN_INFO_SCALE_SEPARATE_BIT | =A0 =A0 =
=A0 =A0 =A0 =A0 =A0\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT | =A0=
 =A0 =A0 =A0 \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT, =A0 =
=A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 .scan_type =3D IIO_ST('u', (_bits), 16, 16 - (_bits)) =A0 =
=A0 \
> +}
> +
> +#define DECLARE_AD5764_CHANNELS(_name, _bits) \
> +const struct iio_chan_spec _name##_channels[] =3D { \
> + =A0 =A0 =A0 AD5764_CHANNEL(0, (_bits)), \
> + =A0 =A0 =A0 AD5764_CHANNEL(1, (_bits)), \
> + =A0 =A0 =A0 AD5764_CHANNEL(2, (_bits)), \
> + =A0 =A0 =A0 AD5764_CHANNEL(3, (_bits)), \
> +};
> +
> +static DECLARE_AD5764_CHANNELS(ad5764, 16);
> +static DECLARE_AD5764_CHANNELS(ad5744, 14);
> +
> +static const struct ad5764_chip_info ad5764_chip_infos[] =3D {
> + =A0 =A0 =A0 [ID_AD5744] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .int_vref =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels =3D ad5744_channels,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [ID_AD5744R] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .int_vref =3D 5000000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels =3D ad5744_channels,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [ID_AD5764] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .int_vref =3D 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels =3D ad5764_channels,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 [ID_AD5764R] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .int_vref =3D 5000000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .channels =3D ad5764_channels,
> + =A0 =A0 =A0 },
> +};
> +
> +static int ad5764_write(struct iio_dev *indio_dev, unsigned int reg,
> + =A0 =A0 =A0 unsigned int val)
> +{
> + =A0 =A0 =A0 struct ad5764_state *st =3D iio_priv(indio_dev);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 mutex_lock(&indio_dev->mlock);
> + =A0 =A0 =A0 st->data[0].d32 =3D cpu_to_be32((reg << 16) | val);
> +
> + =A0 =A0 =A0 ret =3D spi_write(st->spi, &st->data[0].d8[1], 3);
> + =A0 =A0 =A0 mutex_unlock(&indio_dev->mlock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int ad5764_read(struct iio_dev *indio_dev, unsigned int reg,
> + =A0 =A0 =A0 unsigned int *val)
> +{
> + =A0 =A0 =A0 struct ad5764_state *st =3D iio_priv(indio_dev);
> + =A0 =A0 =A0 struct spi_message m;
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct spi_transfer t[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D &st->data[0].d8=
[1],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .cs_change =3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rx_buf =3D &st->data[1].d8=
[1],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 3,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 spi_message_init(&m);
> + =A0 =A0 =A0 spi_message_add_tail(&t[0], &m);
> + =A0 =A0 =A0 spi_message_add_tail(&t[1], &m);
> +
> + =A0 =A0 =A0 mutex_lock(&indio_dev->mlock);
> +
> + =A0 =A0 =A0 st->data[0].d32 =3D cpu_to_be32((1 << 23) | (reg << 16));
> +
> + =A0 =A0 =A0 ret =3D spi_sync(st->spi, &m);
> + =A0 =A0 =A0 if (ret >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D be32_to_cpu(st->data[1].d32) & 0xf=
fff;
> +
> + =A0 =A0 =A0 mutex_unlock(&indio_dev->mlock);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int ad5764_chan_info_to_reg(struct iio_chan_spec const *chan, lon=
g info)
> +{
> + =A0 =A0 =A0 switch (info) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AD5764_REG_DATA(chan->address);
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBBIAS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AD5764_REG_OFFSET(chan->address);
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBSCALE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AD5764_REG_FINE_GAIN(chan->address);
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 BUG();
Should we BUG here?
Is it that severe  because it will halt the whole system?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int ad5764_write_raw(struct iio_dev *indio_dev,
> + =A0 =A0 =A0 struct iio_chan_spec const *chan, int val, int val2, long i=
nfo)
> +{
> + =A0 =A0 =A0 const int max_val =3D (1 << chan->scan_type.realbits);
> + =A0 =A0 =A0 unsigned int reg;
> +
> + =A0 =A0 =A0 switch (info) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val >=3D max_val || val < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val <<=3D chan->scan_type.shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBBIAS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val >=3D 128 || val < -128)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBSCALE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val >=3D 32 || val < -32)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 reg =3D ad5764_chan_info_to_reg(chan, info);
> + =A0 =A0 =A0 return ad5764_write(indio_dev, reg, (u16)val);
> +}
> +
> +static int ad5764_get_channel_vref(struct ad5764_state *st,
> + =A0 =A0 =A0 unsigned int channel)
> +{
> + =A0 =A0 =A0 if (st->chip_info->int_vref)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return st->chip_info->int_vref;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return regulator_get_voltage(st->vref_reg[c=
hannel / 2].consumer);
> +}
> +
> +static int ad5764_read_raw(struct iio_dev *indio_dev,
> + =A0 =A0 =A0 struct iio_chan_spec const *chan, int *val, int *val2, long=
 info)
> +{
> + =A0 =A0 =A0 struct ad5764_state *st =3D iio_priv(indio_dev);
> + =A0 =A0 =A0 unsigned long scale_uv;
> + =A0 =A0 =A0 unsigned int reg;
> + =A0 =A0 =A0 int vref;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 switch (info) {
> + =A0 =A0 =A0 case 0:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D AD5764_REG_DATA(chan->address);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ad5764_read(indio_dev, reg, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val >>=3D chan->scan_type.shift;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBBIAS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D AD5764_REG_OFFSET(chan->address);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ad5764_read(indio_dev, reg, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D sign_extend32(*val, 7);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_CALIBSCALE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D AD5764_REG_FINE_GAIN(chan->address)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D ad5764_read(indio_dev, reg, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D sign_extend32(*val, 5);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_SCALE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* vout =3D 4 * vref + ((dac_code / 65535) =
- 0.5) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 vref =3D ad5764_get_channel_vref(st, chan->=
channel);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (vref < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return vref;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scale_uv =3D (vref * 4 * 100) >> chan->scan=
_type.realbits;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D scale_uv / 100000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val2 =3D (scale_uv % 100000) * 10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT_PLUS_MICRO;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_OFFSET:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D -(1 << chan->scan_type.realbits) /=
 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IIO_VAL_INT;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return -EINVAL;
> +}
> +
> +static const struct iio_info ad5764_info =3D {
> + =A0 =A0 =A0 .read_raw =3D ad5764_read_raw,
> + =A0 =A0 =A0 .write_raw =3D ad5764_write_raw,
> + =A0 =A0 =A0 .driver_module =3D THIS_MODULE,
> +};
> +
> +static int __devinit ad5764_probe(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 enum ad5764_type type =3D spi_get_device_id(spi)->driver_da=
ta;
> + =A0 =A0 =A0 struct iio_dev *indio_dev;
> + =A0 =A0 =A0 struct ad5764_state *st;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 indio_dev =3D iio_allocate_device(sizeof(*st));
> + =A0 =A0 =A0 if (indio_dev =3D=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "Failed to allocate iio =
device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 st =3D iio_priv(indio_dev);
> + =A0 =A0 =A0 spi_set_drvdata(spi, indio_dev);
> +
> + =A0 =A0 =A0 st->spi =3D spi;
> + =A0 =A0 =A0 st->chip_info =3D &ad5764_chip_infos[type];
> +
> + =A0 =A0 =A0 indio_dev->dev.parent =3D &spi->dev;
> + =A0 =A0 =A0 indio_dev->name =3D spi_get_device_id(spi)->name;
> + =A0 =A0 =A0 indio_dev->info =3D &ad5764_info;
> + =A0 =A0 =A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> + =A0 =A0 =A0 indio_dev->num_channels =3D AD5764_NUM_CHANNELS;
> + =A0 =A0 =A0 indio_dev->channels =3D st->chip_info->channels;
> +
> + =A0 =A0 =A0 if (st->chip_info->int_vref =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st->vref_reg[0].supply =3D "vrefAB";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 st->vref_reg[1].supply =3D "vrefCD";
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_bulk_get(&st->spi->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(st->vref_reg), s=
t->vref_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "Failed =
to request vref regulators: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_free;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D regulator_bulk_enable(ARRAY_SIZE(st=
->vref_reg),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st->vref_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "Failed =
to enable vref regulators: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_free_reg;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D iio_device_register(indio_dev);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&spi->dev, "Failed to register iio =
device: %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error_disable_reg;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +
> +error_disable_reg:
> + =A0 =A0 =A0 if (st->chip_info->int_vref =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_bulk_disable(ARRAY_SIZE(st->vref_=
reg), st->vref_reg);
> +error_free_reg:
> + =A0 =A0 =A0 if (st->chip_info->int_vref =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_bulk_free(ARRAY_SIZE(st->vref_reg=
), st->vref_reg);
> +error_free:
> + =A0 =A0 =A0 iio_free_device(indio_dev);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static int __devexit ad5764_remove(struct spi_device *spi)
> +{
> + =A0 =A0 =A0 struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> + =A0 =A0 =A0 struct ad5764_state *st =3D iio_priv(indio_dev);
> +
> + =A0 =A0 =A0 iio_device_unregister(indio_dev);
> +
> + =A0 =A0 =A0 if (st->chip_info->int_vref =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_bulk_disable(ARRAY_SIZE(st->vref_=
reg), st->vref_reg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regulator_bulk_free(ARRAY_SIZE(st->vref_reg=
), st->vref_reg);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 iio_free_device(indio_dev);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct spi_device_id ad5764_ids[] =3D {
> + =A0 =A0 =A0 { "ad5744", ID_AD5744 },
> + =A0 =A0 =A0 { "ad5744r", ID_AD5744R },
> + =A0 =A0 =A0 { "ad5764", ID_AD5764 },
> + =A0 =A0 =A0 { "ad5764r", ID_AD5764R },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(spi, ad5764_ids);
> +
> +static struct spi_driver ad5764_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "ad5764",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .probe =3D ad5764_probe,
> + =A0 =A0 =A0 .remove =3D __devexit_p(ad5764_remove),
> + =A0 =A0 =A0 .id_table =3D ad5764_ids,
> +};
> +
> +static __init int ad5764_spi_init(void)
> +{
> + =A0 =A0 =A0 return spi_register_driver(&ad5764_driver);
> +}
> +module_init(ad5764_spi_init);
> +
> +static __exit void ad5764_spi_exit(void)
> +{
> + =A0 =A0 =A0 spi_unregister_driver(&ad5764_driver);
> +}
> +module_exit(ad5764_spi_exit);
> +
> +MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
> +MODULE_DESCRIPTION("Analog Devices AD5744/AD5744R/AD5764/AD5764R DAC");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
