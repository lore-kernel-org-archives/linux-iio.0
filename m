Return-Path: <ktsai@capellamicro.com>
References: <1372894271-2592-1-git-send-email-ktsai@capellamicro.com> <alpine.DEB.2.01.1307040958580.13431@pmeerw.net>
Message-ID: <1372926366.99136.YahooMailNeo@web5802.biz.mail.ne1.yahoo.com>
Date: Thu, 4 Jul 2013 01:26:06 -0700 (PDT)
From: Kevin Tsai <ktsai@capellamicro.com>
Reply-To: Kevin Tsai <ktsai@capellamicro.com>
Subject: Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO Driver.
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Grant Likely <grant.likely@linaro.org>,
  Rob Herring <rob.herring@calxeda.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
  "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
  "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
In-Reply-To: <alpine.DEB.2.01.1307040958580.13431@pmeerw.net>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="-1467812710-1501340236-1372926366=:99136"
List-ID: <linux-iio@vger.kernel.org>

---1467812710-1501340236-1372926366=:99136
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Peter,=0A=0AThank you for your reply. =A0Can you advise me where is the =
best location?=0A=0AThanks.=0A=0AKevin Tsai=0A07/04/13=0A=0A=0A____________=
____________________=0A From: Peter Meerwald <pmeerw@pmeerw.net>=0ATo: Kevi=
n Tsai <ktsai@capellamicro.com> =0ACc: Jonathan Cameron <jic23@cam.ac.uk>; =
Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Grant Likely <grant.likely=
@linaro.org>; Rob Herring <rob.herring@calxeda.com>; linux-kernel@vger.kern=
el.org; linux-iio@vger.kernel.org; devel@driverdev.osuosl.org; devicetree-d=
iscuss@lists.ozlabs.org =0ASent: Thursday, July 4, 2013 1:17 AM=0ASubject: =
Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO Driver.=0A =
=0A=0AHello,=0A=0Asome comments inline;=0Anew drivers should not go to stag=
ing but to mainline directly =0A=0Aregards, p.=0A=0A> Signed-off-by: Kevin =
Tsai <ktsai@capellamicro.com>=0A> ---=0A>=A0 drivers/staging/iio/light/Kcon=
fig=A0 |=A0  10 +=0A>=A0 drivers/staging/iio/light/Makefile |=A0 =A0 1 +=0A=
>=A0 drivers/staging/iio/light/cm3218.c |=A0 581 ++++++++++++++++++++++++++=
++++++++++=0A>=A0 3 files changed, 592 insertions(+)=0A>=A0 create mode 100=
644 drivers/staging/iio/light/cm3218.c=0A> =0A> diff --git a/drivers/stagin=
g/iio/light/Kconfig b/drivers/staging/iio/light/Kconfig=0A> index ca8d6e6..=
647af0c 100644=0A> --- a/drivers/staging/iio/light/Kconfig=0A> +++ b/driver=
s/staging/iio/light/Kconfig=0A> @@ -40,4 +40,14 @@ config TSL2x7x=0A>=A0 =
=A0=A0=A0  tmd2672, tsl2772, tmd2772 devices.=0A>=A0 =A0=A0=A0  Provides ii=
o_events and direct access via sysfs.=0A>=A0 =0A> +config SENSORS_CM3218=0A=
> +=A0 =A0 =A0 =A0 tristate "CM3218 Ambient Light Sensor"=0A> +=A0 =A0 =A0 =
=A0 depends on I2C=0A> +=A0 =A0 =A0 =A0 help=0A> +=A0 =A0 =A0 =A0  Say Y he=
re if you have a Capella Micro CM3218 Ambient Light Sensor.=0A> +=0A> +=A0 =
=A0 =A0 =A0  To compile this driver as a module, choose M here.=A0 This mod=
ule=0A> +=A0 =A0 =A0 =A0  will be called to 'cm3218'.=A0 It will access ALS=
 data via iio sysfs.=0A> +=A0 =A0 =A0 =A0  This is recommended.=0A> +=0A>=
=A0 endmenu=0A> diff --git a/drivers/staging/iio/light/Makefile b/drivers/s=
taging/iio/light/Makefile=0A> index 9960fdf..63020ab 100644=0A> --- a/drive=
rs/staging/iio/light/Makefile=0A> +++ b/drivers/staging/iio/light/Makefile=
=0A> @@ -6,3 +6,4 @@ obj-$(CONFIG_SENSORS_ISL29018)=A0=A0=A0 +=3D isl29018.=
o=0A>=A0 obj-$(CONFIG_SENSORS_ISL29028)=A0=A0=A0 +=3D isl29028.o=0A>=A0 obj=
-$(CONFIG_TSL2583)=A0=A0=A0 +=3D tsl2583.o=0A>=A0 obj-$(CONFIG_TSL2x7x)=A0=
=A0=A0 +=3D tsl2x7x_core.o=0A> +obj-$(CONFIG_SENSORS_CM3218)=A0 =A0 +=3D cm=
3218.o=0A> diff --git a/drivers/staging/iio/light/cm3218.c b/drivers/stagin=
g/iio/light/cm3218.c=0A> new file mode 100644=0A> index 0000000..9c2584d=0A=
> --- /dev/null=0A> +++ b/drivers/staging/iio/light/cm3218.c=0A> @@ -0,0 +1=
,581 @@=0A> +/*=0A> + * A iio driver for CM3218 Ambient Light Sensor.=0A> +=
 *=0A> + * IIO driver for monitoring ambient light intensity in lux.=0A> + =
*=0A> + * Copyright (c) 2013, Capella Microsystems Inc.=0A> + *=0A> + * Thi=
s program is free software; you can redistribute it and/or modify=0A> + * i=
t under the terms of the GNU General Public License as published by=0A> + *=
 the Free Software Foundation; either version 2 of the License, or=0A> + * =
(at your option) any later version.=0A> + *=0A> + * This program is distrib=
uted in the hope that it will be useful, but WITHOUT=0A> + * ANY WARRANTY; =
without even the implied warranty of MERCHANTABILITY or=0A> + * FITNESS FOR=
 A PARTICULAR PURPOSE.=A0 See the GNU General Public License for=0A> + * mo=
re details.=0A> + *=0A> + * You should have received a copy of the GNU Gene=
ral Public License along=0A> + * with this program; if not, write to the Fr=
ee Software Foundation, Inc.,=0A> + * 51 Franklin Street, Fifth Floor, Bost=
on, MA=A0=A0=A0 02110-1301, USA.=0A> + */=0A> +=0A> +#include <linux/module=
.h>=0A> +#include <linux/i2c.h>=0A> +#include <linux/err.h>=0A> +#include <=
linux/mutex.h>=0A> +#include <linux/delay.h>=0A> +#include <linux/slab.h>=
=0A> +#include <linux/iio/iio.h>=0A> +#include <linux/iio/sysfs.h>=0A> +=0A=
> +/*=0A> + * SMBus ARA address=0Amaybe Address for consistency? =0A=0A> + =
*/=0A> +#define=A0=A0=A0 CM3218_ADDR_ARA=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 0x0C=
=0A> +=0A> +/*=0A> + * CM3218 CMD Registers=0A> + */=0A> +#define=A0=A0=A0 =
CM3218_REG_ADDR_CMD=A0=A0=A0 =A0=A0=A0 0x00=0A> +#define=A0=A0=A0 CM3218_CM=
D_ALS_SD=A0=A0=A0 =A0=A0=A0 0x0001=0A> +#define=A0=A0=A0 CM3218_CMD_ALS_INT=
_EN=A0=A0=A0 =A0=A0=A0 0x0002=0A> +#define=A0=A0=A0 CM3218_CMD_ALS_IT_SHIFT=
=A0=A0=A0 =A0=A0=A0 6=0A> +#define=A0=A0=A0 CM3218_CMD_ALS_IT_MASK=A0=A0=A0=
 =A0=A0=A0 (3 << CM3218_CMD_ALS_IT_SHIFT)=0A> +#define=A0=A0=A0 CM3218_CMD_=
ALS_IT_05T=A0=A0=A0 =A0=A0=A0 (0 << CM3218_CMD_ALS_IT_SHIFT)=0A> +#define=
=A0=A0=A0 CM3218_CMD_ALS_IT_1T=A0=A0=A0 =A0=A0=A0 (1 << CM3218_CMD_ALS_IT_S=
HIFT)=0A> +#define=A0=A0=A0 CM3218_CMD_ALS_IT_2T=A0=A0=A0 =A0=A0=A0 (2 << C=
M3218_CMD_ALS_IT_SHIFT)=0A> +#define=A0=A0=A0 CM3218_CMD_ALS_IT_4T=A0=A0=A0=
 =A0=A0=A0 (3 << CM3218_CMD_ALS_IT_SHIFT)=0A=0A> +#define=A0=A0=A0 CM3218_D=
EFAULT_CMD=A0=A0=A0 =A0=A0=A0 (CM3218_CMD_ALS_IT_1T)=0Ano parenthesis neede=
d =0A=0A> +=0A> +#define=A0=A0=A0 CM3218_REG_ADDR_ALS_WH=A0=A0=A0 =A0=A0=A0=
 0x01=0A> +#define=A0=A0=A0 CM3218_DEFAULT_ALS_WH=A0=A0=A0 =A0=A0=A0 0xFFFF=
=0A> +=0A> +#define=A0=A0=A0 CM3218_REG_ADDR_ALS_WL=A0=A0=A0 =A0=A0=A0 0x02=
=0A> +#define=A0=A0=A0 CM3218_DEFAULT_ALS_WL=A0=A0=A0 =A0=A0=A0 0x0000=0A> =
+=0A> +#define=A0=A0=A0 CM3218_REG_ADDR_ALS=A0=A0=A0 =A0=A0=A0 0x04=0A> +=
=0A> +#define=A0=A0=A0 CM3218_REG_ADDR_STATUS=A0=A0=A0 =A0=A0=A0 0x06=0A> +=
=0A> +#define=A0=A0=A0 CM3218_REG_ADDR_ID=A0=A0=A0 =A0=A0=A0 0x07=0A> +=0A>=
 +/*=0A> + * Software Parameters=0A> + */=0A> +#define=A0=A0=A0 CM3218_MAX_=
CACHE_REGS=A0=A0=A0 =A0=A0=A0 (0x03+1)=A0=A0=A0 /* Reg.0x00 to 0x03 */=0A> =
+=0A> +/*=0A> + * Features=0A> + */=0A> +#define=A0=A0=A0 CM3218_DEBUG=0A> =
+=0A> +static const unsigned short normal_i2c[] =3D {=0A> +=A0=A0=A0 0x10, =
0x48, I2C_CLIENT_END };=0A> +=0A> +struct cm3218_chip {=0A> +=A0=A0=A0 stru=
ct i2c_client=A0=A0=A0 *client;=0A> +=A0=A0=A0 struct mutex=A0=A0=A0 =A0=A0=
=A0 lock;=0A> +=A0=A0=A0 unsigned int=A0=A0=A0 =A0=A0=A0 lensfactor;=0A> +=
=A0=A0=A0 bool=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 suspended;=0A> +=A0=A0=A0 u16=
=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 reg_cache[CM3218_MAX_CACHE_REGS];=0A> +};=0A>=
 +=0A> +static int cm3218_read_ara(struct i2c_client *client)=0A> +{=0A> +=
=A0=A0=A0 int status;=0A> +=A0=A0=A0 unsigned short addr;=0A> +=0A> +=A0=A0=
=A0 addr =3D client->addr;=0A> +=A0=A0=A0 client->addr =3D CM3218_ADDR_ARA;=
=0A> +=A0=A0=A0 status =3D i2c_smbus_read_byte(client);=0A> +=A0=A0=A0 clie=
nt->addr =3D addr;=0A> +=0A> +=A0=A0=A0 if (status < 0)=0A> +=A0=A0=A0 =A0=
=A0=A0 return -ENODEV;=0A> +=0A> +=A0=A0=A0 return 0;=0A> +}=0A> +=0A> +sta=
tic int cm3218_write(struct i2c_client *client, u8 reg, u16 value)=0A> +{=
=0A> +=A0=A0=A0 u16 regval;=0A> +=A0=A0=A0 int ret;=0A> +=A0=A0=A0 struct c=
m3218_chip *chip =3D iio_priv(i2c_get_clientdata(client));=0A> +=0A> +#ifde=
f=A0=A0=A0 CM3218_DEBUG=0A> +=A0=A0=A0 dev_err(&client->dev,=0A> +=A0=A0=A0=
 =A0=A0=A0 "Write to device register 0x%02X with 0x%04X\n", reg, value);=0A=
> +#endif=A0=A0=A0 /* CM3218_DEBUG */=0A=0Adev_dbg? and no _DEBUG=0A=0A> +=
=A0=A0=A0 regval =3D cpu_to_le16(value);=0A> +=A0=A0=A0 ret =3D i2c_smbus_w=
rite_word_data(client, reg, regval);=0A> +=A0=A0=A0 if (ret) {=0A> +=A0=A0=
=A0 =A0=A0=A0 dev_err(&client->dev, "Write to device fails: 0x%x\n", ret);=
=0A> +=A0=A0=A0 } else {=0A> +=A0=A0=A0 =A0=A0=A0 /* Update cache */=0A> +=
=A0=A0=A0 =A0=A0=A0 if (reg < CM3218_MAX_CACHE_REGS)=0A> +=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 chip->reg_cache[reg] =3D value;=0A> +=A0=A0=A0 }=0A> +=0A> +=
=A0=A0=A0 return ret;=0A> +}=0A=0Athere is regmap for caching register cont=
ents; maybe overkill..=0A=0A> +=0A> +static int cm3218_read(struct i2c_clie=
nt *client, u8 reg)=0A> +{=0A> +=A0=A0=A0 int regval;=0A> +=A0=A0=A0 int st=
atus;=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(i2c_get_clientda=
ta(client));=0A> +=0A> +=A0=A0=A0 if (reg < CM3218_MAX_CACHE_REGS) {=0A> +=
=A0=A0=A0 =A0=A0=A0 regval =3D chip->reg_cache[reg];=0A> +=A0=A0=A0 } else =
{=0A> +=A0=A0=A0 =A0=A0=A0 status =3D i2c_smbus_read_word_data(client, reg)=
;=0A> +=A0=A0=A0 =A0=A0=A0 if (status < 0) {=0A> +=A0=A0=A0 =A0=A0=A0 =A0=
=A0=A0 dev_err(&client->dev,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "=
Error in reading Reg.0x%02X\n", reg);=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 re=
turn status;=0A> +=A0=A0=A0 =A0=A0=A0 }=0A> +=A0=A0=A0 =A0=A0=A0 regval =3D=
 le16_to_cpu(status);=0A> +#ifdef=A0=A0=A0 CM3218_DEBUG=0A> +=A0=A0=A0 =A0=
=A0=A0 dev_err(&client->dev,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 "Read from =
device register 0x%02X =3D 0x%04X\n",=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 re=
g, regval);=0A> +#endif=A0=A0=A0 /* CM3218_DEBUG */=0A> +=A0=A0=A0 }=0A> +=
=0A> +=A0=A0=A0 return regval;=0A> +}=0A> +=0A> +static int cm3218_read_sen=
sor_input(struct i2c_client *client)=0A> +{=0A> +=A0=A0=A0 int status;=0A> =
+=A0=A0=A0 int lux;=0A> +=0A> +=A0=A0=A0 status =3D cm3218_read(client, CM3=
218_REG_ADDR_ALS);=0A> +=A0=A0=A0 if (status < 0) {=0A> +=A0=A0=A0 =A0=A0=
=A0 dev_err(&client->dev, "Error in reading Lux DATA\n");=0A> +=A0=A0=A0 =
=A0=A0=A0 return status;=0A> +=A0=A0=A0 }=0A> +=A0=A0=A0 lux =3D status;=0A=
> +=0A> +=A0=A0=A0 dev_vdbg(&client->dev, "lux =3D %u\n", lux);=0A> +=0A> +=
=A0=A0=A0 return lux;=0A> +}=0A> +=0A> +static int cm3218_read_lux(struct i=
2c_client *client, int *lux)=0A> +{=0A> +=A0=A0=A0 struct cm3218_chip *chip=
 =3D iio_priv(i2c_get_clientdata(client));=0A> +=A0=A0=A0 int lux_data;=0A>=
 +=0A> +=A0=A0=A0 lux_data =3D cm3218_read_sensor_input(client);=0A> +=0A> =
+=A0=A0=A0 if (lux_data < 0)=0A> +=A0=A0=A0 =A0=A0=A0 return lux_data;=0A> =
+=0A> +=A0=A0=A0 *lux=A0 =3D lux_data * chip->lensfactor;=0A> +=A0=A0=A0 *l=
ux /=3D 1000;=0A> +=A0=A0=A0 return 0;=0A> +}=0A=0Athese read wrappers coul=
d probably be avoided; most of the code is =0Acascaded error handling=0A=0A=
> +=0A> +/* Sysfs interface */=0A> +/* lensfactor */=0A=0Acomment style=0A=
=0A> +static ssize_t show_lensfactor(struct device *dev,=0A> +=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 struct device_attribute *attr, char *buf)=0A> +{=0A> +=A0=
=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A> +=A0=A0=A0 s=
truct cm3218_chip *chip =3D iio_priv(indio_dev);=0A> +=0A> +=A0=A0=A0 retur=
n sprintf(buf, "%d\n", chip->lensfactor);=0A> +}=0A=0Athe sysfs interface s=
eems to be redundant; there is also CALIBSCALE=0A=0A> +=0A> +static ssize_t=
 store_lensfactor(struct device *dev,=0A> +=A0=A0=A0 =A0=A0=A0 struct devic=
e_attribute *attr, const char *buf, size_t count)=0A> +{=0A> +=A0=A0=A0 str=
uct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A> +=A0=A0=A0 struct cm32=
18_chip *chip =3D iio_priv(indio_dev);=0A> +=A0=A0=A0 unsigned long lval;=
=0A> +=0A> +/*=0A> +=A0=A0=A0 lval =3D kstrtoul(buf, NULL, 10);=0A> +=A0=A0=
=A0 if (lval =3D=3D 0)=0A> +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A> +*/=0A=
=0Aremove comment before submission=0A=0A> +=A0=A0=A0 if (kstrtoul(buf, 10,=
 &lval))=0A> +=A0=A0=A0 =A0=A0=A0 return -EINVAL;=0A> +=0A> +=A0=A0=A0 mute=
x_lock(&chip->lock);=0A> +=A0=A0=A0 chip->lensfactor =3D lval;=0A> +=A0=A0=
=A0 mutex_unlock(&chip->lock);=0A> +=0A> +=A0=A0=A0 return count;=0A> +}=0A=
> +=0A> +static ssize_t get_sensor_data(struct device *dev, char *buf)=0A> =
+{=0A> +=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev);=0A> +=
=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(indio_dev);=0A> +=A0=A0=A0 =
struct i2c_client *client =3D chip->client;=0A> +=A0=A0=A0 int value =3D 0;=
=0A> +=A0=A0=A0 int status;=0A> +=0A> +=A0=A0=A0 mutex_lock(&chip->lock);=
=0A> +=A0=A0=A0 if (chip->suspended) {=0A> +=A0=A0=A0 =A0=A0=A0 mutex_unloc=
k(&chip->lock);=0A> +=A0=A0=A0 =A0=A0=A0 return -EBUSY;=0A> +=A0=A0=A0 }=0A=
> +=0A> +=A0=A0=A0  status =3D cm3218_read_lux(client, &value);=0A=0Aextra =
space here=0A=0A> +=0A> +=A0=A0=A0 if (status < 0) {=0A> +=A0=A0=A0 =A0=A0=
=A0 dev_err(&client->dev, "Error in Reading data");=0A> +=A0=A0=A0 =A0=A0=
=A0 mutex_unlock(&chip->lock);=0A> +=A0=A0=A0 =A0=A0=A0 return status;=0A> =
+=A0=A0=A0 }=0A> +=0A> +=A0=A0=A0 mutex_unlock(&chip->lock);=0A> +=0A> +=A0=
=A0=A0 return sprintf(buf, "%d\n", value);=0A> +}=0A> +=0A> +=0A> +/* Read =
lux */=0A> +static ssize_t show_lux(struct device *dev,=0A> +=A0=A0=A0 stru=
ct device_attribute *devattr, char *buf)=0A> +{=0A> +=A0=A0=A0 return get_s=
ensor_data(dev, buf);=0A> +}=0A> +=0A> +#ifdef=A0=A0=A0 CM3218_DEBUG=0A> +/=
* windows_high */=0A=0Athere would be debugfs_reg_access in iio_info=0A=0A>=
 +static ssize_t show_cmd(struct device *dev,=0A> +=A0=A0=A0 struct device_=
attribute *attr, char *buf)=0A> +{=0A> +=A0=A0=A0 struct iio_dev *indio_dev=
 =3D dev_get_drvdata(dev);=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_=
priv(indio_dev);=0A> +=A0=A0=A0 struct i2c_client *client =3D chip->client;=
=0A> +=A0=A0=A0 int status;=0A> +=0A> +=A0=A0=A0 status =3D cm3218_read(cli=
ent, CM3218_REG_ADDR_CMD);=0A> +=A0=A0=A0 if (status < 0) {=0A> +=A0=A0=A0 =
=A0=A0=A0 dev_err(dev, "Error in getting CM3218_REG_ADDR_CMD\n");=0A> +=A0=
=A0=A0 =A0=A0=A0 return status;=0A> +=A0=A0=A0 }=0A> +=0A> +=A0=A0=A0 retur=
n sprintf(buf, "%u\n", status);=0A> +}=0A> +=0A> +static ssize_t store_cmd(=
struct device *dev,=0A> +=A0=A0=A0 =A0=A0=A0 struct device_attribute *attr,=
 const char *buf, size_t count)=0A> +{=0A> +=A0=A0=A0 struct iio_dev *indio=
_dev =3D dev_get_drvdata(dev);=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D =
iio_priv(indio_dev);=0A> +=A0=A0=A0 struct i2c_client *client =3D chip->cli=
ent;=0A> +=A0=A0=A0 int status;=0A> +=A0=A0=A0 unsigned long lval;=0A> +=0A=
> +=A0=A0=A0 if (kstrtoul(buf, 10, &lval))=0A> +=A0=A0=A0 =A0=A0=A0 return =
-EINVAL;=0A> +=0A> +=A0=A0=A0 mutex_lock(&chip->lock);=0A> +=A0=A0=A0 if (l=
val > 0x10000)=0A> +=A0=A0=A0 =A0=A0=A0 lval =3D 0xFFFF;=0A> +=A0=A0=A0 sta=
tus =3D cm3218_write(client, CM3218_REG_ADDR_CMD, (u16)lval);=0A> +=A0=A0=
=A0 if (status < 0) {=0A> +=A0=A0=A0 =A0=A0=A0 mutex_unlock(&chip->lock);=
=0A> +=A0=A0=A0 =A0=A0=A0 dev_err(dev, "Error in setting CM3218_REG_ADDR_CM=
D\n");=0A> +=A0=A0=A0 =A0=A0=A0 return status;=0A> +=A0=A0=A0 }=0A> +=A0=A0=
=A0 mutex_unlock(&chip->lock);=0A> +=0A> +=A0=A0=A0 return count;=0A> +}=0A=
> +=0A> +/* status */=0A> +static ssize_t show_status(struct device *dev,=
=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 struct device_attribute *attr, char *bu=
f)=0A> +{=0A> +=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdata(dev)=
;=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(indio_dev);=0A> +=A0=
=A0=A0 struct i2c_client *client =3D chip->client;=0A> +=A0=A0=A0 int statu=
s;=0A> +=0A> +=A0=A0=A0 status =3D cm3218_read(client, CM3218_REG_ADDR_STAT=
US);=0A> +=A0=A0=A0 if (status < 0) {=0A> +=A0=A0=A0 =A0=A0=A0 dev_err(dev,=
 "Error in getting CM3218_REG_ADDR_STATUS\n");=0A> +=A0=A0=A0 =A0=A0=A0 ret=
urn status;=0A> +=A0=A0=A0 }=0A> +=0A> +=A0=A0=A0 return sprintf(buf, "%u\n=
", status);=0A> +}=0A> +=0A> +#endif=A0=A0=A0 /* CM3218_DEBUG */=0A> +=0A> =
+/* Channel IO */=0A> +static int cm3218_write_raw(struct iio_dev *indio_de=
v,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 struct iio_chan_spec cons=
t *chan,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 int val,=0A> +=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0 =A0 int val2,=0A> +=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 =A0 =A0 =A0 long mask)=0A> +{=0A> +=A0=A0=A0 struct cm3218_chip *=
chip =3D iio_priv(indio_dev);=0A> +=A0=A0=A0 int ret =3D -EINVAL;=0A=0Aret =
is not used?=0A=0A> +=0A> +=A0=A0=A0 mutex_lock(&chip->lock);=0A> +=A0=A0=
=A0 if (mask =3D=3D IIO_CHAN_INFO_CALIBSCALE && chan->type =3D=3D IIO_LIGHT=
) {=0A> +=A0=A0=A0 =A0=A0=A0 chip->lensfactor =3D val;=0A> +=A0=A0=A0 =A0=
=A0=A0 ret =3D 0;=0A> +=A0=A0=A0 }=0A> +=A0=A0=A0 mutex_unlock(&chip->lock)=
;=0A> +=0A> +=A0=A0=A0 return 0;=0A> +}=0A> +=0A> +static int cm3218_read_r=
aw(struct iio_dev *indio_dev,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  s=
truct iio_chan_spec const *chan,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0=
  int *val,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  int *val2,=0A> +=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0 =A0  long mask)=0A> +{=0A> +=A0=A0=A0 int re=
t =3D -EINVAL;=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(indio_d=
ev);=0A> +=A0=A0=A0 struct i2c_client *client =3D chip->client;=0A> +=0A> +=
=A0=A0=A0 mutex_lock(&chip->lock);=0A> +=A0=A0=A0 if (chip->suspended) {=0A=
> +=A0=A0=A0 =A0=A0=A0 mutex_unlock(&chip->lock);=0A> +=A0=A0=A0 =A0=A0=A0 =
return -EBUSY;=0A> +=A0=A0=A0 }=0A> +=A0=A0=A0 switch (mask) {=0A> +=A0=A0=
=A0 case 0:=0A=0Ahuh? this is not in the channels?=0A=0A> +=A0=A0=A0 =A0=A0=
=A0 ret =3D cm3218_read_lux(client, val);=0A> +=A0=A0=A0 =A0=A0=A0 if (!ret=
)=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 ret =3D IIO_VAL_INT;=0A> +=A0=A0=A0 =
=A0=A0=A0 break;=0A> +=A0=A0=A0 case IIO_CHAN_INFO_CALIBSCALE:=0A> +=A0=A0=
=A0 =A0=A0=A0 *val =3D chip->lensfactor;=0A> +=A0=A0=A0 =A0=A0=A0 ret =3D I=
IO_VAL_INT_PLUS_MICRO;=0A> +=A0=A0=A0 =A0=A0=A0 break;=0A> +=A0=A0=A0 defau=
lt:=0A> +=A0=A0=A0 =A0=A0=A0 break;=0A> +=A0=A0=A0 }=0A> +=A0=A0=A0 mutex_u=
nlock(&chip->lock);=0A> +=A0=A0=A0 return ret;=0A> +}=0A> +=0A> +#define II=
O_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + 1)=0A> +#define IIO_CHAN_INFO_C=
ALIBSCALE_SEPARATE_BIT=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  \=0A> +=A0=A0=A0=
 IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBSCALE)=0A> +=0A> +static con=
st struct iio_chan_spec cm3218_channels[] =3D {=0A> +=A0=A0=A0 {=0A> +=A0=
=A0=A0 =A0=A0=A0 .type =3D IIO_LIGHT,=0A> +=A0=A0=A0 =A0=A0=A0 .indexed =3D=
 1,=0A> +=A0=A0=A0 =A0=A0=A0 .channel =3D 0,=0A> +=A0=A0=A0 =A0=A0=A0 .info=
_mask =3D IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,=0A=0Ainfo_mask_separate wa=
s recently introduced=0A=0A> +=A0=A0=A0 }=0A> +};=0A> +=0A> +static IIO_DEV=
ICE_ATTR(illuminance0_input, S_IRUGO, show_lux, NULL, 0);=0A> +static IIO_D=
EVICE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,=0A> +=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 show_lensfactor, store_lensfactor, 0);=
=0A=0Anot needed; I think you just need the iio_chan_spec=0A=0A> +#ifdef=A0=
=A0=A0 CM3218_DEBUG=0A> +static IIO_DEVICE_ATTR(cmd, S_IRUGO | S_IWUSR, sho=
w_cmd, store_cmd, 0);=0A> +static IIO_DEVICE_ATTR(status, S_IRUGO, show_sta=
tus, NULL, 0);=0A> +#endif=A0=A0=A0 /* CM3218_DEBUG */=0A> +=0A> +#define C=
M3218_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)=0A> +#define CM32=
18_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)=0A> +static stru=
ct attribute *cm3218_attributes[] =3D {=0A> +=A0=A0=A0 CM3218_DEV_ATTR(illu=
minance0_input),=0A> +=A0=A0=A0 CM3218_DEV_ATTR(illuminance0_calibscale),=
=0A> +#ifdef=A0=A0=A0 CM3218_DEBUG=0A> +=A0=A0=A0 CM3218_DEV_ATTR(cmd),=0A>=
 +=A0=A0=A0 CM3218_DEV_ATTR(status),=0A> +#endif=A0=A0=A0 /* CM3218_DEBUG *=
/=0A> +=A0=A0=A0 NULL=0A> +};=0A> +=0A> +static const struct attribute_grou=
p cm3218_group =3D {=0A> +=A0=A0=A0 .attrs =3D cm3218_attributes,=0A> +};=
=0A> +=0A> +static int cm3218_chip_init(struct i2c_client *client)=0A> +{=
=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(i2c_get_clientdata(cl=
ient));=0A> +=A0=A0=A0 int status, i;=0A> +=0A> +=A0=A0=A0 memset(chip->reg=
_cache, 0, sizeof(chip->reg_cache));=0A> +=0A> +=A0=A0=A0 for (i =3D 0; i <=
 5; i++) {=0A> +=A0=A0=A0 =A0=A0=A0 status =3D cm3218_write(client, CM3218_=
REG_ADDR_CMD,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 CM3218_CMD_ALS_S=
D);=0A> +=A0=A0=A0 =A0=A0=A0 if (status >=3D 0)=0A> +=A0=A0=A0 =A0=A0=A0 =
=A0=A0=A0 break;=0A> +=A0=A0=A0 =A0=A0=A0 cm3218_read_ara(client);=0A> +=A0=
=A0=A0 }=0A> +=0A> +=A0=A0=A0 status =3D cm3218_write(client, CM3218_REG_AD=
DR_CMD, CM3218_DEFAULT_CMD);=0A> +=A0=A0=A0 if (status < 0) {=0A> +=A0=A0=
=A0 =A0=A0=A0 dev_err(&client->dev, "Init CM3218 CMD fails\n");=0A> +=A0=A0=
=A0 =A0=A0=A0 return status;=0A> +=A0=A0=A0 }=0A> +=0A> +=0A> +=A0=A0=A0 /*=
 Clean interrupt status */=0A> +=A0=A0=A0 cm3218_read(client, CM3218_REG_AD=
DR_STATUS);=0A> +=0A> +=A0=A0=A0 return 0;=0A> +}=0A> +=0A> +static const s=
truct iio_info cm3218_info =3D {=0A> +=A0=A0=A0 .attrs =3D &cm3218_group,=
=0A> +=A0=A0=A0 .driver_module =3D THIS_MODULE,=0A> +=A0=A0=A0 .read_raw =
=3D &cm3218_read_raw,=0A> +=A0=A0=A0 .write_raw =3D &cm3218_write_raw,=0A> =
+};=0A> +=0A> +static int cm3218_probe(struct i2c_client *client,=0A> +=A0=
=A0=A0 =A0=A0=A0 =A0=A0=A0  const struct i2c_device_id *id)=0A> +{=0A> +=A0=
=A0=A0 struct cm3218_chip *chip;=0A> +=A0=A0=A0 struct iio_dev *indio_dev;=
=0A> +=A0=A0=A0 int err;=0A> +=0A> +=A0=A0=A0 indio_dev =3D iio_device_allo=
c(sizeof(*chip));=0A> +=A0=A0=A0 if (indio_dev =3D=3D NULL) {=0A> +=A0=A0=
=A0 =A0=A0=A0 dev_err(&client->dev, "iio allocation fails\n");=0A> +=A0=A0=
=A0 =A0=A0=A0 err =3D -ENOMEM;=0A> +=A0=A0=A0 =A0=A0=A0 goto exit;=0A=0Amay=
be directly return -ENOMEM?=0A=0A> +=A0=A0=A0 }=0A> +=A0=A0=A0 chip =3D iio=
_priv(indio_dev);=0A> +=A0=A0=A0 chip->client =3D client;=0A> +=A0=A0=A0 i2=
c_set_clientdata(client, indio_dev);=0A> +=0A> +=A0=A0=A0 mutex_init(&chip-=
>lock);=0A> +=0A> +=A0=A0=A0 chip->lensfactor =3D 1000;=0A=0Amaybe some pla=
tform data, DT magic to allow passing the lens factor?=0A=0A> +=A0=A0=A0 ch=
ip->suspended =3D false;=0A> +=0A> +=A0=A0=A0 err =3D cm3218_chip_init(clie=
nt);=0A> +=A0=A0=A0 if (err)=0A> +=A0=A0=A0 =A0=A0=A0 goto exit_iio_free;=
=0A> +=0A> +=A0=A0=A0 indio_dev->info =3D &cm3218_info;=0A> +=A0=A0=A0 indi=
o_dev->channels =3D cm3218_channels;=0A> +=A0=A0=A0 indio_dev->num_channels=
 =3D ARRAY_SIZE(cm3218_channels);=0A> +=A0=A0=A0 indio_dev->name =3D id->na=
me;=0A> +=A0=A0=A0 indio_dev->dev.parent =3D &client->dev;=0A> +=A0=A0=A0 i=
ndio_dev->modes =3D INDIO_DIRECT_MODE;=0A> +=A0=A0=A0 err =3D iio_device_re=
gister(indio_dev);=0A> +=A0=A0=A0 if (err) {=0A> +=A0=A0=A0 =A0=A0=A0 dev_e=
rr(&client->dev, "iio registration fails\n");=0A> +=A0=A0=A0 =A0=A0=A0 goto=
 exit_iio_free;=0A> +=A0=A0=A0 }=0A> +=0A> +=A0=A0=A0 return 0;=0A> +exit_i=
io_free:=0A> +=A0=A0=A0 iio_device_free(indio_dev);=0A> +exit:=0A> +=A0=A0=
=A0 return err;=0A> +}=0A> +=0A> +static int cm3218_detect(struct i2c_clien=
t *client,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0  struct i2c_boa=
rd_info *info)=0A> +{=0A> +=A0=A0=A0 struct i2c_adapter *adapter =3D client=
->adapter;=0A> +=A0=A0=A0 const char *name =3D NULL;=0A> +=0A> +=A0=A0=A0 c=
m3218_read_ara(client);=0A> +=0A> +=A0=A0=A0 if (!i2c_check_functionality(a=
dapter, I2C_FUNC_SMBUS_BYTE_DATA))=0A> +=A0=A0=A0 =A0=A0=A0 return -ENODEV;=
=0A=0Athe driver needs WORD_DATA=0Athe check is after read_ara (which only =
needs BYTE_DATA)=0Awhat is read_ara() fails=0A=0A> +=0A> +=A0=A0=A0 name =
=3D "cm3218";=0A> +=A0=A0=A0 strlcpy(info->type, name, I2C_NAME_SIZE);=0A> =
+=0A> +=A0=A0=A0 return 0;=0A> +}=0A> +=0A> +static int cm3218_remove(struc=
t i2c_client *client)=0A> +{=0A> +=A0=A0=A0 struct iio_dev *indio_dev =3D i=
2c_get_clientdata(client);=0A> +=0A> +=A0=A0=A0 dev_dbg(&client->dev, "%s()=
\n", __func__);=0A> +=A0=A0=A0 iio_device_unregister(indio_dev);=0A> +=A0=
=A0=A0 iio_device_free(indio_dev);=0A> +=0A> +=A0=A0=A0 return 0;=0A> +}=0A=
> +=0A> +#ifdef CONFIG_PM_SLEEP=0A> +static int cm3218_suspend(struct devic=
e *dev)=0A> +{=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(dev_get=
_drvdata(dev));=0A> +=0A> +=A0=A0=A0 mutex_lock(&chip->lock);=0A> +=0A> +=
=A0=A0=A0 /* Since this driver uses only polling commands, we are by defaul=
t in=0A> +=A0=A0=A0  * auto shutdown (ie, power-down) mode.=0A> +=A0=A0=A0 =
 * So we do not have much to do here.=0A> +=A0=A0=A0  */=0A> +=A0=A0=A0 chi=
p->suspended =3D true;=0A> +=0A> +=A0=A0=A0 mutex_unlock(&chip->lock);=0A> =
+=A0=A0=A0 return 0;=0A> +}=0A> +=0A> +static int cm3218_resume(struct devi=
ce *dev)=0A> +{=0A> +=A0=A0=A0 struct iio_dev *indio_dev =3D dev_get_drvdat=
a(dev);=0A> +=A0=A0=A0 struct cm3218_chip *chip =3D iio_priv(indio_dev);=0A=
> +=A0=A0=A0 struct i2c_client *client =3D chip->client;=0A> +=A0=A0=A0 int=
 err;=0A> +=0A> +=A0=A0=A0 mutex_lock(&chip->lock);=0A> +=0A> +=A0=A0=A0 er=
r =3D cm3218_chip_init(client);=0A> +=A0=A0=A0 if (!err)=0A> +=A0=A0=A0 =A0=
=A0=A0 chip->suspended =3D false;=0A> +=0A> +=A0=A0=A0 mutex_unlock(&chip->=
lock);=0A> +=A0=A0=A0 return err;=0A> +}=0A> +=0A> +static SIMPLE_DEV_PM_OP=
S(cm3218_pm_ops, cm3218_suspend, cm3218_resume);=0A> +#define CM3218_PM_OPS=
 (&cm3218_pm_ops)=0A> +#else=0A> +#define CM3218_PM_OPS NULL=0A> +#endif=0A=
> +=0A> +static const struct i2c_device_id cm3218_id[] =3D {=0A> +=A0=A0=A0=
 {"cm3218", 0},=0A> +=A0=A0=A0 {}=0A> +};=0A> +=0A> +MODULE_DEVICE_TABLE(i2=
c, cm3218_id);=0A> +=0A> +static const struct of_device_id cm3218_of_match[=
] =3D {=0A> +=A0=A0=A0 { .compatible =3D "invn,cm3218", },=0A> +=A0=A0=A0 {=
 },=0A> +};=0A> +MODULE_DEVICE_TABLE(of, cm3218_of_match);=0A> +=0A> +stati=
c struct i2c_driver cm3218_driver =3D {=0A> +=A0=A0=A0 .class=A0=A0=A0 =3D =
I2C_CLASS_HWMON,=0A> +=A0=A0=A0 .driver=A0=A0=A0  =3D {=0A> +=A0=A0=A0 =A0=
=A0=A0 =A0=A0=A0 .name =3D "cm3218",=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 .pm=
 =3D CM3218_PM_OPS,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 .owner =3D THIS_MODU=
LE,=0A> +=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 .of_match_table =3D cm3218_of_match,=
=0A> +=A0=A0=A0 =A0=A0=A0 =A0 =A0 },=0A> +=A0=A0=A0 .probe=A0=A0=A0 =A0=A0=
=A0 =3D cm3218_probe,=0A> +=A0=A0=A0 .remove=A0=A0=A0 =A0=A0=A0 =3D cm3218_=
remove,=0A> +=A0=A0=A0 .id_table=A0 =A0 =A0  =3D cm3218_id,=0A> +=A0=A0=A0 =
.detect=A0=A0=A0  =3D cm3218_detect,=0A> +=A0=A0=A0 .address_list=A0  =3D n=
ormal_i2c,=0A> +};=0A> +module_i2c_driver(cm3218_driver);=0A> +=0A> +MODULE=
_DESCRIPTION("CM3218 Ambient Light Sensor driver");=0A> +MODULE_LICENSE("GP=
L");=0A> =0A=0A-- =0A=0APeter Meerwald=0A+43-664-2444418 (mobile)
---1467812710-1501340236-1372926366=:99136
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:10pt"><div><spa=
n>Hi Peter,</span></div><div style=3D"color: rgb(0, 0, 0); font-size: 13px;=
 font-family: 'Courier New', courier, monaco, monospace, sans-serif; backgr=
ound-color: transparent; font-style: normal;"><span><br></span></div><div s=
tyle=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'Courier New', c=
ourier, monaco, monospace, sans-serif; background-color: transparent; font-=
style: normal;"><span>Thank you for your reply. &nbsp;Can you advise me whe=
re is the best location?</span></div><div style=3D"color: rgb(0, 0, 0); fon=
t-size: 13px; font-family: 'Courier New', courier, monaco, monospace, sans-=
serif; background-color: transparent; font-style: normal;"><span><br></span=
></div><div style=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'Co=
urier New', courier, monaco, monospace, sans-serif; background-color:
 transparent; font-style: normal;">Thanks.</div><div style=3D"color: rgb(0,=
 0, 0); font-size: 13px; font-family: 'Courier New', courier, monaco, monos=
pace, sans-serif; background-color: transparent; font-style: normal;"><br><=
/div><div style=3D"color: rgb(0, 0, 0); font-size: 13px; font-family: 'Cour=
ier New', courier, monaco, monospace, sans-serif; background-color: transpa=
rent; font-style: normal;">Kevin Tsai</div><div style=3D"color: rgb(0, 0, 0=
); font-size: 13px; font-family: 'Courier New', courier, monaco, monospace,=
 sans-serif; background-color: transparent; font-style: normal;">07/04/13</=
div><div><br></div>  <div style=3D"font-family: 'Courier New', courier, mon=
aco, monospace, sans-serif; font-size: 10pt;"> <div style=3D"font-family: '=
times new roman', 'new york', times, serif; font-size: 12pt;"> <div dir=3D"=
ltr"> <hr size=3D"1">  <font size=3D"2" face=3D"Arial"> <b><span style=3D"f=
ont-weight:bold;">From:</span></b> Peter Meerwald &lt;pmeerw@pmeerw.net&gt;=
<br> <b><span
 style=3D"font-weight: bold;">To:</span></b> Kevin Tsai &lt;ktsai@capellami=
cro.com&gt; <br><b><span style=3D"font-weight: bold;">Cc:</span></b> Jonath=
an Cameron &lt;jic23@cam.ac.uk&gt;; Greg Kroah-Hartman &lt;gregkh@linuxfoun=
dation.org&gt;; Grant Likely &lt;grant.likely@linaro.org&gt;; Rob Herring &=
lt;rob.herring@calxeda.com&gt;; linux-kernel@vger.kernel.org; linux-iio@vge=
r.kernel.org; devel@driverdev.osuosl.org; devicetree-discuss@lists.ozlabs.o=
rg <br> <b><span style=3D"font-weight: bold;">Sent:</span></b> Thursday, Ju=
ly 4, 2013 1:17 AM<br> <b><span style=3D"font-weight: bold;">Subject:</span=
></b> Re: [PATCH 1/1] Added Capella CM3218 Ambient Light Sensor IIO Driver.=
<br> </font> </div> <div class=3D"y_msg_container"><br>Hello,<br><br>some c=
omments inline;<br>new drivers should not go to staging but to mainline dir=
ectly <br><br>regards, p.<br><br>&gt; Signed-off-by: Kevin Tsai &lt;<a ymai=
lto=3D"mailto:ktsai@capellamicro.com"
 href=3D"mailto:ktsai@capellamicro.com">ktsai@capellamicro.com</a>&gt;<br>&=
gt; ---<br>&gt;&nbsp; drivers/staging/iio/light/Kconfig&nbsp; |&nbsp;  10 +=
<br>&gt;&nbsp; drivers/staging/iio/light/Makefile |&nbsp; &nbsp; 1 +<br>&gt=
;&nbsp; drivers/staging/iio/light/cm3218.c |&nbsp; 581 ++++++++++++++++++++=
++++++++++++++++<br>&gt;&nbsp; 3 files changed, 592 insertions(+)<br>&gt;&n=
bsp; create mode 100644 drivers/staging/iio/light/cm3218.c<br>&gt; <br>&gt;=
 diff --git a/drivers/staging/iio/light/Kconfig b/drivers/staging/iio/light=
/Kconfig<br>&gt; index ca8d6e6..647af0c 100644<br>&gt; --- a/drivers/stagin=
g/iio/light/Kconfig<br>&gt; +++ b/drivers/staging/iio/light/Kconfig<br>&gt;=
 @@ -40,4 +40,14 @@ config TSL2x7x<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp;  tmd267=
2, tsl2772, tmd2772 devices.<br>&gt;&nbsp; &nbsp;&nbsp;&nbsp;  Provides iio=
_events and direct access via sysfs.<br>&gt;&nbsp; <br>&gt; +config SENSORS=
_CM3218<br>&gt; +&nbsp; &nbsp; &nbsp; &nbsp; tristate "CM3218 Ambient
 Light Sensor"<br>&gt; +&nbsp; &nbsp; &nbsp; &nbsp; depends on I2C<br>&gt; =
+&nbsp; &nbsp; &nbsp; &nbsp; help<br>&gt; +&nbsp; &nbsp; &nbsp; &nbsp;  Say=
 Y here if you have a Capella Micro CM3218 Ambient Light Sensor.<br>&gt; +<=
br>&gt; +&nbsp; &nbsp; &nbsp; &nbsp;  To compile this driver as a module, c=
hoose M here.&nbsp; This module<br>&gt; +&nbsp; &nbsp; &nbsp; &nbsp;  will =
be called to 'cm3218'.&nbsp; It will access ALS data via iio sysfs.<br>&gt;=
 +&nbsp; &nbsp; &nbsp; &nbsp;  This is recommended.<br>&gt; +<br>&gt;&nbsp;=
 endmenu<br>&gt; diff --git a/drivers/staging/iio/light/Makefile b/drivers/=
staging/iio/light/Makefile<br>&gt; index 9960fdf..63020ab 100644<br>&gt; --=
- a/drivers/staging/iio/light/Makefile<br>&gt; +++ b/drivers/staging/iio/li=
ght/Makefile<br>&gt; @@ -6,3 +6,4 @@ obj-$(CONFIG_SENSORS_ISL29018)&nbsp;&n=
bsp;&nbsp; +=3D isl29018.o<br>&gt;&nbsp; obj-$(CONFIG_SENSORS_ISL29028)&nbs=
p;&nbsp;&nbsp; +=3D isl29028.o<br>&gt;&nbsp;
 obj-$(CONFIG_TSL2583)&nbsp;&nbsp;&nbsp; +=3D tsl2583.o<br>&gt;&nbsp; obj-$=
(CONFIG_TSL2x7x)&nbsp;&nbsp;&nbsp; +=3D tsl2x7x_core.o<br>&gt; +obj-$(CONFI=
G_SENSORS_CM3218)&nbsp; &nbsp; +=3D cm3218.o<br>&gt; diff --git a/drivers/s=
taging/iio/light/cm3218.c b/drivers/staging/iio/light/cm3218.c<br>&gt; new =
file mode 100644<br>&gt; index 0000000..9c2584d<br>&gt; --- /dev/null<br>&g=
t; +++ b/drivers/staging/iio/light/cm3218.c<br>&gt; @@ -0,0 +1,581 @@<br>&g=
t; +/*<br>&gt; + * A iio driver for CM3218 Ambient Light Sensor.<br>&gt; + =
*<br>&gt; + * IIO driver for monitoring ambient light intensity in lux.<br>=
&gt; + *<br>&gt; + * Copyright (c) 2013, Capella Microsystems Inc.<br>&gt; =
+ *<br>&gt; + * This program is free software; you can redistribute it and/=
or modify<br>&gt; + * it under the terms of the GNU General Public License =
as published by<br>&gt; + * the Free Software Foundation; either version 2 =
of the License, or<br>&gt; + * (at your option) any later version.<br>&gt;
 + *<br>&gt; + * This program is distributed in the hope that it will be us=
eful, but WITHOUT<br>&gt; + * ANY WARRANTY; without even the implied warran=
ty of MERCHANTABILITY or<br>&gt; + * FITNESS FOR A PARTICULAR PURPOSE.&nbsp=
; See the GNU General Public License for<br>&gt; + * more details.<br>&gt; =
+ *<br>&gt; + * You should have received a copy of the GNU General Public L=
icense along<br>&gt; + * with this program; if not, write to the Free Softw=
are Foundation, Inc.,<br>&gt; + * 51 Franklin Street, Fifth Floor, Boston, =
MA&nbsp;&nbsp;&nbsp; 02110-1301, USA.<br>&gt; + */<br>&gt; +<br>&gt; +#incl=
ude &lt;linux/module.h&gt;<br>&gt; +#include &lt;linux/i2c.h&gt;<br>&gt; +#=
include &lt;linux/err.h&gt;<br>&gt; +#include &lt;linux/mutex.h&gt;<br>&gt;=
 +#include &lt;linux/delay.h&gt;<br>&gt; +#include &lt;linux/slab.h&gt;<br>=
&gt; +#include &lt;linux/iio/iio.h&gt;<br>&gt; +#include &lt;linux/iio/sysf=
s.h&gt;<br>&gt; +<br>&gt; +/*<br>&gt; + * SMBus ARA address<br>maybe
 Address for consistency? <br><br>&gt; + */<br>&gt; +#define&nbsp;&nbsp;&nb=
sp; CM3218_ADDR_ARA&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 0x0C<br>&gt; +<br>&gt; +/*<br>&gt; + * CM3218 CMD Registers<br>&gt; + */<b=
r>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_REG_ADDR_CMD&nbsp;&nbsp;&nbsp; &nb=
sp;&nbsp;&nbsp; 0x00<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_CMD_ALS_SD&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x0001<br>&gt; +#define&nbsp;&nbsp;&nbs=
p; CM3218_CMD_ALS_INT_EN&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x0002<br>&gt=
; +#define&nbsp;&nbsp;&nbsp; CM3218_CMD_ALS_IT_SHIFT&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; 6<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_CMD_ALS_IT_MASK&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (3 &lt;&lt; CM3218_CMD_ALS_IT_SHIFT)<b=
r>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_CMD_ALS_IT_05T&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; (0 &lt;&lt; CM3218_CMD_ALS_IT_SHIFT)<br>&gt; +#define&nbs=
p;&nbsp;&nbsp; CM3218_CMD_ALS_IT_1T&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; (1 &lt;&lt; CM3218_CMD_ALS_IT_SHIFT)<br>&gt; +#define&n=
bsp;&nbsp;&nbsp; CM3218_CMD_ALS_IT_2T&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
(2 &lt;&lt; CM3218_CMD_ALS_IT_SHIFT)<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3=
218_CMD_ALS_IT_4T&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (3 &lt;&lt; CM3218_C=
MD_ALS_IT_SHIFT)<br><br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_DEFAULT_CMD&=
nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (CM3218_CMD_ALS_IT_1T)<br>no parenthes=
is needed <br><br>&gt; +<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_REG_ADDR=
_ALS_WH&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x01<br>&gt; +#define&nbsp;&nb=
sp;&nbsp; CM3218_DEFAULT_ALS_WH&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0xFFFF=
<br>&gt; +<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_REG_ADDR_ALS_WL&nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x02<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM32=
18_DEFAULT_ALS_WL&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x0000<br>&gt; +<br>=
&gt; +#define&nbsp;&nbsp;&nbsp;
 CM3218_REG_ADDR_ALS&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x04<br>&gt; +<br=
>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_REG_ADDR_STATUS&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; 0x06<br>&gt; +<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_=
REG_ADDR_ID&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; 0x07<br>&gt; +<br>&gt; +/*=
<br>&gt; + * Software Parameters<br>&gt; + */<br>&gt; +#define&nbsp;&nbsp;&=
nbsp; CM3218_MAX_CACHE_REGS&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; (0x03+1)&n=
bsp;&nbsp;&nbsp; /* Reg.0x00 to 0x03 */<br>&gt; +<br>&gt; +/*<br>&gt; + * F=
eatures<br>&gt; + */<br>&gt; +#define&nbsp;&nbsp;&nbsp; CM3218_DEBUG<br>&gt=
; +<br>&gt; +static const unsigned short normal_i2c[] =3D {<br>&gt; +&nbsp;=
&nbsp;&nbsp; 0x10, 0x48, I2C_CLIENT_END };<br>&gt; +<br>&gt; +struct cm3218=
_chip {<br>&gt; +&nbsp;&nbsp;&nbsp; struct i2c_client&nbsp;&nbsp;&nbsp; *cl=
ient;<br>&gt; +&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp; &nbsp;&nbs=
p;&nbsp; lock;<br>&gt; +&nbsp;&nbsp;&nbsp; unsigned
 int&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; lensfactor;<br>&gt; +&nbsp;&nbsp;=
&nbsp; bool&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; suspend=
ed;<br>&gt; +&nbsp;&nbsp;&nbsp; u16&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; reg_cache[CM3218_MAX_CACHE_REGS];<br>&gt; +};<br>&gt; +<br=
>&gt; +static int cm3218_read_ara(struct i2c_client *client)<br>&gt; +{<br>=
&gt; +&nbsp;&nbsp;&nbsp; int status;<br>&gt; +&nbsp;&nbsp;&nbsp; unsigned s=
hort addr;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; addr =3D client-&gt;addr;<=
br>&gt; +&nbsp;&nbsp;&nbsp; client-&gt;addr =3D CM3218_ADDR_ARA;<br>&gt; +&=
nbsp;&nbsp;&nbsp; status =3D i2c_smbus_read_byte(client);<br>&gt; +&nbsp;&n=
bsp;&nbsp; client-&gt;addr =3D addr;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; =
if (status &lt; 0)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -E=
NODEV;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +=
<br>&gt; +static int cm3218_write(struct i2c_client *client, u8 reg, u16
 value)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; u16 regval;<br>&gt; +&nbsp;&=
nbsp;&nbsp; int ret;<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =
=3D iio_priv(i2c_get_clientdata(client));<br>&gt; +<br>&gt; +#ifdef&nbsp;&n=
bsp;&nbsp; CM3218_DEBUG<br>&gt; +&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt=
;dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "Write to device regis=
ter 0x%02X with 0x%04X\n", reg, value);<br>&gt; +#endif&nbsp;&nbsp;&nbsp; /=
* CM3218_DEBUG */<br><br>dev_dbg? and no _DEBUG<br><br>&gt; +&nbsp;&nbsp;&n=
bsp; regval =3D cpu_to_le16(value);<br>&gt; +&nbsp;&nbsp;&nbsp; ret =3D i2c=
_smbus_write_word_data(client, reg, regval);<br>&gt; +&nbsp;&nbsp;&nbsp; if=
 (ret) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_err(&amp;client=
-&gt;dev, "Write to device fails: 0x%x\n", ret);<br>&gt; +&nbsp;&nbsp;&nbsp=
; } else {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; /* Update cache *=
/<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (reg &lt;
 CM3218_MAX_CACHE_REGS)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; chip-&gt;reg_cache[reg] =3D value;<br>&gt; +&nbsp;&nbsp;&nbs=
p; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return ret;<br>&gt; +}<br><br>th=
ere is regmap for caching register contents; maybe overkill..<br><br>&gt; +=
<br>&gt; +static int cm3218_read(struct i2c_client *client, u8 reg)<br>&gt;=
 +{<br>&gt; +&nbsp;&nbsp;&nbsp; int regval;<br>&gt; +&nbsp;&nbsp;&nbsp; int=
 status;<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio_priv(=
i2c_get_clientdata(client));<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; if (reg =
&lt; CM3218_MAX_CACHE_REGS) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; regval =3D chip-&gt;reg_cache[reg];<br>&gt; +&nbsp;&nbsp;&nbsp; } else {<=
br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; status =3D i2c_smbus_read_wo=
rd_data(client, reg);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (st=
atus &lt; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<br>&gt; +&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "Error in readin=
g Reg.0x%02X\n", reg);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; return status;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 }<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; regval =3D le16_to_cpu(st=
atus);<br>&gt; +#ifdef&nbsp;&nbsp;&nbsp; CM3218_DEBUG<br>&gt; +&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev,<br>&gt; +&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; "Read from device register 0x=
%02X =3D 0x%04X\n",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&n=
bsp;&nbsp; reg, regval);<br>&gt; +#endif&nbsp;&nbsp;&nbsp; /* CM3218_DEBUG =
*/<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; retu=
rn regval;<br>&gt; +}<br>&gt; +<br>&gt; +static int cm3218_read_sensor_inpu=
t(struct i2c_client *client)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; int
 status;<br>&gt; +&nbsp;&nbsp;&nbsp; int lux;<br>&gt; +<br>&gt; +&nbsp;&nbs=
p;&nbsp; status =3D cm3218_read(client, CM3218_REG_ADDR_ALS);<br>&gt; +&nbs=
p;&nbsp;&nbsp; if (status &lt; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; dev_err(&amp;client-&gt;dev, "Error in reading Lux DATA\n");<br>&gt=
; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return status;<br>&gt; +&nbsp;&nbs=
p;&nbsp; }<br>&gt; +&nbsp;&nbsp;&nbsp; lux =3D status;<br>&gt; +<br>&gt; +&=
nbsp;&nbsp;&nbsp; dev_vdbg(&amp;client-&gt;dev, "lux =3D %u\n", lux);<br>&g=
t; +<br>&gt; +&nbsp;&nbsp;&nbsp; return lux;<br>&gt; +}<br>&gt; +<br>&gt; +=
static int cm3218_read_lux(struct i2c_client *client, int *lux)<br>&gt; +{<=
br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio_priv(i2c_get_c=
lientdata(client));<br>&gt; +&nbsp;&nbsp;&nbsp; int lux_data;<br>&gt; +<br>=
&gt; +&nbsp;&nbsp;&nbsp; lux_data =3D cm3218_read_sensor_input(client);<br>=
&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; if (lux_data &lt; 0)<br>&gt;
 +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return lux_data;<br>&gt; +<br>&gt; =
+&nbsp;&nbsp;&nbsp; *lux&nbsp; =3D lux_data * chip-&gt;lensfactor;<br>&gt; =
+&nbsp;&nbsp;&nbsp; *lux /=3D 1000;<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<b=
r>&gt; +}<br><br>these read wrappers could probably be avoided; most of the=
 code is <br>cascaded error handling<br><br>&gt; +<br>&gt; +/* Sysfs interf=
ace */<br>&gt; +/* lensfactor */<br><br>comment style<br><br>&gt; +static s=
size_t show_lensfactor(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)=
<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_g=
et_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D i=
io_priv(indio_dev);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return sprintf(bu=
f, "%d\n", chip-&gt;lensfactor);<br>&gt; +}<br><br>the sysfs interface seem=
s to be redundant; there is also CALIBSCALE<br><br>&gt; +<br>&gt; +static
 ssize_t store_lensfactor(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; struct device_attribute *attr, const char *buf, size_t co=
unt)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D d=
ev_get_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =
=3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; unsigned long lval;<br=
>&gt; +<br>&gt; +/*<br>&gt; +&nbsp;&nbsp;&nbsp; lval =3D kstrtoul(buf, NULL=
, 10);<br>&gt; +&nbsp;&nbsp;&nbsp; if (lval =3D=3D 0)<br>&gt; +&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; return -EINVAL;<br>&gt; +*/<br><br>remove comment=
 before submission<br><br>&gt; +&nbsp;&nbsp;&nbsp; if (kstrtoul(buf, 10, &a=
mp;lval))<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -EINVAL;<br=
>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;chip-&gt;lock);<br>&gt;=
 +&nbsp;&nbsp;&nbsp; chip-&gt;lensfactor =3D lval;<br>&gt; +&nbsp;&nbsp;&nb=
sp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp;
 return count;<br>&gt; +}<br>&gt; +<br>&gt; +static ssize_t get_sensor_data=
(struct device *dev, char *buf)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; stru=
ct iio_dev *indio_dev =3D dev_get_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp;=
 struct cm3218_chip *chip =3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nb=
sp; struct i2c_client *client =3D chip-&gt;client;<br>&gt; +&nbsp;&nbsp;&nb=
sp; int value =3D 0;<br>&gt; +&nbsp;&nbsp;&nbsp; int status;<br>&gt; +<br>&=
gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbs=
p;&nbsp; if (chip-&gt;suspended) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; return -EBUSY;<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt;=
 +&nbsp;&nbsp;&nbsp;  status =3D cm3218_read_lux(client, &amp;value);<br><b=
r>extra space here<br><br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; if (status &lt=
; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
 dev_err(&amp;client-&gt;dev, "Error in Reading data");<br>&gt; +&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return status;<br>&gt; +&nbsp;&nbsp;&nbsp=
; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock);=
<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return sprintf(buf, "%d\n", value);<=
br>&gt; +}<br>&gt; +<br>&gt; +<br>&gt; +/* Read lux */<br>&gt; +static ssiz=
e_t show_lux(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; struct device_=
attribute *devattr, char *buf)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; retur=
n get_sensor_data(dev, buf);<br>&gt; +}<br>&gt; +<br>&gt; +#ifdef&nbsp;&nbs=
p;&nbsp; CM3218_DEBUG<br>&gt; +/* windows_high */<br><br>there would be deb=
ugfs_reg_access in iio_info<br><br>&gt; +static ssize_t show_cmd(struct dev=
ice *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *=
buf)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev
 *indio_dev =3D dev_get_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm=
3218_chip *chip =3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct=
 i2c_client *client =3D chip-&gt;client;<br>&gt; +&nbsp;&nbsp;&nbsp; int st=
atus;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; status =3D cm3218_read(client, =
CM3218_REG_ADDR_CMD);<br>&gt; +&nbsp;&nbsp;&nbsp; if (status &lt; 0) {<br>&=
gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; dev_err(dev, "Error in getting C=
M3218_REG_ADDR_CMD\n");<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; retu=
rn status;<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nb=
sp; return sprintf(buf, "%u\n", status);<br>&gt; +}<br>&gt; +<br>&gt; +stat=
ic ssize_t store_cmd(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; struct device_attribute *attr, const char *buf, size_t count)<=
br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_ge=
t_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D
 iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct i2c_client *client=
 =3D chip-&gt;client;<br>&gt; +&nbsp;&nbsp;&nbsp; int status;<br>&gt; +&nbs=
p;&nbsp;&nbsp; unsigned long lval;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; if=
 (kstrtoul(buf, 10, &amp;lval))<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;c=
hip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; if (lval &gt; 0x10000)<br>&gt; +=
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; lval =3D 0xFFFF;<br>&gt; +&nbsp;&nbsp=
;&nbsp; status =3D cm3218_write(client, CM3218_REG_ADDR_CMD, (u16)lval);<br=
>&gt; +&nbsp;&nbsp;&nbsp; if (status &lt; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; dev_err(dev, "Error in setting CM3218_REG_ADDR_CMD=
\n");<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return status;<br>&gt;=
 +&nbsp;&nbsp;&nbsp; }<br>&gt; +&nbsp;&nbsp;&nbsp;
 mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; re=
turn count;<br>&gt; +}<br>&gt; +<br>&gt; +/* status */<br>&gt; +static ssiz=
e_t show_status(struct device *dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; struct device_attribute *attr, char *buf)<br>&gt=
; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D dev_get_drvd=
ata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio_priv=
(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct i2c_client *client =3D chip=
-&gt;client;<br>&gt; +&nbsp;&nbsp;&nbsp; int status;<br>&gt; +<br>&gt; +&nb=
sp;&nbsp;&nbsp; status =3D cm3218_read(client, CM3218_REG_ADDR_STATUS);<br>=
&gt; +&nbsp;&nbsp;&nbsp; if (status &lt; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; &=
nbsp;&nbsp;&nbsp; dev_err(dev, "Error in getting CM3218_REG_ADDR_STATUS\n")=
;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return status;<br>&gt; +&n=
bsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return sprintf(buf=
,
 "%u\n", status);<br>&gt; +}<br>&gt; +<br>&gt; +#endif&nbsp;&nbsp;&nbsp; /*=
 CM3218_DEBUG */<br>&gt; +<br>&gt; +/* Channel IO */<br>&gt; +static int cm=
3218_write_raw(struct iio_dev *indio_dev,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp=
;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; struct iio_chan_spec =
const *chan,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp; &nbsp; &nbsp; int val,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; int val2,<br>&gt; +&nbsp;&nbs=
p;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; long ma=
sk)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio=
_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br><br>r=
et is not used?<br><br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;c=
hip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; if (mask =3D=3D IIO_CHAN_INFO_CA=
LIBSCALE &amp;&amp; chan-&gt;type =3D=3D IIO_LIGHT) {<br>&gt;
 +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip-&gt;lensfactor =3D val;<br>&gt=
; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D 0;<br>&gt; +&nbsp;&nbsp;&n=
bsp; }<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt=
; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +<br>&gt; +sta=
tic int cm3218_read_raw(struct iio_dev *indio_dev,<br>&gt; +&nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  struct iio_chan_sp=
ec const *chan,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;=
&nbsp; &nbsp; &nbsp;  int *val,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  int *val2,<br>&gt; +&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;  long mask)<br>&gt; +=
{<br>&gt; +&nbsp;&nbsp;&nbsp; int ret =3D -EINVAL;<br>&gt; +&nbsp;&nbsp;&nb=
sp; struct cm3218_chip *chip =3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;=
&nbsp; struct i2c_client *client =3D chip-&gt;client;<br>&gt; +<br>&gt;
 +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&=
nbsp; if (chip-&gt;suspended) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nb=
sp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nb=
sp;&nbsp; return -EBUSY;<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +&nbsp;&nbsp=
;&nbsp; switch (mask) {<br>&gt; +&nbsp;&nbsp;&nbsp; case 0:<br><br>huh? thi=
s is not in the channels?<br><br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; ret =3D cm3218_read_lux(client, val);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; if (!ret)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
&nbsp;&nbsp; ret =3D IIO_VAL_INT;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; break;<br>&gt; +&nbsp;&nbsp;&nbsp; case IIO_CHAN_INFO_CALIBSCALE:<br>=
&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; *val =3D chip-&gt;lensfactor;<b=
r>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ret =3D IIO_VAL_INT_PLUS_MICR=
O;<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&gt;
 +&nbsp;&nbsp;&nbsp; default:<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp=
; break;<br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_un=
lock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; return ret;<br>&gt; +=
}<br>&gt; +<br>&gt; +#define IIO_CHAN_INFO_SEPARATE_BIT(type) BIT(type*2 + =
1)<br>&gt; +#define IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT&nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  \<br>&gt; +&nbsp;&nbsp;&nbsp;=
 IIO_CHAN_INFO_SEPARATE_BIT(IIO_CHAN_INFO_CALIBSCALE)<br>&gt; +<br>&gt; +st=
atic const struct iio_chan_spec cm3218_channels[] =3D {<br>&gt; +&nbsp;&nbs=
p;&nbsp; {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .type =3D IIO_LIG=
HT,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .indexed =3D 1,<br>&gt; =
+&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .channel =3D 0,<br>&gt; +&nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; .info_mask =3D IIO_CHAN_INFO_CALIBSCALE_SEPARATE=
_BIT,<br><br>info_mask_separate was recently introduced<br><br>&gt;
 +&nbsp;&nbsp;&nbsp; }<br>&gt; +};<br>&gt; +<br>&gt; +static IIO_DEVICE_ATT=
R(illuminance0_input, S_IRUGO, show_lux, NULL, 0);<br>&gt; +static IIO_DEVI=
CE_ATTR(illuminance0_calibscale, S_IRUGO | S_IWUSR,<br>&gt; +&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&=
nbsp; show_lensfactor, store_lensfactor, 0);<br><br>not needed; I think you=
 just need the iio_chan_spec<br><br>&gt; +#ifdef&nbsp;&nbsp;&nbsp; CM3218_D=
EBUG<br>&gt; +static IIO_DEVICE_ATTR(cmd, S_IRUGO | S_IWUSR, show_cmd, stor=
e_cmd, 0);<br>&gt; +static IIO_DEVICE_ATTR(status, S_IRUGO, show_status, NU=
LL, 0);<br>&gt; +#endif&nbsp;&nbsp;&nbsp; /* CM3218_DEBUG */<br>&gt; +<br>&=
gt; +#define CM3218_DEV_ATTR(name) (&amp;iio_dev_attr_##name.dev_attr.attr)=
<br>&gt; +#define CM3218_CONST_ATTR(name) (&amp;iio_const_attr_##name.dev_a=
ttr.attr)<br>&gt; +static struct attribute *cm3218_attributes[] =3D {<br>&g=
t; +&nbsp;&nbsp;&nbsp; CM3218_DEV_ATTR(illuminance0_input),<br>&gt;
 +&nbsp;&nbsp;&nbsp; CM3218_DEV_ATTR(illuminance0_calibscale),<br>&gt; +#if=
def&nbsp;&nbsp;&nbsp; CM3218_DEBUG<br>&gt; +&nbsp;&nbsp;&nbsp; CM3218_DEV_A=
TTR(cmd),<br>&gt; +&nbsp;&nbsp;&nbsp; CM3218_DEV_ATTR(status),<br>&gt; +#en=
dif&nbsp;&nbsp;&nbsp; /* CM3218_DEBUG */<br>&gt; +&nbsp;&nbsp;&nbsp; NULL<b=
r>&gt; +};<br>&gt; +<br>&gt; +static const struct attribute_group cm3218_gr=
oup =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; .attrs =3D cm3218_attributes,<br>&gt;=
 +};<br>&gt; +<br>&gt; +static int cm3218_chip_init(struct i2c_client *clie=
nt)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio=
_priv(i2c_get_clientdata(client));<br>&gt; +&nbsp;&nbsp;&nbsp; int status, =
i;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; memset(chip-&gt;reg_cache, 0, size=
of(chip-&gt;reg_cache));<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; for (i =3D 0=
; i &lt; 5; i++) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; status =
=3D cm3218_write(client, CM3218_REG_ADDR_CMD,<br>&gt; +&nbsp;&nbsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; CM3218_CMD_ALS_SD=
);<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if (status &gt;=3D 0)<br>=
&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break;<br>&g=
t; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cm3218_read_ara(client);<br>&gt; =
+&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; status =3D cm32=
18_write(client, CM3218_REG_ADDR_CMD, CM3218_DEFAULT_CMD);<br>&gt; +&nbsp;&=
nbsp;&nbsp; if (status &lt; 0) {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; dev_err(&amp;client-&gt;dev, "Init CM3218 CMD fails\n");<br>&gt; +&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return status;<br>&gt; +&nbsp;&nbsp;&nbsp=
; }<br>&gt; +<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Clean interrupt stat=
us */<br>&gt; +&nbsp;&nbsp;&nbsp; cm3218_read(client, CM3218_REG_ADDR_STATU=
S);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +<br=
>&gt; +static const struct iio_info cm3218_info =3D {<br>&gt;
 +&nbsp;&nbsp;&nbsp; .attrs =3D &amp;cm3218_group,<br>&gt; +&nbsp;&nbsp;&nb=
sp; .driver_module =3D THIS_MODULE,<br>&gt; +&nbsp;&nbsp;&nbsp; .read_raw =
=3D &amp;cm3218_read_raw,<br>&gt; +&nbsp;&nbsp;&nbsp; .write_raw =3D &amp;c=
m3218_write_raw,<br>&gt; +};<br>&gt; +<br>&gt; +static int cm3218_probe(str=
uct i2c_client *client,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbs=
p;&nbsp;&nbsp;  const struct i2c_device_id *id)<br>&gt; +{<br>&gt; +&nbsp;&=
nbsp;&nbsp; struct cm3218_chip *chip;<br>&gt; +&nbsp;&nbsp;&nbsp; struct ii=
o_dev *indio_dev;<br>&gt; +&nbsp;&nbsp;&nbsp; int err;<br>&gt; +<br>&gt; +&=
nbsp;&nbsp;&nbsp; indio_dev =3D iio_device_alloc(sizeof(*chip));<br>&gt; +&=
nbsp;&nbsp;&nbsp; if (indio_dev =3D=3D NULL) {<br>&gt; +&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, "iio allocation fails\n");<=
br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; err =3D -ENOMEM;<br>&gt; +&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto exit;<br><br>maybe directly return
 -ENOMEM?<br><br>&gt; +&nbsp;&nbsp;&nbsp; }<br>&gt; +&nbsp;&nbsp;&nbsp; chi=
p =3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; chip-&gt;client =3D =
client;<br>&gt; +&nbsp;&nbsp;&nbsp; i2c_set_clientdata(client, indio_dev);<=
br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_init(&amp;chip-&gt;lock);<br>&g=
t; +<br>&gt; +&nbsp;&nbsp;&nbsp; chip-&gt;lensfactor =3D 1000;<br><br>maybe=
 some platform data, DT magic to allow passing the lens factor?<br><br>&gt;=
 +&nbsp;&nbsp;&nbsp; chip-&gt;suspended =3D false;<br>&gt; +<br>&gt; +&nbsp=
;&nbsp;&nbsp; err =3D cm3218_chip_init(client);<br>&gt; +&nbsp;&nbsp;&nbsp;=
 if (err)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto exit_iio_free=
;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;info =3D &amp;cm3218_=
info;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;channels =3D cm3218_channel=
s;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;num_channels =3D ARRAY_SIZE(cm=
3218_channels);<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;name =3D
 id-&gt;name;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;dev.parent =3D &amp=
;client-&gt;dev;<br>&gt; +&nbsp;&nbsp;&nbsp; indio_dev-&gt;modes =3D INDIO_=
DIRECT_MODE;<br>&gt; +&nbsp;&nbsp;&nbsp; err =3D iio_device_register(indio_=
dev);<br>&gt; +&nbsp;&nbsp;&nbsp; if (err) {<br>&gt; +&nbsp;&nbsp;&nbsp; &n=
bsp;&nbsp;&nbsp; dev_err(&amp;client-&gt;dev, "iio registration fails\n");<=
br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; goto exit_iio_free;<br>&gt; =
+&nbsp;&nbsp;&nbsp; }<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&g=
t; +exit_iio_free:<br>&gt; +&nbsp;&nbsp;&nbsp; iio_device_free(indio_dev);<=
br>&gt; +exit:<br>&gt; +&nbsp;&nbsp;&nbsp; return err;<br>&gt; +}<br>&gt; +=
<br>&gt; +static int cm3218_detect(struct i2c_client *client,<br>&gt; +&nbs=
p;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nb=
sp;  struct i2c_board_info *info)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; st=
ruct i2c_adapter *adapter =3D client-&gt;adapter;<br>&gt;
 +&nbsp;&nbsp;&nbsp; const char *name =3D NULL;<br>&gt; +<br>&gt; +&nbsp;&n=
bsp;&nbsp; cm3218_read_ara(client);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; i=
f (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))<br>&gt; +&n=
bsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ENODEV;<br><br>the driver needs=
 WORD_DATA<br>the check is after read_ara (which only needs BYTE_DATA)<br>w=
hat is read_ara() fails<br><br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; name =3D =
"cm3218";<br>&gt; +&nbsp;&nbsp;&nbsp; strlcpy(info-&gt;type, name, I2C_NAME=
_SIZE);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; =
+<br>&gt; +static int cm3218_remove(struct i2c_client *client)<br>&gt; +{<b=
r>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =3D i2c_get_clientdata=
(client);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; dev_dbg(&amp;client-&gt;dev=
, "%s()\n", __func__);<br>&gt; +&nbsp;&nbsp;&nbsp; iio_device_unregister(in=
dio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; iio_device_free(indio_dev);<br>&gt;
 +<br>&gt; +&nbsp;&nbsp;&nbsp; return 0;<br>&gt; +}<br>&gt; +<br>&gt; +#ifd=
ef CONFIG_PM_SLEEP<br>&gt; +static int cm3218_suspend(struct device *dev)<b=
r>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip *chip =3D iio_priv=
(dev_get_drvdata(dev));<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&a=
mp;chip-&gt;lock);<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; /* Since this driv=
er uses only polling commands, we are by default in<br>&gt; +&nbsp;&nbsp;&n=
bsp;  * auto shutdown (ie, power-down) mode.<br>&gt; +&nbsp;&nbsp;&nbsp;  *=
 So we do not have much to do here.<br>&gt; +&nbsp;&nbsp;&nbsp;  */<br>&gt;=
 +&nbsp;&nbsp;&nbsp; chip-&gt;suspended =3D true;<br>&gt; +<br>&gt; +&nbsp;=
&nbsp;&nbsp; mutex_unlock(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; =
return 0;<br>&gt; +}<br>&gt; +<br>&gt; +static int cm3218_resume(struct dev=
ice *dev)<br>&gt; +{<br>&gt; +&nbsp;&nbsp;&nbsp; struct iio_dev *indio_dev =
=3D dev_get_drvdata(dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct cm3218_chip
 *chip =3D iio_priv(indio_dev);<br>&gt; +&nbsp;&nbsp;&nbsp; struct i2c_clie=
nt *client =3D chip-&gt;client;<br>&gt; +&nbsp;&nbsp;&nbsp; int err;<br>&gt=
; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_lock(&amp;chip-&gt;lock);<br>&gt; +<b=
r>&gt; +&nbsp;&nbsp;&nbsp; err =3D cm3218_chip_init(client);<br>&gt; +&nbsp=
;&nbsp;&nbsp; if (!err)<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; chip=
-&gt;suspended =3D false;<br>&gt; +<br>&gt; +&nbsp;&nbsp;&nbsp; mutex_unloc=
k(&amp;chip-&gt;lock);<br>&gt; +&nbsp;&nbsp;&nbsp; return err;<br>&gt; +}<b=
r>&gt; +<br>&gt; +static SIMPLE_DEV_PM_OPS(cm3218_pm_ops, cm3218_suspend, c=
m3218_resume);<br>&gt; +#define CM3218_PM_OPS (&amp;cm3218_pm_ops)<br>&gt; =
+#else<br>&gt; +#define CM3218_PM_OPS NULL<br>&gt; +#endif<br>&gt; +<br>&gt=
; +static const struct i2c_device_id cm3218_id[] =3D {<br>&gt; +&nbsp;&nbsp=
;&nbsp; {"cm3218", 0},<br>&gt; +&nbsp;&nbsp;&nbsp; {}<br>&gt; +};<br>&gt; +=
<br>&gt; +MODULE_DEVICE_TABLE(i2c, cm3218_id);<br>&gt; +<br>&gt; +static co=
nst
 struct of_device_id cm3218_of_match[] =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; { =
.compatible =3D "invn,cm3218", },<br>&gt; +&nbsp;&nbsp;&nbsp; { },<br>&gt; =
+};<br>&gt; +MODULE_DEVICE_TABLE(of, cm3218_of_match);<br>&gt; +<br>&gt; +s=
tatic struct i2c_driver cm3218_driver =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; .cl=
ass&nbsp;&nbsp;&nbsp; =3D I2C_CLASS_HWMON,<br>&gt; +&nbsp;&nbsp;&nbsp; .dri=
ver&nbsp;&nbsp;&nbsp;  =3D {<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=
 &nbsp;&nbsp;&nbsp; .name =3D "cm3218",<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .pm =3D CM3218_PM_OPS,<br>&gt; +&nbsp;&nbsp;=
&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>&gt=
; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .of_match_table=
 =3D cm3218_of_match,<br>&gt; +&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;=
 &nbsp; },<br>&gt; +&nbsp;&nbsp;&nbsp; .probe&nbsp;&nbsp;&nbsp; &nbsp;&nbsp=
;&nbsp; =3D cm3218_probe,<br>&gt; +&nbsp;&nbsp;&nbsp; .remove&nbsp;&nbsp;&n=
bsp;
 &nbsp;&nbsp;&nbsp; =3D cm3218_remove,<br>&gt; +&nbsp;&nbsp;&nbsp; .id_tabl=
e&nbsp; &nbsp; &nbsp;  =3D cm3218_id,<br>&gt; +&nbsp;&nbsp;&nbsp; .detect&n=
bsp;&nbsp;&nbsp;  =3D cm3218_detect,<br>&gt; +&nbsp;&nbsp;&nbsp; .address_l=
ist&nbsp;  =3D normal_i2c,<br>&gt; +};<br>&gt; +module_i2c_driver(cm3218_dr=
iver);<br>&gt; +<br>&gt; +MODULE_DESCRIPTION("CM3218 Ambient Light Sensor d=
river");<br>&gt; +MODULE_LICENSE("GPL");<br>&gt; <br><br>-- <br><br>Peter M=
eerwald<br>+43-664-2444418 (mobile)<br><br><br></div> </div> </div>  </div>=
</body></html>
---1467812710-1501340236-1372926366=:99136--
