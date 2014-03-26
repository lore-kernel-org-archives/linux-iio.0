Return-Path: <ktsai@capellamicro.com>
References: <1395773538-2649-1-git-send-email-ktsai@capellamicro.com> <alpine.DEB.2.01.1403260025350.13112@pmeerw.net> <7781785490BB4EA78BBDC2E5DB00E920@GustyD430> <alpine.DEB.2.01.1403260120230.13112@pmeerw.net>
Message-ID: <1395809544.53200.YahooMailNeo@web122006.mail.ne1.yahoo.com>
Date: Tue, 25 Mar 2014 21:52:24 -0700 (PDT)
From: Kevin Tsai <ktsai@capellamicro.com>
Reply-To: Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH V3 1/1] iio: add Capella cm3218x ambient light sensor driver.
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
  "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.01.1403260120230.13112@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="-1192396609-1770039525-1395809544=:53200"
List-ID: <linux-iio@vger.kernel.org>

---1192396609-1770039525-1395809544=:53200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,=0A=0AThanks for your explanation. =C2=A0I will follow your advise=
 and resubmit.=0A=0AHave a nice day.=0A=0AKevin Tsai=0A03/25/14=0A=0A=0A___=
_____________________________=0A From: Peter Meerwald <pmeerw@pmeerw.net>=
=0ATo: Kevin Tsai <ktsai@capellamicro.com> =0ACc: Jonathan Cameron <jic23@k=
ernel.org>; linux-iio@vger.kernel.org =0ASent: Tuesday, March 25, 2014 5:40=
 PM=0ASubject: Re: [PATCH V3 1/1] iio: add Capella cm3218x ambient light se=
nsor driver.=0A =0A=0A=0A> (1). Not all machines use ACPI method.=C2=A0 For=
 example, one of my machines=0A> loads driver by manually.=0A=0Athe driver =
fails to compile if CONFIG_ACPI is not defined, e.g. on ARM =0Aplatform, he=
nce I think 'depends on ACPI' is appropriate in Kconfig=0A=0Amaybe you coul=
d #ifdef certain function in the driver if ACPI is not =0Aavailable in orde=
r to support devices without ACPI=0A=0Adrivers/iio/light/cm3218x.c: In func=
tion =E2=80=98cm3218x_acpi_get_cpm_info=E2=80=99:=0Adrivers/iio/light/cm321=
8x.c:195:2: error: unknown type name =E2=80=98acpi_handle=E2=80=99=0Adriver=
s/iio/light/cm3218x.c:196:9: error: variable =E2=80=98buffer=E2=80=99 has =
=0Ainitializer but incomplete type=0A=C2=A0 structacpi_buffer buffer =3D {A=
CPI_ALLOCATE_BUFFER, NULL};=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0  ^=0Adrivers/iio/=
light/cm3218x.c:196:31: error: =E2=80=98ACPI_ALLOCATE_BUFFER=E2=80=99 =0Aun=
declared (first use in this function)=0A=C2=A0 structacpi_buffer buffer =3D=
 {ACPI_ALLOCATE_BUFFER, NULL};=0A=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  ^=0A...=0A=
=0A> (2). About the ARA register, some of sensors use SMBus ARA, others use=
 I2C=0A> to report interrupt.=C2=A0 I need to call i2c_new_dummy() to read =
the ARA=0A> register to clean interrupt.=C2=A0 Otherwise, device may be blo=
cked by SMBus=0A> protocol.=C2=A0 In the _remove(), I have to call i2c_unre=
gister_device(chip->ara).=0A> Otherwise, I cannot get the handler for ARA w=
hen I reload this module.=0A=0Amy concern is that if an error occurs in _pr=
obe() after calling =0Ai2c_new_dummy(), the matching i2c_unregister_device(=
chip->ara) is missing=0A=0Aregards, p.=0A=0A> ----- Original Message ----- =
From: "Peter Meerwald" <pmeerw@pmeerw.net>=0A> To: "Kevin Tsai" <ktsai@cape=
llamicro.com>=0A> Cc: "Jonathan Cameron" <jic23@kernel.org>; <linux-iio@vge=
r.kernel.org>=0A> Sent: Tuesday, March 25, 2014 16:39=0A> Subject: Re: [PAT=
CH V3 1/1] iio: add Capella cm3218x ambient light sensor=0A> driver.=0A> =
=0A> =0A> > =0A> > > Add Capella Microsystem CM3218X family Ambient Light S=
ensor IIO driver.=0A> > > This driver will convert raw data to lux value.=
=C2=A0 Default parameters are=0A> > > for reference only.=C2=A0 It will det=
ect ACPI table to load per-system=0A> > > manufacturing=0A> > > parameters.=
=0A> > > =0A> > > V2: Follow Jonathan Cameron's advise to separate device i=
d.=0A> > > Also, follow Peter Meerwald's advise to correct whitespace, pref=
ix, and,=0A> > > comments.=0A> > > =0A> > > V3: Follow Peter Meerwald's adv=
ise to create a separated i2c_client=0A> > > handler to=0A> > > access SMBu=
s ARA register.=0A> > =0A> > couple of minor comments...=0A> > =0A> > > Sig=
ned-off-by: Kevin Tsai <ktsai@capellamicro.com>=0A> > > ---=0A> > >=C2=A0 .=
../devicetree/bindings/i2c/trivial-devices.txt=C2=A0 =C2=A0 |=C2=A0  1 +=0A=
> > >=C2=A0 drivers/iio/light/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 11 +=0A> > >=
=C2=A0 drivers/iio/light/Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0  |=C2=A0  1 +=0A> > >=C2=A0 drive=
rs/iio/light/cm3218x.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 745=0A> > > +++++++++++++++++++++=0A> > >=
=C2=A0 4 files changed, 758 insertions(+)=0A> > >=C2=A0 create mode 100644 =
drivers/iio/light/cm3218x.c=0A> > > =0A> > > diff --git a/Documentation/dev=
icetree/bindings/i2c/trivial-devices.txt=0A> > > b/Documentation/devicetree=
/bindings/i2c/trivial-devices.txt=0A> > > index 1a1ac2e..c3c869b 100644=0A>=
 > > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt=0A> > =
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt=0A> > > @=
@ -17,6 +17,7 @@ at,24c08 i2c serial eeprom=C2=A0 (24cxx)=0A> > >=C2=A0 atm=
el,24c02 i2c serial eeprom=C2=A0 (24cxx)=0A> > >=C2=A0 atmel,at97sc3204t i2=
c trusted platform module (TPM)=0A> > >=C2=A0 capella,cm32181 CM32181: Ambi=
ent Light Sensor=0A> > > +capella,cm3218x CM3218X: Ambient Light Sensor=0A>=
 > >=C2=A0 catalyst,24c32 i2c serial eeprom=0A> > >=C2=A0 dallas,ds1307 64 =
x 8, Serial, I2C Real-Time Clock=0A> > >=C2=A0 dallas,ds1338 I2C RTC with 5=
6-Byte NV RAM=0A> > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/=
light/Kconfig=0A> > > index d12b2a0..97a341a 100644=0A> > > --- a/drivers/i=
io/light/Kconfig=0A> > > +++ b/drivers/iio/light/Kconfig=0A> > > @@ -38,6 +=
38,17 @@ config CM32181=0A> > >=C2=A0 To compile this driver as a module, c=
hoose M here:=0A> > >=C2=A0 the module will be called cm32181.=0A> > > =0A>=
 > > +config CM3218X=0A> > > + depends on I2C=0A> > =0A> > depends on I2C &=
& ACPI ???=0A> > =0A> > > + tristate "CM3218X driver"=0A> > > + help=0A> > =
> + Say Y here if you use cm3218x.=0A> > > + This option enables ambient li=
ght sensor using=0A> > > + Capella cm3218x device driver.=0A> > > +=0A> > >=
 + To compile this driver as a module, choose M here:=0A> > > + the module =
will be called cm3218x.=0A> > > +=0A> > >=C2=A0 config CM36651=0A> > >=C2=
=A0 depends on I2C=0A> > >=C2=A0 tristate "CM36651 driver"=0A> > > diff --g=
it a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile=0A> > > index =
60e35ac..a506c23 100644=0A> > > --- a/drivers/iio/light/Makefile=0A> > > ++=
+ b/drivers/iio/light/Makefile=0A> > > @@ -6,6 +6,7 @@=0A> > >=C2=A0 obj-$(=
CONFIG_ADJD_S311) +=3D adjd_s311.o=0A> > >=C2=A0 obj-$(CONFIG_APDS9300) +=
=3D apds9300.o=0A> > >=C2=A0 obj-$(CONFIG_CM32181) +=3D cm32181.o=0A> > > +=
obj-$(CONFIG_CM3218X) +=3D cm3218x.o=0A> > >=C2=A0 obj-$(CONFIG_CM36651) +=
=3D cm36651.o=0A> > >=C2=A0 obj-$(CONFIG_GP2AP020A00F) +=3D gp2ap020a00f.o=
=0A> > >=C2=A0 obj-$(CONFIG_HID_SENSOR_ALS) +=3D hid-sensor-als.o=0A> > > d=
iff --git a/drivers/iio/light/cm3218x.c b/drivers/iio/light/cm3218x.c=0A> >=
 > new file mode 100644=0A> > > index 0000000..efd0d0a=0A> > > --- /dev/nul=
l=0A> > > +++ b/drivers/iio/light/cm3218x.c=0A> > > @@ -0,0 +1,745 @@=0A> >=
 > +/*=0A> > > + * Copyright (C) 2014 Capella Microsystems Inc.=0A> > > + *=
 Author: Kevin Tsai <ktsai@capellamicro.com>=0A> > > + *=0A> > > + * This p=
rogram is free software; you can redistribute it and/or modify=0A> > > it=
=0A> > > + * under the terms of the GNU General Public License version 2, a=
s=0A> > > published=0A> > > + * by the Free Software Foundation.=0A> > > + =
*=0A> > > + * Special thanks SrinivasPandruvada=0A> > > <srinivas.pandruvad=
a@linux.intel.com>=0A> > > + * help to add ACPI support.=0A> > > + *=0A> > =
> + */=0A> > > +=0A> > > +#include <linux/delay.h>=0A> > > +#include <linux=
/err.h>=0A> > > +#include <linux/i2c.h>=0A> > > +#include <linux/mutex.h>=
=0A> > > +#include <linux/module.h>=0A> > > +#include <linux/interrupt.h>=
=0A> > > +#include <linux/regulator/consumer.h>=0A> > > +#include <linux/ii=
o/iio.h>=0A> > > +#include <linux/iio/sysfs.h>=0A> > > +#include <linux/iio=
/events.h>=0A> > > +#include <linux/init.h>=0A> > > +#include <linux/acpi.h=
>=0A> > > +=0A> > > +/* Registers Address */=0A> > > +#define CM3218X_REG_A=
DDR_CMD 0x00=0A> > > +#define CM3218X_REG_ADDR_WH 0x01=0A> > > +#define CM3=
218X_REG_ADDR_WL 0x02=0A> > > +#define CM3218X_REG_ADDR_TEST 0x03=0A> > > +=
#define CM3218X_REG_ADDR_ALS 0x04=0A> > > +#define CM3218X_REG_ADDR_STATUS =
0x06=0A> > > +#define CM3218X_REG_ADDR_ID 0x07=0A> > > +=0A> > > +/* Number=
 of Configurable Registers */=0A> > > +#define CM3218X_CONF_REG_NUM 16=0A> =
> > +=0A> > > +/* CMD register */=0A> > > +#define CM3218X_CMD_ALS_DISABLE =
BIT(0)=0A> > > +#define CM3218X_CMD_ALS_INT_EN BIT(1)=0A> > > +#define CM32=
18X_CMD_ALS_THRES_WINDOW BIT(2)=0A> > > +=0A> > > +#define CM3218X_CMD_ALS_=
PERS_SHIFT 4=0A> > > +#define CM3218X_CMD_ALS_PERS_MASK (0x03 << CM3218X_CM=
D_ALS_PERS_SHIFT)=0A> > > +#define CM3218X_CMD_ALS_PERS_DEFAULT (0x01 <<=0A=
> > > CM3218X_CMD_ALS_PERS_SHIFT)=0A> > > +=0A> > > +#define CM3218X_CMD_AL=
S_IT_SHIFT 6=0A> > > +#define CM3218X_CMD_ALS_IT_MASK (0x0F << CM3218X_CMD_=
ALS_IT_SHIFT)=0A> > > +#define CM3218X_CMD_ALS_IT_DEFAULT (0x01 << CM3218X_=
CMD_ALS_IT_SHIFT)=0A> > > +=0A> > > +#define CM3218X_CMD_ALS_HS_SHIFT 11=0A=
> > > +#define CM3218X_CMD_ALS_HS_MASK (0x01 << CM3218X_CMD_ALS_HS_SHIFT)=
=0A> > > +#define CM3218X_CMD_ALS_HS_DEFAULT (0x00 << CM3218X_CMD_ALS_HS_SH=
IFT)=0A> > > +=0A> > > +#define CM3218X_CMD_DEFAULT (CM3218X_CMD_ALS_THRES_=
WINDOW |\=0A> > > + CM3218X_CMD_ALS_PERS_DEFAULT |\=0A> > > + CM3218X_CMD_A=
LS_IT_DEFAULT |\=0A> > > + CM3218X_CMD_ALS_HS_DEFAULT)=0A> > > +=0A> > > +#=
define CM3218X_WH_DEFAULT 0xFFFF=0A> > > +#define CM3218X_WL_DEFAULT 0x0000=
=0A> > > +=0A> > > +#define CM3218X_CALIBSCALE_DEFAULT 100000=0A> > > +#def=
ine CM3218X_CALIBSCALE_RESOLUTION 100000=0A> > > +#define CM3218X_MLUX_PER_=
LUX 1000=0A> > > +#define CM3218X_THRESHOLD_PERCENT 10 /* 10 percent */=0A>=
 > > +=0A> > > +#define CM3218X_ARA 0x0C=0A> > > +=0A> > > +/* CM3218X fami=
ly */=0A> > > +enum {=0A> > > + cm3218,=0A> > > + cm32181,=0A> > > + cm3218=
2=0A> > > +};=0A> > > +=0A> > > +/* CM3218 Family */=0A> > > +#define CM321=
8_MLUX_PER_BIT_DEFAULT 5 /* Depend on system */=0A> > > +#define CM3218_MLU=
X_PER_BIT_BASE_IT 800000=0A> > > +static const int CM3218_als_it_bits[] =3D=
 {0, 1, 2, 3};=0A> > > +static const int CM3218_als_it_values[] =3D {100000=
, 200000, 400000,=0A> > > 800000};=0A> > > +=0A> > > +/* CM32181 Family */=
=0A> > > +#define CM32181_MLUX_PER_BIT_DEFAULT 5=0A> > > +#define CM32181_M=
LUX_PER_BIT_BASE_IT 800000=0A> > > +static const int CM32181_als_it_bits[] =
=3D {12, 8, 0, 1, 2, 3};=0A> > > +static const int CM32181_als_it_values[] =
=3D {=0A> > > + 25000, 50000, 100000, 200000, 400000, 800000};=0A> > > +=0A=
> > > +struct cm3218x_als_info {=0A> > > + u32 id;=0A> > > + int int_type;=
=0A> > > +#define CM3218X_INT_TYPE_SMBUS 0=0A> > > +#define CM3218X_INT_TYP=
E_I2C 1=0A> > > + int regs_bmp;=0A> > > + int calibscale;=0A> > > + int mlu=
x_per_bit;=0A> > > + int mlux_per_bit_base_it;=0A> > > + const int *als_it_=
bits;=0A> > > + const int *als_it_values;=0A> > > + int num_als_it;=0A> > >=
 + int als_raw;=0A> > > +};=0A> > > +=0A> > > +static struct cm3218x_als_in=
fo cm3218_info =3D {=0A> > > + 3218, CM3218X_INT_TYPE_SMBUS, 0x0F, CM3218X_=
CALIBSCALE_DEFAULT,=0A> > > + CM3218_MLUX_PER_BIT_DEFAULT, CM3218_MLUX_PER_=
BIT_BASE_IT,=0A> > > + CM3218_als_it_bits, CM3218_als_it_values,=0A> > > + =
ARRAY_SIZE(CM3218_als_it_bits), 0};=0A> > =0A> > const?=0A> > =0A> > > +=0A=
> > > +static struct cm3218x_als_info cm32181_info =3D {=0A> > > + 32181, C=
M3218X_INT_TYPE_I2C, 0x0F, CM3218X_CALIBSCALE_DEFAULT,=0A> > > + CM32181_ML=
UX_PER_BIT_DEFAULT, CM32181_MLUX_PER_BIT_BASE_IT,=0A> > > + CM32181_als_it_=
bits, CM32181_als_it_values,=0A> > > + ARRAY_SIZE(CM32181_als_it_bits), 0};=
=0A> > > +=0A> > > +static struct cm3218x_als_info cm32182_info =3D {=0A> >=
 > + 32182, CM3218X_INT_TYPE_I2C, 0x0F, CM3218X_CALIBSCALE_DEFAULT,=0A> > >=
 + CM32181_MLUX_PER_BIT_DEFAULT, CM32181_MLUX_PER_BIT_BASE_IT,=0A> > > + CM=
32181_als_it_bits, CM32181_als_it_values,=0A> > > + ARRAY_SIZE(CM32181_als_=
it_bits), 0};=0A> > > +=0A> > > +struct cm3218x_chip {=0A> > > + struct i2c=
_client *client;=0A> > > + struct i2c_client *ara;=0A> > > + structmutex lo=
ck;=0A> > > + u16 conf_regs[CM3218X_CONF_REG_NUM];=0A> > > + struct cm3218x=
_als_info *als_info;=0A> > > +};=0A> > > +=0A> > > +static int cm3218x_get_=
lux(struct cm3218x_chip *chip);=0A> > > +static int cm3218x_threshold_updat=
e(struct cm3218x_chip *chip, int=0A> > > percent);=0A> > > +static int cm32=
18x_read_als_it(struct cm3218x_chip *chip, int *val2);=0A> > > +=0A> > > +/=
**=0A> > > + * cm3218x_interrupt_config() - Enable/Disable CM3218X interrup=
t=0A> > > + * @chip: pointer of struct cm3218x.=0A> > > + * @enable: 0 to d=
isable; otherwise to enable=0A> > > + *=0A> > > + * Config CM3218X interrup=
t control bit.=0A> > > + *=0A> > > + * Return: 0 for success; otherwise for=
 error code.=0A> > > + */=0A> > > +static int cm3218x_interrupt_config(stru=
ct cm3218x_chip *chip, int=0A> > > enable)=0A> > > +{=0A> > > + struct i2c_=
client *client =3D chip->client;=0A> > > + struct cm3218x_als_info *als_inf=
o =3D chip->als_info;=0A> > > + int status;=0A> > > +=0A> > > + if (!als_in=
fo)=0A> > > + return -ENODEV;=0A> > > +=0A> > > + /* Force to clean interru=
pt */=0A> > > + if (als_info->int_type =3D=3D CM3218X_INT_TYPE_I2C) {=0A> >=
 > + status =3D i2c_smbus_read_word_data(client,=0A> > > + CM3218X_REG_ADDR=
_STATUS);=0A> > > + if (status < 0)=0A> > > + als_info->int_type =3D CM3218=
X_INT_TYPE_SMBUS;=0A> > > + }=0A> > > + if (chip->ara && als_info->int_type=
 =3D=3D CM3218X_INT_TYPE_SMBUS)=0A> > > + i2c_smbus_read_byte(chip->ara);=
=0A> > > +=0A> > > + if (enable)=0A> > > + chip->conf_regs[CM3218X_REG_ADDR=
_CMD] |=3D=0A> > > + CM3218X_CMD_ALS_INT_EN;=0A> > > + else=0A> > > + chip-=
>conf_regs[CM3218X_REG_ADDR_CMD] &=3D=0A> > > + ~CM3218X_CMD_ALS_INT_EN;=0A=
> > > +=0A> > > + status =3D i2c_smbus_write_word_data(client, CM3218X_REG_=
ADDR_CMD,=0A> > > + chip->conf_regs[CM3218X_REG_ADDR_CMD]);=0A> > > +=0A> >=
 > + if (status < 0)=0A> > > + return -ENODEV;=0A> > > +=0A> > > + return s=
tatus;=0A> > > +}=0A> > > +=0A> > > +/**=0A> > > + * cm3218x_acpi_get_cpm_i=
nfo() - Get CPM object from ACPI=0A> > > + * @client pointer of struct i2c_=
client.=0A> > > + * @obj_name pointer of ACPI object name.=0A> > > + * @cou=
nt maximum size of return array.=0A> > > + * @vals pointer of array for ret=
urn elements.=0A> > > + *=0A> > > + * Convert ACPICPM table to array. Speci=
al thanks SrinivasPandruvada's=0A> > > + * help to implement this routine.=
=0A> > > + *=0A> > > + * Return: -ENODEV for fail.=C2=A0 Otherwise is numbe=
r of elements.=0A> > > + */=0A> > > +static int cm3218x_acpi_get_cpm_info(s=
truct i2c_client *client, char=0A> > > *obj_name,=0A> > > + int count, u64 =
*vals)=0A> > > +{=0A> > > + acpi_handle handle;=0A> > > + structacpi_buffer=
 buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};=0A> > > + int i;=0A> > > + acpi_s=
tatus status;=0A> > > + union acpi_object *cpm;=0A> > > +=0A> > > + handle =
=3D ACPI_HANDLE(&client->dev);=0A> > > + if (!handle)=0A> > > + return -ENO=
DEV;=0A> > > +=0A> > > + status =3D acpi_evaluate_object(handle, obj_name, =
NULL, &buffer);=0A> > > + if (ACPI_FAILURE(status)) {=0A> > > + dev_err(&cl=
ient->dev, "object %s not found\n", obj_name);=0A> > > + return -ENODEV;=0A=
> > > + }=0A> > > +=0A> > > + cpm =3D buffer.pointer;=0A> > > + for (i =3D =
0; i < cpm->package.count && i < count; ++i) {=0A> > > + union acpi_object =
*elem;=0A> > > + elem =3D &(cpm->package.elements[i]);=0A> > > + vals[i] =
=3D elem->integer.value;=0A> > > + }=0A> > > +=0A> > > + kfree(buffer.point=
er);=0A> > > +=0A> > > + return cpm->package.count;=0A> > > +}=0A> > > +=0A=
> > > +/**=0A> > > + * cm3218x_reg_init() - Initialize CM3218X registers=0A=
> > > + * @chip: pointer of struct cm3218x.=0A> > > + *=0A> > > + * Initial=
ize CM3218X ambient light sensor register to default values.=0A> > > + *=0A=
> > > +=C2=A0 Return: 0 for success; otherwise for error code.=0A> > > + */=
=0A> > > +static int cm3218x_reg_init(struct cm3218x_chip *chip)=0A> > > +{=
=0A> > > + struct i2c_client *client =3D chip->client;=0A> > > + int i;=0A>=
 > > + s32 ret;=0A> > > + int cpm_elem_count;=0A> > > + u64 cpm_elems[20];=
=0A> > > + struct cm3218x_als_info *als_info;=0A> > > +=0A> > > + /* Defaul=
t device */=0A> > > + chip->als_info =3D &cm3218_info;=0A> > > + chip->conf=
_regs[CM3218X_REG_ADDR_CMD] =3D CM3218X_CMD_DEFAULT;=0A> > > + chip->conf_r=
egs[CM3218X_REG_ADDR_WH] =3D CM3218X_WH_DEFAULT;=0A> > > + chip->conf_regs[=
CM3218X_REG_ADDR_WL] =3D CM3218X_WL_DEFAULT;=0A> > > +=0A> > > + /* Disable=
 interrupt */=0A> > > + cm3218x_interrupt_config(chip, 0);=0A> > > +=0A> > =
> + /* Disable Test Mode */=0A> > > + i2c_smbus_write_word_data(client, CM3=
218X_REG_ADDR_TEST, 0x0000);=0A> > > +=0A> > > + /* Disable device */=0A> >=
 > + i2c_smbus_write_word_data(client, CM3218X_REG_ADDR_CMD,=0A> > > + CM32=
18X_CMD_ALS_DISABLE);=0A> > > +=0A> > > + /* Identify device */=0A> > > + r=
et =3D i2c_smbus_read_word_data(client, CM3218X_REG_ADDR_ID);=0A> > > + if =
(ret < 0)=0A> > > + return ret;=0A> > > + switch (ret & 0xFF) {=0A> > > + c=
ase 0x18:=0A> > > + als_info =3D chip->als_info =3D &cm3218_info;=0A> > > +=
 if (ret & 0x0800)=0A> > > + als_info->int_type =3D CM3218X_INT_TYPE_I2C;=
=0A> > > + else=0A> > > + als_info->int_type =3D CM3218X_INT_TYPE_SMBUS;=0A=
> > > + break;=0A> > > + case 0x81:=0A> > > + als_info =3D chip->als_info =
=3D &cm32181_info;=0A> > > + break;=0A> > > + case 0x82:=0A> > > + als_info=
 =3D chip->als_info =3D &cm32182_info;=0A> > > + break;=0A> > > + default:=
=0A> > > + return -ENODEV;=0A> > > + }=0A> > > +=0A> > > + if (ACPI_HANDLE(=
&client->dev)) {=0A> > > + /* Load from ACPI */=0A> > > + cpm_elem_count =
=3D cm3218x_acpi_get_cpm_info(client, "CPM0",=0A> > > + ARRAY_SIZE(cpm_elem=
s),=0A> > > + cpm_elems);=0A> > > + if (cpm_elem_count > 0) {=0A> > > + int=
 header_num =3D 3;=0A> > > + int reg_num =3D cpm_elem_count - header_num;=
=0A> > > +=0A> > > + als_info->regs_bmp =3D cpm_elems[2];=0A> > > + for (i =
=3D 0; i < reg_num; i++)=0A> > > + if (als_info->regs_bmp & (1<<i))=0A> > >=
 + chip->conf_regs[i] =3D=0A> > > + cpm_elems[header_num+i];=0A> > > + }=0A=
> > > +=0A> > > + cpm_elem_count =3D cm3218x_acpi_get_cpm_info(client, "CPM=
1",=0A> > > + ARRAY_SIZE(cpm_elems),=0A> > > + cpm_elems);=0A> > > + if (cp=
m_elem_count > 0) {=0A> > > + als_info->mlux_per_bit =3D (int)cpm_elems[0] =
/ 100;=0A> > > + als_info->calibscale =3D (int)cpm_elems[1];=0A> > > + }=0A=
> > > + }=0A> > > +=0A> > > + /* Force to disable interrupt */=0A> > > + ch=
ip->conf_regs[CM3218X_REG_ADDR_CMD] &=3D ~CM3218X_CMD_ALS_INT_EN;=0A> > > +=
=0A> > > + /* Initialize registers */=0A> > > + for (i =3D 0; i < CM3218X_C=
ONF_REG_NUM; i++) {=0A> > > + if (als_info->regs_bmp & (1<<i)) {=0A> > > + =
ret =3D i2c_smbus_write_word_data(client, i,=0A> > > + chip->conf_regs[i]);=
=0A> > > + if (ret < 0)=0A> > > + return ret;=0A> > > + }=0A> > > + }=0A> >=
 > +=0A> > > + return 0;=0A> > > +}=0A> > > +=0A> > > +/**=0A> > > + *=C2=
=A0 cm3218x_read_als_it() - Get sensor integration time (ms)=0A> > > + *=C2=
=A0 @chip: pointer of struct cm3218x=0A> > > + *=C2=A0 @val2: pointer of in=
t to load the als_it value.=0A> > > + *=0A> > > + *=C2=A0 Report the curren=
t integartion time in milliseconds.=0A> > =0A> > integration=0A> > =0A> > >=
 + *=0A> > > + *=C2=A0 Return: IIO_VAL_INT_PLUS_MICRO for success, otherwis=
e -EINVAL.=0A> > > + */=0A> > > +static int cm3218x_read_als_it(struct cm32=
18x_chip *chip, int *val2)=0A> > > +{=0A> > > + struct cm3218x_als_info *al=
s_info =3D chip->als_info;=0A> > > + u16 als_it;=0A> > > + int i;=0A> > > +=
=0A> > > + als_it =3D chip->conf_regs[CM3218X_REG_ADDR_CMD];=0A> > > + als_=
it &=3D CM3218X_CMD_ALS_IT_MASK;=0A> > > + als_it >>=3D CM3218X_CMD_ALS_IT_=
SHIFT;=0A> > > + for (i =3D 0; i < als_info->num_als_it; i++) {=0A> > > + i=
f (als_it =3D=3D als_info->als_it_bits[i]) {=0A> > > + *val2 =3D als_info->=
als_it_values[i];=0A> > > + return IIO_VAL_INT_PLUS_MICRO;=0A> > > + }=0A> =
> > + }=0A> > > +=0A> > > + return -EINVAL;=0A> > > +}=0A> > > +=0A> > > +/=
**=0A> > > + * cm3218x_write_als_it() - Write sensor integration time=0A> >=
 > + * @chip: pointer of struct cm3218x.=0A> > > + * @val: integration time=
 in milliseconds.=0A> > > + *=0A> > > + * Convert integration time (ms) to =
sensor value.=0A> > > + *=0A> > > + * Return: i2c_smbus_write_word_data com=
mand return value.=0A> > > + */=0A> > > +static int cm3218x_write_als_it(st=
ruct cm3218x_chip *chip, int val)=0A> > > +{=0A> > > + struct i2c_client *c=
lient =3D chip->client;=0A> > > + struct cm3218x_als_info *als_info =3D chi=
p->als_info;=0A> > > + u16 als_it;=0A> > > + int ret, i;=0A> > > +=0A> > > =
+ for (i =3D 0; i < als_info->num_als_it; i++)=0A> > > + if (val <=3D als_i=
nfo->als_it_values[i])=0A> > > + break;=0A> > > + if (i >=3D als_info->num_=
als_it)=0A> > > + i =3D als_info->num_als_it - 1;=0A> > > +=0A> > > + als_i=
t =3D als_info->als_it_bits[i];=0A> > > + als_it <<=3D CM3218X_CMD_ALS_IT_S=
HIFT;=0A> > > +=0A> > > + mutex_lock(&chip->lock);=0A> > > + chip->conf_reg=
s[CM3218X_REG_ADDR_CMD] &=3D=0A> > > + ~CM3218X_CMD_ALS_IT_MASK;=0A> > > + =
chip->conf_regs[CM3218X_REG_ADDR_CMD] |=3D=0A> > > + als_it;=0A> > > + ret =
=3D i2c_smbus_write_word_data(client, CM3218X_REG_ADDR_CMD,=0A> > > + chip-=
>conf_regs[CM3218X_REG_ADDR_CMD]);=0A> > > + mutex_unlock(&chip->lock);=0A>=
 > > +=0A> > > + return ret;=0A> > > +}=0A> > > +=0A> > > +/**=0A> > > + * =
cm3218x_get_lux() - report current lux value=0A> > > + * @chip: pointer of =
struct cm3218x.=0A> > > + *=0A> > > + * Convert sensor raw data to lux.=C2=
=A0 It depends on integration=0A> > > + * time and calibscale variable.=0A>=
 > > + *=0A> > > + * Return: Positive value is lux, otherwise is error code=
.=0A> > > + */=0A> > > +static int cm3218x_get_lux(struct cm3218x_chip *chi=
p)=0A> > > +{=0A> > > + struct i2c_client *client =3D chip->client;=0A> > >=
 + struct cm3218x_als_info *als_info =3D chip->als_info;=0A> > > + int ret;=
=0A> > > + int als_it;=0A> > > + u64 tmp;=0A> > > +=0A> > > + /* Calculate =
mlux per bit based on als_it */=0A> > > + ret =3D cm3218x_read_als_it(chip,=
 &als_it);=0A> > > + if (ret < 0)=0A> > > + return -EINVAL;=0A> > > + tmp =
=3D (__force u64)als_info->mlux_per_bit;=0A> > > + tmp *=3D als_info->mlux_=
per_bit_base_it;=0A> > > + tmp =3D div_u64(tmp, als_it);=0A> > > +=0A> > > =
+ /* Get als_raw */=0A> > > + if (!(chip->conf_regs[CM3218X_REG_ADDR_CMD] &=
 CM3218X_CMD_ALS_INT_EN))=0A> > > + als_info->als_raw =3D i2c_smbus_read_wo=
rd_data(=0A> > > + client,=0A> > > + CM3218X_REG_ADDR_ALS);=0A> > > + if (a=
ls_info->als_raw < 0)=0A> > > + return als_info->als_raw;=0A> > > +=0A> > >=
 + tmp *=3D als_info->als_raw;=0A> > > + tmp *=3D als_info->calibscale;=0A>=
 > > + tmp =3D div_u64(tmp, CM3218X_CALIBSCALE_RESOLUTION);=0A> > > + tmp =
=3D div_u64(tmp, CM3218X_MLUX_PER_LUX);=0A> > > +=0A> > > + if (tmp > 0xFFF=
F)=0A> > > + tmp =3D 0xFFFF;=0A> > > +=0A> > > + return (int)tmp;=0A> > > +=
}=0A> > > +=0A> > > +static int cm3218x_read_raw(struct iio_dev *indio_dev,=
=0A> > > + struct iio_chan_spec const *chan,=0A> > > + int *val, int *val2,=
 long mask)=0A> > > +{=0A> > > + struct cm3218x_chip *chip =3D iio_priv(ind=
io_dev);=0A> > > + struct cm3218x_als_info *als_info =3D chip->als_info;=0A=
> > > + int ret;=0A> > > +=0A> > > + switch (mask) {=0A> > > + case IIO_CHA=
N_INFO_PROCESSED:=0A> > > + ret =3D cm3218x_get_lux(chip);=0A> > > + if (re=
t < 0)=0A> > > + return ret;=0A> > > + *val =3D ret;=0A> > > + return IIO_V=
AL_INT;=0A> > > + case IIO_CHAN_INFO_CALIBSCALE:=0A> > > + *val =3D als_inf=
o->calibscale;=0A> > > + return IIO_VAL_INT;=0A> > > + case IIO_CHAN_INFO_I=
NT_TIME:=0A> > > + *val =3D 0;=0A> > > + ret =3D cm3218x_read_als_it(chip, =
val2);=0A> > > + return ret;=0A> > > + }=0A> > > +=0A> > > + return -EINVAL=
;=0A> > > +}=0A> > > +=0A> > > +static int cm3218x_write_raw(struct iio_dev=
 *indio_dev,=0A> > > + struct iio_chan_spec const *chan,=0A> > > + int val,=
 int val2, long mask)=0A> > > +{=0A> > > + struct cm3218x_chip *chip =3D ii=
o_priv(indio_dev);=0A> > > + struct cm3218x_als_info *als_info =3D chip->al=
s_info;=0A> > > + long ms;=0A> > > +=0A> > > + switch (mask) {=0A> > > + ca=
se IIO_CHAN_INFO_CALIBSCALE:=0A> > > + als_info->calibscale =3D val;=0A> > =
> + return val;=0A> > > + case IIO_CHAN_INFO_INT_TIME:=0A> > > + ms =3D val=
 * 1000000 + val2;=0A> > > + return cm3218x_write_als_it(chip, (int)ms);=0A=
> > > + }=0A> > > +=0A> > > + return -EINVAL;=0A> > > +}=0A> > > +=0A> > > =
+/**=0A> > > + * cm3218x_get_it_available() - Get available ALS IT value=0A=
> > > + * @dev: pointer of struct device.=0A> > > + * @attr: pointer of str=
uct device_attribute.=0A> > > + * @buf: pointer of return string buffer.=0A=
> > > + *=0A> > > + * Display the available integration time in millisecond=
s.=0A> > > + *=0A> > > + * Return: string length.=0A> > > + */=0A> > > +sta=
tic ssize_t cm3218x_get_it_available(struct device *dev,=0A> > > + struct d=
evice_attribute *attr, char *buf)=0A> > > +{=0A> > > + struct cm3218x_chip =
*chip =3D iio_priv(dev_to_iio_dev(dev));=0A> > > + struct cm3218x_als_info =
*als_info =3D chip->als_info;=0A> > > + int i, len;=0A> > > +=0A> > > + for=
 (i =3D 0, len =3D 0; i < als_info->num_als_it; i++)=0A> > > + len +=3D scn=
printf(buf + len, PAGE_SIZE - len, "%u.%06u ",=0A> > > + als_info->als_it_v=
alues[i]/1000000,=0A> > > + als_info->als_it_values[i]%1000000);=0A> > > + =
return len + scnprintf(buf + len, PAGE_SIZE - len, "\n");=0A> > > +}=0A> > =
> +=0A> > > +/**=0A> > > + * cm3218x_threshold_update() - Update the thresh=
old registers.=0A> > > + * @chip: pointer of struct cm3218x_chip.=0A> > > +=
 * @percent: +/- percent.=0A> > > + *=0A> > > + * Based on the current ALS =
value, tupdate the hi and low threshold=0A> > > registers.=0A> > =0A> > tup=
date?=0A> > =0A> > > + *=0A> > > + * Return: 0 for success; otherwise for e=
rror code.=0A> > > + */=0A> > > +static int cm3218x_threshold_update(struct=
 cm3218x_chip *chip, int=0A> > > percent)=0A> > > +{=0A> > > + struct i2c_c=
lient *client =3D chip->client;=0A> > > + struct cm3218x_als_info *als_info=
 =3D chip->als_info;=0A> > > + int ret;=0A> > > + int wh, wl;=0A> > > +=0A>=
 > > + ret =3D als_info->als_raw =3D i2c_smbus_read_word_data(client,=0A> >=
 > + CM3218X_REG_ADDR_ALS);=0A> > > + if (ret < 0)=0A> > > + return ret;=0A=
> > > +=0A> > > + wh =3D wl =3D ret;=0A> > > + ret *=3D percent;=0A> > > + =
ret /=3D 100;=0A> > > + if (ret < 1)=0A> > > + ret =3D 1;=0A> > > + wh +=3D=
 ret;=0A> > > + wl -=3D ret;=0A> > > + if (wh > 65535)=0A> > > + wh =3D 655=
35;=0A> > > + if (wl < 0)=0A> > > + wl =3D 0;=0A> > > +=0A> > > + chip->con=
f_regs[CM3218X_REG_ADDR_WH] =3D wh;=0A> > > + ret =3D i2c_smbus_write_word_=
data(=0A> > > + client,=0A> > > + CM3218X_REG_ADDR_WH,=0A> > > + chip->conf=
_regs[CM3218X_REG_ADDR_WH]);=0A> > > + if (ret < 0)=0A> > > + return ret;=
=0A> > > +=0A> > > + chip->conf_regs[CM3218X_REG_ADDR_WL] =3D wl;=0A> > > +=
 ret =3D i2c_smbus_write_word_data(=0A> > > + client,=0A> > > + CM3218X_REG=
_ADDR_WL,=0A> > > + chip->conf_regs[CM3218X_REG_ADDR_WL]);=0A> > > +=0A> > =
> + return ret;=0A> > > +}=0A> > > +=0A> > > +/**=0A> > > + * cm3218x_event=
_handler() - Interrupt handling routine.=0A> > > + * @irq: irq number.=0A> =
> > + * @private: pointer of void.=0A> > > + *=0A> > > + * Clean interrupt =
and reset threshold registers.=0A> > > + *=0A> > > + * Return: IRQ_HANDLED.=
=0A> > > + */=0A> > > +static irqreturn_t cm3218x_event_handler(int irq, vo=
id *private)=0A> > > +{=0A> > > + struct iio_dev *dev_info =3D private;=0A>=
 > > + struct cm3218x_chip *chip =3D iio_priv(dev_info);=0A> > > + int ret;=
=0A> > > +=0A> > > + mutex_lock(&chip->lock);=0A> > > +=0A> > > + /* Disabl=
e interrupt */=0A> > > + ret =3D cm3218x_interrupt_config(chip, 0);=0A> > >=
 + if (ret < 0)=0A> > > + goto error_handler_unlock;=0A> > > +=0A> > > + /*=
 Update Hi/Lo windows */=0A> > > + ret =3D cm3218x_threshold_update(chip, C=
M3218X_THRESHOLD_PERCENT);=0A> > > + if (ret < 0)=0A> > > + goto error_hand=
ler_unlock;=0A> > > +=0A> > > + /* Enable interrupt */=0A> > > + ret =3D cm=
3218x_interrupt_config(chip, 1);=0A> > =0A> > no need to check ret value=0A=
> > =0A> > > + if (ret < 0)=0A> > > + goto error_handler_unlock;=0A> > > +=
=0A> > > +error_handler_unlock:=0A> > > + mutex_unlock(&chip->lock);=0A> > =
> + return IRQ_HANDLED;=0A> > > +}=0A> > > +=0A> > > +static conststruct ii=
o_chan_spec cm3218x_channels[] =3D {=0A> > > + {=0A> > > + .type =3D IIO_LI=
GHT,=0A> > > + .info_mask_separate =3D=0A> > > + BIT(IIO_CHAN_INFO_PROCESSE=
D) |=0A> > > + BIT(IIO_CHAN_INFO_CALIBSCALE) |=0A> > > + BIT(IIO_CHAN_INFO_=
INT_TIME),=0A> > > + }=0A> > > +};=0A> > > +=0A> > > +static IIO_DEVICE_ATT=
R(in_illuminance_integration_time_available,=0A> > > + S_IRUGO, cm3218x_get=
_it_available, NULL, 0);=0A> > > +=0A> > > +static struct attribute *cm3218=
x_attributes[] =3D {=0A> > > + &iio_dev_attr_in_illuminance_integration_tim=
e_available.dev_attr.attr,=0A> > > + NULL,=0A> > > +};=0A> > > +=0A> > > +s=
tatic conststruct attribute_group cm3218x_attribute_group =3D {=0A> > > + .=
attrs =3D cm3218x_attributes=0A> > > +};=0A> > > +=0A> > > +static conststr=
uct iio_info cm3218x_info =3D {=0A> > > + .driver_module =3D THIS_MODULE,=
=0A> > > + .read_raw =3D &cm3218x_read_raw,=0A> > > + .write_raw =3D &cm321=
8x_write_raw,=0A> > > + .attrs =3D &cm3218x_attribute_group,=0A> > > +};=0A=
> > > +=0A> > > +static int cm3218x_probe(struct i2c_client *client,=0A> > =
> + conststruct i2c_device_id *id)=0A> > > +{=0A> > > + struct cm3218x_chip=
 *chip;=0A> > > + struct iio_dev *indio_dev;=0A> > > + int ret;=0A> > > +=
=0A> > > + indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip))=
;=0A> > > + if (!indio_dev) {=0A> > > + dev_err(&client->dev, "devm_iio_dev=
ice_alloc failed\n");=0A> > > + return -ENOMEM;=0A> > > + }=0A> > > +=0A> >=
 > + chip =3D iio_priv(indio_dev);=0A> > > + i2c_set_clientdata(client, ind=
io_dev);=0A> > > + chip->client =3D client;=0A> > > + chip->ara =3D i2c_new=
_dummy(client->adapter, CM3218X_ARA);=0A> > > +=0A> > =0A> > there is no i2=
c_unregister_device(chip->ara) in the error path below; but=0A> > i2c_unreg=
ister_device(chip->ara) is called in _remove()=0A> > =0A> > > + mutex_init(=
&chip->lock);=0A> > > + indio_dev->dev.parent =3D &client->dev;=0A> > > + i=
ndio_dev->channels =3D cm3218x_channels;=0A> > > + indio_dev->num_channels =
=3D ARRAY_SIZE(cm3218x_channels);=0A> > > + indio_dev->info =3D &cm3218x_in=
fo;=0A> > > + if (id && id->name)=0A> > > + indio_dev->name =3D id->name;=
=0A> > > + else=0A> > > + indio_dev->name =3D (char *)dev_name(&client->dev=
);=0A> > > + indio_dev->modes =3D INDIO_DIRECT_MODE;=0A> > > +=0A> > > + re=
t =3D cm3218x_reg_init(chip);=0A> > > + if (ret) {=0A> > > + dev_err(&clien=
t->dev,=0A> > > + "%s: register init failed\n",=0A> > > + __func__);=0A> > =
> + return ret;=0A> > > + }=0A> > > +=0A> > > + if (client->irq) {=0A> > > =
+ ret =3D request_threaded_irq(client->irq,=0A> > > + NULL,=0A> > > + cm321=
8x_event_handler,=0A> > > + IRQF_TRIGGER_FALLING | IRQF_ONESHOT,=0A> > > + =
"cm3218x_event",=0A> > > + indio_dev);=0A> > > +=0A> > > + if (ret < 0) {=
=0A> > > + dev_err(&client->dev, "irq request error %d\n",=0A> > > + -ret);=
=0A> > > + goto error_disable_int;=0A> > > + }=0A> > > + }=0A> > > +=0A> > =
> + ret =3D iio_device_register(indio_dev);=0A> > > + if (ret < 0) {=0A> > =
> + dev_err(&client->dev,=0A> > > + "%s: regist device failed\n",=0A> > > +=
 __func__);=0A> > > + goto error_free_irq;=0A> > > + }=0A> > > +=0A> > > + =
if (client->irq) {=0A> > > + ret =3D cm3218x_threshold_update(chip, CM3218X=
_THRESHOLD_PERCENT);=0A> > > + if (ret < 0)=0A> > > + goto error_free_irq;=
=0A> > > +=0A> > > + ret =3D cm3218x_interrupt_config(chip, 1);=0A> > > + i=
f (ret < 0)=0A> > > + goto error_free_irq;=0A> > > + }=0A> > > +=0A> > > + =
return 0;=0A> > > +=0A> > > +error_free_irq:=0A> > > + free_irq(client->irq=
, indio_dev);=0A> > =0A> > in _remove() free_irq() is only called when clie=
nt->irq !=3D 0=0A> > =0A> > > +error_disable_int:=0A> > > + cm3218x_interru=
pt_config(chip, 0);=0A> > > + return ret;=0A> > > +}=0A> > > +=0A> > > +sta=
tic int cm3218x_remove(struct i2c_client *client)=0A> > > +{=0A> > > + stru=
ct iio_dev *indio_dev =3D i2c_get_clientdata(client);=0A> > > + struct cm32=
18x_chip *chip =3D iio_priv(indio_dev);=0A> > > +=0A> > > + cm3218x_interru=
pt_config(chip, 0);=0A> > > + if (chip->ara)=0A> > > + i2c_unregister_devic=
e(chip->ara);=0A> > > + if (client->irq)=0A> > > + free_irq(client->irq, in=
dio_dev);=0A> > > + iio_device_unregister(indio_dev);=0A> > > + return 0;=
=0A> > > +}=0A> > > +=0A> > > +static conststruct i2c_device_id cm3218x_id[=
] =3D {=0A> > > + { "cm3218", cm3218},=0A> > > + { "cm32181", cm32181},=0A>=
 > > + { "cm32182", cm32182},=0A> > > + { }=0A> > > +};=0A> > > +=0A> > > +=
MODULE_DEVICE_TABLE(i2c, cm3218x_id);=0A> > > +=0A> > > +static conststruct=
 of_device_id cm3218x_of_match[] =3D {=0A> > > + { .compatible =3D "capella=
,cm3218" },=0A> > > + { }=0A> > > +};=0A> > > +=0A> > > +static conststruct=
acpi_device_id cm3218x_acpi_match[] =3D {=0A> > > + { "CPLM3218", 0},=0A> >=
 > + {},=0A> > > +};=0A> > > +=0A> > > +MODULE_DEVICE_TABLE(acpi, cm3218x_a=
cpi_match);=0A> > > +=0A> > > +static struct i2c_driver cm3218x_driver =3D =
{=0A> > > + .driver =3D {=0A> > > + .name =3D "cm3218x",=0A> > > + .acpi_ma=
tch_table =3D ACPI_PTR(cm3218x_acpi_match),=0A> > > + .of_match_table =3D o=
f_match_ptr(cm3218x_of_match),=0A> > > + .owner =3D THIS_MODULE,=0A> > > + =
},=0A> > > + .id_table =3D cm3218x_id,=0A> > > + .probe =3D cm3218x_probe,=
=0A> > > + .remove =3D cm3218x_remove,=0A> > > +};=0A> > > +=0A> > > +modul=
e_i2c_driver(cm3218x_driver);=0A> > > +=0A> > > +MODULE_AUTHOR("Kevin Tsai =
<ktsai@capellamicro.com>");=0A> > > +MODULE_DESCRIPTION("CM3218X ambient li=
ght sensor driver");=0A> > > +MODULE_LICENSE("GPL");=0A> > > =0A> > =0A> > =
-- =0A> > =0A> > Peter Meerwald=0A> > +43-664-2444418 (mobile)=0A> =0A=0A--=
 =0A=0APeter Meerwald=0A+43-664-2444418 (mobile)
---1192396609-1770039525-1395809544=:53200
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:8pt"><div><span=
>Hi Peter,</span></div><div style=3D"color: rgb(0, 0, 0); font-size: 11px; =
font-family: 'Courier New', courier, monaco, monospace, sans-serif; backgro=
und-color: transparent; font-style: normal;"><span><br></span></div><div st=
yle=3D"color: rgb(0, 0, 0); font-size: 11px; font-family: 'Courier New', co=
urier, monaco, monospace, sans-serif; background-color: transparent; font-s=
tyle: normal;"><span>Thanks for your explanation. &nbsp;I will follow your =
advise and resubmit.</span></div><div style=3D"color: rgb(0, 0, 0); font-si=
ze: 11px; font-family: 'Courier New', courier, monaco, monospace, sans-seri=
f; background-color: transparent; font-style: normal;"><span><br></span></d=
iv><div style=3D"color: rgb(0, 0, 0); font-size: 11px; font-family: 'Courie=
r New', courier, monaco, monospace, sans-serif; background-color: transpare=
nt;
 font-style: normal;"><span>Have a nice day.</span></div><div style=3D"colo=
r: rgb(0, 0, 0); font-size: 11px; font-family: 'Courier New', courier, mona=
co, monospace, sans-serif; background-color: transparent; font-style: norma=
l;"><span><br></span></div><div style=3D"color: rgb(0, 0, 0); font-size: 11=
px; font-family: 'Courier New', courier, monaco, monospace, sans-serif; bac=
kground-color: transparent; font-style: normal;"><span>Kevin Tsai</span></d=
iv><div style=3D"color: rgb(0, 0, 0); font-size: 11px; font-family: 'Courie=
r New', courier, monaco, monospace, sans-serif; background-color: transpare=
nt; font-style: normal;"><span>03/25/14</span></div><div><br></div>  <div s=
tyle=3D"font-family: 'Courier New', courier, monaco, monospace, sans-serif;=
 font-size: 8pt;"> <div style=3D"font-family: 'times new roman', 'new york'=
, times, serif; font-size: 12pt;"> <div dir=3D"ltr"> <hr size=3D"1">  <font=
 size=3D"2" face=3D"Arial"> <b><span style=3D"font-weight:bold;">From:</spa=
n></b> Peter
 Meerwald &lt;pmeerw@pmeerw.net&gt;<br> <b><span style=3D"font-weight: bold=
;">To:</span></b> Kevin Tsai &lt;ktsai@capellamicro.com&gt; <br><b><span st=
yle=3D"font-weight: bold;">Cc:</span></b> Jonathan Cameron &lt;jic23@kernel=
.org&gt;; linux-iio@vger.kernel.org <br> <b><span style=3D"font-weight: bol=
d;">Sent:</span></b> Tuesday, March 25, 2014 5:40 PM<br> <b><span style=3D"=
font-weight: bold;">Subject:</span></b> Re: [PATCH V3 1/1] iio: add Capella=
 cm3218x ambient light sensor driver.<br> </font> </div> <div class=3D"y_ms=
g_container"><br><br>&gt; (1). Not all machines use <span id=3D"misspell-4"=
 class=3D"mark">ACPI</span> method.&nbsp; For example, one of my machines<b=
r>&gt; loads driver by manually.<br><br>the driver fails to compile if <spa=
n id=3D"misspell-5" class=3D"mark">CONFIG</span>_<span id=3D"misspell-6" cl=
ass=3D"mark">ACPI</span> is not defined, e.g. on ARM <br>platform, hence I =
think 'depends on <span id=3D"misspell-7" class=3D"mark">ACPI</span>' is ap=
propriate in <span
 id=3D"misspell-8" class=3D"mark">Kconfig</span><br><br>maybe you could #<s=
pan id=3D"misspell-9" class=3D"mark">ifdef</span> certain function in the d=
river if <span id=3D"misspell-10" class=3D"mark">ACPI</span> is not <br>ava=
ilable in order to support devices without <span id=3D"misspell-11" class=
=3D"mark">ACPI</span><br><br>drivers/iio/light/cm3218x.c: In function =E2=
=80=98cm3218x_<span id=3D"misspell-13" class=3D"mark">acpi</span>_get_<span=
 id=3D"misspell-14" class=3D"mark">cpm</span>_info=E2=80=99:<br>drivers/iio=
/light/cm3218x.c:195:2: error: unknown type name =E2=80=98<span id=3D"missp=
ell-16" class=3D"mark">acpi</span>_handle=E2=80=99<br>drivers/iio/light/cm3=
218x.c:196:9: error: variable =E2=80=98buffer=E2=80=99 has <br><span id=3D"=
misspell-18" class=3D"mark">initializer</span> but incomplete type<br>&nbsp=
; <span id=3D"misspell-19" class=3D"mark">struct</span> <span id=3D"misspel=
l-20" class=3D"mark">acpi</span>_buffer buffer =3D {<span id=3D"misspell-21=
" class=3D"mark">ACPI</span>_ALLOCATE_BUFFER, NULL};<br>&nbsp; &nbsp; &nbsp=
;
 &nbsp;  ^<br>drivers/iio/light/cm3218x.c:196:31: error: =E2=80=98<span id=
=3D"misspell-23" class=3D"mark">ACPI</span>_ALLOCATE_BUFFER=E2=80=99 <br>un=
declared (first use in this function)<br>&nbsp; <span id=3D"misspell-24" cl=
ass=3D"mark">struct</span> <span id=3D"misspell-25" class=3D"mark">acpi</sp=
an>_buffer buffer =3D {<span id=3D"misspell-26" class=3D"mark">ACPI</span>_=
ALLOCATE_BUFFER, NULL};<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  ^<br>...<br><br>&=
gt; (2). About the ARA register, some of sensors use <span id=3D"misspell-2=
7" class=3D"mark">SMBus</span> ARA, others use I2C<br>&gt; to report interr=
upt.&nbsp; I need to call i2c_new_dummy() to read the ARA<br>&gt; register =
to clean interrupt.&nbsp; Otherwise, device may be blocked by <span id=3D"m=
isspell-28" class=3D"mark">SMBus</span><br>&gt; protocol.&nbsp; In the _rem=
ove(), I have to call i2c_<span id=3D"misspell-29" class=3D"mark">unregiste=
r</span>_device(chip-&gt;<span
 id=3D"misspell-30" class=3D"mark">ara</span>).<br>&gt; Otherwise, I cannot=
 get the handler for ARA when I reload this module.<br><br>my concern is th=
at if an error occurs in _probe() after calling <br>i2c_new_dummy(), the ma=
tching i2c_<span id=3D"misspell-31" class=3D"mark">unregister</span>_device=
(chip-&gt;<span id=3D"misspell-32" class=3D"mark">ara</span>) is missing<br=
><br>regards, p.<br><br>&gt; ----- Original Message ----- From: "Peter Meer=
wald" &lt;<a ymailto=3D"mailto:pmeerw@pmeerw.net" href=3D"mailto:pmeerw@pme=
erw.net">pmeerw@pmeerw.net</a>&gt;<br>&gt; To: "Kevin Tsai" &lt;<a ymailto=
=3D"mailto:ktsai@capellamicro.com" href=3D"mailto:ktsai@capellamicro.com">k=
tsai@capellamicro.com</a>&gt;<br>&gt; Cc: "Jonathan Cameron" &lt;<a ymailto=
=3D"mailto:jic23@kernel.org" href=3D"mailto:jic23@kernel.org">jic23@kernel.=
org</a>&gt;; &lt;<a ymailto=3D"mailto:linux-iio@vger.kernel.org" href=3D"ma=
ilto:linux-iio@vger.kernel.org">linux-iio@vger.kernel.org</a>&gt;<br>&gt; S=
ent: Tuesday, March
 25, 2014 16:39<br>&gt; Subject: Re: [PATCH V3 1/1] iio: add Capella cm3218=
x ambient light sensor<br>&gt; driver.<br>&gt; <br>&gt; <br>&gt; &gt; <br>&=
gt; &gt; &gt; Add Capella <span id=3D"misspell-36" class=3D"mark">Microsyst=
em</span> CM3218X family Ambient Light Sensor IIO driver.<br>&gt; &gt; &gt;=
 This driver will convert raw data to <span id=3D"misspell-38" class=3D"mar=
k">lux</span> value.&nbsp; Default parameters are<br>&gt; &gt; &gt; for ref=
erence only.&nbsp; It will detect <span id=3D"misspell-39" class=3D"mark">A=
CPI</span> table to load per-system<br>&gt; &gt; &gt; manufacturing<br>&gt;=
 &gt; &gt; parameters.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; V2: Follow Jona=
than Cameron's advise to separate device id.<br>&gt; &gt; &gt; Also, follow=
 Peter <span id=3D"misspell-40" class=3D"mark">Meerwald's</span> advise to =
correct <span id=3D"misspell-41" class=3D"mark">whitespace</span>, prefix, =
and,<br>&gt; &gt; &gt; comments.<br>&gt; &gt; &gt; <br>&gt; &gt; &gt; V3: F=
ollow Peter
 <span id=3D"misspell-42" class=3D"mark">Meerwald's</span> advise to create=
 a separated i2c_client<br>&gt; &gt; &gt; handler to<br>&gt; &gt; &gt; acce=
ss <span id=3D"misspell-43" class=3D"mark">SMBus</span> ARA register.<br>&g=
t; &gt; <br>&gt; &gt; couple of minor comments...<br>&gt; &gt; <br>&gt; &gt=
; &gt; Signed-off-by: Kevin Tsai &lt;<a ymailto=3D"mailto:ktsai@capellamicr=
o.com" href=3D"mailto:ktsai@capellamicro.com">ktsai@capellamicro.com</a>&gt=
;<br>&gt; &gt; &gt; ---<br>&gt; &gt; &gt;&nbsp; .../devicetree/bindings/i2c=
/trivial-devices.txt&nbsp; &nbsp; |&nbsp;  1 +<br>&gt; &gt; &gt;&nbsp; driv=
ers/iio/light/<span id=3D"misspell-46" class=3D"">Kconfig</span>&nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; |&nbsp; 11 +<br>&gt; &gt; &gt;&nbsp; drivers/iio/light/<span id=3D"mis=
spell-48" class=3D"mark">Makefile</span>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  |&nbsp;  1 +<br>&gt; &gt;=
 &gt;&nbsp;
 drivers/iio/light/cm3218x.c&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | 745<br>&gt; &gt; &gt; ++++++++++++++=
+++++++<br>&gt; &gt; &gt;&nbsp; 4 files changed, 758 insertions(+)<br>&gt; =
&gt; &gt;&nbsp; create mode 100644 drivers/iio/light/cm3218x.c<br>&gt; &gt;=
 &gt; <br>&gt; &gt; &gt; diff --git a/Documentation/<span id=3D"misspell-51=
" class=3D"mark">devicetree</span>/bindings/i2c/trivial-devices.<span id=3D=
"misspell-52" class=3D"mark">txt</span><br>&gt; &gt; &gt; b/Documentation/<=
span id=3D"misspell-53" class=3D"mark">devicetree</span>/bindings/i2c/trivi=
al-devices.<span id=3D"misspell-54" class=3D"mark">txt</span><br>&gt; &gt; =
&gt; index 1a1ac2e..c3c869b 100644<br>&gt; &gt; &gt; --- a/Documentation/<s=
pan id=3D"misspell-55" class=3D"mark">devicetree</span>/bindings/i2c/trivia=
l-devices.<span id=3D"misspell-56" class=3D"mark">txt</span><br>&gt; &gt; &=
gt; +++ b/Documentation/<span id=3D"misspell-57"
 class=3D"mark">devicetree</span>/bindings/i2c/trivial-devices.<span id=3D"=
misspell-58" class=3D"mark">txt</span><br>&gt; &gt; &gt; @@ -17,6 +17,7 @@ =
at,24c08 i2c serial <span id=3D"misspell-59" class=3D"mark">eeprom</span>&n=
bsp; (24<span id=3D"misspell-60" class=3D"mark">cxx</span>)<br>&gt; &gt; &g=
t;&nbsp; <span id=3D"misspell-61" class=3D"mark">atmel</span>,24c02 i2c ser=
ial <span id=3D"misspell-62" class=3D"mark">eeprom</span>&nbsp; (24<span id=
=3D"misspell-63" class=3D"mark">cxx</span>)<br>&gt; &gt; &gt;&nbsp; <span i=
d=3D"misspell-64" class=3D"mark">atmel</span>,at97<span id=3D"misspell-65" =
class=3D"mark">sc</span>3204t i2c trusted platform module (<span id=3D"miss=
pell-66" class=3D"mark">TPM</span>)<br>&gt; &gt; &gt;&nbsp; <span id=3D"mis=
spell-67" class=3D"mark">capella</span>,cm32181 CM32181: Ambient Light Sens=
or<br>&gt; &gt; &gt; +<span id=3D"misspell-68" class=3D"mark">capella</span=
>,cm3218x CM3218X: Ambient Light Sensor<br>&gt; &gt; &gt;&nbsp; catalyst,24=
c32 i2c serial <span id=3D"misspell-69"
 class=3D"mark">eeprom</span><br>&gt; &gt; &gt;&nbsp; <span id=3D"misspell-=
70" class=3D"mark">dallas</span>,<span id=3D"misspell-71" class=3D"mark">ds=
</span>1307 64 x 8, Serial, I2C Real-Time Clock<br>&gt; &gt; &gt;&nbsp; <sp=
an id=3D"misspell-72" class=3D"mark">dallas</span>,<span id=3D"misspell-73"=
 class=3D"mark">ds</span>1338 I2C <span id=3D"misspell-74" class=3D"mark">R=
TC</span> with 56-Byte NV RAM<br>&gt; &gt; &gt; diff --git a/drivers/iio/li=
ght/<span id=3D"misspell-76" class=3D"mark">Kconfig</span> b/drivers/iio/li=
ght/<span id=3D"misspell-78" class=3D"mark">Kconfig</span><br>&gt; &gt; &gt=
; index d12b2a0..97a341a 100644<br>&gt; &gt; &gt; --- a/drivers/iio/light/<=
span id=3D"misspell-80" class=3D"mark">Kconfig</span><br>&gt; &gt; &gt; +++=
 b/drivers/iio/light/<span id=3D"misspell-82" class=3D"mark">Kconfig</span>=
<br>&gt; &gt; &gt; @@ -38,6 +38,17 @@ <span id=3D"misspell-83" class=3D"mar=
k">config</span> CM32181<br>&gt; &gt; &gt;&nbsp; To compile this driver as =
a module, choose M here:<br>&gt;
 &gt; &gt;&nbsp; the module will be called cm32181.<br>&gt; &gt; &gt; <br>&=
gt; &gt; &gt; +<span id=3D"misspell-84" class=3D"mark">config</span> CM3218=
X<br>&gt; &gt; &gt; + depends on I2C<br>&gt; &gt; <br>&gt; &gt; depends on =
I2C &amp;&amp; <span id=3D"misspell-85" class=3D"mark">ACPI</span> ???<br>&=
gt; &gt; <br>&gt; &gt; &gt; + <span id=3D"misspell-86" class=3D"mark">trist=
ate</span> "CM3218X driver"<br>&gt; &gt; &gt; + help<br>&gt; &gt; &gt; + Sa=
y Y here if you use cm3218x.<br>&gt; &gt; &gt; + This option enables ambien=
t light sensor using<br>&gt; &gt; &gt; + Capella cm3218x device driver.<br>=
&gt; &gt; &gt; +<br>&gt; &gt; &gt; + To compile this driver as a module, ch=
oose M here:<br>&gt; &gt; &gt; + the module will be called cm3218x.<br>&gt;=
 &gt; &gt; +<br>&gt; &gt; &gt;&nbsp; <span id=3D"misspell-87" class=3D"mark=
">config</span> CM36651<br>&gt; &gt; &gt;&nbsp; depends on I2C<br>&gt; &gt;=
 &gt;&nbsp; <span id=3D"misspell-88" class=3D"mark">tristate</span> "CM3665=
1
 driver"<br>&gt; &gt; &gt; diff --git a/drivers/iio/light/<span id=3D"missp=
ell-90" class=3D"mark">Makefile</span> b/drivers/iio/light/<span id=3D"miss=
pell-92" class=3D"mark">Makefile</span><br>&gt; &gt; &gt; index 60e35ac..a5=
06c23 100644<br>&gt; &gt; &gt; --- a/drivers/iio/light/<span id=3D"misspell=
-94" class=3D"mark">Makefile</span><br>&gt; &gt; &gt; +++ b/drivers/iio/lig=
ht/<span id=3D"misspell-96" class=3D"mark">Makefile</span><br>&gt; &gt; &gt=
; @@ -6,6 +6,7 @@<br>&gt; &gt; &gt;&nbsp; obj-$(<span id=3D"misspell-97" cl=
ass=3D"mark">CONFIG</span>_<span id=3D"misspell-98" class=3D"mark">ADJD</sp=
an>_S311) +=3D <span id=3D"misspell-99" class=3D"mark">adjd</span>_s311.o<b=
r>&gt; &gt; &gt;&nbsp; obj-$(<span id=3D"misspell-100" class=3D"mark">CONFI=
G</span>_<span id=3D"misspell-101" class=3D"mark">APDS</span>9300) +=3D <sp=
an id=3D"misspell-102" class=3D"mark">apds</span>9300.o<br>&gt; &gt; &gt;&n=
bsp; obj-$(<span id=3D"misspell-103" class=3D"mark">CONFIG</span>_CM32181) =
+=3D cm32181.o<br>&gt; &gt; &gt;
 +obj-$(<span id=3D"misspell-104" class=3D"mark">CONFIG</span>_CM3218X) +=
=3D cm3218x.o<br>&gt; &gt; &gt;&nbsp; obj-$(<span id=3D"misspell-105" class=
=3D"mark">CONFIG</span>_CM36651) +=3D cm36651.o<br>&gt; &gt; &gt;&nbsp; obj=
-$(<span id=3D"misspell-106" class=3D"mark">CONFIG</span>_GP2AP020A00F) +=
=3D <span id=3D"misspell-107" class=3D"mark">gp</span>2<span id=3D"misspell=
-108" class=3D"mark">ap</span>020a00f.o<br>&gt; &gt; &gt;&nbsp; obj-$(<span=
 id=3D"misspell-109" class=3D"mark">CONFIG</span>_HID_SENSOR_<span id=3D"mi=
sspell-110" class=3D"mark">ALS</span>) +=3D hid-sensor-<span id=3D"misspell=
-111" class=3D"mark">als</span>.o<br>&gt; &gt; &gt; diff --git a/drivers/ii=
o/light/cm3218x.c b/drivers/iio/light/cm3218x.c<br>&gt; &gt; &gt; new file =
mode 100644<br>&gt; &gt; &gt; index 0000000..<span id=3D"misspell-114" clas=
s=3D"mark">efd</span>0d0a<br>&gt; &gt; &gt; --- /<span id=3D"misspell-115" =
class=3D"mark">dev</span>/null<br>&gt; &gt; &gt; +++ b/drivers/iio/light/cm=
3218x.c<br>&gt; &gt; &gt; @@ -0,0 +1,745
 @@<br>&gt; &gt; &gt; +/*<br>&gt; &gt; &gt; + * Copyright (C) 2014 Capella =
<span id=3D"misspell-117" class=3D"mark">Microsystems</span> Inc.<br>&gt; &=
gt; &gt; + * Author: Kevin Tsai &lt;<a ymailto=3D"mailto:ktsai@capellamicro=
.com" href=3D"mailto:ktsai@capellamicro.com">ktsai@capellamicro.com</a>&gt;=
<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * This program is free software;=
 you can redistribute it and/or modify<br>&gt; &gt; &gt; it<br>&gt; &gt; &g=
t; + * under the terms of the GNU General Public License version 2, as<br>&=
gt; &gt; &gt; published<br>&gt; &gt; &gt; + * by the Free Software Foundati=
on.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Special thanks <span id=3D"=
misspell-119" class=3D"mark">Srinivas</span> <span id=3D"misspell-120" clas=
s=3D"mark">Pandruvada</span><br>&gt; &gt; &gt; &lt;<a ymailto=3D"mailto:sri=
nivas.pandruvada@linux.intel.com" href=3D"mailto:srinivas.pandruvada@linux.=
intel.com">srinivas.pandruvada@linux.intel.com</a>&gt;<br>&gt; &gt; &gt; + =
* help to add
 <span id=3D"misspell-121" class=3D"mark">ACPI</span> support.<br>&gt; &gt;=
 &gt; + *<br>&gt; &gt; &gt; + */<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#in=
clude &lt;linux/delay.h&gt;<br>&gt; &gt; &gt; +#include &lt;linux/err.h&gt;=
<br>&gt; &gt; &gt; +#include &lt;linux/i2c.h&gt;<br>&gt; &gt; &gt; +#includ=
e &lt;linux/<span id=3D"misspell-126" class=3D"mark">mutex</span>.h&gt;<br>=
&gt; &gt; &gt; +#include &lt;linux/module.h&gt;<br>&gt; &gt; &gt; +#include=
 &lt;linux/interrupt.h&gt;<br>&gt; &gt; &gt; +#include &lt;linux/regulator/=
consumer.h&gt;<br>&gt; &gt; &gt; +#include &lt;linux/iio/iio.h&gt;<br>&gt; =
&gt; &gt; +#include &lt;linux/iio/<span id=3D"misspell-135" class=3D"mark">=
sysfs</span>.h&gt;<br>&gt; &gt; &gt; +#include &lt;linux/iio/events.h&gt;<b=
r>&gt; &gt; &gt; +#include &lt;linux/<span id=3D"misspell-139" class=3D"mar=
k">init</span>.h&gt;<br>&gt; &gt; &gt; +#include &lt;linux/<span id=3D"miss=
pell-141" class=3D"mark">acpi</span>.h&gt;<br>&gt; &gt; &gt; +<br>&gt; &gt;=
 &gt; +/*
 Registers Address */<br>&gt; &gt; &gt; +#define CM3218X_REG_<span id=3D"mi=
sspell-142" class=3D"mark">ADDR</span>_<span id=3D"misspell-143" class=3D"m=
ark">CMD</span> 0x00<br>&gt; &gt; &gt; +#define CM3218X_REG_<span id=3D"mis=
spell-144" class=3D"mark">ADDR</span>_<span id=3D"misspell-145" class=3D"ma=
rk">WH</span> 0x01<br>&gt; &gt; &gt; +#define CM3218X_REG_<span id=3D"missp=
ell-146" class=3D"mark">ADDR</span>_<span id=3D"misspell-147" class=3D"mark=
">WL</span> 0x02<br>&gt; &gt; &gt; +#define CM3218X_REG_<span id=3D"misspel=
l-148" class=3D"mark">ADDR</span>_TEST 0x03<br>&gt; &gt; &gt; +#define CM32=
18X_REG_<span id=3D"misspell-149" class=3D"mark">ADDR</span>_<span id=3D"mi=
sspell-150" class=3D"mark">ALS</span> 0x04<br>&gt; &gt; &gt; +#define CM321=
8X_REG_<span id=3D"misspell-151" class=3D"mark">ADDR</span>_STATUS 0x06<br>=
&gt; &gt; &gt; +#define CM3218X_REG_<span id=3D"misspell-152" class=3D"mark=
">ADDR</span>_ID 0x07<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/* Number of C=
onfigurable Registers */<br>&gt; &gt;
 &gt; +#define CM3218X_<span id=3D"misspell-153" class=3D"mark">CONF</span>=
_REG_<span id=3D"misspell-154" class=3D"mark">NUM</span> 16<br>&gt; &gt; &g=
t; +<br>&gt; &gt; &gt; +/* <span id=3D"misspell-155" class=3D"mark">CMD</sp=
an> register */<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-156=
" class=3D"mark">CMD</span>_<span id=3D"misspell-157" class=3D"mark">ALS</s=
pan>_DISABLE BIT(0)<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell=
-158" class=3D"mark">CMD</span>_<span id=3D"misspell-159" class=3D"mark">AL=
S</span>_INT_EN BIT(1)<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"missp=
ell-160" class=3D"mark">CMD</span>_<span id=3D"misspell-161" class=3D"mark"=
>ALS</span>_<span id=3D"misspell-162" class=3D"mark">THRES</span>_WINDOW BI=
T(2)<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"mis=
spell-163" class=3D"mark">CMD</span>_<span id=3D"misspell-164" class=3D"mar=
k">ALS</span>_<span id=3D"misspell-165" class=3D"mark">PERS</span>_SHIFT 4<=
br>&gt; &gt; &gt; +#define CM3218X_<span
 id=3D"misspell-166" class=3D"mark">CMD</span>_<span id=3D"misspell-167" cl=
ass=3D"mark">ALS</span>_<span id=3D"misspell-168" class=3D"mark">PERS</span=
>_MASK (0x03 &lt;&lt; CM3218X_<span id=3D"misspell-169" class=3D"mark">CMD<=
/span>_<span id=3D"misspell-170" class=3D"mark">ALS</span>_<span id=3D"miss=
pell-171" class=3D"mark">PERS</span>_SHIFT)<br>&gt; &gt; &gt; +#define CM32=
18X_<span id=3D"misspell-172" class=3D"mark">CMD</span>_<span id=3D"misspel=
l-173" class=3D"mark">ALS</span>_<span id=3D"misspell-174" class=3D"mark">P=
ERS</span>_DEFAULT (0x01 &lt;&lt;<br>&gt; &gt; &gt; CM3218X_<span id=3D"mis=
spell-175" class=3D"mark">CMD</span>_<span id=3D"misspell-176" class=3D"mar=
k">ALS</span>_<span id=3D"misspell-177" class=3D"mark">PERS</span>_SHIFT)<b=
r>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-=
178" class=3D"mark">CMD</span>_<span id=3D"misspell-179" class=3D"mark">ALS=
</span>_IT_SHIFT 6<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-=
180" class=3D"mark">CMD</span>_<span
 id=3D"misspell-181" class=3D"mark">ALS</span>_IT_MASK (0x0F &lt;&lt; CM321=
8X_<span id=3D"misspell-182" class=3D"mark">CMD</span>_<span id=3D"misspell=
-183" class=3D"mark">ALS</span>_IT_SHIFT)<br>&gt; &gt; &gt; +#define CM3218=
X_<span id=3D"misspell-184" class=3D"mark">CMD</span>_<span id=3D"misspell-=
185" class=3D"mark">ALS</span>_IT_DEFAULT (0x01 &lt;&lt; CM3218X_<span id=
=3D"misspell-186" class=3D"mark">CMD</span>_<span id=3D"misspell-187" class=
=3D"mark">ALS</span>_IT_SHIFT)<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#defi=
ne CM3218X_<span id=3D"misspell-188" class=3D"mark">CMD</span>_<span id=3D"=
misspell-189" class=3D"mark">ALS</span>_HS_SHIFT 11<br>&gt; &gt; &gt; +#def=
ine CM3218X_<span id=3D"misspell-190" class=3D"mark">CMD</span>_<span id=3D=
"misspell-191" class=3D"mark">ALS</span>_HS_MASK (0x01 &lt;&lt; CM3218X_<sp=
an id=3D"misspell-192" class=3D"mark">CMD</span>_<span id=3D"misspell-193" =
class=3D"mark">ALS</span>_HS_SHIFT)<br>&gt; &gt; &gt; +#define CM3218X_<spa=
n id=3D"misspell-194"
 class=3D"mark">CMD</span>_<span id=3D"misspell-195" class=3D"mark">ALS</sp=
an>_HS_DEFAULT (0x00 &lt;&lt; CM3218X_<span id=3D"misspell-196" class=3D"ma=
rk">CMD</span>_<span id=3D"misspell-197" class=3D"mark">ALS</span>_HS_SHIFT=
)<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspe=
ll-198" class=3D"mark">CMD</span>_DEFAULT (CM3218X_<span id=3D"misspell-199=
" class=3D"mark">CMD</span>_<span id=3D"misspell-200" class=3D"mark">ALS</s=
pan>_<span id=3D"misspell-201" class=3D"mark">THRES</span>_WINDOW |\<br>&gt=
; &gt; &gt; + CM3218X_<span id=3D"misspell-202" class=3D"mark">CMD</span>_<=
span id=3D"misspell-203" class=3D"mark">ALS</span>_<span id=3D"misspell-204=
" class=3D"mark">PERS</span>_DEFAULT |\<br>&gt; &gt; &gt; + CM3218X_<span i=
d=3D"misspell-205" class=3D"mark">CMD</span>_<span id=3D"misspell-206" clas=
s=3D"mark">ALS</span>_IT_DEFAULT |\<br>&gt; &gt; &gt; + CM3218X_<span id=3D=
"misspell-207" class=3D"mark">CMD</span>_<span id=3D"misspell-208" class=3D=
"mark">ALS</span>_HS_DEFAULT)<br>&gt; &gt; &gt;
 +<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-209" class=3D"ma=
rk">WH</span>_DEFAULT 0<span id=3D"misspell-210" class=3D"mark">xFFFF</span=
><br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-211" class=3D"mar=
k">WL</span>_DEFAULT 0x0000<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +#define =
CM3218X_<span id=3D"misspell-212" class=3D"mark">CALIBSCALE</span>_DEFAULT =
100000<br>&gt; &gt; &gt; +#define CM3218X_<span id=3D"misspell-213" class=
=3D"mark">CALIBSCALE</span>_RESOLUTION 100000<br>&gt; &gt; &gt; +#define CM=
3218X_<span id=3D"misspell-214" class=3D"mark">MLUX</span>_PER_<span id=3D"=
misspell-215" class=3D"mark">LUX</span> 1000<br>&gt; &gt; &gt; +#define CM3=
218X_THRESHOLD_PERCENT 10 /* 10 percent */<br>&gt; &gt; &gt; +<br>&gt; &gt;=
 &gt; +#define CM3218X_ARA 0x0C<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/* C=
M3218X family */<br>&gt; &gt; &gt; +<span id=3D"misspell-216" class=3D"mark=
">enum</span> {<br>&gt; &gt; &gt; + cm3218,<br>&gt; &gt; &gt; + cm32181,<br=
>&gt; &gt; &gt; +
 cm32182<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/* CM=
3218 Family */<br>&gt; &gt; &gt; +#define CM3218_<span id=3D"misspell-217" =
class=3D"mark">MLUX</span>_PER_BIT_DEFAULT 5 /* Depend on system */<br>&gt;=
 &gt; &gt; +#define CM3218_<span id=3D"misspell-218" class=3D"mark">MLUX</s=
pan>_PER_BIT_BASE_IT 800000<br>&gt; &gt; &gt; +static <span id=3D"misspell-=
219" class=3D"mark">const</span> int CM3218_<span id=3D"misspell-220" class=
=3D"mark">als</span>_it_bits[] =3D {0, 1, 2, 3};<br>&gt; &gt; &gt; +static =
<span id=3D"misspell-221" class=3D"mark">const</span> int CM3218_<span id=
=3D"misspell-222" class=3D"mark">als</span>_it_values[] =3D {100000, 200000=
, 400000,<br>&gt; &gt; &gt; 800000};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; =
+/* CM32181 Family */<br>&gt; &gt; &gt; +#define CM32181_<span id=3D"misspe=
ll-223" class=3D"mark">MLUX</span>_PER_BIT_DEFAULT 5<br>&gt; &gt; &gt; +#de=
fine CM32181_<span id=3D"misspell-224" class=3D"mark">MLUX</span>_PER_BIT_B=
ASE_IT 800000<br>&gt; &gt; &gt;
 +static <span id=3D"misspell-225" class=3D"mark">const</span> int CM32181_=
<span id=3D"misspell-226" class=3D"mark">als</span>_it_bits[] =3D {12, 8, 0=
, 1, 2, 3};<br>&gt; &gt; &gt; +static <span id=3D"misspell-227" class=3D"ma=
rk">const</span> int CM32181_<span id=3D"misspell-228" class=3D"mark">als</=
span>_it_values[] =3D {<br>&gt; &gt; &gt; + 25000, 50000, 100000, 200000, 4=
00000, 800000};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +<span id=3D"misspell=
-229" class=3D"mark">struct</span> cm3218x_<span id=3D"misspell-230" class=
=3D"mark">als</span>_info {<br>&gt; &gt; &gt; + u32 id;<br>&gt; &gt; &gt; +=
 int int_type;<br>&gt; &gt; &gt; +#define CM3218X_INT_TYPE_<span id=3D"miss=
pell-231" class=3D"mark">SMBUS</span> 0<br>&gt; &gt; &gt; +#define CM3218X_=
INT_TYPE_I2C 1<br>&gt; &gt; &gt; + int regs_<span id=3D"misspell-232" class=
=3D"mark">bmp</span>;<br>&gt; &gt; &gt; + int <span id=3D"misspell-233" cla=
ss=3D"mark">calibscale</span>;<br>&gt; &gt; &gt; + int <span id=3D"misspell=
-234"
 class=3D"mark">mlux</span>_per_bit;<br>&gt; &gt; &gt; + int <span id=3D"mi=
sspell-235" class=3D"mark">mlux</span>_per_bit_base_it;<br>&gt; &gt; &gt; +=
 <span id=3D"misspell-236" class=3D"mark">const</span> int *<span id=3D"mis=
spell-237" class=3D"mark">als</span>_it_bits;<br>&gt; &gt; &gt; + <span id=
=3D"misspell-238" class=3D"mark">const</span> int *<span id=3D"misspell-239=
" class=3D"mark">als</span>_it_values;<br>&gt; &gt; &gt; + int <span id=3D"=
misspell-240" class=3D"mark">num</span>_<span id=3D"misspell-241" class=3D"=
mark">als</span>_it;<br>&gt; &gt; &gt; + int <span id=3D"misspell-242" clas=
s=3D"mark">als</span>_raw;<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt=
; &gt; &gt; +static <span id=3D"misspell-243" class=3D"mark">struct</span> =
cm3218x_<span id=3D"misspell-244" class=3D"mark">als</span>_info cm3218_inf=
o =3D {<br>&gt; &gt; &gt; + 3218, CM3218X_INT_TYPE_<span id=3D"misspell-245=
" class=3D"mark">SMBUS</span>, 0x0F, CM3218X_<span id=3D"misspell-246" clas=
s=3D"mark">CALIBSCALE</span>_DEFAULT,<br>&gt;
 &gt; &gt; + CM3218_<span id=3D"misspell-247" class=3D"mark">MLUX</span>_PE=
R_BIT_DEFAULT, CM3218_<span id=3D"misspell-248" class=3D"mark">MLUX</span>_=
PER_BIT_BASE_IT,<br>&gt; &gt; &gt; + CM3218_<span id=3D"misspell-249" class=
=3D"mark">als</span>_it_bits, CM3218_<span id=3D"misspell-250" class=3D"mar=
k">als</span>_it_values,<br>&gt; &gt; &gt; + ARRAY_SIZE(CM3218_<span id=3D"=
misspell-251" class=3D"mark">als</span>_it_bits), 0};<br>&gt; &gt; <br>&gt;=
 &gt; <span id=3D"misspell-252" class=3D"mark">const</span>?<br>&gt; &gt; <=
br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static <span id=3D"misspell-253" cla=
ss=3D"mark">struct</span> cm3218x_<span id=3D"misspell-254" class=3D"mark">=
als</span>_info cm32181_info =3D {<br>&gt; &gt; &gt; + 32181, CM3218X_INT_T=
YPE_I2C, 0x0F, CM3218X_<span id=3D"misspell-255" class=3D"mark">CALIBSCALE<=
/span>_DEFAULT,<br>&gt; &gt; &gt; + CM32181_<span id=3D"misspell-256" class=
=3D"mark">MLUX</span>_PER_BIT_DEFAULT, CM32181_<span id=3D"misspell-257"
 class=3D"mark">MLUX</span>_PER_BIT_BASE_IT,<br>&gt; &gt; &gt; + CM32181_<s=
pan id=3D"misspell-258" class=3D"mark">als</span>_it_bits, CM32181_<span id=
=3D"misspell-259" class=3D"mark">als</span>_it_values,<br>&gt; &gt; &gt; + =
ARRAY_SIZE(CM32181_<span id=3D"misspell-260" class=3D"mark">als</span>_it_b=
its), 0};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static <span id=3D"misspel=
l-261" class=3D"mark">struct</span> cm3218x_<span id=3D"misspell-262" class=
=3D"mark">als</span>_info cm32182_info =3D {<br>&gt; &gt; &gt; + 32182, CM3=
218X_INT_TYPE_I2C, 0x0F, CM3218X_<span id=3D"misspell-263" class=3D"mark">C=
ALIBSCALE</span>_DEFAULT,<br>&gt; &gt; &gt; + CM32181_<span id=3D"misspell-=
264" class=3D"mark">MLUX</span>_PER_BIT_DEFAULT, CM32181_<span id=3D"misspe=
ll-265" class=3D"mark">MLUX</span>_PER_BIT_BASE_IT,<br>&gt; &gt; &gt; + CM3=
2181_<span id=3D"misspell-266" class=3D"mark">als</span>_it_bits, CM32181_<=
span id=3D"misspell-267" class=3D"mark">als</span>_it_values,<br>&gt; &gt; =
&gt; + ARRAY_SIZE(CM32181_<span
 id=3D"misspell-268" class=3D"mark">als</span>_it_bits), 0};<br>&gt; &gt; &=
gt; +<br>&gt; &gt; &gt; +<span id=3D"misspell-269" class=3D"mark">struct</s=
pan> cm3218x_chip {<br>&gt; &gt; &gt; + <span id=3D"misspell-270" class=3D"=
mark">struct</span> i2c_client *client;<br>&gt; &gt; &gt; + <span id=3D"mis=
spell-271" class=3D"mark">struct</span> i2c_client *<span id=3D"misspell-27=
2" class=3D"mark">ara</span>;<br>&gt; &gt; &gt; + <span id=3D"misspell-273"=
 class=3D"mark">struct</span> <span id=3D"misspell-274" class=3D"mark">mute=
x</span> lock;<br>&gt; &gt; &gt; + u16 <span id=3D"misspell-275" class=3D"m=
ark">conf</span>_regs[CM3218X_<span id=3D"misspell-276" class=3D"mark">CONF=
</span>_REG_<span id=3D"misspell-277" class=3D"mark">NUM</span>];<br>&gt; &=
gt; &gt; + <span id=3D"misspell-278" class=3D"mark">struct</span> cm3218x_<=
span id=3D"misspell-279" class=3D"mark">als</span>_info *<span id=3D"misspe=
ll-280" class=3D"mark">als</span>_info;<br>&gt; &gt; &gt; +};<br>&gt; &gt; =
&gt; +<br>&gt; &gt; &gt; +static int
 cm3218x_get_<span id=3D"misspell-281" class=3D"mark">lux</span>(<span id=
=3D"misspell-282" class=3D"mark">struct</span> cm3218x_chip *chip);<br>&gt;=
 &gt; &gt; +static int cm3218x_threshold_update(<span id=3D"misspell-283" c=
lass=3D"mark">struct</span> cm3218x_chip *chip, int<br>&gt; &gt; &gt; perce=
nt);<br>&gt; &gt; &gt; +static int cm3218x_read_<span id=3D"misspell-284" c=
lass=3D"mark">als</span>_it(<span id=3D"misspell-285" class=3D"mark">struct=
</span> cm3218x_chip *chip, int *val2);<br>&gt; &gt; &gt; +<br>&gt; &gt; &g=
t; +/**<br>&gt; &gt; &gt; + * cm3218x_interrupt_<span id=3D"misspell-286" c=
lass=3D"mark">config</span>() - Enable/Disable CM3218X interrupt<br>&gt; &g=
t; &gt; + * @chip: pointer of <span id=3D"misspell-287" class=3D"mark">stru=
ct</span> cm3218x.<br>&gt; &gt; &gt; + * @enable: 0 to disable; otherwise t=
o enable<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * <span id=3D"misspell-2=
88" class=3D"mark">Config</span> CM3218X interrupt control bit.<br>&gt; &gt=
; &gt; + *<br>&gt; &gt;
 &gt; + * Return: 0 for success; otherwise for error code.<br>&gt; &gt; &gt=
; + */<br>&gt; &gt; &gt; +static int cm3218x_interrupt_<span id=3D"misspell=
-289" class=3D"mark">config</span>(<span id=3D"misspell-290" class=3D"mark"=
>struct</span> cm3218x_chip *chip, int<br>&gt; &gt; &gt; enable)<br>&gt; &g=
t; &gt; +{<br>&gt; &gt; &gt; + <span id=3D"misspell-291" class=3D"mark">str=
uct</span> i2c_client *client =3D chip-&gt;client;<br>&gt; &gt; &gt; + <spa=
n id=3D"misspell-292" class=3D"mark">struct</span> cm3218x_<span id=3D"miss=
pell-293" class=3D"mark">als</span>_info *<span id=3D"misspell-294" class=
=3D"mark">als</span>_info =3D chip-&gt;<span id=3D"misspell-295" class=3D"m=
ark">als</span>_info;<br>&gt; &gt; &gt; + int status;<br>&gt; &gt; &gt; +<b=
r>&gt; &gt; &gt; + if (!<span id=3D"misspell-296" class=3D"mark">als</span>=
_info)<br>&gt; &gt; &gt; + return -<span id=3D"misspell-297" class=3D"mark"=
>ENODEV</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Force to clean i=
nterrupt */<br>&gt; &gt; &gt; + if
 (<span id=3D"misspell-298" class=3D"mark">als</span>_info-&gt;int_type =3D=
=3D CM3218X_INT_TYPE_I2C) {<br>&gt; &gt; &gt; + status =3D i2c_<span id=3D"=
misspell-299" class=3D"mark">smbus</span>_read_word_data(client,<br>&gt; &g=
t; &gt; + CM3218X_REG_<span id=3D"misspell-300" class=3D"mark">ADDR</span>_=
STATUS);<br>&gt; &gt; &gt; + if (status &lt; 0)<br>&gt; &gt; &gt; + <span i=
d=3D"misspell-301" class=3D"mark">als</span>_info-&gt;int_type =3D CM3218X_=
INT_TYPE_<span id=3D"misspell-302" class=3D"mark">SMBUS</span>;<br>&gt; &gt=
; &gt; + }<br>&gt; &gt; &gt; + if (chip-&gt;<span id=3D"misspell-303" class=
=3D"mark">ara</span> &amp;&amp; <span id=3D"misspell-304" class=3D"mark">al=
s</span>_info-&gt;int_type =3D=3D CM3218X_INT_TYPE_<span id=3D"misspell-305=
" class=3D"mark">SMBUS</span>)<br>&gt; &gt; &gt; + i2c_<span id=3D"misspell=
-306" class=3D"mark">smbus</span>_read_byte(chip-&gt;<span id=3D"misspell-3=
07" class=3D"mark">ara</span>);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + if =
(enable)<br>&gt; &gt; &gt; + chip-&gt;<span
 id=3D"misspell-308" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=
=3D"misspell-309" class=3D"mark">ADDR</span>_<span id=3D"misspell-310" clas=
s=3D"mark">CMD</span>] |=3D<br>&gt; &gt; &gt; + CM3218X_<span id=3D"misspel=
l-311" class=3D"mark">CMD</span>_<span id=3D"misspell-312" class=3D"mark">A=
LS</span>_INT_EN;<br>&gt; &gt; &gt; + else<br>&gt; &gt; &gt; + chip-&gt;<sp=
an id=3D"misspell-313" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=
=3D"misspell-314" class=3D"mark">ADDR</span>_<span id=3D"misspell-315" clas=
s=3D"mark">CMD</span>] &amp;=3D<br>&gt; &gt; &gt; + ~CM3218X_<span id=3D"mi=
sspell-316" class=3D"mark">CMD</span>_<span id=3D"misspell-317" class=3D"ma=
rk">ALS</span>_INT_EN;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + status =3D i=
2c_<span id=3D"misspell-318" class=3D"mark">smbus</span>_write_word_data(cl=
ient, CM3218X_REG_<span id=3D"misspell-319" class=3D"mark">ADDR</span>_<spa=
n id=3D"misspell-320" class=3D"mark">CMD</span>,<br>&gt; &gt; &gt; + chip-&=
gt;<span id=3D"misspell-321"
 class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspell-322" clas=
s=3D"mark">ADDR</span>_<span id=3D"misspell-323" class=3D"mark">CMD</span>]=
);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + if (status &lt; 0)<br>&gt; &gt; =
&gt; + return -<span id=3D"misspell-324" class=3D"mark">ENODEV</span>;<br>&=
gt; &gt; &gt; +<br>&gt; &gt; &gt; + return status;<br>&gt; &gt; &gt; +}<br>=
&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + * cm3218x_<span=
 id=3D"misspell-325" class=3D"mark">acpi</span>_get_<span id=3D"misspell-32=
6" class=3D"mark">cpm</span>_info() - Get <span id=3D"misspell-327" class=
=3D"mark">CPM</span> object from <span id=3D"misspell-328" class=3D"mark">A=
CPI</span><br>&gt; &gt; &gt; + * @client pointer of <span id=3D"misspell-32=
9" class=3D"mark">struct</span> i2c_client.<br>&gt; &gt; &gt; + * @obj_name=
 pointer of <span id=3D"misspell-330" class=3D"mark">ACPI</span> object nam=
e.<br>&gt; &gt; &gt; + * @count maximum size of return array.<br>&gt; &gt; =
&gt; + * @<span id=3D"misspell-331"
 class=3D"mark">vals</span> pointer of array for return elements.<br>&gt; &=
gt; &gt; + *<br>&gt; &gt; &gt; + * Convert <span id=3D"misspell-332" class=
=3D"mark">ACPI</span> <span id=3D"misspell-333" class=3D"mark">CPM</span> t=
able to array. Special thanks <span id=3D"misspell-334" class=3D"mark">Srin=
ivas</span> <span id=3D"misspell-335" class=3D"mark">Pandruvada's</span><br=
>&gt; &gt; &gt; + * help to implement this routine.<br>&gt; &gt; &gt; + *<b=
r>&gt; &gt; &gt; + * Return: -<span id=3D"misspell-336" class=3D"mark">ENOD=
EV</span> for fail.&nbsp; Otherwise is number of elements.<br>&gt; &gt; &gt=
; + */<br>&gt; &gt; &gt; +static int cm3218x_<span id=3D"misspell-337" clas=
s=3D"mark">acpi</span>_get_<span id=3D"misspell-338" class=3D"mark">cpm</sp=
an>_info(<span id=3D"misspell-339" class=3D"mark">struct</span> i2c_client =
*client, char<br>&gt; &gt; &gt; *obj_name,<br>&gt; &gt; &gt; + int count, u=
64 *<span id=3D"misspell-340" class=3D"mark">vals</span>)<br>&gt; &gt; &gt;=
 +{<br>&gt; &gt; &gt; + <span
 id=3D"misspell-341" class=3D"mark">acpi</span>_handle handle;<br>&gt; &gt;=
 &gt; + <span id=3D"misspell-342" class=3D"mark">struct</span> <span id=3D"=
misspell-343" class=3D"mark">acpi</span>_buffer buffer =3D {<span id=3D"mis=
spell-344" class=3D"mark">ACPI</span>_ALLOCATE_BUFFER, NULL};<br>&gt; &gt; =
&gt; + int i;<br>&gt; &gt; &gt; + <span id=3D"misspell-345" class=3D"mark">=
acpi</span>_status status;<br>&gt; &gt; &gt; + union <span id=3D"misspell-3=
46" class=3D"mark">acpi</span>_object *<span id=3D"misspell-347" class=3D"m=
ark">cpm</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + handle =3D <span i=
d=3D"misspell-348" class=3D"mark">ACPI</span>_HANDLE(&amp;client-&gt;<span =
id=3D"misspell-349" class=3D"mark">dev</span>);<br>&gt; &gt; &gt; + if (!ha=
ndle)<br>&gt; &gt; &gt; + return -<span id=3D"misspell-350" class=3D"mark">=
ENODEV</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + status =3D <span id=
=3D"misspell-351" class=3D"mark">acpi</span>_evaluate_object(handle, obj_na=
me, NULL, &amp;buffer);<br>&gt; &gt; &gt; +
 if (<span id=3D"misspell-352" class=3D"mark">ACPI</span>_FAILURE(status)) =
{<br>&gt; &gt; &gt; + <span id=3D"misspell-353" class=3D"mark">dev</span>_e=
rr(&amp;client-&gt;<span id=3D"misspell-354" class=3D"mark">dev</span>, "ob=
ject %s not found\n", obj_name);<br>&gt; &gt; &gt; + return -<span id=3D"mi=
sspell-355" class=3D"mark">ENODEV</span>;<br>&gt; &gt; &gt; + }<br>&gt; &gt=
; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell-356" class=3D"mark">cpm</=
span> =3D buffer.pointer;<br>&gt; &gt; &gt; + for (i =3D 0; i &lt; <span id=
=3D"misspell-357" class=3D"mark">cpm</span>-&gt;package.count &amp;&amp; i =
&lt; count; ++i) {<br>&gt; &gt; &gt; + union <span id=3D"misspell-358" clas=
s=3D"mark">acpi</span>_object *elem;<br>&gt; &gt; &gt; + elem =3D &amp;(<sp=
an id=3D"misspell-359" class=3D"mark">cpm</span>-&gt;package.elements[i]);<=
br>&gt; &gt; &gt; + <span id=3D"misspell-360" class=3D"mark">vals</span>[i]=
 =3D elem-&gt;integer.value;<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&=
gt; &gt; &gt; + <span
 id=3D"misspell-361" class=3D"mark">kfree</span>(buffer.pointer);<br>&gt; &=
gt; &gt; +<br>&gt; &gt; &gt; + return <span id=3D"misspell-362" class=3D"ma=
rk">cpm</span>-&gt;package.count;<br>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +<=
br>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + * cm3218x_reg_<span id=3D"misspe=
ll-363" class=3D"mark">init</span>() - Initialize CM3218X registers<br>&gt;=
 &gt; &gt; + * @chip: pointer of <span id=3D"misspell-364" class=3D"mark">s=
truct</span> cm3218x.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Initializ=
e CM3218X ambient light sensor register to default values.<br>&gt; &gt; &gt=
; + *<br>&gt; &gt; &gt; +&nbsp; Return: 0 for success; otherwise for error =
code.<br>&gt; &gt; &gt; + */<br>&gt; &gt; &gt; +static int cm3218x_reg_<spa=
n id=3D"misspell-365" class=3D"mark">init</span>(<span id=3D"misspell-366" =
class=3D"mark">struct</span> cm3218x_chip *chip)<br>&gt; &gt; &gt; +{<br>&g=
t; &gt; &gt; + <span id=3D"misspell-367" class=3D"mark">struct</span> i2c_c=
lient *client =3D
 chip-&gt;client;<br>&gt; &gt; &gt; + int i;<br>&gt; &gt; &gt; + s32 <span =
id=3D"misspell-368" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; + int <spa=
n id=3D"misspell-369" class=3D"mark">cpm</span>_elem_count;<br>&gt; &gt; &g=
t; + u64 <span id=3D"misspell-370" class=3D"mark">cpm</span>_<span id=3D"mi=
sspell-371" class=3D"mark">elems</span>[20];<br>&gt; &gt; &gt; + <span id=
=3D"misspell-372" class=3D"mark">struct</span> cm3218x_<span id=3D"misspell=
-373" class=3D"mark">als</span>_info *<span id=3D"misspell-374" class=3D"ma=
rk">als</span>_info;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Default dev=
ice */<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"misspell-375" class=3D"mark=
">als</span>_info =3D &amp;cm3218_info;<br>&gt; &gt; &gt; + chip-&gt;<span =
id=3D"misspell-376" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D=
"misspell-377" class=3D"mark">ADDR</span>_<span id=3D"misspell-378" class=
=3D"mark">CMD</span>] =3D CM3218X_<span id=3D"misspell-379" class=3D"mark">=
CMD</span>_DEFAULT;<br>&gt; &gt; &gt; +
 chip-&gt;<span id=3D"misspell-380" class=3D"mark">conf</span>_regs[CM3218X=
_REG_<span id=3D"misspell-381" class=3D"mark">ADDR</span>_<span id=3D"missp=
ell-382" class=3D"mark">WH</span>] =3D CM3218X_<span id=3D"misspell-383" cl=
ass=3D"mark">WH</span>_DEFAULT;<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"mi=
sspell-384" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspel=
l-385" class=3D"mark">ADDR</span>_<span id=3D"misspell-386" class=3D"mark">=
WL</span>] =3D CM3218X_<span id=3D"misspell-387" class=3D"mark">WL</span>_D=
EFAULT;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Disable interrupt */<br>=
&gt; &gt; &gt; + cm3218x_interrupt_<span id=3D"misspell-388" class=3D"mark"=
>config</span>(chip, 0);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Disable=
 Test Mode */<br>&gt; &gt; &gt; + i2c_<span id=3D"misspell-389" class=3D"ma=
rk">smbus</span>_write_word_data(client, CM3218X_REG_<span id=3D"misspell-3=
90" class=3D"mark">ADDR</span>_TEST, 0x0000);<br>&gt; &gt; &gt; +<br>&gt; &=
gt; &gt; + /* Disable device */<br>&gt;
 &gt; &gt; + i2c_<span id=3D"misspell-391" class=3D"mark">smbus</span>_writ=
e_word_data(client, CM3218X_REG_<span id=3D"misspell-392" class=3D"mark">AD=
DR</span>_<span id=3D"misspell-393" class=3D"mark">CMD</span>,<br>&gt; &gt;=
 &gt; + CM3218X_<span id=3D"misspell-394" class=3D"mark">CMD</span>_<span i=
d=3D"misspell-395" class=3D"mark">ALS</span>_DISABLE);<br>&gt; &gt; &gt; +<=
br>&gt; &gt; &gt; + /* Identify device */<br>&gt; &gt; &gt; + <span id=3D"m=
isspell-396" class=3D"mark">ret</span> =3D i2c_<span id=3D"misspell-397" cl=
ass=3D"mark">smbus</span>_read_word_data(client, CM3218X_REG_<span id=3D"mi=
sspell-398" class=3D"mark">ADDR</span>_ID);<br>&gt; &gt; &gt; + if (<span i=
d=3D"misspell-399" class=3D"mark">ret</span> &lt; 0)<br>&gt; &gt; &gt; + re=
turn <span id=3D"misspell-400" class=3D"mark">ret</span>;<br>&gt; &gt; &gt;=
 + switch (<span id=3D"misspell-401" class=3D"mark">ret</span> &amp; 0<span=
 id=3D"misspell-402" class=3D"mark">xFF</span>) {<br>&gt; &gt; &gt; + case =
0x18:<br>&gt; &gt; &gt; + <span
 id=3D"misspell-403" class=3D"mark">als</span>_info =3D chip-&gt;<span id=
=3D"misspell-404" class=3D"mark">als</span>_info =3D &amp;cm3218_info;<br>&=
gt; &gt; &gt; + if (<span id=3D"misspell-405" class=3D"mark">ret</span> &am=
p; 0x0800)<br>&gt; &gt; &gt; + <span id=3D"misspell-406" class=3D"mark">als=
</span>_info-&gt;int_type =3D CM3218X_INT_TYPE_I2C;<br>&gt; &gt; &gt; + els=
e<br>&gt; &gt; &gt; + <span id=3D"misspell-407" class=3D"mark">als</span>_i=
nfo-&gt;int_type =3D CM3218X_INT_TYPE_<span id=3D"misspell-408" class=3D"ma=
rk">SMBUS</span>;<br>&gt; &gt; &gt; + break;<br>&gt; &gt; &gt; + case 0x81:=
<br>&gt; &gt; &gt; + <span id=3D"misspell-409" class=3D"mark">als</span>_in=
fo =3D chip-&gt;<span id=3D"misspell-410" class=3D"mark">als</span>_info =
=3D &amp;cm32181_info;<br>&gt; &gt; &gt; + break;<br>&gt; &gt; &gt; + case =
0x82:<br>&gt; &gt; &gt; + <span id=3D"misspell-411" class=3D"mark">als</spa=
n>_info =3D chip-&gt;<span id=3D"misspell-412" class=3D"mark">als</span>_in=
fo =3D &amp;cm32182_info;<br>&gt; &gt; &gt; +
 break;<br>&gt; &gt; &gt; + default:<br>&gt; &gt; &gt; + return -<span id=
=3D"misspell-413" class=3D"mark">ENODEV</span>;<br>&gt; &gt; &gt; + }<br>&g=
t; &gt; &gt; +<br>&gt; &gt; &gt; + if (<span id=3D"misspell-414" class=3D"m=
ark">ACPI</span>_HANDLE(&amp;client-&gt;<span id=3D"misspell-415" class=3D"=
mark">dev</span>)) {<br>&gt; &gt; &gt; + /* Load from <span id=3D"misspell-=
416" class=3D"mark">ACPI</span> */<br>&gt; &gt; &gt; + <span id=3D"misspell=
-417" class=3D"mark">cpm</span>_elem_count =3D cm3218x_<span id=3D"misspell=
-418" class=3D"mark">acpi</span>_get_<span id=3D"misspell-419" class=3D"mar=
k">cpm</span>_info(client, "<span id=3D"misspell-420" class=3D"mark">CPM</s=
pan>0",<br>&gt; &gt; &gt; + ARRAY_SIZE(<span id=3D"misspell-421" class=3D"m=
ark">cpm</span>_<span id=3D"misspell-422" class=3D"mark">elems</span>),<br>=
&gt; &gt; &gt; + <span id=3D"misspell-423" class=3D"mark">cpm</span>_<span =
id=3D"misspell-424" class=3D"mark">elems</span>);<br>&gt; &gt; &gt; + if (<=
span id=3D"misspell-425"
 class=3D"mark">cpm</span>_elem_count &gt; 0) {<br>&gt; &gt; &gt; + int hea=
der_<span id=3D"misspell-426" class=3D"mark">num</span> =3D 3;<br>&gt; &gt;=
 &gt; + int reg_<span id=3D"misspell-427" class=3D"mark">num</span> =3D <sp=
an id=3D"misspell-428" class=3D"mark">cpm</span>_elem_count - header_<span =
id=3D"misspell-429" class=3D"mark">num</span>;<br>&gt; &gt; &gt; +<br>&gt; =
&gt; &gt; + <span id=3D"misspell-430" class=3D"mark">als</span>_info-&gt;re=
gs_<span id=3D"misspell-431" class=3D"mark">bmp</span> =3D <span id=3D"miss=
pell-432" class=3D"mark">cpm</span>_<span id=3D"misspell-433" class=3D"mark=
">elems</span>[2];<br>&gt; &gt; &gt; + for (i =3D 0; i &lt; reg_<span id=3D=
"misspell-434" class=3D"mark">num</span>; i++)<br>&gt; &gt; &gt; + if (<spa=
n id=3D"misspell-435" class=3D"mark">als</span>_info-&gt;regs_<span id=3D"m=
isspell-436" class=3D"mark">bmp</span> &amp; (1&lt;&lt;i))<br>&gt; &gt; &gt=
; + chip-&gt;<span id=3D"misspell-437" class=3D"mark">conf</span>_regs[i] =
=3D<br>&gt; &gt; &gt; + <span id=3D"misspell-438"
 class=3D"mark">cpm</span>_<span id=3D"misspell-439" class=3D"mark">elems</=
span>[header_<span id=3D"misspell-440" class=3D"mark">num</span>+i];<br>&gt=
; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspel=
l-441" class=3D"mark">cpm</span>_elem_count =3D cm3218x_<span id=3D"misspel=
l-442" class=3D"mark">acpi</span>_get_<span id=3D"misspell-443" class=3D"ma=
rk">cpm</span>_info(client, "<span id=3D"misspell-444" class=3D"mark">CPM</=
span>1",<br>&gt; &gt; &gt; + ARRAY_SIZE(<span id=3D"misspell-445" class=3D"=
mark">cpm</span>_<span id=3D"misspell-446" class=3D"mark">elems</span>),<br=
>&gt; &gt; &gt; + <span id=3D"misspell-447" class=3D"mark">cpm</span>_<span=
 id=3D"misspell-448" class=3D"mark">elems</span>);<br>&gt; &gt; &gt; + if (=
<span id=3D"misspell-449" class=3D"mark">cpm</span>_elem_count &gt; 0) {<br=
>&gt; &gt; &gt; + <span id=3D"misspell-450" class=3D"mark">als</span>_info-=
&gt;<span id=3D"misspell-451" class=3D"mark">mlux</span>_per_bit =3D (int)<=
span id=3D"misspell-452"
 class=3D"mark">cpm</span>_<span id=3D"misspell-453" class=3D"mark">elems</=
span>[0] / 100;<br>&gt; &gt; &gt; + <span id=3D"misspell-454" class=3D"mark=
">als</span>_info-&gt;<span id=3D"misspell-455" class=3D"mark">calibscale</=
span> =3D (int)<span id=3D"misspell-456" class=3D"mark">cpm</span>_<span id=
=3D"misspell-457" class=3D"mark">elems</span>[1];<br>&gt; &gt; &gt; + }<br>=
&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Force to disa=
ble interrupt */<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"misspell-458" cla=
ss=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspell-459" class=3D=
"mark">ADDR</span>_<span id=3D"misspell-460" class=3D"mark">CMD</span>] &am=
p;=3D ~CM3218X_<span id=3D"misspell-461" class=3D"mark">CMD</span>_<span id=
=3D"misspell-462" class=3D"mark">ALS</span>_INT_EN;<br>&gt; &gt; &gt; +<br>=
&gt; &gt; &gt; + /* Initialize registers */<br>&gt; &gt; &gt; + for (i =3D =
0; i &lt; CM3218X_<span id=3D"misspell-463" class=3D"mark">CONF</span>_REG_=
<span id=3D"misspell-464"
 class=3D"mark">NUM</span>; i++) {<br>&gt; &gt; &gt; + if (<span id=3D"miss=
pell-465" class=3D"mark">als</span>_info-&gt;regs_<span id=3D"misspell-466"=
 class=3D"mark">bmp</span> &amp; (1&lt;&lt;i)) {<br>&gt; &gt; &gt; + <span =
id=3D"misspell-467" class=3D"mark">ret</span> =3D i2c_<span id=3D"misspell-=
468" class=3D"mark">smbus</span>_write_word_data(client, i,<br>&gt; &gt; &g=
t; + chip-&gt;<span id=3D"misspell-469" class=3D"mark">conf</span>_regs[i])=
;<br>&gt; &gt; &gt; + if (<span id=3D"misspell-470" class=3D"mark">ret</spa=
n> &lt; 0)<br>&gt; &gt; &gt; + return <span id=3D"misspell-471" class=3D"ma=
rk">ret</span>;<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; + }<br>&gt; &gt; &g=
t; +<br>&gt; &gt; &gt; + return 0;<br>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +=
<br>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + *&nbsp; cm3218x_read_<span id=
=3D"misspell-472" class=3D"mark">als</span>_it() - Get sensor integration t=
ime (ms)<br>&gt; &gt; &gt; + *&nbsp; @chip: pointer of <span id=3D"misspell=
-473" class=3D"mark">struct</span>
 cm3218x<br>&gt; &gt; &gt; + *&nbsp; @val2: pointer of int to load the <spa=
n id=3D"misspell-474" class=3D"mark">als</span>_it value.<br>&gt; &gt; &gt;=
 + *<br>&gt; &gt; &gt; + *&nbsp; Report the current <span id=3D"misspell-47=
5" class=3D"mark">integartion</span> time in milliseconds.<br>&gt; &gt; <br=
>&gt; &gt; integration<br>&gt; &gt; <br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt=
; + *&nbsp; Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -<span id=
=3D"misspell-477" class=3D"mark">EINVAL</span>.<br>&gt; &gt; &gt; + */<br>&=
gt; &gt; &gt; +static int cm3218x_read_<span id=3D"misspell-478" class=3D"m=
ark">als</span>_it(<span id=3D"misspell-479" class=3D"mark">struct</span> c=
m3218x_chip *chip, int *val2)<br>&gt; &gt; &gt; +{<br>&gt; &gt; &gt; + <spa=
n id=3D"misspell-480" class=3D"mark">struct</span> cm3218x_<span id=3D"miss=
pell-481" class=3D"mark">als</span>_info *<span id=3D"misspell-482" class=
=3D"mark">als</span>_info =3D chip-&gt;<span id=3D"misspell-483" class=3D"m=
ark">als</span>_info;<br>&gt;
 &gt; &gt; + u16 <span id=3D"misspell-484" class=3D"mark">als</span>_it;<br=
>&gt; &gt; &gt; + int i;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=
=3D"misspell-485" class=3D"mark">als</span>_it =3D chip-&gt;<span id=3D"mis=
spell-486" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspell=
-487" class=3D"mark">ADDR</span>_<span id=3D"misspell-488" class=3D"mark">C=
MD</span>];<br>&gt; &gt; &gt; + <span id=3D"misspell-489" class=3D"mark">al=
s</span>_it &amp;=3D CM3218X_<span id=3D"misspell-490" class=3D"mark">CMD</=
span>_<span id=3D"misspell-491" class=3D"mark">ALS</span>_IT_MASK;<br>&gt; =
&gt; &gt; + <span id=3D"misspell-492" class=3D"mark">als</span>_it &gt;&gt;=
=3D CM3218X_<span id=3D"misspell-493" class=3D"mark">CMD</span>_<span id=3D=
"misspell-494" class=3D"mark">ALS</span>_IT_SHIFT;<br>&gt; &gt; &gt; + for =
(i =3D 0; i &lt; <span id=3D"misspell-495" class=3D"mark">als</span>_info-&=
gt;<span id=3D"misspell-496" class=3D"mark">num</span>_<span id=3D"misspell=
-497" class=3D"mark">als</span>_it; i++) {<br>&gt; &gt;
 &gt; + if (<span id=3D"misspell-498" class=3D"mark">als</span>_it =3D=3D <=
span id=3D"misspell-499" class=3D"mark">als</span>_info-&gt;<span id=3D"mis=
spell-500" class=3D"mark">als</span>_it_bits[i]) {<br>&gt; &gt; &gt; + *val=
2 =3D <span id=3D"misspell-501" class=3D"mark">als</span>_info-&gt;<span id=
=3D"misspell-502" class=3D"mark">als</span>_it_values[i];<br>&gt; &gt; &gt;=
 + return IIO_VAL_INT_PLUS_MICRO;<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +=
 }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + return -<span id=3D"misspell-504=
" class=3D"mark">EINVAL</span>;<br>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +<br=
>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + * cm3218x_write_<span id=3D"misspe=
ll-505" class=3D"mark">als</span>_it() - Write sensor integration time<br>&=
gt; &gt; &gt; + * @chip: pointer of <span id=3D"misspell-506" class=3D"mark=
">struct</span> cm3218x.<br>&gt; &gt; &gt; + * @val: integration time in mi=
lliseconds.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Convert integration=
 time (ms) to sensor
 value.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Return: i2c_<span id=3D=
"misspell-507" class=3D"mark">smbus</span>_write_word_data command return v=
alue.<br>&gt; &gt; &gt; + */<br>&gt; &gt; &gt; +static int cm3218x_write_<s=
pan id=3D"misspell-508" class=3D"mark">als</span>_it(<span id=3D"misspell-5=
09" class=3D"mark">struct</span> cm3218x_chip *chip, int val)<br>&gt; &gt; =
&gt; +{<br>&gt; &gt; &gt; + <span id=3D"misspell-510" class=3D"mark">struct=
</span> i2c_client *client =3D chip-&gt;client;<br>&gt; &gt; &gt; + <span i=
d=3D"misspell-511" class=3D"mark">struct</span> cm3218x_<span id=3D"misspel=
l-512" class=3D"mark">als</span>_info *<span id=3D"misspell-513" class=3D"m=
ark">als</span>_info =3D chip-&gt;<span id=3D"misspell-514" class=3D"mark">=
als</span>_info;<br>&gt; &gt; &gt; + u16 <span id=3D"misspell-515" class=3D=
"mark">als</span>_it;<br>&gt; &gt; &gt; + int <span id=3D"misspell-516" cla=
ss=3D"mark">ret</span>, i;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + for (i =
=3D 0; i &lt; <span id=3D"misspell-517"
 class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-518" class=3D"mark=
">num</span>_<span id=3D"misspell-519" class=3D"mark">als</span>_it; i++)<b=
r>&gt; &gt; &gt; + if (val &lt;=3D <span id=3D"misspell-520" class=3D"mark"=
>als</span>_info-&gt;<span id=3D"misspell-521" class=3D"mark">als</span>_it=
_values[i])<br>&gt; &gt; &gt; + break;<br>&gt; &gt; &gt; + if (i &gt;=3D <s=
pan id=3D"misspell-522" class=3D"mark">als</span>_info-&gt;<span id=3D"miss=
pell-523" class=3D"mark">num</span>_<span id=3D"misspell-524" class=3D"mark=
">als</span>_it)<br>&gt; &gt; &gt; + i =3D <span id=3D"misspell-525" class=
=3D"mark">als</span>_info-&gt;<span id=3D"misspell-526" class=3D"mark">num<=
/span>_<span id=3D"misspell-527" class=3D"mark">als</span>_it - 1;<br>&gt; =
&gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell-528" class=3D"mark">al=
s</span>_it =3D <span id=3D"misspell-529" class=3D"mark">als</span>_info-&g=
t;<span id=3D"misspell-530" class=3D"mark">als</span>_it_bits[i];<br>&gt; &=
gt; &gt; + <span id=3D"misspell-531"
 class=3D"mark">als</span>_it &lt;&lt;=3D CM3218X_<span id=3D"misspell-532"=
 class=3D"mark">CMD</span>_<span id=3D"misspell-533" class=3D"mark">ALS</sp=
an>_IT_SHIFT;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell-=
534" class=3D"mark">mutex</span>_lock(&amp;chip-&gt;lock);<br>&gt; &gt; &gt=
; + chip-&gt;<span id=3D"misspell-535" class=3D"mark">conf</span>_regs[CM32=
18X_REG_<span id=3D"misspell-536" class=3D"mark">ADDR</span>_<span id=3D"mi=
sspell-537" class=3D"mark">CMD</span>] &amp;=3D<br>&gt; &gt; &gt; + ~CM3218=
X_<span id=3D"misspell-538" class=3D"mark">CMD</span>_<span id=3D"misspell-=
539" class=3D"mark">ALS</span>_IT_MASK;<br>&gt; &gt; &gt; + chip-&gt;<span =
id=3D"misspell-540" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D=
"misspell-541" class=3D"mark">ADDR</span>_<span id=3D"misspell-542" class=
=3D"mark">CMD</span>] |=3D<br>&gt; &gt; &gt; + <span id=3D"misspell-543" cl=
ass=3D"mark">als</span>_it;<br>&gt; &gt; &gt; + <span id=3D"misspell-544" c=
lass=3D"mark">ret</span> =3D i2c_<span id=3D"misspell-545"
 class=3D"mark">smbus</span>_write_word_data(client, CM3218X_REG_<span id=
=3D"misspell-546" class=3D"mark">ADDR</span>_<span id=3D"misspell-547" clas=
s=3D"mark">CMD</span>,<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"misspell-54=
8" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspell-549" cl=
ass=3D"mark">ADDR</span>_<span id=3D"misspell-550" class=3D"mark">CMD</span=
>]);<br>&gt; &gt; &gt; + <span id=3D"misspell-551" class=3D"mark">mutex</sp=
an>_unlock(&amp;chip-&gt;lock);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + ret=
urn <span id=3D"misspell-552" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; =
+}<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + * cm3218x=
_get_<span id=3D"misspell-553" class=3D"mark">lux</span>() - report current=
 <span id=3D"misspell-554" class=3D"mark">lux</span> value<br>&gt; &gt; &gt=
; + * @chip: pointer of <span id=3D"misspell-555" class=3D"mark">struct</sp=
an> cm3218x.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Convert sensor raw=
 data to <span id=3D"misspell-556"
 class=3D"mark">lux</span>.&nbsp; It depends on integration<br>&gt; &gt; &g=
t; + * time and <span id=3D"misspell-557" class=3D"mark">calibscale</span> =
variable.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Return: Positive valu=
e is <span id=3D"misspell-558" class=3D"mark">lux</span>, otherwise is erro=
r code.<br>&gt; &gt; &gt; + */<br>&gt; &gt; &gt; +static int cm3218x_get_<s=
pan id=3D"misspell-559" class=3D"mark">lux</span>(<span id=3D"misspell-560"=
 class=3D"mark">struct</span> cm3218x_chip *chip)<br>&gt; &gt; &gt; +{<br>&=
gt; &gt; &gt; + <span id=3D"misspell-561" class=3D"mark">struct</span> i2c_=
client *client =3D chip-&gt;client;<br>&gt; &gt; &gt; + <span id=3D"misspel=
l-562" class=3D"mark">struct</span> cm3218x_<span id=3D"misspell-563" class=
=3D"mark">als</span>_info *<span id=3D"misspell-564" class=3D"mark">als</sp=
an>_info =3D chip-&gt;<span id=3D"misspell-565" class=3D"mark">als</span>_i=
nfo;<br>&gt; &gt; &gt; + int <span id=3D"misspell-566" class=3D"mark">ret</=
span>;<br>&gt; &gt; &gt; + int <span
 id=3D"misspell-567" class=3D"mark">als</span>_it;<br>&gt; &gt; &gt; + u64 =
<span id=3D"misspell-568" class=3D"mark">tmp</span>;<br>&gt; &gt; &gt; +<br=
>&gt; &gt; &gt; + /* Calculate <span id=3D"misspell-569" class=3D"mark">mlu=
x</span> per bit based on <span id=3D"misspell-570" class=3D"mark">als</spa=
n>_it */<br>&gt; &gt; &gt; + <span id=3D"misspell-571" class=3D"mark">ret</=
span> =3D cm3218x_read_<span id=3D"misspell-572" class=3D"mark">als</span>_=
it(chip, &amp;<span id=3D"misspell-573" class=3D"mark">als</span>_it);<br>&=
gt; &gt; &gt; + if (<span id=3D"misspell-574" class=3D"mark">ret</span> &lt=
; 0)<br>&gt; &gt; &gt; + return -<span id=3D"misspell-575" class=3D"mark">E=
INVAL</span>;<br>&gt; &gt; &gt; + <span id=3D"misspell-576" class=3D"mark">=
tmp</span> =3D (__force u64)<span id=3D"misspell-577" class=3D"mark">als</s=
pan>_info-&gt;<span id=3D"misspell-578" class=3D"mark">mlux</span>_per_bit;=
<br>&gt; &gt; &gt; + <span id=3D"misspell-579" class=3D"mark">tmp</span> *=
=3D <span id=3D"misspell-580"
 class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-581" class=3D"mark=
">mlux</span>_per_bit_base_it;<br>&gt; &gt; &gt; + <span id=3D"misspell-582=
" class=3D"mark">tmp</span> =3D div_u64(<span id=3D"misspell-583" class=3D"=
mark">tmp</span>, <span id=3D"misspell-584" class=3D"mark">als</span>_it);<=
br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Get <span id=3D"misspell-585" cl=
ass=3D"mark">als</span>_raw */<br>&gt; &gt; &gt; + if (!(chip-&gt;<span id=
=3D"misspell-586" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"m=
isspell-587" class=3D"mark">ADDR</span>_<span id=3D"misspell-588" class=3D"=
mark">CMD</span>] &amp; CM3218X_<span id=3D"misspell-589" class=3D"mark">CM=
D</span>_<span id=3D"misspell-590" class=3D"mark">ALS</span>_INT_EN))<br>&g=
t; &gt; &gt; + <span id=3D"misspell-591" class=3D"mark">als</span>_info-&gt=
;<span id=3D"misspell-592" class=3D"mark">als</span>_raw =3D i2c_<span id=
=3D"misspell-593" class=3D"mark">smbus</span>_read_word_data(<br>&gt; &gt; =
&gt; + client,<br>&gt; &gt; &gt; + CM3218X_REG_<span
 id=3D"misspell-594" class=3D"mark">ADDR</span>_<span id=3D"misspell-595" c=
lass=3D"mark">ALS</span>);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-596=
" class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-597" class=3D"mar=
k">als</span>_raw &lt; 0)<br>&gt; &gt; &gt; + return <span id=3D"misspell-5=
98" class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-599" class=3D"m=
ark">als</span>_raw;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"mi=
sspell-600" class=3D"mark">tmp</span> *=3D <span id=3D"misspell-601" class=
=3D"mark">als</span>_info-&gt;<span id=3D"misspell-602" class=3D"mark">als<=
/span>_raw;<br>&gt; &gt; &gt; + <span id=3D"misspell-603" class=3D"mark">tm=
p</span> *=3D <span id=3D"misspell-604" class=3D"mark">als</span>_info-&gt;=
<span id=3D"misspell-605" class=3D"mark">calibscale</span>;<br>&gt; &gt; &g=
t; + <span id=3D"misspell-606" class=3D"mark">tmp</span> =3D div_u64(<span =
id=3D"misspell-607" class=3D"mark">tmp</span>, CM3218X_<span id=3D"misspell=
-608" class=3D"mark">CALIBSCALE</span>_RESOLUTION);<br>&gt;
 &gt; &gt; + <span id=3D"misspell-609" class=3D"mark">tmp</span> =3D div_u6=
4(<span id=3D"misspell-610" class=3D"mark">tmp</span>, CM3218X_<span id=3D"=
misspell-611" class=3D"mark">MLUX</span>_PER_<span id=3D"misspell-612" clas=
s=3D"mark">LUX</span>);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + if (<span i=
d=3D"misspell-613" class=3D"mark">tmp</span> &gt; 0<span id=3D"misspell-614=
" class=3D"mark">xFFFF</span>)<br>&gt; &gt; &gt; + <span id=3D"misspell-615=
" class=3D"mark">tmp</span> =3D 0<span id=3D"misspell-616" class=3D"mark">x=
FFFF</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + return (int)<span id=
=3D"misspell-617" class=3D"mark">tmp</span>;<br>&gt; &gt; &gt; +}<br>&gt; &=
gt; &gt; +<br>&gt; &gt; &gt; +static int cm3218x_read_raw(<span id=3D"missp=
ell-618" class=3D"mark">struct</span> iio_<span id=3D"misspell-620" class=
=3D"mark">dev</span> *<span id=3D"misspell-621" class=3D"mark">indio</span>=
_<span id=3D"misspell-622" class=3D"mark">dev</span>,<br>&gt; &gt; &gt; + <=
span id=3D"misspell-623" class=3D"mark">struct</span>
 iio_<span id=3D"misspell-625" class=3D"mark">chan</span>_spec <span id=3D"=
misspell-626" class=3D"mark">const</span> *<span id=3D"misspell-627" class=
=3D"mark">chan</span>,<br>&gt; &gt; &gt; + int *val, int *val2, long mask)<=
br>&gt; &gt; &gt; +{<br>&gt; &gt; &gt; + <span id=3D"misspell-628" class=3D=
"mark">struct</span> cm3218x_chip *chip =3D iio_<span id=3D"misspell-630" c=
lass=3D"mark">priv</span>(<span id=3D"misspell-631" class=3D"mark">indio</s=
pan>_<span id=3D"misspell-632" class=3D"mark">dev</span>);<br>&gt; &gt; &gt=
; + <span id=3D"misspell-633" class=3D"mark">struct</span> cm3218x_<span id=
=3D"misspell-634" class=3D"mark">als</span>_info *<span id=3D"misspell-635"=
 class=3D"mark">als</span>_info =3D chip-&gt;<span id=3D"misspell-636" clas=
s=3D"mark">als</span>_info;<br>&gt; &gt; &gt; + int <span id=3D"misspell-63=
7" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + switc=
h (mask) {<br>&gt; &gt; &gt; + case IIO_CHAN_INFO_PROCESSED:<br>&gt; &gt; &=
gt; + <span id=3D"misspell-639"
 class=3D"mark">ret</span> =3D cm3218x_get_<span id=3D"misspell-640" class=
=3D"mark">lux</span>(chip);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-64=
1" class=3D"mark">ret</span> &lt; 0)<br>&gt; &gt; &gt; + return <span id=3D=
"misspell-642" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; + *val =3D <spa=
n id=3D"misspell-643" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; + return=
 IIO_VAL_INT;<br>&gt; &gt; &gt; + case IIO_CHAN_INFO_<span id=3D"misspell-6=
46" class=3D"mark">CALIBSCALE</span>:<br>&gt; &gt; &gt; + *val =3D <span id=
=3D"misspell-647" class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-6=
48" class=3D"mark">calibscale</span>;<br>&gt; &gt; &gt; + return IIO_VAL_IN=
T;<br>&gt; &gt; &gt; + case IIO_CHAN_INFO_INT_TIME:<br>&gt; &gt; &gt; + *va=
l =3D 0;<br>&gt; &gt; &gt; + <span id=3D"misspell-651" class=3D"mark">ret</=
span> =3D cm3218x_read_<span id=3D"misspell-652" class=3D"mark">als</span>_=
it(chip, val2);<br>&gt; &gt; &gt; + return <span id=3D"misspell-653" class=
=3D"mark">ret</span>;<br>&gt; &gt; &gt; +
 }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + return -<span id=3D"misspell-654=
" class=3D"mark">EINVAL</span>;<br>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +<br=
>&gt; &gt; &gt; +static int cm3218x_write_raw(<span id=3D"misspell-655" cla=
ss=3D"mark">struct</span> iio_<span id=3D"misspell-657" class=3D"mark">dev<=
/span> *<span id=3D"misspell-658" class=3D"mark">indio</span>_<span id=3D"m=
isspell-659" class=3D"mark">dev</span>,<br>&gt; &gt; &gt; + <span id=3D"mis=
spell-660" class=3D"mark">struct</span> iio_<span id=3D"misspell-662" class=
=3D"mark">chan</span>_spec <span id=3D"misspell-663" class=3D"mark">const</=
span> *<span id=3D"misspell-664" class=3D"mark">chan</span>,<br>&gt; &gt; &=
gt; + int val, int val2, long mask)<br>&gt; &gt; &gt; +{<br>&gt; &gt; &gt; =
+ <span id=3D"misspell-665" class=3D"mark">struct</span> cm3218x_chip *chip=
 =3D iio_<span id=3D"misspell-667" class=3D"mark">priv</span>(<span id=3D"m=
isspell-668" class=3D"mark">indio</span>_<span id=3D"misspell-669" class=3D=
"mark">dev</span>);<br>&gt; &gt; &gt; + <span
 id=3D"misspell-670" class=3D"mark">struct</span> cm3218x_<span id=3D"missp=
ell-671" class=3D"mark">als</span>_info *<span id=3D"misspell-672" class=3D=
"mark">als</span>_info =3D chip-&gt;<span id=3D"misspell-673" class=3D"mark=
">als</span>_info;<br>&gt; &gt; &gt; + long ms;<br>&gt; &gt; &gt; +<br>&gt;=
 &gt; &gt; + switch (mask) {<br>&gt; &gt; &gt; + case IIO_CHAN_INFO_<span i=
d=3D"misspell-675" class=3D"mark">CALIBSCALE</span>:<br>&gt; &gt; &gt; + <s=
pan id=3D"misspell-676" class=3D"mark">als</span>_info-&gt;<span id=3D"miss=
pell-677" class=3D"mark">calibscale</span> =3D val;<br>&gt; &gt; &gt; + ret=
urn val;<br>&gt; &gt; &gt; + case IIO_CHAN_INFO_INT_TIME:<br>&gt; &gt; &gt;=
 + ms =3D val * 1000000 + val2;<br>&gt; &gt; &gt; + return cm3218x_write_<s=
pan id=3D"misspell-679" class=3D"mark">als</span>_it(chip, (int)ms);<br>&gt=
; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + return -<span id=3D=
"misspell-680" class=3D"mark">EINVAL</span>;<br>&gt; &gt; &gt; +}<br>&gt; &=
gt; &gt; +<br>&gt; &gt; &gt;
 +/**<br>&gt; &gt; &gt; + * cm3218x_get_it_available() - Get available <spa=
n id=3D"misspell-681" class=3D"mark">ALS</span> IT value<br>&gt; &gt; &gt; =
+ * @<span id=3D"misspell-682" class=3D"mark">dev</span>: pointer of <span =
id=3D"misspell-683" class=3D"mark">struct</span> device.<br>&gt; &gt; &gt; =
+ * @<span id=3D"misspell-684" class=3D"mark">attr</span>: pointer of <span=
 id=3D"misspell-685" class=3D"mark">struct</span> device_attribute.<br>&gt;=
 &gt; &gt; + * @<span id=3D"misspell-686" class=3D"mark">buf</span>: pointe=
r of return string buffer.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Disp=
lay the available integration time in milliseconds.<br>&gt; &gt; &gt; + *<b=
r>&gt; &gt; &gt; + * Return: string length.<br>&gt; &gt; &gt; + */<br>&gt; =
&gt; &gt; +static <span id=3D"misspell-687" class=3D"mark">ssize</span>_t c=
m3218x_get_it_available(<span id=3D"misspell-688" class=3D"mark">struct</sp=
an> device *<span id=3D"misspell-689" class=3D"mark">dev</span>,<br>&gt; &g=
t; &gt; + <span
 id=3D"misspell-690" class=3D"mark">struct</span> device_attribute *<span i=
d=3D"misspell-691" class=3D"mark">attr</span>, char *<span id=3D"misspell-6=
92" class=3D"mark">buf</span>)<br>&gt; &gt; &gt; +{<br>&gt; &gt; &gt; + <sp=
an id=3D"misspell-693" class=3D"mark">struct</span> cm3218x_chip *chip =3D =
iio_<span id=3D"misspell-695" class=3D"mark">priv</span>(<span id=3D"misspe=
ll-696" class=3D"mark">dev</span>_to_iio_<span id=3D"misspell-698" class=3D=
"mark">dev</span>(<span id=3D"misspell-699" class=3D"mark">dev</span>));<br=
>&gt; &gt; &gt; + <span id=3D"misspell-700" class=3D"mark">struct</span> cm=
3218x_<span id=3D"misspell-701" class=3D"mark">als</span>_info *<span id=3D=
"misspell-702" class=3D"mark">als</span>_info =3D chip-&gt;<span id=3D"miss=
pell-703" class=3D"mark">als</span>_info;<br>&gt; &gt; &gt; + int i, <span =
id=3D"misspell-704" class=3D"mark">len</span>;<br>&gt; &gt; &gt; +<br>&gt; =
&gt; &gt; + for (i =3D 0, <span id=3D"misspell-705" class=3D"mark">len</spa=
n> =3D 0; i &lt; <span id=3D"misspell-706"
 class=3D"mark">als</span>_info-&gt;<span id=3D"misspell-707" class=3D"mark=
">num</span>_<span id=3D"misspell-708" class=3D"mark">als</span>_it; i++)<b=
r>&gt; &gt; &gt; + <span id=3D"misspell-709" class=3D"mark">len</span> +=3D=
 <span id=3D"misspell-710" class=3D"mark">scnprintf</span>(<span id=3D"miss=
pell-711" class=3D"mark">buf</span> + <span id=3D"misspell-712" class=3D"ma=
rk">len</span>, PAGE_SIZE - <span id=3D"misspell-713" class=3D"mark">len</s=
pan>, "%u.%06u ",<br>&gt; &gt; &gt; + <span id=3D"misspell-714" class=3D"ma=
rk">als</span>_info-&gt;<span id=3D"misspell-715" class=3D"mark">als</span>=
_it_values[i]/1000000,<br>&gt; &gt; &gt; + <span id=3D"misspell-716" class=
=3D"mark">als</span>_info-&gt;<span id=3D"misspell-717" class=3D"mark">als<=
/span>_it_values[i]%1000000);<br>&gt; &gt; &gt; + return <span id=3D"misspe=
ll-718" class=3D"mark">len</span> + <span id=3D"misspell-719" class=3D"mark=
">scnprintf</span>(<span id=3D"misspell-720" class=3D"mark">buf</span> + <s=
pan id=3D"misspell-721" class=3D"mark">len</span>,
 PAGE_SIZE - <span id=3D"misspell-722" class=3D"mark">len</span>, "\n");<br=
>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/**<br>&gt; &gt; =
&gt; + * cm3218x_threshold_update() - Update the threshold registers.<br>&g=
t; &gt; &gt; + * @chip: pointer of <span id=3D"misspell-723" class=3D"mark"=
>struct</span> cm3218x_chip.<br>&gt; &gt; &gt; + * @percent: +/- percent.<b=
r>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Based on the current <span id=3D=
"misspell-724" class=3D"mark">ALS</span> value, <span id=3D"misspell-725" c=
lass=3D"mark">tupdate</span> the hi and low threshold<br>&gt; &gt; &gt; reg=
isters.<br>&gt; &gt; <br>&gt; &gt; <span id=3D"misspell-726" class=3D"mark"=
>tupdate</span>?<br>&gt; &gt; <br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * =
Return: 0 for success; otherwise for error code.<br>&gt; &gt; &gt; + */<br>=
&gt; &gt; &gt; +static int cm3218x_threshold_update(<span id=3D"misspell-72=
7" class=3D"mark">struct</span> cm3218x_chip *chip, int<br>&gt; &gt; &gt; p=
ercent)<br>&gt;
 &gt; &gt; +{<br>&gt; &gt; &gt; + <span id=3D"misspell-728" class=3D"mark">=
struct</span> i2c_client *client =3D chip-&gt;client;<br>&gt; &gt; &gt; + <=
span id=3D"misspell-729" class=3D"mark">struct</span> cm3218x_<span id=3D"m=
isspell-730" class=3D"mark">als</span>_info *<span id=3D"misspell-731" clas=
s=3D"mark">als</span>_info =3D chip-&gt;<span id=3D"misspell-732" class=3D"=
mark">als</span>_info;<br>&gt; &gt; &gt; + int <span id=3D"misspell-733" cl=
ass=3D"mark">ret</span>;<br>&gt; &gt; &gt; + int <span id=3D"misspell-734" =
class=3D"mark">wh</span>, <span id=3D"misspell-735" class=3D"mark">wl</span=
>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell-736" class=
=3D"mark">ret</span> =3D <span id=3D"misspell-737" class=3D"mark">als</span=
>_info-&gt;<span id=3D"misspell-738" class=3D"mark">als</span>_raw =3D i2c_=
<span id=3D"misspell-739" class=3D"mark">smbus</span>_read_word_data(client=
,<br>&gt; &gt; &gt; + CM3218X_REG_<span id=3D"misspell-740" class=3D"mark">=
ADDR</span>_<span id=3D"misspell-741"
 class=3D"mark">ALS</span>);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-7=
42" class=3D"mark">ret</span> &lt; 0)<br>&gt; &gt; &gt; + return <span id=
=3D"misspell-743" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; +<br>&gt; &g=
t; &gt; + <span id=3D"misspell-744" class=3D"mark">wh</span> =3D <span id=
=3D"misspell-745" class=3D"mark">wl</span> =3D <span id=3D"misspell-746" cl=
ass=3D"mark">ret</span>;<br>&gt; &gt; &gt; + <span id=3D"misspell-747" clas=
s=3D"mark">ret</span> *=3D percent;<br>&gt; &gt; &gt; + <span id=3D"misspel=
l-748" class=3D"mark">ret</span> /=3D 100;<br>&gt; &gt; &gt; + if (<span id=
=3D"misspell-749" class=3D"mark">ret</span> &lt; 1)<br>&gt; &gt; &gt; + <sp=
an id=3D"misspell-750" class=3D"mark">ret</span> =3D 1;<br>&gt; &gt; &gt; +=
 <span id=3D"misspell-751" class=3D"mark">wh</span> +=3D <span id=3D"misspe=
ll-752" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; + <span id=3D"misspell=
-753" class=3D"mark">wl</span> -=3D <span id=3D"misspell-754" class=3D"mark=
">ret</span>;<br>&gt; &gt; &gt; + if (<span id=3D"misspell-755"
 class=3D"mark">wh</span> &gt; 65535)<br>&gt; &gt; &gt; + <span id=3D"missp=
ell-756" class=3D"mark">wh</span> =3D 65535;<br>&gt; &gt; &gt; + if (<span =
id=3D"misspell-757" class=3D"mark">wl</span> &lt; 0)<br>&gt; &gt; &gt; + <s=
pan id=3D"misspell-758" class=3D"mark">wl</span> =3D 0;<br>&gt; &gt; &gt; +=
<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"misspell-759" class=3D"mark">conf=
</span>_regs[CM3218X_REG_<span id=3D"misspell-760" class=3D"mark">ADDR</spa=
n>_<span id=3D"misspell-761" class=3D"mark">WH</span>] =3D <span id=3D"miss=
pell-762" class=3D"mark">wh</span>;<br>&gt; &gt; &gt; + <span id=3D"misspel=
l-763" class=3D"mark">ret</span> =3D i2c_<span id=3D"misspell-764" class=3D=
"mark">smbus</span>_write_word_data(<br>&gt; &gt; &gt; + client,<br>&gt; &g=
t; &gt; + CM3218X_REG_<span id=3D"misspell-765" class=3D"mark">ADDR</span>_=
<span id=3D"misspell-766" class=3D"mark">WH</span>,<br>&gt; &gt; &gt; + chi=
p-&gt;<span id=3D"misspell-767" class=3D"mark">conf</span>_regs[CM3218X_REG=
_<span id=3D"misspell-768"
 class=3D"mark">ADDR</span>_<span id=3D"misspell-769" class=3D"mark">WH</sp=
an>]);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-770" class=3D"mark">ret=
</span> &lt; 0)<br>&gt; &gt; &gt; + return <span id=3D"misspell-771" class=
=3D"mark">ret</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + chip-&gt;<spa=
n id=3D"misspell-772" class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=
=3D"misspell-773" class=3D"mark">ADDR</span>_<span id=3D"misspell-774" clas=
s=3D"mark">WL</span>] =3D <span id=3D"misspell-775" class=3D"mark">wl</span=
>;<br>&gt; &gt; &gt; + <span id=3D"misspell-776" class=3D"mark">ret</span> =
=3D i2c_<span id=3D"misspell-777" class=3D"mark">smbus</span>_write_word_da=
ta(<br>&gt; &gt; &gt; + client,<br>&gt; &gt; &gt; + CM3218X_REG_<span id=3D=
"misspell-778" class=3D"mark">ADDR</span>_<span id=3D"misspell-779" class=
=3D"mark">WL</span>,<br>&gt; &gt; &gt; + chip-&gt;<span id=3D"misspell-780"=
 class=3D"mark">conf</span>_regs[CM3218X_REG_<span id=3D"misspell-781" clas=
s=3D"mark">ADDR</span>_<span id=3D"misspell-782"
 class=3D"mark">WL</span>]);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + return=
 <span id=3D"misspell-783" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; +}<=
br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +/**<br>&gt; &gt; &gt; + * cm3218x_ev=
ent_handler() - Interrupt handling routine.<br>&gt; &gt; &gt; + * @<span id=
=3D"misspell-784" class=3D"mark">irq</span>: <span id=3D"misspell-785" clas=
s=3D"mark">irq</span> number.<br>&gt; &gt; &gt; + * @private: pointer of vo=
id.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Clean interrupt and reset t=
hreshold registers.<br>&gt; &gt; &gt; + *<br>&gt; &gt; &gt; + * Return: <sp=
an id=3D"misspell-786" class=3D"mark">IRQ</span>_HANDLED.<br>&gt; &gt; &gt;=
 + */<br>&gt; &gt; &gt; +static <span id=3D"misspell-787" class=3D"mark">ir=
qreturn</span>_t cm3218x_event_handler(int <span id=3D"misspell-788" class=
=3D"mark">irq</span>, void *private)<br>&gt; &gt; &gt; +{<br>&gt; &gt; &gt;=
 + <span id=3D"misspell-789" class=3D"mark">struct</span> iio_<span id=3D"m=
isspell-791"
 class=3D"mark">dev</span> *<span id=3D"misspell-792" class=3D"mark">dev</s=
pan>_info =3D private;<br>&gt; &gt; &gt; + <span id=3D"misspell-793" class=
=3D"mark">struct</span> cm3218x_chip *chip =3D iio_<span id=3D"misspell-795=
" class=3D"mark">priv</span>(<span id=3D"misspell-796" class=3D"mark">dev</=
span>_info);<br>&gt; &gt; &gt; + int <span id=3D"misspell-797" class=3D"mar=
k">ret</span>;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell=
-798" class=3D"mark">mutex</span>_lock(&amp;chip-&gt;lock);<br>&gt; &gt; &g=
t; +<br>&gt; &gt; &gt; + /* Disable interrupt */<br>&gt; &gt; &gt; + <span =
id=3D"misspell-799" class=3D"mark">ret</span> =3D cm3218x_interrupt_<span i=
d=3D"misspell-800" class=3D"mark">config</span>(chip, 0);<br>&gt; &gt; &gt;=
 + if (<span id=3D"misspell-801" class=3D"mark">ret</span> &lt; 0)<br>&gt; =
&gt; &gt; + <span id=3D"misspell-802" class=3D"mark">goto</span> error_hand=
ler_unlock;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + /* Update Hi/Lo windows=
 */<br>&gt; &gt; &gt; + <span
 id=3D"misspell-803" class=3D"mark">ret</span> =3D cm3218x_threshold_update=
(chip, CM3218X_THRESHOLD_PERCENT);<br>&gt; &gt; &gt; + if (<span id=3D"miss=
pell-804" class=3D"mark">ret</span> &lt; 0)<br>&gt; &gt; &gt; + <span id=3D=
"misspell-805" class=3D"mark">goto</span> error_handler_unlock;<br>&gt; &gt=
; &gt; +<br>&gt; &gt; &gt; + /* Enable interrupt */<br>&gt; &gt; &gt; + <sp=
an id=3D"misspell-806" class=3D"mark">ret</span> =3D cm3218x_interrupt_<spa=
n id=3D"misspell-807" class=3D"mark">config</span>(chip, 1);<br>&gt; &gt; <=
br>&gt; &gt; no need to check <span id=3D"misspell-808" class=3D"mark">ret<=
/span> value<br>&gt; &gt; <br>&gt; &gt; &gt; + if (<span id=3D"misspell-809=
" class=3D"mark">ret</span> &lt; 0)<br>&gt; &gt; &gt; + <span id=3D"misspel=
l-810" class=3D"mark">goto</span> error_handler_unlock;<br>&gt; &gt; &gt; +=
<br>&gt; &gt; &gt; +error_handler_unlock:<br>&gt; &gt; &gt; + <span id=3D"m=
isspell-811" class=3D"mark">mutex</span>_unlock(&amp;chip-&gt;lock);<br>&gt=
; &gt; &gt; + return <span
 id=3D"misspell-812" class=3D"mark">IRQ</span>_HANDLED;<br>&gt; &gt; &gt; +=
}<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static <span id=3D"misspell-813" c=
lass=3D"mark">const</span> <span id=3D"misspell-814" class=3D"mark">struct<=
/span> iio_<span id=3D"misspell-816" class=3D"mark">chan</span>_spec cm3218=
x_channels[] =3D {<br>&gt; &gt; &gt; + {<br>&gt; &gt; &gt; + .type =3D IIO_=
LIGHT,<br>&gt; &gt; &gt; + .info_mask_separate =3D<br>&gt; &gt; &gt; + BIT(=
IIO_CHAN_INFO_PROCESSED) |<br>&gt; &gt; &gt; + BIT(IIO_CHAN_INFO_<span id=
=3D"misspell-820" class=3D"mark">CALIBSCALE</span>) |<br>&gt; &gt; &gt; + B=
IT(IIO_CHAN_INFO_INT_TIME),<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +};<br>=
&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static IIO_DEVICE_<span id=3D"misspell-=
823" class=3D"mark">ATTR</span>(in_<span id=3D"misspell-824" class=3D"mark"=
>illuminance</span>_integration_time_available,<br>&gt; &gt; &gt; + S_<span=
 id=3D"misspell-825" class=3D"mark">IRUGO</span>, cm3218x_get_it_available,=
 NULL, 0);<br>&gt; &gt; &gt;
 +<br>&gt; &gt; &gt; +static <span id=3D"misspell-826" class=3D"mark">struc=
t</span> attribute *cm3218x_attributes[] =3D {<br>&gt; &gt; &gt; + &amp;iio=
_dev_attr_in_illuminance_integration_time_available.dev_attr.attr,<br>&gt; =
&gt; &gt; + NULL,<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &g=
t; +static <span id=3D"misspell-827" class=3D"mark">const</span> <span id=
=3D"misspell-828" class=3D"mark">struct</span> attribute_group cm3218x_attr=
ibute_group =3D {<br>&gt; &gt; &gt; + .<span id=3D"misspell-829" class=3D"m=
ark">attrs</span> =3D cm3218x_attributes<br>&gt; &gt; &gt; +};<br>&gt; &gt;=
 &gt; +<br>&gt; &gt; &gt; +static <span id=3D"misspell-830" class=3D"mark">=
const</span> <span id=3D"misspell-831" class=3D"mark">struct</span> iio_inf=
o cm3218x_info =3D {<br>&gt; &gt; &gt; + .driver_module =3D THIS_MODULE,<br=
>&gt; &gt; &gt; + .read_raw =3D &amp;cm3218x_read_raw,<br>&gt; &gt; &gt; + =
.write_raw =3D &amp;cm3218x_write_raw,<br>&gt; &gt; &gt; + .<span id=3D"mis=
spell-833"
 class=3D"mark">attrs</span> =3D &amp;cm3218x_attribute_group,<br>&gt; &gt;=
 &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static int cm3218x_probe(<=
span id=3D"misspell-834" class=3D"mark">struct</span> i2c_client *client,<b=
r>&gt; &gt; &gt; + <span id=3D"misspell-835" class=3D"mark">const</span> <s=
pan id=3D"misspell-836" class=3D"mark">struct</span> i2c_device_id *id)<br>=
&gt; &gt; &gt; +{<br>&gt; &gt; &gt; + <span id=3D"misspell-837" class=3D"ma=
rk">struct</span> cm3218x_chip *chip;<br>&gt; &gt; &gt; + <span id=3D"missp=
ell-838" class=3D"mark">struct</span> iio_<span id=3D"misspell-840" class=
=3D"mark">dev</span> *<span id=3D"misspell-841" class=3D"mark">indio</span>=
_<span id=3D"misspell-842" class=3D"mark">dev</span>;<br>&gt; &gt; &gt; + i=
nt <span id=3D"misspell-843" class=3D"mark">ret</span>;<br>&gt; &gt; &gt; +=
<br>&gt; &gt; &gt; + <span id=3D"misspell-844" class=3D"mark">indio</span>_=
<span id=3D"misspell-845" class=3D"mark">dev</span> =3D <span id=3D"misspel=
l-846"
 class=3D"mark">devm</span>_iio_device_<span id=3D"misspell-848" class=3D"m=
ark">alloc</span>(&amp;client-&gt;<span id=3D"misspell-849" class=3D"mark">=
dev</span>, <span id=3D"misspell-850" class=3D"mark">sizeof</span>(*chip));=
<br>&gt; &gt; &gt; + if (!<span id=3D"misspell-851" class=3D"mark">indio</s=
pan>_<span id=3D"misspell-852" class=3D"mark">dev</span>) {<br>&gt; &gt; &g=
t; + <span id=3D"misspell-853" class=3D"mark">dev</span>_err(&amp;client-&g=
t;<span id=3D"misspell-854" class=3D"mark">dev</span>, "<span id=3D"misspel=
l-855" class=3D"mark">devm</span>_iio_device_<span id=3D"misspell-857" clas=
s=3D"mark">alloc</span> failed\n");<br>&gt; &gt; &gt; + return -<span id=3D=
"misspell-858" class=3D"mark">ENOMEM</span>;<br>&gt; &gt; &gt; + }<br>&gt; =
&gt; &gt; +<br>&gt; &gt; &gt; + chip =3D iio_<span id=3D"misspell-860" clas=
s=3D"mark">priv</span>(<span id=3D"misspell-861" class=3D"mark">indio</span=
>_<span id=3D"misspell-862" class=3D"mark">dev</span>);<br>&gt; &gt; &gt; +=
 i2c_set_<span id=3D"misspell-863"
 class=3D"mark">clientdata</span>(client, <span id=3D"misspell-864" class=
=3D"mark">indio</span>_<span id=3D"misspell-865" class=3D"mark">dev</span>)=
;<br>&gt; &gt; &gt; + chip-&gt;client =3D client;<br>&gt; &gt; &gt; + chip-=
&gt;<span id=3D"misspell-866" class=3D"mark">ara</span> =3D i2c_new_dummy(c=
lient-&gt;adapter, CM3218X_ARA);<br>&gt; &gt; &gt; +<br>&gt; &gt; <br>&gt; =
&gt; there is no i2c_<span id=3D"misspell-867" class=3D"mark">unregister</s=
pan>_device(chip-&gt;<span id=3D"misspell-868" class=3D"mark">ara</span>) i=
n the error path below; but<br>&gt; &gt; i2c_<span id=3D"misspell-869" clas=
s=3D"mark">unregister</span>_device(chip-&gt;<span id=3D"misspell-870" clas=
s=3D"mark">ara</span>) is called in _remove()<br>&gt; &gt; <br>&gt; &gt; &g=
t; + <span id=3D"misspell-871" class=3D"mark">mutex</span>_<span id=3D"miss=
pell-872" class=3D"mark">init</span>(&amp;chip-&gt;lock);<br>&gt; &gt; &gt;=
 + <span id=3D"misspell-873" class=3D"mark">indio</span>_<span id=3D"misspe=
ll-874" class=3D"mark">dev</span>-&gt;<span
 id=3D"misspell-875" class=3D"mark">dev</span>.parent =3D &amp;client-&gt;<=
span id=3D"misspell-876" class=3D"mark">dev</span>;<br>&gt; &gt; &gt; + <sp=
an id=3D"misspell-877" class=3D"mark">indio</span>_<span id=3D"misspell-878=
" class=3D"mark">dev</span>-&gt;channels =3D cm3218x_channels;<br>&gt; &gt;=
 &gt; + <span id=3D"misspell-879" class=3D"mark">indio</span>_<span id=3D"m=
isspell-880" class=3D"mark">dev</span>-&gt;<span id=3D"misspell-881" class=
=3D"mark">num</span>_channels =3D ARRAY_SIZE(cm3218x_channels);<br>&gt; &gt=
; &gt; + <span id=3D"misspell-882" class=3D"mark">indio</span>_<span id=3D"=
misspell-883" class=3D"mark">dev</span>-&gt;info =3D &amp;cm3218x_info;<br>=
&gt; &gt; &gt; + if (id &amp;&amp; id-&gt;name)<br>&gt; &gt; &gt; + <span i=
d=3D"misspell-884" class=3D"mark">indio</span>_<span id=3D"misspell-885" cl=
ass=3D"mark">dev</span>-&gt;name =3D id-&gt;name;<br>&gt; &gt; &gt; + else<=
br>&gt; &gt; &gt; + <span id=3D"misspell-886" class=3D"mark">indio</span>_<=
span id=3D"misspell-887"
 class=3D"mark">dev</span>-&gt;name =3D (char *)<span id=3D"misspell-888" c=
lass=3D"mark">dev</span>_name(&amp;client-&gt;<span id=3D"misspell-889" cla=
ss=3D"mark">dev</span>);<br>&gt; &gt; &gt; + <span id=3D"misspell-890" clas=
s=3D"mark">indio</span>_<span id=3D"misspell-891" class=3D"mark">dev</span>=
-&gt;modes =3D <span id=3D"misspell-892" class=3D"mark">INDIO</span>_DIRECT=
_MODE;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <span id=3D"misspell-893" cl=
ass=3D"mark">ret</span> =3D cm3218x_reg_<span id=3D"misspell-894" class=3D"=
mark">init</span>(chip);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-895" =
class=3D"mark">ret</span>) {<br>&gt; &gt; &gt; + <span id=3D"misspell-896" =
class=3D"mark">dev</span>_err(&amp;client-&gt;<span id=3D"misspell-897" cla=
ss=3D"mark">dev</span>,<br>&gt; &gt; &gt; + "%s: register <span id=3D"missp=
ell-898" class=3D"mark">init</span> failed\n",<br>&gt; &gt; &gt; + __<span =
id=3D"misspell-899" class=3D"mark">func</span>__);<br>&gt; &gt; &gt; + retu=
rn <span id=3D"misspell-900"
 class=3D"mark">ret</span>;<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&g=
t; &gt; &gt; + if (client-&gt;<span id=3D"misspell-901" class=3D"mark">irq<=
/span>) {<br>&gt; &gt; &gt; + <span id=3D"misspell-902" class=3D"mark">ret<=
/span> =3D request_threaded_<span id=3D"misspell-903" class=3D"mark">irq</s=
pan>(client-&gt;<span id=3D"misspell-904" class=3D"mark">irq</span>,<br>&gt=
; &gt; &gt; + NULL,<br>&gt; &gt; &gt; + cm3218x_event_handler,<br>&gt; &gt;=
 &gt; + <span id=3D"misspell-905" class=3D"mark">IRQF</span>_TRIGGER_FALLIN=
G | <span id=3D"misspell-906" class=3D"mark">IRQF</span>_<span id=3D"misspe=
ll-907" class=3D"mark">ONESHOT</span>,<br>&gt; &gt; &gt; + "cm3218x_event",=
<br>&gt; &gt; &gt; + <span id=3D"misspell-908" class=3D"mark">indio</span>_=
<span id=3D"misspell-909" class=3D"mark">dev</span>);<br>&gt; &gt; &gt; +<b=
r>&gt; &gt; &gt; + if (<span id=3D"misspell-910" class=3D"mark">ret</span> =
&lt; 0) {<br>&gt; &gt; &gt; + <span id=3D"misspell-911" class=3D"mark">dev<=
/span>_err(&amp;client-&gt;<span
 id=3D"misspell-912" class=3D"mark">dev</span>, "<span id=3D"misspell-913" =
class=3D"mark">irq</span> request error %d\n",<br>&gt; &gt; &gt; + -<span i=
d=3D"misspell-914" class=3D"mark">ret</span>);<br>&gt; &gt; &gt; + <span id=
=3D"misspell-915" class=3D"mark">goto</span> error_disable_int;<br>&gt; &gt=
; &gt; + }<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; + <s=
pan id=3D"misspell-916" class=3D"mark">ret</span> =3D iio_device_register(<=
span id=3D"misspell-918" class=3D"mark">indio</span>_<span id=3D"misspell-9=
19" class=3D"mark">dev</span>);<br>&gt; &gt; &gt; + if (<span id=3D"misspel=
l-920" class=3D"mark">ret</span> &lt; 0) {<br>&gt; &gt; &gt; + <span id=3D"=
misspell-921" class=3D"mark">dev</span>_err(&amp;client-&gt;<span id=3D"mis=
spell-922" class=3D"mark">dev</span>,<br>&gt; &gt; &gt; + "%s: <span id=3D"=
misspell-923" class=3D"mark">regist</span> device failed\n",<br>&gt; &gt; &=
gt; + __<span id=3D"misspell-924" class=3D"mark">func</span>__);<br>&gt; &g=
t; &gt; + <span id=3D"misspell-925"
 class=3D"mark">goto</span> error_free_<span id=3D"misspell-926" class=3D"m=
ark">irq</span>;<br>&gt; &gt; &gt; + }<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt=
; + if (client-&gt;<span id=3D"misspell-927" class=3D"mark">irq</span>) {<b=
r>&gt; &gt; &gt; + <span id=3D"misspell-928" class=3D"mark">ret</span> =3D =
cm3218x_threshold_update(chip, CM3218X_THRESHOLD_PERCENT);<br>&gt; &gt; &gt=
; + if (<span id=3D"misspell-929" class=3D"mark">ret</span> &lt; 0)<br>&gt;=
 &gt; &gt; + <span id=3D"misspell-930" class=3D"mark">goto</span> error_fre=
e_<span id=3D"misspell-931" class=3D"mark">irq</span>;<br>&gt; &gt; &gt; +<=
br>&gt; &gt; &gt; + <span id=3D"misspell-932" class=3D"mark">ret</span> =3D=
 cm3218x_interrupt_<span id=3D"misspell-933" class=3D"mark">config</span>(c=
hip, 1);<br>&gt; &gt; &gt; + if (<span id=3D"misspell-934" class=3D"mark">r=
et</span> &lt; 0)<br>&gt; &gt; &gt; + <span id=3D"misspell-935" class=3D"ma=
rk">goto</span> error_free_<span id=3D"misspell-936" class=3D"mark">irq</sp=
an>;<br>&gt; &gt; &gt; + }<br>&gt; &gt;
 &gt; +<br>&gt; &gt; &gt; + return 0;<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt;=
 +error_free_<span id=3D"misspell-937" class=3D"mark">irq</span>:<br>&gt; &=
gt; &gt; + free_<span id=3D"misspell-938" class=3D"mark">irq</span>(client-=
&gt;<span id=3D"misspell-939" class=3D"mark">irq</span>, <span id=3D"misspe=
ll-940" class=3D"mark">indio</span>_<span id=3D"misspell-941" class=3D"mark=
">dev</span>);<br>&gt; &gt; <br>&gt; &gt; in _remove() free_<span id=3D"mis=
spell-942" class=3D"mark">irq</span>() is only called when client-&gt;<span=
 id=3D"misspell-943" class=3D"mark">irq</span> !=3D 0<br>&gt; &gt; <br>&gt;=
 &gt; &gt; +error_disable_int:<br>&gt; &gt; &gt; + cm3218x_interrupt_<span =
id=3D"misspell-944" class=3D"mark">config</span>(chip, 0);<br>&gt; &gt; &gt=
; + return <span id=3D"misspell-945" class=3D"mark">ret</span>;<br>&gt; &gt=
; &gt; +}<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +static int cm3218x_remove(=
<span id=3D"misspell-946" class=3D"mark">struct</span> i2c_client *client)<=
br>&gt; &gt; &gt; +{<br>&gt; &gt;
 &gt; + <span id=3D"misspell-947" class=3D"mark">struct</span> iio_<span id=
=3D"misspell-949" class=3D"mark">dev</span> *<span id=3D"misspell-950" clas=
s=3D"mark">indio</span>_<span id=3D"misspell-951" class=3D"mark">dev</span>=
 =3D i2c_get_<span id=3D"misspell-952" class=3D"mark">clientdata</span>(cli=
ent);<br>&gt; &gt; &gt; + <span id=3D"misspell-953" class=3D"mark">struct</=
span> cm3218x_chip *chip =3D iio_<span id=3D"misspell-955" class=3D"mark">p=
riv</span>(<span id=3D"misspell-956" class=3D"mark">indio</span>_<span id=
=3D"misspell-957" class=3D"mark">dev</span>);<br>&gt; &gt; &gt; +<br>&gt; &=
gt; &gt; + cm3218x_interrupt_<span id=3D"misspell-958" class=3D"mark">confi=
g</span>(chip, 0);<br>&gt; &gt; &gt; + if (chip-&gt;<span id=3D"misspell-95=
9" class=3D"mark">ara</span>)<br>&gt; &gt; &gt; + i2c_<span id=3D"misspell-=
960" class=3D"mark">unregister</span>_device(chip-&gt;<span id=3D"misspell-=
961" class=3D"mark">ara</span>);<br>&gt; &gt; &gt; + if (client-&gt;<span i=
d=3D"misspell-962" class=3D"mark">irq</span>)<br>&gt;
 &gt; &gt; + free_<span id=3D"misspell-963" class=3D"mark">irq</span>(clien=
t-&gt;<span id=3D"misspell-964" class=3D"mark">irq</span>, <span id=3D"miss=
pell-965" class=3D"mark">indio</span>_<span id=3D"misspell-966" class=3D"ma=
rk">dev</span>);<br>&gt; &gt; &gt; + iio_device_<span id=3D"misspell-968" c=
lass=3D"mark">unregister</span>(<span id=3D"misspell-969" class=3D"mark">in=
dio</span>_<span id=3D"misspell-970" class=3D"mark">dev</span>);<br>&gt; &g=
t; &gt; + return 0;<br>&gt; &gt; &gt; +}<br>&gt; &gt; &gt; +<br>&gt; &gt; &=
gt; +static <span id=3D"misspell-971" class=3D"mark">const</span> <span id=
=3D"misspell-972" class=3D"mark">struct</span> i2c_device_id cm3218x_id[] =
=3D {<br>&gt; &gt; &gt; + { "cm3218", cm3218},<br>&gt; &gt; &gt; + { "cm321=
81", cm32181},<br>&gt; &gt; &gt; + { "cm32182", cm32182},<br>&gt; &gt; &gt;=
 + { }<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +MODULE_=
DEVICE_TABLE(i2c, cm3218x_id);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +stati=
c <span id=3D"misspell-973"
 class=3D"mark">const</span> <span id=3D"misspell-974" class=3D"mark">struc=
t</span> of_device_id cm3218x_of_match[] =3D {<br>&gt; &gt; &gt; + { .compa=
tible =3D "<span id=3D"misspell-975" class=3D"mark">capella</span>,cm3218" =
},<br>&gt; &gt; &gt; + { }<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt=
; &gt; &gt; +static <span id=3D"misspell-976" class=3D"mark">const</span> <=
span id=3D"misspell-977" class=3D"mark">struct</span> <span id=3D"misspell-=
978" class=3D"mark">acpi</span>_device_id cm3218x_<span id=3D"misspell-979"=
 class=3D"mark">acpi</span>_match[] =3D {<br>&gt; &gt; &gt; + { "<span id=
=3D"misspell-980" class=3D"mark">CPLM</span>3218", 0},<br>&gt; &gt; &gt; + =
{},<br>&gt; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +MODULE_DEV=
ICE_TABLE(<span id=3D"misspell-981" class=3D"mark">acpi</span>, cm3218x_<sp=
an id=3D"misspell-982" class=3D"mark">acpi</span>_match);<br>&gt; &gt; &gt;=
 +<br>&gt; &gt; &gt; +static <span id=3D"misspell-983" class=3D"mark">struc=
t</span> i2c_driver cm3218x_driver =3D
 {<br>&gt; &gt; &gt; + .driver =3D {<br>&gt; &gt; &gt; + .name =3D "cm3218x=
",<br>&gt; &gt; &gt; + .<span id=3D"misspell-984" class=3D"mark">acpi</span=
>_match_table =3D <span id=3D"misspell-985" class=3D"mark">ACPI</span>_<spa=
n id=3D"misspell-986" class=3D"mark">PTR</span>(cm3218x_<span id=3D"misspel=
l-987" class=3D"mark">acpi</span>_match),<br>&gt; &gt; &gt; + .of_match_tab=
le =3D of_match_<span id=3D"misspell-988" class=3D"mark">ptr</span>(cm3218x=
_of_match),<br>&gt; &gt; &gt; + .owner =3D THIS_MODULE,<br>&gt; &gt; &gt; +=
 },<br>&gt; &gt; &gt; + .id_table =3D cm3218x_id,<br>&gt; &gt; &gt; + .prob=
e =3D cm3218x_probe,<br>&gt; &gt; &gt; + .remove =3D cm3218x_remove,<br>&gt=
; &gt; &gt; +};<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +module_i2c_driver(cm=
3218x_driver);<br>&gt; &gt; &gt; +<br>&gt; &gt; &gt; +MODULE_AUTHOR("Kevin =
Tsai &lt;<a ymailto=3D"mailto:ktsai@capellamicro.com" href=3D"mailto:ktsai@=
capellamicro.com">ktsai@capellamicro.com</a>&gt;");<br>&gt; &gt; &gt; +MODU=
LE_DESCRIPTION("CM3218X ambient
 light sensor driver");<br>&gt; &gt; &gt; +MODULE_LICENSE("<span id=3D"miss=
pell-990" class=3D"mark">GPL</span>");<br>&gt; &gt; &gt; <br>&gt; &gt; <br>=
&gt; &gt; -- <br>&gt; &gt; <br>&gt; &gt; Peter Meerwald<br>&gt; &gt; +43-66=
4-2444418 (mobile)<br>&gt; <br><br>-- <br><br>Peter Meerwald<br>+43-664-244=
4418 (mobile)<br><br></div> </div> </div>  </div></body></html>
---1192396609-1770039525-1395809544=:53200--
