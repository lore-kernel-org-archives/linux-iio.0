Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeEFQpc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 May 2018 12:45:32 -0400
Date: Sun, 6 May 2018 17:45:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: mag3110: Add ability to run in
 continuous mode
Message-ID: <20180506174527.69bc8fb0@archlinux>
In-Reply-To: <f9675638-e5d4-481e-6061-a678f5325cec@electromag.com.au>
References: <cc70f548-7c42-25a3-e908-b24ed8156c69@electromag.com.au>
        <f9675638-e5d4-481e-6061-a678f5325cec@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 30 Apr 2018 17:53:54 +0800
Richard Tresidder <rtresidd@electromag.com.au> wrote:

> Hi
> Again sorry had maintainer wrong...
If that happens, don't resend, just reply ccing the maintainer.
Sometimes the maintainer may then ask you to resend.  Right now all
I got was a cryptic mess of patches when they turned up in my email
client.

Note, when a patch is applied all the text above the --- goes into
the commit log for ever more.  Hence any side comments like this should
be below the --- cut line.  That is also where version change logs etc
belong.

Also this has nothing to do with your other patch (at least they should
not be in the same series.)  If you didn't want to put them in a single
series then it should have numbered patches and a cover letter.
As it is, we just have the two different sets overlapping because
you sent the second one as a reply.

> =C2=A0=C2=A0 This patch adds the ability to run the Mag3110 in continuous=
 mode to
> speed up the sampling rate.
> Depending on the sampling rate requested the device can be put in or out
> of continuous mode automatically.
> Shifting out of continuous mode requires a potential 1 / ODR wait which
> is also implemented
> This part is largely based on the mma8542 driver implementation.
>=20
> Also modified the sleep method when data is not ready to allow for
> sampling > 50sps to work.
> This is similar to my other recent patch regarding the mma8452 driver.
>=20
> Have tested upto 80sps using hr timer and iio buffer
>=20
> Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
Again, I think the fundamental change is good, but as you suggested
in the other patch, you should be sticking to just that change
not a mixture of 'tidy' ups and the real change.

Thanks,

Jonathan
> ---
> diff --git a/drivers/iio/magnetometer/mag3110.c
> b/drivers/iio/magnetometer/mag3110.c
> index b34ace7..7cdd185 100644
> --- a/drivers/iio/magnetometer/mag3110.c
> +++ b/drivers/iio/magnetometer/mag3110.c
> @@ -26,6 +26,7 @@
> =C2=A0#define MAG3110_OUT_Y 0x03
> =C2=A0#define MAG3110_OUT_Z 0x05
> =C2=A0#define MAG3110_WHO_AM_I 0x07
> +#define MAG3110_SYSMOD 0x08
> =C2=A0#define MAG3110_OFF_X 0x09 /* MSB first */
> =C2=A0#define MAG3110_OFF_Y 0x0b
> =C2=A0#define MAG3110_OFF_Z 0x0d
> @@ -39,6 +40,8 @@
> =C2=A0#define MAG3110_CTRL_DR_SHIFT 5
> =C2=A0#define MAG3110_CTRL_DR_DEFAULT 0
> =C2=A0
> +#define MAG3110_SYSMOD_MODE_MASK (BIT(1) | BIT(0))
GENMASK not combination of two individual bits.  That would
have been fine if they had independent uses but they don't so
this needs fixing.

> +
> =C2=A0#define MAG3110_CTRL_TM BIT(1) /* trigger single measurement */
> =C2=A0#define MAG3110_CTRL_AC BIT(0) /* continuous measurements */
> =C2=A0
> @@ -52,26 +55,35 @@ struct mag3110_data {
> =C2=A0=C2=A0=C2=A0=C2=A0 struct i2c_client *client;
> =C2=A0=C2=A0=C2=A0=C2=A0 struct mutex lock;
> =C2=A0=C2=A0=C2=A0=C2=A0 u8 ctrl_reg1;
> +=C2=A0=C2=A0=C2=A0 int sleep_val;
> =C2=A0};
> =C2=A0
> =C2=A0static int mag3110_request(struct mag3110_data *data)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 int ret, tries =3D 150;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 /* trigger measurement */
> -=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client, MAG31=
10_CTRL_REG1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 | MAG3110_CTR=
L_TM);
> -=C2=A0=C2=A0=C2=A0 if (ret < 0)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> +=C2=A0=C2=A0=C2=A0 if ((data->ctrl_reg1 & MAG3110_CTRL_AC) =3D=3D 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* trigger measurement */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_=
data(data->client, MAG3110_CTRL_REG1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data-=
>ctrl_reg1 | MAG3110_CTRL_TM);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> +=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 while (tries-- > 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_b=
yte_data(data->client, MAG3110_STATUS);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_e=
rr(&data->client->dev, "i2c error\n");

Don't introduce new error messages into existing code paths.  Definitely
don't do it in a patch making more substantial changes elsewhere.
It just distracts from the important stuff.


> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for data ready */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((ret & MAG3110_STATU=
S_DRDY) =3D=3D MAG3110_STATUS_DRDY)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep(20);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->sleep_val <=3D 20)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uslee=
p_range(data->sleep_val * 250, data->sleep_val * 500);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mslee=
p(20);
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 if (tries < 0) {
> @@ -100,7 +112,7 @@ static int mag3110_read(struct mag3110_data *data,
> __be16 buf[3])
> =C2=A0}
> =C2=A0
> =C2=A0static ssize_t mag3110_show_int_plus_micros(char *buf,
> -=C2=A0=C2=A0=C2=A0 const int (*vals)[2], int n)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const in=
t (*vals)[2], int n)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 size_t len =3D 0;
> =C2=A0
> @@ -115,7 +127,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
> =C2=A0}
> =C2=A0
> =C2=A0static int mag3110_get_int_plus_micros_index(const int (*vals)[2], =
int n,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
t val, int val2)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 while (n-- > 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val =3D=3D vals[n][0=
] && val2 =3D=3D vals[n][1])
> @@ -130,7 +142,8 @@ static int mag3110_get_int_plus_micros_index(const
> int (*vals)[2], int n,
> =C2=A0};
> =C2=A0
> =C2=A0static ssize_t mag3110_show_samp_freq_avail(struct device *dev,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 struct device_attribute *attr, char *buf)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct d=
evice_attribute *attr,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *bu=
f)

Not in this patch same for any more of these above this point.

> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 return mag3110_show_int_plus_micros(buf, mag3110=
_samp_freq, 8);
> =C2=A0}
> @@ -138,12 +151,118 @@ static ssize_t
> mag3110_show_samp_freq_avail(struct device *dev,
> =C2=A0static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(mag3110_show_samp_freq_avail);
> =C2=A0
> =C2=A0static int mag3110_get_samp_freq_index(struct mag3110_data *data,
> -=C2=A0=C2=A0=C2=A0 int val, int val2)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int val, int v=
al2)

This sort of tidy up doesn't not belong in any patch making a functional
change.

> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 return mag3110_get_int_plus_micros_index(mag3110=
_samp_freq, 8, val,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val2);
> =C2=A0}
> =C2=A0
> +static int mag3110_calculate_sleep(struct mag3110_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 int ret, i =3D data->ctrl_reg1 >> MAG3110_CTRL_DR_SHI=
FT;
> +
> +=C2=A0=C2=A0=C2=A0 if(mag3110_samp_freq[i][0] > 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1000 / mag3110_samp_f=
req[i][0];
> +=C2=A0=C2=A0=C2=A0 else
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 1000;
> +
> +=C2=A0=C2=A0=C2=A0 return ret =3D=3D 0 ? 1 : ret;
> +}
> +
> +static int mag3110_standby(struct mag3110_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 return i2c_smbus_write_byte_data(data->client, MAG311=
0_CTRL_REG1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 & ~MAG3110=
_CTRL_AC);
> +}
> +
> +static int mag3110_wait_standby(struct mag3110_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 int ret, tries =3D 30;
> +
> +=C2=A0=C2=A0=C2=A0 /* Takes up to 1/ODR to come out of active mode into =
stby
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Longest expected period=
 is 12.5seconds. We'll sleep for 500ms
> between checks*/

Please run checkpatch.pl over your patches.  I expect it will complain
about this comment.  Coding style is very rigorous in the kernel and
this isn't how we do multiline comments.

> +=C2=A0=C2=A0=C2=A0 while (tries-- > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_byte_d=
ata(data->client, MAG3110_SYSMOD);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_e=
rr(&data->client->dev, "i2c error\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* wait for standby */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((ret & MAG3110_SYSMOD_MOD=
E_MASK) =3D=3D 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msleep_interruptible(500);
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (tries < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_err(&data->client->dev, "=
device not entering standby mode\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 return 0;
> +}
> +
> +static int mag3110_active(struct mag3110_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 return i2c_smbus_write_byte_data(data->client, MAG311=
0_CTRL_REG1,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1);
This little wrapper doesn't add anything - if anything it makes
it a little harder to review as the reviewer has to come find it to
see what the call is doing.

Just put the i2c write inline where you are currently calling this
function.

> +}
> +
> +/* returns >0 if active, 0 if in standby and <0 on error */
> +static int mag3110_is_active(struct mag3110_data *data)
> +{
> +=C2=A0=C2=A0=C2=A0 int reg;
> +
> +=C2=A0=C2=A0=C2=A0 reg =3D i2c_smbus_read_byte_data(data->client, MAG311=
0_CTRL_REG1);
> +=C2=A0=C2=A0=C2=A0 if (reg < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return reg;
> +
> +=C2=A0=C2=A0=C2=A0 return reg & MAG3110_CTRL_AC;
> +}
> +
> +static int mag3110_change_config(struct mag3110_data *data, u8 reg, u8 v=
al)
> +{
> +=C2=A0=C2=A0=C2=A0 int ret;
> +=C2=A0=C2=A0=C2=A0 int is_active;
> +
> +=C2=A0=C2=A0=C2=A0 mutex_lock(&data->lock);
> +
> +=C2=A0=C2=A0=C2=A0 is_active =3D mag3110_is_active(data);
> +=C2=A0=C2=A0=C2=A0 if (is_active < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D is_active;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* config can only be changed when in standby */
> +=C2=A0=C2=A0=C2=A0 if (is_active > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mag3110_standby(data);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
fail;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 /* After coming out of active we must wait for the pa=
rt to
> transition to STBY
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This can take up to 1 /ODR to occur=
 */

Wrong comment style.

> +=C2=A0=C2=A0=C2=A0 ret =3D mag3110_wait_standby(data);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(data->client, reg, =
val);
> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto fail;
> +
> +=C2=A0=C2=A0=C2=A0 if (is_active > 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mag3110_active(data);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto =
fail;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D 0;
> +fail:
> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->lock);
> +
> +=C2=A0=C2=A0=C2=A0 return ret;
> +}
> +
> =C2=A0static int mag3110_read_raw(struct iio_dev *indio_dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> @@ -235,11 +354,13 @@ static int mag3110_write_raw(struct iio_dev
> *indio_dev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ret =3D -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
break;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> -

Clean out any unrelated white space changes.

> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 &=3D ~MAG3110=
_CTRL_DR_MASK;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 &=3D ~MAG3110=
_CTRL_DR_MASK & ~MAG3110_CTRL_AC;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 |=3D rat=
e << MAG3110_CTRL_DR_SHIFT;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_=
data(data->client,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MAG31=
10_CTRL_REG1, data->ctrl_reg1);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->sleep_val =3D mag3110_c=
alculate_sleep(data);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (data->sleep_val < 40)

Why 40?

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data-=
>ctrl_reg1 |=3D MAG3110_CTRL_AC;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D mag3110_change_config=
(data, MAG3110_CTRL_REG1,
> data->ctrl_reg1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> =C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_CALIBBIAS:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val < -10000 || val =
> 10000) {
> @@ -337,12 +458,6 @@ static irqreturn_t mag3110_trigger_handler(int irq,
> void *p)
> =C2=A0
> =C2=A0static const unsigned long mag3110_scan_masks[] =3D {0x7, 0xf, 0};
> =C2=A0
> -static int mag3110_standby(struct mag3110_data *data)
> -{
> -=C2=A0=C2=A0=C2=A0 return i2c_smbus_write_byte_data(data->client, MAG311=
0_CTRL_REG1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 & ~MAG3110_CT=
RL_AC);
> -}
> -
> =C2=A0static int mag3110_probe(struct i2c_client *client,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 const struct i2c_device_id *id)
> =C2=A0{
> @@ -374,8 +489,11 @@ static int mag3110_probe(struct i2c_client *client,
> =C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->available_scan_masks =3D mag3110_scan=
_masks;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 =3D MAG3110_CTRL_DR_DEFAULT << M=
AG3110_CTRL_DR_SHIFT;
> -=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_byte_data(client, MAG3110_CTR=
L_REG1,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1);
> +=C2=A0=C2=A0=C2=A0 data->sleep_val =3D mag3110_calculate_sleep(data);
> +=C2=A0=C2=A0=C2=A0 if (data->sleep_val < 40)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data->ctrl_reg1 |=3D MAG3110_=
CTRL_AC;
> +
> +=C2=A0=C2=A0=C2=A0 ret =3D mag3110_change_config(data, MAG3110_CTRL_REG1=
, data->ctrl_reg1);
> =C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> =C2=A0
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=C2=A0 http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

