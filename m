Return-Path: <SRS0=rk2p=5L=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: test whoami against invalid
 values and do it first
Date: Tue, 6 Jun 2017 08:59:54 +0000
Message-ID: <BLUPR12MB06574B4197A3CCC8D6315251C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB06575D31F4F7233ED58923E1C4F30@BLUPR12MB0657.namprd12.prod.outlook.com>,<20170603094733.545ceda2@jic23.retrosnub.co.uk>
In-Reply-To: <20170603094733.545ceda2@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Saturday, June 3, 2017 10:47
>To: Jean-Baptiste Maneyrol
>Cc: linux-iio
>Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: test whoami against invalid=
 values and do it first
>  =20
>On Mon, 29 May 2017 13:17:14 +0000
>Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>
>> SPI bus is never generating error during transfer, so to check if
>> a chip is correctly connected on a SPI bus we enforce whoami check
>> to be correct.
>> In this way we can assure SPI probe is failing if there is no chip
>> connected.
>>=20
>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>Hi Jean-Baptiste,
>
>Sorry, I have just read back the previous emails and realised
>I wasn't being very clear.=A0 What I was suggesting was that we should
>check against all valid ids that are known, not just the one registered.
>So many of invensense's parts are 'nearly' compatible that it is
>common to get different revisions of boards using different versions.
>As such we are sure to break boards if we insist the code is right.
>(for starters I know there are DTSs out there for the beaglebone blue
>claiming it has a 9150 when it actually always has a 9250)
>
>So what I was looking for was a check over all valid IDs. Perhaps
>stick a warning in the log if the wrong one is found and fix up
>which chip info we are using.
>
>I'm afraid I thought this was what you meant when I agreed in
>the v1 thread, whereas it's clear you were thinking to enforce people
>getting it 'right!' (sadly something we know they don't always do).
>
>Jonathan
Hi Jonathan,

you're right, I misunderstood what you were meaning. Sorry about that.
Now it's crystal clear, thanks for the explanation.

I will do a patch v3 checking against all known ids and if there is a
mismatch, emit a warning and print the real chip name.

Thanks.
Jean-Baptiste

> ---
>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 21 +++++++++++----------
>=A0 1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..57b3442 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -774,23 +774,24 @@ static int inv_check_and_setup_chip(struct inv_mpu6=
050_state *st)
>=A0=A0=A0=A0=A0=A0=A0 st->hw=A0 =3D &hw_info[st->chip_type];
>=A0=A0=A0=A0=A0=A0=A0 st->reg =3D hw_info[st->chip_type].reg;
>=A0=20
> -=A0=A0=A0=A0 /* reset to make sure previous state are not there */
> -=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 INV_MPU6050_BIT_H_RESET);
> -=A0=A0=A0=A0 if (result)
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
> -=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
> -
>=A0=A0=A0=A0=A0=A0=A0 /* check chip self-identification */
>=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_read(st->map, INV_MPU6050_REG_WHOA=
MI, &regval);
>=A0=A0=A0=A0=A0=A0=A0 if (result)
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>=A0=A0=A0=A0=A0=A0=A0 if (regval !=3D st->hw->whoami) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->map)=
,
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 "whoami mismatch got %#02x expected %#02hhx for %s\n",
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 regval, st->hw->whoami, st->hw->name);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(regmap_get_device(st->map),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "invalid wh=
oami got %#02x expected %#02hhx for %s\n",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regval, st-=
>hw->whoami, st->hw->name);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENODEV;
>=A0=A0=A0=A0=A0=A0=A0 }
>=A0=20
> +=A0=A0=A0=A0 /* reset to make sure previous state are not there */
> +=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 INV_MPU6050_BIT_H_RESET);
> +=A0=A0=A0=A0 if (result)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
> +=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
> +
>=A0=A0=A0=A0=A0=A0=A0 /*
>=A0=A0=A0=A0=A0=A0=A0=A0 * toggle power state. After reset, the sleep bit =
could be on
>=A0=A0=A0=A0=A0=A0=A0=A0 * or off depending on the OTP settings. Toggling =
power would

    =
