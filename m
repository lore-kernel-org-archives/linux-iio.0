Return-Path: <SRS0=MX92=4X=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values
 and do it first
Date: Wed, 17 May 2017 15:03:37 +0000
Message-ID: <BLUPR12MB06573DAB544C2B6C067587C4C4E70@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>
 <e90a537f-3eb8-2075-9c1d-393890ad1c3c@kernel.org>
 <BLUPR12MB0657D4E46506A1BED6430FCEC4E10@BLUPR12MB0657.namprd12.prod.outlook.com>,<d7b3b09c-2b4e-d8c5-b0c5-62c18d162091@kernel.org>
In-Reply-To: <d7b3b09c-2b4e-d8c5-b0c5-62c18d162091@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Tuesday, May 16, 2017 20:06
>To: Jean-Baptiste Maneyrol; linux-iio@vger.kernel.org
>Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid va=
lues and do it first
>=A0  =20
>On 15/05/17 09:42, Jean-Baptiste Maneyrol wrote:
>> Hello,
>>=20
>> this is mainly useful for our test platforms where we want to support
>> both I2C and SPI configuration with the same kernel image. For that
>> purpose we declare 2 chips, 1 on I2C and 1 on SPI bus. But on the
>> hardware there is only 1 chip connected (you can plug it in a I2C or
>> SPI slot as required). And we expect the driver probe to fail
>> properly when there is no chip connected on the corresponding bus
>> (wasn't the case with SPI version).
>>=20
>> In any case if there is a SPI wiring issue somewhere, it is useful to
>> have the driver probe failing correctly and reporting the issue.
>> Since SPI transfer are not acked, there always will be a response for
>> every transaction even if there is no chip behind (this is 0x00 on my
>> platform, I don't know if there is some "standard" response here).
>> That's why I am testing whoami reading against these values to ensure
>> there is a real chip behind.
>>=20
>> I think it is useful to keep the check against ID not preventing the
>> driver probe to succeed. We have a lot of similar chips with
>> different IDs, so it can be helpful. Otherwise, I can switch to
>> checking against ID and add all known IDs.
>That would be be my preference.=A0 Check against all known and
>report but don't fail on the 'it is the wrong one' case we
>all know happens out in the wild!
>
>Jonathan
>
>p.s. Please don't top post and please wrap lines at 80 chars.
>I've just broken some threading email clients by wrapping
>it in this reply... (minor point!)

We agree on this point, but we are digressing from the issue.
Sorry my explanations were a bit too long.

The main point is that the SPI driver probe is not failing when
there is no chip connected or when the wiring is broken.
This is a blocking issue for my use case and not very clean anyway.
The problem is that SPI transactions are never failing even if there is
a transfer problem. That's not the case with I2C where every
transactions are acked.

My solution is to read whoami and test if the value is clearly invalid
(0x00 or 0xff are obvious invalid whoami that will be never used in any
invensense chips, and are possible return values for a
not working SPI wiring). So that we are not blocking the driver probe for
future possible whoami.

Is this approach correct for you? Otherwise if you have a better idea,
it would be welcome.

Thanks for your help.

JB

P.S.: Hope this e-mail is OK. I'm stuck with Outlook WebApp,
but that's not that bad to use.

>>=20
>> Thanks. Jean-Baptiste
>>=20
>> From: Jonathan Cameron <jic23@kernel.org>
>> Sent: Sunday, May 14, 2017 16:49
>> To: Jean-Baptiste Maneyrol; linux-iio@vger.kernel.org
>> Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid =
values and do it first
>>=A0=A0=A0=A0=A0=20
>> On 12/05/17 13:45, Jean-Baptiste Maneyrol wrote:
>>> SPI bus is never generating error during transfer, so a simple way to c=
heck
>>> if a chip is correctly connected on a SPI bus is to check a fixed value=
 like
>>> whoami against valid values. 0x00 or 0xff can never happened. It is bet=
ter
>>> to do this test first since if there is a problem with a DTS and an inc=
orrect
>>> chip is wired instead, a write can be more damaging than a read.
>>>
>>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>> Hmm. I'd a little unsure on this one.=A0 If we start getting into the
>> general game of protecting against every wrong DTS it may be a slippery
>> slope.
>>=20
>> Is there an actual platform out there that you know of that this will
>> protect?=A0 If so I can probably be persuaded.
>>=20
>> If not I would actually prefer if we checked against the specified ID
>> rather than relying on a different chip producing either high or low
>> consistently when hit with this query.
>>=20
>> So perhaps make the ID check a failure if it doesn't match any of the
>> supported parts?=A0 Bit of a pain for new devices as they won't work
>> immediately but conversely protects them against issues due to incorrect
>> identification as well.
>>=20
>> Jonathan
>>=20
>>> ---
>>=A0=A0=A0=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++=
-------
>>=A0=A0=A0=A0 1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_core.c
>> index 96dabbd..42fb135 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -774,23 +774,28 @@ static int inv_check_and_setup_chip(struct inv_mpu=
6050_state *st)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->hw=A0 =3D &hw_info[st->chip_type];
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->reg =3D hw_info[st->chip_type].reg;
>>=A0=A0=A0=A0=20
>> -=A0=A0=A0=A0 /* reset to make sure previous state are not there */
>> -=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_H_RESET);
>> -=A0=A0=A0=A0 if (result)
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>> -=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
>> -
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* check chip self-identification */
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_read(st->map, INV_MPU6050_R=
EG_WHOAMI, &regval);
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (result)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (regval !=3D st->hw->whoami) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (regval =3D=3D 0x00 || regval =
=3D=3D 0xff) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(re=
gmap_get_device(st->map),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "invalid whoami probably io error\n=
");
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EI=
O;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_d=
evice(st->map),
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 "whoami mismatch got %#02x expected %#02hhx for=
 %s\n",
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 regval, st->hw->whoami, st->hw->name);
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>=A0=A0=A0=A0=20
>> +=A0=A0=A0=A0 /* reset to make sure previous state are not there */
>> +=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_H_RESET);
>> +=A0=A0=A0=A0 if (result)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>> +=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
>> +
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * toggle power state. After reset, the sle=
ep bit could be on
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * or off depending on the OTP settings. To=
ggling power would
>>
>=20
>=A0=A0=A0=A0=A0=20
>=20

    =
