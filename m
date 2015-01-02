Return-Path: <ktsai@capellamicro.com>
Date: Fri, 2 Jan 2015 04:23:26 +0000 (UTC)
From: Kevin Tsai <ktsai@capellamicro.com>
Reply-To: Kevin Tsai <ktsai@capellamicro.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Archana Patni <archana.patni@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <192777296.3545074.1420172606886.JavaMail.yahoo@jws10654.mail.bf1.yahoo.com>
In-Reply-To: <alpine.DEB.2.02.1501011140190.21620@pmeerw.net>
References: <alpine.DEB.2.02.1501011140190.21620@pmeerw.net>
Subject: Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient light sensor
 driver.
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3545073_1948205960.1420172606867"
List-ID: <linux-iio@vger.kernel.org>

------=_Part_3545073_1948205960.1420172606867
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,
Thanks for your comments. =C2=A0I will update and resubmit it next week.
About your question:> +=C2=A0=C2=A0=C2=A0 als_it =3D chip->regs_cmd;
> +=C2=A0=C2=A0=C2=A0 als_it &=3D CM3232_CMD_ALS_IT_MASK;
> +=C2=A0=C2=A0=C2=A0 als_it >>=3D CM3232_CMD_ALS_IT_SHIFT;

there is no i2c read here?!

KT: Configure register is "Write only" register. =C2=A0I use "chip->regs_cm=
d" to store the value.
Thanks.
Kevin Tsai01/01/15
      From: Peter Meerwald <pmeerw@pmeerw.net>
 To: Kevin Tsai <ktsai@capellamicro.com>=20
Cc: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; =
Lars-Peter Clausen <lars@metafoo.de>; Daniel Baluta <daniel.baluta@intel.co=
m>; Archana Patni <archana.patni@linux.intel.com>; linux-iio@vger.kernel.or=
g=20
 Sent: Thursday, January 1, 2015 3:02 AM
 Subject: Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient light sensor=
 driver.
  =20
On Wed, 31 Dec 2014, Kevin Tsai wrote:

> CM3232 is an advanced ambient light sensor with I2C protocol interface.
> The I2C slave address is internally hardwired as 0x10 (7-bit).=C2=A0 Writ=
ing
> to configure register is byte mode, but reading ALS register requests to
> use word mode for 16-bit resolution.

comments below
=20
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> ---
>=C2=A0 .../devicetree/bindings/i2c/trivial-devices.txt=C2=A0 =C2=A0 |=C2=
=A0 1 +
>=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 6 +
>=C2=A0 drivers/iio/light/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +
>=C2=A0 drivers/iio/light/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +
>=C2=A0 drivers/iio/light/cm3232.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 403 +++++++++++++++++++++
>=C2=A0 5 files changed, 422 insertions(+)
>=C2=A0 create mode 100644 drivers/iio/light/cm3232.c
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/=
Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index 9f4e382..572a7c4 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -34,6 +34,7 @@ atmel,24c512=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c s=
erial eeprom=C2=A0 (24cxx)
>=C2=A0 atmel,24c1024=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c serial eepro=
m=C2=A0 (24cxx)
>=C2=A0 atmel,at97sc3204t=C2=A0=C2=A0=C2=A0 i2c trusted platform module (TP=
M)
>=C2=A0 capella,cm32181=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CM32181: Ambie=
nt Light Sensor
> +capella,cm3232=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CM3232: Ambient Ligh=
t Sensor
>=C2=A0 catalyst,24c32=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i2c serial eepr=
om
>=C2=A0 cirrus,cs42l51=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 Cirrus Logic CS=
42L51 audio codec
>=C2=A0 dallas,ds1307=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 64 x 8, Serial, =
I2C Real-Time Clock
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddb9ac8..06a613a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2378,6 +2378,12 @@ F:=C2=A0=C2=A0=C2=A0 security/capability.c
>=C2=A0 F:=C2=A0=C2=A0=C2=A0 security/commoncap.c
>=C2=A0 F:=C2=A0=C2=A0=C2=A0 kernel/capability.c
>=C2=A0=20
> +CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> +M:=C2=A0=C2=A0=C2=A0 Kevin Tsai <ktsai@capellamicro.com>
> +S:=C2=A0=C2=A0=C2=A0 Maintained
> +F:=C2=A0=C2=A0=C2=A0 drivers/iio/light/cm*
> +F:=C2=A0=C2=A0=C2=A0 Documentation/devicetree/bindings/i2c/trivial-devic=
es.txt
> +
>=C2=A0 CC2520 IEEE-802.15.4 RADIO DRIVER
>=C2=A0 M:=C2=A0=C2=A0=C2=A0 Varka Bhadram <varkabhadram@gmail.com>
>=C2=A0 L:=C2=A0=C2=A0=C2=A0 linux-wpan@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 5bea821..d2318e2 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -48,6 +48,17 @@ config CM32181
>=C2=A0 =C2=A0=C2=A0=C2=A0 To compile this driver as a module, choose M her=
e:
>=C2=A0 =C2=A0=C2=A0=C2=A0 the module will be called cm32181.
>=C2=A0=20
> +config CM3232
> +=C2=A0=C2=A0=C2=A0 depends on I2C
> +=C2=A0=C2=A0=C2=A0 tristate "CM3232 driver"
> +=C2=A0=C2=A0=C2=A0 help
> +=C2=A0=C2=A0=C2=A0 Say Y here if you use cm3232.
> +=C2=A0=C2=A0=C2=A0 This option enables ambient light sensor using
> +=C2=A0=C2=A0=C2=A0 Capella Microsystems cm3232 device driver.
> +
> +=C2=A0=C2=A0=C2=A0 To compile this driver as a module, choose M here:
> +=C2=A0=C2=A0=C2=A0 the module will be called cm3232.
> +
>=C2=A0 config CM36651
>=C2=A0 =C2=A0=C2=A0=C2=A0 depends on I2C
>=C2=A0 =C2=A0=C2=A0=C2=A0 tristate "CM36651 driver"
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 47877a3..f2c8d55 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -7,6 +7,7 @@ obj-$(CONFIG_ADJD_S311)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 +=3D adjd_s311.o
>=C2=A0 obj-$(CONFIG_AL3320A)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +=3D al3=
320a.o
>=C2=A0 obj-$(CONFIG_APDS9300)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +=3D ap=
ds9300.o
>=C2=A0 obj-$(CONFIG_CM32181)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +=3D cm3=
2181.o
> +obj-$(CONFIG_CM3232)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +=3D cm3232.o
>=C2=A0 obj-$(CONFIG_CM36651)=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 +=3D cm3=
6651.o
>=C2=A0 obj-$(CONFIG_GP2AP020A00F)=C2=A0=C2=A0=C2=A0 +=3D gp2ap020a00f.o
>=C2=A0 obj-$(CONFIG_HID_SENSOR_ALS)=C2=A0=C2=A0=C2=A0 +=3D hid-sensor-als.=
o
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> new file mode 100644
> index 0000000..fd98eeb
> --- /dev/null
> +++ b/drivers/iio/light/cm3232.c
> @@ -0,0 +1,403 @@
> +/*
> + * Copyright (C) 2014 Capella Microsystems Inc.
> + * Author: Kevin Tsai <ktsai@capellamicro.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License version 2, as publi=
shed
> + * by the Free Software Foundation.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/iio/events.h>
> +#include <linux/init.h>
> +
> +/* Registers Address */
> +#define CM3232_REG_ADDR_CMD=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x00
> +#define CM3232_REG_ADDR_ALS=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x50
> +#define CM3232_REG_ADDR_ID=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 0x53
> +
> +/* CMD register */
> +#define CM3232_CMD_ALS_DISABLE=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(=
0)
> +#define=C2=A0=C2=A0=C2=A0 CM3232_CMD_ALS_HS=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 BIT(1)

whitespace issue, replace tab with space
ALS_HS is not used

> +
> +#define CM3232_CMD_ALS_IT_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 2
> +#define CM3232_CMD_ALS_IT_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (0x07 <=
< CM3232_CMD_ALS_IT_SHIFT)
> +#define CM3232_CMD_ALS_IT_DEFAULT=C2=A0 =C2=A0 =C2=A0 (0x01 << CM3232_CM=
D_ALS_IT_SHIFT)
> +
> +#define=C2=A0=C2=A0=C2=A0 CM3232_CMD_ALS_RESET=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 BIT(6)
> +
> +#define CM3232_CMD_DEFAULT=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 CM3232_C=
MD_ALS_IT_DEFAULT
> +
> +#define CM3232_CALIBSCALE_DEFAULT=C2=A0=C2=A0=C2=A0 100000
> +#define CM3232_CALIBSCALE_RESOLUTION=C2=A0=C2=A0=C2=A0 100000
> +#define CM3232_MLUX_PER_LUX=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 1000
> +
> +#define CM3232_MLUX_PER_BIT_DEFAULT=C2=A0=C2=A0=C2=A0 64
> +#define CM3232_MLUX_PER_BIT_BASE_IT=C2=A0=C2=A0=C2=A0 100000
> +static const int CM3232_als_it_bits[] =3D { 0, 1, 2, 3, 4, 5};

cm3232_als_it_bits and remove space before 0

> +static const int CM3232_als_it_values[] =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 100000, 200000,=
 400000, 800000, 1600000, 3200000};

cm3232_als_it_values

> +
> +struct cm3232_als_info {

that may pay off lateron, currently there is just one chip...

> +=C2=A0=C2=A0=C2=A0 u32 id;
> +=C2=A0=C2=A0=C2=A0 int calibscale;
> +=C2=A0=C2=A0=C2=A0 int mlux_per_bit;
> +=C2=A0=C2=A0=C2=A0 int mlux_per_bit_base_it;
> +=C2=A0=C2=A0=C2=A0 const int *als_it_bits;
> +=C2=A0=C2=A0=C2=A0 const int *als_it_values;
> +=C2=A0=C2=A0=C2=A0 const int num_als_it;

num_als_it could be unsigned probably

> +=C2=A0=C2=A0=C2=A0 int als_raw;
> +};
> +
> +static struct cm3232_als_info cm3232_als_info_default =3D {
> +=C2=A0=C2=A0=C2=A0 .id =3D 3232,
> +=C2=A0=C2=A0=C2=A0 .calibscale =3D CM3232_CALIBSCALE_DEFAULT,
> +=C2=A0=C2=A0=C2=A0 .mlux_per_bit =3D CM3232_MLUX_PER_BIT_DEFAULT,
> +=C2=A0=C2=A0=C2=A0 .mlux_per_bit_base_it =3D CM3232_MLUX_PER_BIT_BASE_IT=
,
> +=C2=A0=C2=A0=C2=A0 .als_it_bits =3D CM3232_als_it_bits,
> +=C2=A0=C2=A0=C2=A0 .als_it_values =3D CM3232_als_it_values,
> +=C2=A0=C2=A0=C2=A0 .num_als_it =3D ARRAY_SIZE(CM3232_als_it_bits),
> +};
> +
> +struct cm3232_chip {
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client;
> +=C2=A0=C2=A0=C2=A0 struct mutex lock;
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info;
> +=C2=A0=C2=A0=C2=A0 u8 regs_cmd;
> +};
> +
> +static int cm3232_get_lux(struct cm3232_chip *chip);
> +static int cm3232_read_als_it(struct cm3232_chip *chip, int *val2);
> +
> +/**
> + * cm3232_reg_init() - Initialize CM3232 registers
> + * @chip:=C2=A0=C2=A0=C2=A0 pointer of struct cm3232.
> + *
> + * Initialize CM3232 ambient light sensor register to default values.

checks for and initializes; registers

> + *
> +=C2=A0 Return: 0 for success; otherwise for error code.
> + */
> +static int cm3232_reg_init(struct cm3232_chip *chip)
> +{
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D chip->client;
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info;
> +=C2=A0=C2=A0=C2=A0 s32 ret;
> +
> +=C2=A0=C2=A0=C2=A0 /* Identify device */
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_word_data(client, CM3232_REG_A=
DDR_ID);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 if ((ret & 0xFF) !=3D 0x32)

this could/should use the .id field of _als_info

> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENODEV;
> +
> +=C2=A0=C2=A0=C2=A0 /* Disable and reset device */
> +=C2=A0=C2=A0=C2=A0 chip->regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CM=
D_ALS_RESET;
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_=
ADDR_CMD,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 chip->regs_cmd);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0 /* Initialization */
> +=C2=A0=C2=A0=C2=A0 als_info =3D chip->als_info =3D &cm3232_als_info_defa=
ult;
> +=C2=A0=C2=A0=C2=A0 chip->regs_cmd =3D CM3232_CMD_DEFAULT;
> +
> +=C2=A0=C2=A0=C2=A0 /* Configure register */
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_=
ADDR_CMD,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 chip->regs_cmd);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +
> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +/**
> + *=C2=A0 cm3232_read_als_it() - Get sensor integration time (ms)
> + *=C2=A0 @chip:=C2=A0=C2=A0=C2=A0 pointer of struct cm3232
> + *=C2=A0 @val2:=C2=A0=C2=A0=C2=A0 pointer of int to load the als_it valu=
e.
> + *
> + *=C2=A0 Report the current integration time in milliseconds.
> + *
> + *=C2=A0 Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
> + */
> +static int cm3232_read_als_it(struct cm3232_chip *chip, int *val2)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 u16 als_it;
> +=C2=A0=C2=A0=C2=A0 int i;
> +
> +=C2=A0=C2=A0=C2=A0 als_it =3D chip->regs_cmd;
> +=C2=A0=C2=A0=C2=A0 als_it &=3D CM3232_CMD_ALS_IT_MASK;
> +=C2=A0=C2=A0=C2=A0 als_it >>=3D CM3232_CMD_ALS_IT_SHIFT;

there is no i2c read here?!
what is regs_cmd? the name seems to be rather inappropriate

> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < als_info->num_als_it; i++) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (als_it =3D=3D als_info->als_it=
_bits[i]) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val2 =3D als_i=
nfo->als_it_values[i];
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IIO_VAL_=
INT_PLUS_MICRO;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +}
> +
> +/**
> + * cm3232_write_als_it() - Write sensor integration time
> + * @chip:=C2=A0=C2=A0=C2=A0 pointer of struct cm3232.
> + * @val:=C2=A0=C2=A0=C2=A0 integration time in milliseconds.
> + *
> + * Convert integration time (ms) to sensor value.
> + *
> + * Return: i2c_smbus_write_word_data command return value.

write_byte_data

> + */
> +static int cm3232_write_als_it(struct cm3232_chip *chip, int val)
> +{
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D chip->client;
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 u16 als_it;
> +=C2=A0=C2=A0=C2=A0 int ret, i;
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < als_info->num_als_it; i++)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (val <=3D als_info->als_it_valu=
es[i])
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0 if (i >=3D als_info->num_als_it)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 i =3D als_info->num_als_it - 1;
> +
> +=C2=A0=C2=A0=C2=A0 als_it =3D als_info->als_it_bits[i];
> +=C2=A0=C2=A0=C2=A0 als_it <<=3D CM3232_CMD_ALS_IT_SHIFT;
> +
> +=C2=A0=C2=A0=C2=A0 mutex_lock(&chip->lock);

I don't see what the mutex is trying to lock -- why?

> +=C2=A0=C2=A0=C2=A0 chip->regs_cmd &=3D ~CM3232_CMD_ALS_IT_MASK;
> +=C2=A0=C2=A0=C2=A0 chip->regs_cmd |=3D als_it;
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_=
ADDR_CMD,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 chip->regs_cmd)=
;
> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&chip->lock);
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> +/**
> + * cm3232_get_lux() - report current lux value
> + * @chip:=C2=A0=C2=A0=C2=A0 pointer of struct cm3232.
> + *
> + * Convert sensor raw data to lux.=C2=A0 It depends on integration
> + * time and calibscale variable.
> + *
> + * Return: Positive value is lux, otherwise is error code.

otherwise error code

> + */
> +static int cm3232_get_lux(struct cm3232_chip *chip)
> +{
> +=C2=A0=C2=A0=C2=A0 struct i2c_client *client =3D chip->client;
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0 int als_it;
> +=C2=A0=C2=A0=C2=A0 u64 tmp;
> +
> +=C2=A0=C2=A0=C2=A0 /* Calculate mlux per bit based on als_it */
> +=C2=A0=C2=A0=C2=A0 ret =3D cm3232_read_als_it(chip, &als_it);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
> +=C2=A0=C2=A0=C2=A0 tmp =3D (__force u64)als_info->mlux_per_bit;
> +=C2=A0=C2=A0=C2=A0 tmp *=3D als_info->mlux_per_bit_base_it;
> +=C2=A0=C2=A0=C2=A0 tmp =3D div_u64 (tmp, als_it);
> +
> +=C2=A0=C2=A0=C2=A0 /* Get als_raw */

interesting comment :)

> +=C2=A0=C2=A0=C2=A0 als_info->als_raw =3D i2c_smbus_read_word_data(
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 CM3232_REG_ADDR_ALS);
> +=C2=A0=C2=A0=C2=A0 if (als_info->als_raw < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return als_info->als_raw;
> +
> +=C2=A0=C2=A0=C2=A0 tmp *=3D als_info->als_raw;
> +=C2=A0=C2=A0=C2=A0 tmp *=3D als_info->calibscale;
> +=C2=A0=C2=A0=C2=A0 tmp =3D div_u64(tmp, CM3232_CALIBSCALE_RESOLUTION);
> +=C2=A0=C2=A0=C2=A0 tmp =3D div_u64(tmp, CM3232_MLUX_PER_LUX);
> +
> +=C2=A0=C2=A0=C2=A0 if (tmp > 0xFFFF)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tmp =3D 0xFFFF;
> +
> +=C2=A0=C2=A0=C2=A0 return (int)tmp;
> +}
> +
> +static int cm3232_read_raw(struct iio_dev *indio_dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct iio_chan=
_spec const *chan,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int *val, int *=
val2, long mask)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cm3232_chip *chip =3D iio_priv(indio_dev);
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 switch (mask) {
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_PROCESSED:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D cm3232_get_lux(chip);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D ret;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBSCALE:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D als_info->calibscale;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return IIO_VAL_INT;
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_INT_TIME:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *val =3D 0;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ret =3D cm3232_read_als_it(chip, v=
al2);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +}
> +
> +static int cm3232_write_raw(struct iio_dev *indio_dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct iio_chan=
_spec const *chan,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 int val, int va=
l2, long mask)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cm3232_chip *chip =3D iio_priv(indio_dev);
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 long ms;

ms is cast into int later

what is ms -- milliseconds or microseconds? the latter I guess; ms is=20
usually millisecs

> +
> +=C2=A0=C2=A0=C2=A0 switch (mask) {
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBSCALE:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 als_info->calibscale =3D val;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return val;
> +=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_INT_TIME:
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ms =3D val * 1000000 + val2;
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return cm3232_write_als_it(chip, (=
int)ms);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return -EINVAL;
> +}
> +
> +/**
> + * cm3232_get_it_available() - Get available ALS IT value
> + * @dev:=C2=A0=C2=A0=C2=A0 pointer of struct device.
> + * @attr:=C2=A0=C2=A0=C2=A0 pointer of struct device_attribute.
> + * @buf:=C2=A0=C2=A0=C2=A0 pointer of return string buffer.
> + *
> + * Display the available integration time in milliseconds.
> + *
> + * Return: string length.
> + */
> +static ssize_t cm3232_get_it_available(struct device *dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct device_a=
ttribute *attr, char *buf)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cm3232_chip *chip =3D iio_priv(dev_to_iio_dev(=
dev));
> +=C2=A0=C2=A0=C2=A0 struct cm3232_als_info *als_info =3D chip->als_info;
> +=C2=A0=C2=A0=C2=A0 int i, len;
> +
> +=C2=A0=C2=A0=C2=A0 for (i =3D 0, len =3D 0; i < als_info->num_als_it; i+=
+)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 len +=3D scnprintf(buf + len, PAGE=
_SIZE - len, "%u.%06u ",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 als_info->als_i=
t_values[i]/1000000,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 als_info->als_i=
t_values[i]%1000000);
> +=C2=A0=C2=A0=C2=A0 return len + scnprintf(buf + len, PAGE_SIZE - len, "\=
n");
> +}
> +
> +static const struct iio_chan_spec cm3232_channels[] =3D {
> +=C2=A0=C2=A0=C2=A0 {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D IIO_LIGHT,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .info_mask_separate =3D
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_PROCESSED) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_CALIBSCALE) |
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_IN=
FO_INT_TIME),
> +=C2=A0=C2=A0=C2=A0 }
> +};
> +
> +static IIO_DEVICE_ATTR(in_illuminance_integration_time_available,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 S_IRUGO, cm3232=
_get_it_available, NULL, 0);
> +
> +static struct attribute *cm3232_attributes[] =3D {
> +=C2=A0=C2=A0=C2=A0 &iio_dev_attr_in_illuminance_integration_time_availab=
le.dev_attr.attr,
> +=C2=A0=C2=A0=C2=A0 NULL,
> +};
> +
> +static const struct attribute_group cm3232_attribute_group =3D {
> +=C2=A0=C2=A0=C2=A0 .attrs =3D cm3232_attributes
> +};
> +
> +static const struct iio_info cm3232_info =3D {
> +=C2=A0=C2=A0=C2=A0 .driver_module=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=3D THIS_MODULE,
> +=C2=A0=C2=A0=C2=A0 .read_raw=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &c=
m3232_read_raw,
> +=C2=A0=C2=A0=C2=A0 .write_raw=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D &=
cm3232_write_raw,
> +=C2=A0=C2=A0=C2=A0 .attrs=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =3D &cm3232_attribute_group,
> +};
> +
> +static int cm3232_probe(struct i2c_client *client,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 const struct i2=
c_device_id *id)
> +{
> +=C2=A0=C2=A0=C2=A0 struct cm3232_chip *chip;
> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev;
> +=C2=A0=C2=A0=C2=A0 int ret;
> +
> +=C2=A0=C2=A0=C2=A0 indio_dev =3D devm_iio_device_alloc(&client->dev, siz=
eof(*chip));
> +=C2=A0=C2=A0=C2=A0 if (!indio_dev) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&client->dev, "devm_iio_de=
vice_alloc failed\n");
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -ENOMEM;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 chip =3D iio_priv(indio_dev);
> +=C2=A0=C2=A0=C2=A0 i2c_set_clientdata(client, indio_dev);
> +=C2=A0=C2=A0=C2=A0 chip->client =3D client;
> +
> +=C2=A0=C2=A0=C2=A0 mutex_init(&chip->lock);
> +=C2=A0=C2=A0=C2=A0 indio_dev->dev.parent =3D &client->dev;
> +=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D cm3232_channels;
> +=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(cm3232_channel=
s);
> +=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &cm3232_info;
> +=C2=A0=C2=A0=C2=A0 if (id && id->name)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 indio_dev->name =3D id->name;
> +=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 indio_dev->name =3D (char *)dev_na=
me(&client->dev);
> +=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D cm3232_reg_init(chip);
> +=C2=A0=C2=A0=C2=A0 if (ret) {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 dev_err(&client->dev,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 "%s: register i=
nit failed\n",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __func__);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D iio_device_register(indio_dev);

ret not checked

> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +static int cm3232_remove(struct i2c_client *client)
> +{
> +=C2=A0=C2=A0=C2=A0 struct iio_dev *indio_dev =3D i2c_get_clientdata(clie=
nt);
> +
> +=C2=A0=C2=A0=C2=A0 iio_device_unregister(indio_dev);

maybe disable device?

> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +static const struct i2c_device_id cm3232_id[] =3D {
> +=C2=A0=C2=A0=C2=A0 { "cm3232", 0},
> +=C2=A0=C2=A0=C2=A0 { }
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cm3232_id);
> +
> +static const struct of_device_id cm3232_of_match[] =3D {
> +=C2=A0=C2=A0=C2=A0 { .compatible =3D "capella,cm3232" },
> +=C2=A0=C2=A0=C2=A0 { }
> +};
> +
> +static struct i2c_driver cm3232_driver =3D {
> +=C2=A0=C2=A0=C2=A0 .driver =3D {
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .name=C2=A0=C2=A0=C2=A0 =3D "cm323=
2",
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .owner=C2=A0=C2=A0=C2=A0 =3D THIS_=
MODULE,
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .of_match_table =3D of_match_ptr(c=
m3232_of_match),
> +=C2=A0=C2=A0=C2=A0 },
> +=C2=A0=C2=A0=C2=A0 .id_table=C2=A0=C2=A0=C2=A0 =3D cm3232_id,
> +=C2=A0=C2=A0=C2=A0 .probe=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D cm323=
2_probe,
> +=C2=A0=C2=A0=C2=A0 .remove=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =3D cm32=
32_remove,
> +};
> +
> +module_i2c_driver(cm3232_driver);
> +
> +MODULE_AUTHOR("Kevin Tsai <ktsai@capellamicro.com>");
> +MODULE_DESCRIPTION("CM3232 ambient light sensor driver");
> +MODULE_LICENSE("GPL");
>=20

--=20

Peter Meerwald
+43-664-2444418 (mobile)


  
------=_Part_3545073_1948205960.1420172606867
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:16px"><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_4556"><span>Hi Peter,</span></div=
><div dir=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_3376"><span><br></span><=
/div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_3378"><span id=3D"yu=
i_3_16_0_1_1420171459038_3377">Thanks for your comments. &nbsp;I will updat=
e and resubmit it next week.</span></div><div dir=3D"ltr" id=3D"yui_3_16_0_=
1_1420171459038_3381"><span><br></span></div><div dir=3D"ltr" id=3D"yui_3_1=
6_0_1_1420171459038_3379"><span>About your question:</span></div><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_3380"><span style=3D"font-family:=
 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-seri=
f; font-size: 13px;" class=3D"">&gt; +&nbsp;&nbsp;&nbsp; als_it =3D chip-&g=
t;regs_cmd;</span><br style=3D"font-family: 'Helvetica Neue', 'Segoe UI', H=
elvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;" class=3D"">=
<span style=3D"font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial,=
 'Lucida Grande', sans-serif; font-size: 13px;" class=3D"">&gt; +&nbsp;&nbs=
p;&nbsp; als_it &amp;=3D CM3232_CMD_ALS_IT_MASK;</span><br style=3D"font-fa=
mily: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans=
-serif; font-size: 13px;" class=3D""><span style=3D"font-family: 'Helvetica=
 Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande', sans-serif; font-siz=
e: 13px;" class=3D"">&gt; +&nbsp;&nbsp;&nbsp; als_it &gt;&gt;=3D CM3232_CMD=
_ALS_IT_SHIFT;</span><br style=3D"font-family: 'Helvetica Neue', 'Segoe UI'=
, Helvetica, Arial, 'Lucida Grande', sans-serif; font-size: 13px;" class=3D=
""><br style=3D"font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial=
, 'Lucida Grande', sans-serif; font-size: 13px;" class=3D""><span style=3D"=
font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Grande=
', sans-serif; font-size: 13px;" class=3D"">there is no i2c read here?!</sp=
an><span><br></span></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1420171459038=
_3709"><span style=3D"font-family: 'Helvetica Neue', 'Segoe UI', Helvetica,=
 Arial, 'Lucida Grande', sans-serif; font-size: 13px;" class=3D""><br></spa=
n></div><div dir=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_3710"><span style=
=3D"font-family: 'Helvetica Neue', 'Segoe UI', Helvetica, Arial, 'Lucida Gr=
ande', sans-serif; font-size: 13px;" class=3D"">KT: Configure register is "=
Write only" register. &nbsp;I use "chip-&gt;regs_cmd" to store the value.</=
span></div><div id=3D"yui_3_16_0_1_1420171459038_3909"><br></div><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1420171459038_3911">Thanks.</div><div dir=3D"lt=
r" id=3D"yui_3_16_0_1_1420171459038_3912"><br></div><div dir=3D"ltr" id=3D"=
yui_3_16_0_1_1420171459038_4562">Kevin Tsai</div><div dir=3D"ltr" id=3D"yui=
_3_16_0_1_1420171459038_4563">01/01/15</div><div dir=3D"ltr" id=3D"yui_3_16=
_0_1_1420171459038_4564"><br></div>  <div style=3D"font-family: Courier New=
, courier, monaco, monospace, sans-serif; font-size: 16px;" id=3D"yui_3_16_=
0_1_1420171459038_3713"> <div style=3D"font-family: HelveticaNeue, Helvetic=
a Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;" id=
=3D"yui_3_16_0_1_1420171459038_3712"> <div dir=3D"ltr" id=3D"yui_3_16_0_1_1=
420171459038_3711"> <hr size=3D"1">  <font size=3D"2" face=3D"Arial" id=3D"=
yui_3_16_0_1_1420171459038_3714"> <b id=3D"yui_3_16_0_1_1420171459038_4566"=
><span style=3D"font-weight:bold;" id=3D"yui_3_16_0_1_1420171459038_4565">F=
rom:</span></b> Peter Meerwald &lt;pmeerw@pmeerw.net&gt;<br> <b><span style=
=3D"font-weight: bold;">To:</span></b> Kevin Tsai &lt;ktsai@capellamicro.co=
m&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span></b> Jonathan Cam=
eron &lt;jic23@kernel.org&gt;; Hartmut Knaack &lt;knaack.h@gmx.de&gt;; Lars=
-Peter Clausen &lt;lars@metafoo.de&gt;; Daniel Baluta &lt;daniel.baluta@int=
el.com&gt;; Archana Patni &lt;archana.patni@linux.intel.com&gt;; linux-iio@=
vger.kernel.org <br> <b><span style=3D"font-weight: bold;">Sent:</span></b>=
 Thursday, January 1, 2015 3:02 AM<br> <b><span style=3D"font-weight: bold;=
">Subject:</span></b> Re: [PATCH V1 1/1] iio: Added Capella cm3232 ambient =
light sensor driver.<br> </font> </div> <div class=3D"y_msg_container" id=
=3D"yui_3_16_0_1_1420171459038_4315"><br>On Wed, 31 Dec 2014, Kevin Tsai wr=
ote:<br><br>&gt; CM3232 is an advanced ambient light sensor with I2C protoc=
ol interface.<br>&gt; The I2C slave address is internally hardwired as 0x10=
 (7-bit).&nbsp; Writing<br>&gt; to configure register is byte mode, but rea=
ding ALS register requests to<br>&gt; use word mode for 16-bit resolution.<=
br><br>comments below<br> <br>&gt; Signed-off-by: Kevin Tsai &lt;<a ymailto=
=3D"mailto:ktsai@capellamicro.com" href=3D"mailto:ktsai@capellamicro.com">k=
tsai@capellamicro.com</a>&gt;<br>&gt; ---<br>&gt;&nbsp; .../devicetree/bind=
ings/i2c/trivial-devices.txt&nbsp; &nbsp; |&nbsp;  1 +<br>&gt;&nbsp; MAINTA=
INERS&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbs=
p;  6 +<br>&gt;&nbsp; drivers/iio/light/Kconfig&nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; |&nbsp; 11 +=
<br>&gt;&nbsp; drivers/iio/light/Makefile&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  |&nbsp;  1 +<br>&gt;&nbs=
p; drivers/iio/light/cm3232.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  | 403 +++++++++++++++++++++<br>&gt;&=
nbsp; 5 files changed, 422 insertions(+)<br>&gt;&nbsp; create mode 100644 d=
rivers/iio/light/cm3232.c<br>&gt; <br>&gt; diff --git a/Documentation/devic=
etree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/=
i2c/trivial-devices.txt<br>&gt; index 9f4e382..572a7c4 100644<br>&gt; --- a=
/Documentation/devicetree/bindings/i2c/trivial-devices.txt<br>&gt; +++ b/Do=
cumentation/devicetree/bindings/i2c/trivial-devices.txt<br>&gt; @@ -34,6 +3=
4,7 @@ atmel,24c512&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i2c serial eeprom&=
nbsp; (24cxx)<br>&gt;&nbsp; atmel,24c1024&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; i2c serial eeprom&nbsp; (24cxx)<br>&gt;&nbsp; atmel,at97sc3204t&nbsp;&n=
bsp;&nbsp; i2c trusted platform module (TPM)<br>&gt;&nbsp; capella,cm32181&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; CM32181: Ambient Light Sensor<br>&gt; =
+capella,cm3232&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; CM3232: Ambient Light =
Sensor<br>&gt;&nbsp; catalyst,24c32&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i2=
c serial eeprom<br>&gt;&nbsp; cirrus,cs42l51&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; Cirrus Logic CS42L51 audio codec<br>&gt;&nbsp; dallas,ds1307&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; 64 x 8, Serial, I2C Real-Time Clock<br>&gt; d=
iff --git a/MAINTAINERS b/MAINTAINERS<br>&gt; index ddb9ac8..06a613a 100644=
<br>&gt; --- a/MAINTAINERS<br>&gt; +++ b/MAINTAINERS<br>&gt; @@ -2378,6 +23=
78,12 @@ F:&nbsp;&nbsp;&nbsp; security/capability.c<br>&gt;&nbsp; F:&nbsp;&=
nbsp;&nbsp; security/commoncap.c<br>&gt;&nbsp; F:&nbsp;&nbsp;&nbsp; kernel/=
capability.c<br>&gt;&nbsp; <br>&gt; +CAPELLA MICROSYSTEMS LIGHT SENSOR DRIV=
ER<br>&gt; +M:&nbsp;&nbsp;&nbsp; Kevin Tsai &lt;<a ymailto=3D"mailto:ktsai@=
capellamicro.com" href=3D"mailto:ktsai@capellamicro.com">ktsai@capellamicro=
.com</a>&gt;<br>&gt; +S:&nbsp;&nbsp;&nbsp; Maintained<br>&gt; +F:&nbsp;&nbs=
p;&nbsp; drivers/iio/light/cm*<br>&gt; +F:&nbsp;&nbsp;&nbsp; Documentation/=
devicetree/bindings/i2c/trivial-devices.txt<br>&gt; +<br>&gt;&nbsp; CC2520 =
IEEE-802.15.4 RADIO DRIVER<br>&gt;&nbsp; M:&nbsp;&nbsp;&nbsp; Varka Bhadram=
 &lt;<a ymailto=3D"mailto:varkabhadram@gmail.com" href=3D"mailto:varkabhadr=
am@gmail.com">varkabhadram@gmail.com</a>&gt;<br>&gt;&nbsp; L:&nbsp;&nbsp;&n=
bsp; <a ymailto=3D"mailto:linux-wpan@vger.kernel.org" href=3D"mailto:linux-=
wpan@vger.kernel.org">linux-wpan@vger.kernel.org</a><br>&gt; diff --git a/d=
rivers/iio/light/Kconfig b/drivers/iio/light/Kconfig<br>&gt; index 5bea821.=
.d2318e2 100644<br>&gt; --- a/drivers/iio/light/Kconfig<br>&gt; +++ b/drive=
rs/iio/light/Kconfig<br>&gt; @@ -48,6 +48,17 @@ config CM32181<br>&gt;&nbsp=
; &nbsp;&nbsp;&nbsp;  To compile this driver as a module, choose M here:<br=
>&gt;&nbsp; &nbsp;&nbsp;&nbsp;  the module will be called cm32181.<br>&gt;&=
nbsp; <br>&gt; +config CM3232<br>&gt; +&nbsp;&nbsp;&nbsp; depends on I2C<br=
>&gt; +&nbsp;&nbsp;&nbsp; tristate "CM3232 driver"<br>&gt; +&nbsp;&nbsp;&nb=
sp; help<br>&gt; +&nbsp;&nbsp;&nbsp;  Say Y here if you use cm3232.<br>&gt;=
 +&nbsp;&nbsp;&nbsp;  This option enables ambient light sensor using<br>&gt=
; +&nbsp;&nbsp;&nbsp;  Capella Microsystems cm3232 device driver.<br>&gt; +=
<br>&gt; +&nbsp;&nbsp;&nbsp;  To compile this driver as a module, choose M =
here:<br>&gt; +&nbsp;&nbsp;&nbsp;  the module will be called cm3232.<br>&gt=
; +<br>&gt;&nbsp; config CM36651<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp; depends o=
n I2C<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp; tristate "CM36651 driver"<br>&gt; di=
ff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile<br>&gt; =
index 47877a3..f2c8d55 100644<br>&gt; --- a/drivers/iio/light/Makefile<br>&=
gt; +++ b/drivers/iio/light/Makefile<br>&gt; @@ -7,6 +7,7 @@ obj-$(CONFIG_A=
DJD_S311)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; +=3D adjd_s311.o<br>&gt;&nbs=
p; obj-$(CONFIG_AL3320A)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; +=3D al3320a.=
o<br>&gt;&nbsp; obj-$(CONFIG_APDS9300)&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 +=3D apds9300.o<br>&gt;&nbsp; obj-$(CONFIG_CM32181)&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; +=3D cm32181.o<br>&gt; +obj-$(CONFIG_CM3232)&nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; +=3D cm3232.o<br>&gt;&nbsp; obj-$(CONFIG_CM36651)&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; +=3D cm36651.o<br>&gt;&nbsp; obj-$(CONFIG=
_GP2AP020A00F)&nbsp;&nbsp;&nbsp; +=3D gp2ap020a00f.o<br>&gt;&nbsp; obj-$(CO=
NFIG_HID_SENSOR_ALS)&nbsp;&nbsp;&nbsp; +=3D hid-sensor-als.o<br>&gt; diff -=
-git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c<br>&gt; new =
file mode 100644<br>&gt; index 0000000..fd98eeb<br>&gt; --- /dev/null<br>&g=
t; +++ b/drivers/iio/light/cm3232.c<br>&gt; @@ -0,0 +1,403 @@<br>&gt; +/*<b=
r>&gt; + * Copyright (C) 2014 Capella Microsystems Inc.<br>&gt; + * Author:=
 Kevin Tsai &lt;<a ymailto=3D"mailto:ktsai@capellamicro.com" href=3D"mailto=
:ktsai@capellamicro.com">ktsai@capellamicro.com</a>&gt;<br>&gt; + *<br>&gt;=
 + * This program is free software; you can redistribute it and/or modify i=
t<br>&gt; + * under the terms of the GNU General Public License version 2, =
as published<br>&gt; + * by the Free Software Foundation.<br>&gt; + *<br>&g=
t; + */<br>&gt; +<br>&gt; +#include &lt;linux/delay.h&gt;<br>&gt; +#include=
 &lt;linux/err.h&gt;<br>&gt; +#include &lt;linux/i2c.h&gt;<br>&gt; +#includ=
e &lt;linux/mutex.h&gt;<br>&gt; +#include &lt;linux/module.h&gt;<br>&gt; +#=
include &lt;linux/interrupt.h&gt;<br>&gt; +#include &lt;linux/regulator/con=
sumer.h&gt;<br>&gt; +#include &lt;linux/iio/iio.h&gt;<br>&gt; +#include &lt=
;linux/iio/sysfs.h&gt;<br>&gt; +#include &lt;linux/iio/events.h&gt;<br>&gt;=
 +#include &lt;linux/init.h&gt;<br>&gt; +<br>&gt; +/* Registers Address */<=
br>&gt; +#define CM3232_REG_ADDR_CMD&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0=
x00<br>&gt; +#define CM3232_REG_ADDR_ALS&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; 0x50<br>&gt; +#define CM3232_REG_ADDR_ID&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; 0x53<br>&gt; +<br>&gt; +/* CMD register */<br>&gt; +#define CM3232_CM=
D_ALS_DISABLE&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BIT(0)<br>&gt; +#define&=
nbsp;&nbsp;&nbsp; CM3232_CMD_ALS_HS&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BI=
T(1)<br><br>whitespace issue, replace tab with space<br>ALS_HS is not used<=
br><br>&gt; +<br>&gt; +#define CM3232_CMD_ALS_IT_SHIFT&nbsp; &nbsp; &nbsp; =
&nbsp;  2<br>&gt; +#define CM3232_CMD_ALS_IT_MASK&nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; (0x07 &lt;&lt; CM3232_CMD_ALS_IT_SHIFT)<br>&gt; +#define CM3232_CM=
D_ALS_IT_DEFAULT&nbsp; &nbsp; &nbsp;  (0x01 &lt;&lt; CM3232_CMD_ALS_IT_SHIF=
T)<br>&gt; +<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3232_CMD_ALS_RESET&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BIT(6)<br>&gt; +<br>&gt; +#define CM3232_CMD=
_DEFAULT&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; CM3232_CMD_ALS_IT_DEFAULT<br>=
&gt; +<br>&gt; +#define CM3232_CALIBSCALE_DEFAULT&nbsp;&nbsp;&nbsp; 100000<=
br>&gt; +#define CM3232_CALIBSCALE_RESOLUTION&nbsp;&nbsp;&nbsp; 100000<br>&=
gt; +#define CM3232_MLUX_PER_LUX&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 1000<=
br>&gt; +<br>&gt; +#define CM3232_MLUX_PER_BIT_DEFAULT&nbsp;&nbsp;&nbsp; 64=
<br>&gt; +#define CM3232_MLUX_PER_BIT_BASE_IT&nbsp;&nbsp;&nbsp; 100000<br>&=
gt; +static const int CM3232_als_it_bits[] =3D { 0, 1, 2, 3, 4, 5};<br><br>=
cm3232_als_it_bits and remove space before 0<br><br>&gt; +static const int =
CM3232_als_it_values[] =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; 100000, 200000, 400000, 800000, 1600000, 3200000};<br><=
br>cm3232_als_it_values<br><br>&gt; +<br>&gt; +struct cm3232_als_info {<br>=
<br>that may pay off lateron, currently there is just one chip...<br><br>&g=
t; +&nbsp;&nbsp;&nbsp; u32 id;<br>&gt; +&nbsp;&nbsp;&nbsp; int calibscale;<=
br>&gt; +&nbsp;&nbsp;&nbsp; int mlux_per_bit;<br>&gt; +&nbsp;&nbsp;&nbsp; i=
nt mlux_per_bit_base_it;<br>&gt; +&nbsp;&nbsp;&nbsp; const int *als_it_bits=
;<br>&gt; +&nbsp;&nbsp;&nbsp; const int *als_it_values;<br>&gt; +&nbsp;&nbs=
p;&nbsp; const int num_als_it;<br><br>num_als_it could be unsigned probably=
<br><br>&gt; +&nbsp;&nbsp;&nbsp; int als_raw;<br>&gt; +};<br>&gt; +<br>&gt;=
 +static struct cm3232_als_info cm3232_als_info_default =3D {<br>&gt; +&nbs=
p;&nbsp;&nbsp; .id =3D 3232,<br>&gt; +&nbsp;&nbsp;&nbsp; .calibscale =3D CM=
3232_CALIBSCALE_DEFAULT,<br>&gt; +&nbsp;&nbsp;&nbsp; .mlux_per_bit =3D CM32=
32_MLUX_PER_BIT_DEFAULT,<br>&gt; +&nbsp;&nbsp;&nbsp; .mlux_per_bit_base_it =
=3D CM3232_MLUX_PER_BIT_BASE_IT,<br>&gt; +&nbsp;&nbsp;&nbsp; .als_it_bits =
=3D CM3232_als_it_bits,<br>&gt; +&nbsp;&nbsp;&nbsp; .als_it_values =3D CM32=
32_als_it_values,<br>&gt; +&nbsp;&nbsp;&nbsp; .num_als_it =3D ARRAY_SIZE(CM=
3232_als_it_bits),<br>&gt; +};<br>&gt; +<br>&gt; +struct cm3232_chip {<br>&=
gt; +&nbsp;&nbsp;&nbsp; struct i2c_client *client;<br>&gt; +&nbsp;&nbsp;&nb=
sp; struct mutex lock;<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3232_als_info *=
als_info;<br>&gt; +&nbsp;&nbsp;&nbsp; u8 regs_cmd;<br>&gt; +};<br>&gt; +<br=
>&gt; +static int cm3232_get_lux(struct cm3232_chip *chip);<br>&gt; +static=
 int cm3232_read_als_it(struct cm3232_chip *chip, int *val2);<br>&gt; +<br>=
&gt; +/**<br>&gt; + * cm3232_reg_init() - Initialize CM3232 registers<br>&g=
t; + * @chip:&nbsp;&nbsp;&nbsp; pointer of struct cm3232.<br>&gt; + *<br>&g=
t; + * Initialize CM3232 ambient light sensor register to default values.<b=
r><br>checks for and initializes; registers<br><br>&gt; + *<br>&gt; +&nbsp;=
 Return: 0 for success; otherwise for error code.<br>&gt; + */<br>&gt; +sta=
tic int cm3232_reg_init(struct cm3232_chip *chip)<br>&gt; +{<br>&gt; +&nbsp=
;&nbsp;&nbsp; struct i2c_client *client =3D chip-&gt;client;<br>&gt; +&nbsp=
;&nbsp;&nbsp; struct cm3232_als_info *als_info;<br>&gt; +&nbsp;&nbsp;&nbsp;=
 s32 ret;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Identify device */<br>&g=
t; +&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_read_word_data(client, CM3232_REG_=
ADDR_ID);<br>&gt; +&nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>&gt; +&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; return ret;<br>&gt; +&nbsp;&nbsp;&nbsp; if ((ret =
&amp; 0xFF) !=3D 0x32)<br><br>this could/should use the .id field of _als_i=
nfo<br><br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENODEV;<br>&=
gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Disable and reset device */<br>&gt; +&=
nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd =3D CM3232_CMD_ALS_DISABLE | CM3232_CMD=
_ALS_RESET;<br>&gt; +&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_byte_data(c=
lient, CM3232_REG_ADDR_CMD,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd);<br>&gt; +&nbsp;&n=
bsp;&nbsp; if (ret &lt; 0)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; r=
eturn ret;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Initialization */<br>&g=
t; +&nbsp;&nbsp;&nbsp; als_info =3D chip-&gt;als_info =3D &amp;cm3232_als_i=
nfo_default;<br>&gt; +&nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd =3D CM3232_CMD_D=
EFAULT;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Configure register */<br>&=
gt; +&nbsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_byte_data(client, CM3232_RE=
G_ADDR_CMD,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd);<br>&gt; +&nbsp;&nbsp;&nbsp; if (r=
et &lt; 0)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;<br>&g=
t; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +<br>&gt; +/*=
*<br>&gt; + *&nbsp; cm3232_read_als_it() - Get sensor integration time (ms)=
<br>&gt; + *&nbsp; @chip:&nbsp;&nbsp;&nbsp; pointer of struct cm3232<br>&gt=
; + *&nbsp; @val2:&nbsp;&nbsp;&nbsp; pointer of int to load the als_it valu=
e.<br>&gt; + *<br>&gt; + *&nbsp; Report the current integration time in mil=
liseconds.<br>&gt; + *<br>&gt; + *&nbsp; Return: IIO_VAL_INT_PLUS_MICRO for=
 success, otherwise -EINVAL.<br>&gt; + */<br>&gt; +static int cm3232_read_a=
ls_it(struct cm3232_chip *chip, int *val2)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;=
&nbsp; struct cm3232_als_info *als_info =3D chip-&gt;als_info;<br>&gt; +&nb=
sp;&nbsp;&nbsp; u16 als_it;<br>&gt; +&nbsp;&nbsp;&nbsp; int i;<br>&gt; +<br=
>&gt; +&nbsp;&nbsp;&nbsp; als_it =3D chip-&gt;regs_cmd;<br>&gt; +&nbsp;&nbs=
p;&nbsp; als_it &amp;=3D CM3232_CMD_ALS_IT_MASK;<br>&gt; +&nbsp;&nbsp;&nbsp=
; als_it &gt;&gt;=3D CM3232_CMD_ALS_IT_SHIFT;<br><br>there is no i2c read h=
ere?!<br>what is regs_cmd? the name seems to be rather inappropriate<br><br=
>&gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; als_info-&gt;num_als_it; i++=
) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (als_it =3D=3D als_in=
fo-&gt;als_it_bits[i]) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; *val2 =3D als_info-&gt;als_it_values[i];<br>&gt; +&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return IIO_VAL_INT_PLUS_MIC=
RO;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>&gt; +&nbsp;&nbsp;&=
nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return -EINVAL;<br>&gt; +}<br=
>&gt; +<br>&gt; +/**<br>&gt; + * cm3232_write_als_it() - Write sensor integ=
ration time<br>&gt; + * @chip:&nbsp;&nbsp;&nbsp; pointer of struct cm3232.<=
br>&gt; + * @val:&nbsp;&nbsp;&nbsp; integration time in milliseconds.<br>&g=
t; + *<br>&gt; + * Convert integration time (ms) to sensor value.<br>&gt; +=
 *<br>&gt; + * Return: i2c_smbus_write_word_data command return value.<br><=
br>write_byte_data<br><br>&gt; + */<br>&gt; +static int cm3232_write_als_it=
(struct cm3232_chip *chip, int val)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; =
struct i2c_client *client =3D chip-&gt;client;<br>&gt; +&nbsp;&nbsp;&nbsp; =
struct cm3232_als_info *als_info =3D chip-&gt;als_info;<br>&gt; +&nbsp;&nbs=
p;&nbsp; u16 als_it;<br>&gt; +&nbsp;&nbsp;&nbsp; int ret, i;<br>&gt; +<br>&=
gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; als_info-&gt;num_als_it; i++)<=
br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (val &lt;=3D als_info-&gt=
;als_it_values[i])<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; break;<br>&gt; +&nbsp;&nbsp;&nbsp; if (i &gt;=3D als_info-&gt;num=
_als_it)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; i =3D als_info-&gt;=
num_als_it - 1;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; als_it =3D als_info-&=
gt;als_it_bits[i];<br>&gt; +&nbsp;&nbsp;&nbsp; als_it &lt;&lt;=3D CM3232_CM=
D_ALS_IT_SHIFT;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;chip-=
&gt;lock);<br><br>I don't see what the mutex is trying to lock -- why?<br><=
br>&gt; +&nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd &amp;=3D ~CM3232_CMD_ALS_IT_M=
ASK;<br>&gt; +&nbsp;&nbsp;&nbsp; chip-&gt;regs_cmd |=3D als_it;<br>&gt; +&n=
bsp;&nbsp;&nbsp; ret =3D i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_=
CMD,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip=
-&gt;regs_cmd);<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock=
);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return ret;<br>&gt; +}<br>&gt; +<b=
r>&gt; +/**<br>&gt; + * cm3232_get_lux() - report current lux value<br>&gt;=
 + * @chip:&nbsp;&nbsp;&nbsp; pointer of struct cm3232.<br>&gt; + *<br>&gt;=
 + * Convert sensor raw data to lux.&nbsp; It depends on integration<br>&gt=
; + * time and calibscale variable.<br>&gt; + *<br>&gt; + * Return: Positiv=
e value is lux, otherwise is error code.<br><br>otherwise error code<br><br=
>&gt; + */<br>&gt; +static int cm3232_get_lux(struct cm3232_chip *chip)<br>=
&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D chip-&gt;=
client;<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3232_als_info *als_info =3D ch=
ip-&gt;als_info;<br>&gt; +&nbsp;&nbsp;&nbsp; int ret;<br>&gt; +&nbsp;&nbsp;=
&nbsp; int als_it;<br>&gt; +&nbsp;&nbsp;&nbsp; u64 tmp;<br>&gt; +<br>&gt; +=
&nbsp;&nbsp;&nbsp; /* Calculate mlux per bit based on als_it */<br>&gt; +&n=
bsp;&nbsp;&nbsp; ret =3D cm3232_read_als_it(chip, &amp;als_it);<br>&gt; +&n=
bsp;&nbsp;&nbsp; if (ret &lt; 0)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; return -EINVAL;<br>&gt; +&nbsp;&nbsp;&nbsp; tmp =3D (__force u64)als_i=
nfo-&gt;mlux_per_bit;<br>&gt; +&nbsp;&nbsp;&nbsp; tmp *=3D als_info-&gt;mlu=
x_per_bit_base_it;<br>&gt; +&nbsp;&nbsp;&nbsp; tmp =3D div_u64 (tmp, als_it=
);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Get als_raw */<br><br>interesti=
ng comment :)<br><br>&gt; +&nbsp;&nbsp;&nbsp; als_info-&gt;als_raw =3D i2c_=
smbus_read_word_data(<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; client,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; CM3232_REG_ADDR_ALS);<br>=
&gt; +&nbsp;&nbsp;&nbsp; if (als_info-&gt;als_raw &lt; 0)<br>&gt; +&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; return als_info-&gt;als_raw;<br>&gt; +<br>&gt=
; +&nbsp;&nbsp;&nbsp; tmp *=3D als_info-&gt;als_raw;<br>&gt; +&nbsp;&nbsp;&=
nbsp; tmp *=3D als_info-&gt;calibscale;<br>&gt; +&nbsp;&nbsp;&nbsp; tmp =3D=
 div_u64(tmp, CM3232_CALIBSCALE_RESOLUTION);<br>&gt; +&nbsp;&nbsp;&nbsp; tm=
p =3D div_u64(tmp, CM3232_MLUX_PER_LUX);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nb=
sp; if (tmp &gt; 0xFFFF)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; tmp=
 =3D 0xFFFF;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return (int)tmp;<br>&gt;=
 +}<br>&gt; +<br>&gt; +static int cm3232_read_raw(struct iio_dev *indio_dev=
,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct =
iio_chan_spec const *chan,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; int *val, int *val2, long mask)<br>&gt; +{<br>&gt; +&nbsp=
;&nbsp;&nbsp; struct cm3232_chip *chip =3D iio_priv(indio_dev);<br>&gt; +&n=
bsp;&nbsp;&nbsp; struct cm3232_als_info *als_info =3D chip-&gt;als_info;<br=
>&gt; +&nbsp;&nbsp;&nbsp; int ret;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; sw=
itch (mask) {<br>&gt; +&nbsp;&nbsp;&nbsp; case IIO_CHAN_INFO_PROCESSED:<br>=
&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D cm3232_get_lux(chip);<b=
r>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (ret &lt; 0)<br>&gt; +&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;<br>&gt; +&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *val =3D ret;<br>&gt; +&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; return IIO_VAL_INT;<br>&gt; +&nbsp;&nbsp;&nbsp; case=
 IIO_CHAN_INFO_CALIBSCALE:<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *=
val =3D als_info-&gt;calibscale;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; return IIO_VAL_INT;<br>&gt; +&nbsp;&nbsp;&nbsp; case IIO_CHAN_INFO_INT=
_TIME:<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *val =3D 0;<br>&gt; +=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D cm3232_read_als_it(chip, val2=
);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;<br>&gt; +&nbs=
p;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return -EINVAL;<br>&=
gt; +}<br>&gt; +<br>&gt; +static int cm3232_write_raw(struct iio_dev *indio=
_dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; str=
uct iio_chan_spec const *chan,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; &nbsp;&nbsp;&nbsp; int val, int val2, long mask)<br>&gt; +{<br>&gt; +&nb=
sp;&nbsp;&nbsp; struct cm3232_chip *chip =3D iio_priv(indio_dev);<br>&gt; +=
&nbsp;&nbsp;&nbsp; struct cm3232_als_info *als_info =3D chip-&gt;als_info;<=
br>&gt; +&nbsp;&nbsp;&nbsp; long ms;<br><br>ms is cast into int later<br><b=
r>what is ms -- milliseconds or microseconds? the latter I guess; ms is <br=
>usually millisecs<br><br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; switch (mask) =
{<br>&gt; +&nbsp;&nbsp;&nbsp; case IIO_CHAN_INFO_CALIBSCALE:<br>&gt; +&nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; als_info-&gt;calibscale =3D val;<br>&gt; +=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return val;<br>&gt; +&nbsp;&nbsp;&nbs=
p; case IIO_CHAN_INFO_INT_TIME:<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; ms =3D val * 1000000 + val2;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; return cm3232_write_als_it(chip, (int)ms);<br>&gt; +&nbsp;&nbsp;&nbsp;=
 }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return -EINVAL;<br>&gt; +}<br>&gt;=
 +<br>&gt; +/**<br>&gt; + * cm3232_get_it_available() - Get available ALS I=
T value<br>&gt; + * @dev:&nbsp;&nbsp;&nbsp; pointer of struct device.<br>&g=
t; + * @attr:&nbsp;&nbsp;&nbsp; pointer of struct device_attribute.<br>&gt;=
 + * @buf:&nbsp;&nbsp;&nbsp; pointer of return string buffer.<br>&gt; + *<b=
r>&gt; + * Display the available integration time in milliseconds.<br>&gt; =
+ *<br>&gt; + * Return: string length.<br>&gt; + */<br>&gt; +static ssize_t=
 cm3232_get_it_available(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *bu=
f)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3232_chip *chip =3D iio_=
priv(dev_to_iio_dev(dev));<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3232_als_in=
fo *als_info =3D chip-&gt;als_info;<br>&gt; +&nbsp;&nbsp;&nbsp; int i, len;=
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0, len =3D 0; i &lt; als_=
info-&gt;num_als_it; i++)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; le=
n +=3D scnprintf(buf + len, PAGE_SIZE - len, "%u.%06u ",<br>&gt; +&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; als_info-&gt;als_it_values[=
i]/1000000,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p; als_info-&gt;als_it_values[i]%1000000);<br>&gt; +&nbsp;&nbsp;&nbsp; retu=
rn len + scnprintf(buf + len, PAGE_SIZE - len, "\n");<br>&gt; +}<br>&gt; +<=
br>&gt; +static const struct iio_chan_spec cm3232_channels[] =3D {<br>&gt; =
+&nbsp;&nbsp;&nbsp; {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type =
=3D IIO_LIGHT,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .info_mask_se=
parate =3D<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; BIT(IIO_CHAN_INFO_PROCESSED) |<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; BIT(IIO_CHAN_INFO_CALIBSCALE) |<br>&gt; +&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; BIT(IIO_CHAN_INFO_INT_TIME),=
<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +};<br>&gt; +<br>&gt; +static IIO_DE=
VICE_ATTR(in_illuminance_integration_time_available,<br>&gt; +&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; S_IRUGO, cm3232_get_it_availabl=
e, NULL, 0);<br>&gt; +<br>&gt; +static struct attribute *cm3232_attributes[=
] =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; &amp;iio_dev_attr_in_illuminance_integr=
ation_time_available.dev_attr.attr,<br>&gt; +&nbsp;&nbsp;&nbsp; NULL,<br>&g=
t; +};<br>&gt; +<br>&gt; +static const struct attribute_group cm3232_attrib=
ute_group =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; .attrs =3D cm3232_attributes<br=
>&gt; +};<br>&gt; +<br>&gt; +static const struct iio_info cm3232_info =3D {=
<br>&gt; +&nbsp;&nbsp;&nbsp; .driver_module&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; =3D THIS_MODULE,<br>&gt; +&nbsp;&nbsp;&nbsp; .read_raw&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; =3D &amp;cm3232_read_raw,<br>&gt; +&nbsp;&nbsp;&nbsp=
; .write_raw&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D &amp;cm3232_write_raw=
,<br>&gt; +&nbsp;&nbsp;&nbsp; .attrs&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; =3D &amp;cm3232_attribute_group,<br>&gt; +};<br>&gt; +<br=
>&gt; +static int cm3232_probe(struct i2c_client *client,<br>&gt; +&nbsp;&n=
bsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; const struct i2c_device_id=
 *id)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3232_chip *chip;<br>&=
gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev;<br>&gt; +&nbsp;&nbsp;&nb=
sp; int ret;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev =3D devm_iio_d=
evice_alloc(&amp;client-&gt;dev, sizeof(*chip));<br>&gt; +&nbsp;&nbsp;&nbsp=
; if (!indio_dev) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_err(=
&amp;client-&gt;dev, "devm_iio_device_alloc failed\n");<br>&gt; +&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; return -ENOMEM;<br>&gt; +&nbsp;&nbsp;&nbsp; }<b=
r>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; chip =3D iio_priv(indio_dev);<br>&gt; =
+&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, indio_dev);<br>&gt; +&nbsp;&=
nbsp;&nbsp; chip-&gt;client =3D client;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbs=
p; mutex_init(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&g=
t;dev.parent =3D &amp;client-&gt;dev;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev=
-&gt;channels =3D cm3232_channels;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&g=
t;num_channels =3D ARRAY_SIZE(cm3232_channels);<br>&gt; +&nbsp;&nbsp;&nbsp;=
 indio_dev-&gt;info =3D &amp;cm3232_info;<br>&gt; +&nbsp;&nbsp;&nbsp; if (i=
d &amp;&amp; id-&gt;name)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; in=
dio_dev-&gt;name =3D id-&gt;name;<br>&gt; +&nbsp;&nbsp;&nbsp; else<br>&gt; =
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; indio_dev-&gt;name =3D (char *)dev_n=
ame(&amp;client-&gt;dev);<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;modes =
=3D INDIO_DIRECT_MODE;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; ret =3D cm3232=
_reg_init(chip);<br>&gt; +&nbsp;&nbsp;&nbsp; if (ret) {<br>&gt; +&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<br>&gt; +&nbsp;&nb=
sp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "%s: register init failed\n=
",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; __func=
__);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return ret;<br>&gt; +&n=
bsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; ret =3D iio_device=
_register(indio_dev);<br><br>ret not checked<br><br>&gt; +&nbsp;&nbsp;&nbsp=
; return 0;<br>&gt; +}<br>&gt; +<br>&gt; +static int cm3232_remove(struct i=
2c_client *client)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *i=
ndio_dev =3D i2c_get_clientdata(client);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nb=
sp; iio_device_unregister(indio_dev);<br><br>maybe disable device?<br><br>&=
gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +<br>&gt; +static cons=
t struct i2c_device_id cm3232_id[] =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; { "cm3=
232", 0},<br>&gt; +&nbsp;&nbsp;&nbsp; { }<br>&gt; +};<br>&gt; +<br>&gt; +MO=
DULE_DEVICE_TABLE(i2c, cm3232_id);<br>&gt; +<br>&gt; +static const struct o=
f_device_id cm3232_of_match[] =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; { .compatib=
le =3D "capella,cm3232" },<br>&gt; +&nbsp;&nbsp;&nbsp; { }<br>&gt; +};<br>&=
gt; +<br>&gt; +static struct i2c_driver cm3232_driver =3D {<br>&gt; +&nbsp;=
&nbsp;&nbsp; .driver =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .=
name&nbsp;&nbsp;&nbsp; =3D "cm3232",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; .owner&nbsp;&nbsp;&nbsp; =3D THIS_MODULE,<br>&gt; +&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; .of_match_table =3D of_match_ptr(cm3232_of_match),<b=
r>&gt; +&nbsp;&nbsp;&nbsp; },<br>&gt; +&nbsp;&nbsp;&nbsp; .id_table&nbsp;&n=
bsp;&nbsp; =3D cm3232_id,<br>&gt; +&nbsp;&nbsp;&nbsp; .probe&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; =3D cm3232_probe,<br>&gt; +&nbsp;&nbsp;&nbsp; .remov=
e&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D cm3232_remove,<br>&gt; +};<br>&g=
t; +<br>&gt; +module_i2c_driver(cm3232_driver);<br>&gt; +<br>&gt; +MODULE_A=
UTHOR("Kevin Tsai &lt;<a ymailto=3D"mailto:ktsai@capellamicro.com" href=3D"=
mailto:ktsai@capellamicro.com">ktsai@capellamicro.com</a>&gt;");<br>&gt; +M=
ODULE_DESCRIPTION("CM3232 ambient light sensor driver");<br>&gt; +MODULE_LI=
CENSE("GPL");<br>&gt; <br><br>-- <br><br>Peter Meerwald<br>+43-664-2444418 =
(mobile)<br><br><br></div> </div> </div>  </div></body></html>
------=_Part_3545073_1948205960.1420172606867--
