Return-Path: <omaplinuxkernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1339449915-7542-1-git-send-email-pmeerw@pmeerw.net>
References: <1339449915-7542-1-git-send-email-pmeerw@pmeerw.net>
Date: Tue, 12 Jun 2012 11:20:40 +0530
Message-ID: <CAM=Q2csF1NAUg5h6q2shwGYQQ7vZb1E8HWW0HXq=r5bXshUURQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: add vcnl4000 combined ALS and proximity sensor
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Peter,

On Tue, Jun 12, 2012 at 2:55 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> minimal driver, submitting to staging
>
> v2 (address comments by Lars-Peter Clausen and Jonathan Cameron)
> * unify code for reading PS and AL data into
> =A0parameterized _measure() function
> * limit wait for data to become ready within 20 tries
> * drop IIO_LIGHT channel, add SCALE to IIO_INTENSITY
> * drop extra string arguments used for logging purpose only
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> ---
> =A0drivers/staging/iio/light/Kconfig =A0 =A0| =A0 11 ++
> =A0drivers/staging/iio/light/Makefile =A0 | =A0 =A01 +
> =A0drivers/staging/iio/light/vcnl4000.c | =A0238 ++++++++++++++++++++++++=
++++++++++
> =A03 files changed, 250 insertions(+)
> =A0create mode 100644 drivers/staging/iio/light/vcnl4000.c
>
> diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/ligh=
t/Kconfig
> index 4bed30e..6b8d022 100644
> --- a/drivers/staging/iio/light/Kconfig
> +++ b/drivers/staging/iio/light/Kconfig
> @@ -50,4 +50,15 @@ config TSL2x7x
> =A0 =A0 =A0 =A0 tmd2672, tsl2772, tmd2772 devices.
> =A0 =A0 =A0 =A0 Provides iio_events and direct access via sysfs.
>
> +config SENSORS_VCNL4000
> + =A0 =A0 =A0 tristate "VCNL4000 combined ALS and proximity sensor"
> + =A0 =A0 =A0 depends on I2C
> + =A0 =A0 =A0 default n

Nit:  Thats anyways default can be removed.

> + =A0 =A0 =A0 ---help---
> + =A0 =A0 =A0 =A0 Say Y here if you want to build a driver for the VCNL40=
00
> + =A0 =A0 =A0 =A0 combined ambient light and proximity sensor.
> +
> + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here: the
> + =A0 =A0 =A0 =A0 module will be called vcnl4000.
> +
> =A0endmenu
> diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/lig=
ht/Makefile
> index 141af1e..ea2c2f2 100644
> --- a/drivers/staging/iio/light/Makefile
> +++ b/drivers/staging/iio/light/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_SENSORS_ISL29018) =A0+=3D isl29018.o
> =A0obj-$(CONFIG_SENSORS_ISL29028) +=3D isl29028.o
> =A0obj-$(CONFIG_TSL2583) =A0+=3D tsl2583.o
> =A0obj-$(CONFIG_TSL2x7x) =A0+=3D tsl2x7x_core.o
> +obj-$(CONFIG_SENSORS_VCNL4000) +=3D vcnl4000.o
> diff --git a/drivers/staging/iio/light/vcnl4000.c b/drivers/staging/iio/l=
ight/vcnl4000.c
> new file mode 100644
> index 0000000..7a28d9e
> --- /dev/null
> +++ b/drivers/staging/iio/light/vcnl4000.c
> @@ -0,0 +1,238 @@
> +/*
> + * vcnl4000.c - Support for Vishay VCNL4000 combined ambient light and
> + * proximity sensor
> + *
> + * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
> + *
> + * This file is subject to the terms and conditions of version 2 of
> + * the GNU General Public License. =A0See the file COPYING in the main
> + * directory of this archive for more details.
> + *
> + * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
> + *
> + * TODO:
> + * =A0 allow to adjust IR current
> + * =A0 need scale/calibscale?
> + * =A0 proximity threshold and event handling
> + */
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#define VCNL4000_DRV_NAME "vcnl4000"
> +
> +#define VCNL4000_COMMAND =A0 =A0 =A0 0x80 /* Command register */
> +#define VCNL4000_PROD_REV =A0 =A0 =A00x81 /* Product ID and Revision ID =
*/
> +#define VCNL4000_LED_CURRENT =A0 0x83 /* IR LED current for proximity mo=
de */
> +#define VCNL4000_AL_PARAM =A0 =A0 =A00x84 /* Ambient light parameter reg=
ister */
> +#define VCNL4000_AL_RESULT_HI =A00x85 /* Ambient light result register, =
MSB */
> +#define VCNL4000_AL_RESULT_LO =A00x86 /* Ambient light result register, =
LSB */
> +#define VCNL4000_PS_RESULT_HI =A00x87 /* Proximity result register, MSB =
*/
> +#define VCNL4000_PS_RESULT_LO =A00x88 /* Proximity result register, LSB =
*/
> +#define VCNL4000_PS_MEAS_FREQ =A00x89 /* Proximity measurement signal fr=
equency */
> +#define VCNL4000_PS_MOD_ADJ =A0 =A00x8a /* Proximity modulator timing ad=
justment */
> +
> +/* Bit masks for COMMAND register */
> +#define VCNL4000_AL_RDY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x40 /* ALS data =
ready? */
> +#define VCNL4000_PS_RDY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x20 /* proximity=
 data ready? */
> +#define VCNL4000_AL_OD =A0 =A0 =A0 =A0 0x10 /* start on-demand ALS measu=
rement */
> +#define VCNL4000_PS_OD =A0 =A0 =A0 =A0 0x08 /* start on-demand proximity=
 measurement */
> +
> +struct vcnl4000_data {
> + =A0 =A0 =A0 struct i2c_client *client;
> +};
> +
> +static const struct i2c_device_id vcnl4000_id[] =3D {
> + =A0 =A0 =A0 { "vcnl4000", 0 },
> + =A0 =A0 =A0 { }
> +};
> +MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
> +
> +static int vcnl4000_read(struct vcnl4000_data *data, u8 reg)
> +{
> + =A0 =A0 =A0 int ret =3D i2c_smbus_read_byte_data(data->client, reg);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vcnl4000_read() failed, er=
ror %d\n", ret);
> + =A0 =A0 =A0 return ret;
> +}
The functions can be called directly.
> +
> +static int vcnl4000_write(struct vcnl4000_data *data, u8 reg, u8 val)
> +{
> + =A0 =A0 =A0 int ret =3D i2c_smbus_write_byte_data(data->client, reg, va=
l);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vcnl4000_write() failed, e=
rror %d\n", ret);
> + =A0 =A0 =A0 return ret;
> +}
Same here

> +
> +static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 rdy_mask=
, u8 data_reg, int *val)
> +{
> + =A0 =A0 =A0 int tries =3D 20;
> + =A0 =A0 =A0 u16 buf;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 ret =3D vcnl4000_write(data, VCNL4000_COMMAND, req_mask);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 /* wait for data to become ready */
> + =A0 =A0 =A0 while (tries--) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vcnl4000_read(data, VCNL4000_COMMAN=
D);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret & rdy_mask)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(1);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (tries < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vcnl4000_measure() failed,=
 data not ready\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D i2c_smbus_read_i2c_block_data(data->client,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_reg, sizeof(buf), (u8 *) &buf);
> + =A0 =A0 =A0 if (ret < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&data->client->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "vcnl4000_measure() failed,=
 error %d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 *val =3D be16_to_cpu(buf);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static const struct iio_chan_spec vcnl4000_channels[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D IIO_INTENSITY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_B=
IT |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IIO_CHAN_INFO_SCALE_SEPARAT=
E_BIT,
> + =A0 =A0 =A0 }, {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =3D IIO_PROXIMITY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_B=
IT,
> + =A0 =A0 =A0 }
> +};
> +
> +static int vcnl4000_read_raw(struct iio_dev *indio_dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct iio_=
chan_spec const *chan,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int *val, i=
nt *val2, long mask)
> +{
> + =A0 =A0 =A0 int ret =3D -EINVAL;
> + =A0 =A0 =A0 struct vcnl4000_data *data =3D iio_priv(indio_dev);

Does it need some locking? Not sure though.

> +
> + =A0 =A0 =A0 switch (mask) {
> + =A0 =A0 =A0 case IIO_CHAN_INFO_RAW:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 switch (chan->type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case IIO_INTENSITY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vcnl4000_measure(da=
ta,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VCNL4000_AL=
_OD, VCNL4000_AL_RDY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VCNL4000_AL=
_RESULT_HI, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IIO_VAL_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case IIO_PROXIMITY:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D vcnl4000_measure(da=
ta,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VCNL4000_PS=
_OD, VCNL4000_PS_RDY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 VCNL4000_PS=
_RESULT_HI, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IIO_VAL_INT;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case IIO_CHAN_INFO_SCALE:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chan->type =3D=3D IIO_INTENSITY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *val2 =3D 250000;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D IIO_VAL_INT_PLUS_MI=
CRO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +static const struct iio_info vcnl4000_info =3D {
> + =A0 =A0 =A0 .read_raw =3D vcnl4000_read_raw,
> + =A0 =A0 =A0 .driver_module =3D THIS_MODULE,
> +};
