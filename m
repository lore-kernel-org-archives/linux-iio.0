Return-Path: <grundler@google.com>
MIME-Version: 1.0
Sender: grundler@google.com
In-Reply-To: <1334834109-30183-3-git-send-email-ldewangan@nvidia.com>
References: <1334834109-30183-1-git-send-email-ldewangan@nvidia.com>
	<1334834109-30183-3-git-send-email-ldewangan@nvidia.com>
Date: Thu, 19 Apr 2012 10:52:23 -0700
Message-ID: <CANEJEGtvfwUmtXjsu_PTWP2zCRAbYMJh_jJp-c6Ex2ca=Sietg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] staging: iio: light: isl29018: use regmap for
 register access
From: Grant Grundler <grundler@chromium.org>
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: jic23@cam.ac.uk, gregkh@linuxfoundation.org, max@stro.at,
	jbrenner@taosinc.com, bfreed@chromium.org, lars@metafoo.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Apr 19, 2012 at 4:15 AM, Laxman Dewangan <ldewangan@nvidia.com> wro=
te:
> Using regmap for accessing register through i2c bus. This will
> remove the code for caching registers, read-modify-write logics.
> Also it will provide the debugfs feature to dump register
> through regmap debugfs.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Reviewed-by: Grant Grundler <grundler@chromium.org>

Laxman,
Thanks for reposting this patch. I was talking with Bryan Freed and it
looks like the caching of registers will change the usage of
ADD_COMMAND1. More details below.

...
> -static int isl29018_write_data(struct i2c_client *client, u8 reg,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 u8 val, u8 mask, u8 shift)
> -{
> - =C2=A0 =C2=A0 =C2=A0 u8 regval =3D val;
> - =C2=A0 =C2=A0 =C2=A0 int ret;
> - =C2=A0 =C2=A0 =C2=A0 struct isl29018_chip *chip =3D iio_priv(i2c_get_cl=
ientdata(client));
> -
> - =C2=A0 =C2=A0 =C2=A0 /* don't cache or mask REG_TEST */
> - =C2=A0 =C2=A0 =C2=A0 if (reg < ISL29018_MAX_REGS) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D chip->reg_c=
ache[reg];
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval &=3D ~mask;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval |=3D val << shi=
ft;
> - =C2=A0 =C2=A0 =C2=A0 }

Note the only REG_TEST isn't cached. Everything else updates the cache
on write.

> -
> - =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_byte_data(client, reg, reg=
val);
> - =C2=A0 =C2=A0 =C2=A0 if (ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, =
"Write to device fails status %x\n", ret);
> - =C2=A0 =C2=A0 =C2=A0 } else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* don't update cache =
on err */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg < ISL29018_MAX=
_REGS)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 chip->reg_cache[reg] =3D regval;
> - =C2=A0 =C2=A0 =C2=A0 }
> -
> - =C2=A0 =C2=A0 =C2=A0 return ret;
> -}

...
> -static int isl29018_read_sensor_input(struct i2c_client *client, int mod=
e)
> +static int isl29018_read_sensor_input(struct isl29018_chip *chip, int mo=
de)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int status;
> - =C2=A0 =C2=A0 =C2=A0 int lsb;
> - =C2=A0 =C2=A0 =C2=A0 int msb;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int lsb;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int msb;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set mode */
> - =C2=A0 =C2=A0 =C2=A0 status =3D isl29018_write_data(client, ISL29018_RE=
G_ADD_COMMAND1,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 mode, COMMMAND1_OPMODE_MASK, COMMMAND1_OPMODE_SHIFT);
> + =C2=A0 =C2=A0 =C2=A0 status =3D regmap_update_bits(chip->regmap, ISL290=
18_REG_ADD_COMMAND1,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 COMMMAND1_OPMODE_MASK, mode << COMMMAND1_OPMODE_SHIFT);

The old code will do a single I2C write. The new code will do a
read+write for ADD_COMMAND1 register. I reviewed the behaviors in
drivers/base/regmap/regmap.c and regcache.c.

I can't judge if this is a "real" problem. Given the limited BW on
I2C, someone with more I2C experience should carefully consider and
share their opinion.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (status) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, =
"Error in setting operating mode\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(chip->dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "Error in setting operating mode err %d\n", status);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return status;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0msleep(CONVERSION_TIME_MS);
> - =C2=A0 =C2=A0 =C2=A0 lsb =3D i2c_smbus_read_byte_data(client, ISL29018_=
REG_ADD_DATA_LSB);

Old code for DATA_LSB and DATA_MSB ignored the "write cache" for reads
- so marking these as volatile looks correct to me.

...
> +static bool is_volatile_reg(struct device *dev, unsigned int reg)
> +{
> + =C2=A0 =C2=A0 =C2=A0 switch (reg) {
> + =C2=A0 =C2=A0 =C2=A0 case ISL29018_REG_ADD_DATA_LSB:
> + =C2=A0 =C2=A0 =C2=A0 case ISL29018_REG_ADD_DATA_MSB:
> + =C2=A0 =C2=A0 =C2=A0 case ISL29018_REG_ADD_COMMAND1:
> + =C2=A0 =C2=A0 =C2=A0 case ISL29018_REG_TEST:

Of these four, I think only ADD_COMMAND1 wasn't treated as volatile in
the old code. Am I overlooking something?

My concern is only about the additional I2C read traffic this patch
might generate. It's possible *some* bits in that register are
volatile and we could previously ignore them.

cheers,
grant
