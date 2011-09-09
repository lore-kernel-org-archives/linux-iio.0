Return-Path: <grundler@google.com>
MIME-Version: 1.0
In-Reply-To: <4E69D435.6040104@cam.ac.uk>
References: <20110906230533.GA5882@kroah.com>
	<1315558385-12879-1-git-send-email-jic23@cam.ac.uk>
	<4E69D435.6040104@cam.ac.uk>
Date: Fri, 9 Sep 2011 08:20:44 -0700
Message-ID: <CANEJEGtC-WZnoYnbHCFVmijvtJs=1M+zME-MXSze0hew8n2ZYQ@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] staging:iio:light: V3 fix out of bounds
 reg_cache[] access
From: Grant Grundler <grundler@google.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: greg@kroah.com, devel@linuxdriverproject.org, linux-iio@vger.kernel.org,
        bfreed@chromium.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Fri, Sep 9, 2011 at 1:54 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
> Grant, please take a quick look at this and check I didn't mess anything =
up.

Jonathan,
LGTM. I'm at LPC2011 now and don't have time to "compile test" this.
I'm pretty sure it's correct.

> Looks like a trivial context change was the issue, but best to be sure!

Agreed - thanks for fixing this up and reposting! :)

grant

>> V3 is a straightforward forward port to teh current tree of V2.
>>
>> Simple fix is to just not cache REG_TEST (offset 8).
>> Cache doesn't help REG_TEST anyway since we write all 8 bits exactly onc=
e
>> (at resume/init time).
>>
>> Also fix an "off-by-one" allocation of reg_cache[] array size that
>> was in the original code before I touched it.
>>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Signed-off-by: Grant Grundler <grundler@chromium.org>
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>> =C2=A0drivers/staging/iio/light/isl29018.c | =C2=A0 23 ++++++++++++++---=
------
>> =C2=A01 files changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/=
light/isl29018.c
>> index f31e8c2..3e9a06c 100644
>> --- a/drivers/staging/iio/light/isl29018.c
>> +++ b/drivers/staging/iio/light/isl29018.c
>> @@ -51,7 +51,7 @@
>>
>> =C2=A0#define ISL29018_REG_ADD_DATA_LSB =C2=A0 =C2=A00x02
>> =C2=A0#define ISL29018_REG_ADD_DATA_MSB =C2=A0 =C2=A00x03
>> -#define ISL29018_MAX_REGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ISL2=
9018_REG_ADD_DATA_MSB
>> +#define ISL29018_MAX_REGS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(ISL=
29018_REG_ADD_DATA_MSB+1)
>>
>> =C2=A0#define ISL29018_REG_TEST =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x08
>> =C2=A0#define ISL29018_TEST_SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00
>> @@ -70,22 +70,27 @@ struct isl29018_chip {
>> =C2=A0static int isl29018_write_data(struct i2c_client *client, u8 reg,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 u8 val, u8 mask, u8 shift)
>> =C2=A0{
>> - =C2=A0 =C2=A0 u8 regval;
>> - =C2=A0 =C2=A0 int ret =3D 0;
>> + =C2=A0 =C2=A0 u8 regval =3D val;
>> + =C2=A0 =C2=A0 int ret;
>> =C2=A0 =C2=A0 =C2=A0 struct isl29018_chip *chip =3D iio_priv(i2c_get_cli=
entdata(client));
>>
>> - =C2=A0 =C2=A0 regval =3D chip->reg_cache[reg];
>> - =C2=A0 =C2=A0 regval &=3D ~mask;
>> - =C2=A0 =C2=A0 regval |=3D val << shift;
>> + =C2=A0 =C2=A0 /* don't cache or mask REG_TEST */
>> + =C2=A0 =C2=A0 if (reg < ISL29018_MAX_REGS) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval =3D chip->reg_cache[r=
eg];
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval &=3D ~mask;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regval |=3D val << shift;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 ret =3D i2c_smbus_write_byte_data(client, reg, regv=
al);
>> =C2=A0 =C2=A0 =C2=A0 if (ret) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&client->dev, "=
Write to device fails status %x\n", ret);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
>> + =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* don't update cache on err=
 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (reg < ISL29018_MAX_REGS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
chip->reg_cache[reg] =3D regval;
>> =C2=A0 =C2=A0 =C2=A0 }
>> - =C2=A0 =C2=A0 chip->reg_cache[reg] =3D regval;
>>
>> - =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 return ret;
>> =C2=A0}
>>
>> =C2=A0static int isl29018_set_range(struct i2c_client *client, unsigned =
long range,
>
>
