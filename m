Return-Path: <SRS0=UkXy=4V=invensense.com=JManeyrol@kernel.org>
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid values
 and do it first
Date: Mon, 15 May 2017 08:42:49 +0000
Message-ID: <BLUPR12MB0657D4E46506A1BED6430FCEC4E10@BLUPR12MB0657.namprd12.prod.outlook.com>
References: <BLUPR12MB0657CCC7922C6655D88C9FB0C4E20@BLUPR12MB0657.namprd12.prod.outlook.com>,<e90a537f-3eb8-2075-9c1d-393890ad1c3c@kernel.org>
In-Reply-To: <e90a537f-3eb8-2075-9c1d-393890ad1c3c@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hello,

this is mainly useful for our test platforms where we want to support both =
I2C and SPI configuration with the same kernel image. For that purpose we d=
eclare 2 chips, 1 on I2C and 1 on SPI bus. But on the hardware there is onl=
y 1 chip connected (you can plug it in a I2C or SPI slot as required). And =
we expect the driver probe to fail properly when there is no chip connected=
 on the corresponding bus (wasn't the case with SPI version).

In any case if there is a SPI wiring issue somewhere, it is useful to have =
the driver probe failing correctly and reporting the issue. Since SPI trans=
fer are not acked, there always will be a response for every transaction ev=
en if there is no chip behind (this is 0x00 on my platform, I don't know if=
 there is some "standard" response here). That's why I am testing whoami re=
ading against these values to ensure there is a real chip behind.

I think it is useful to keep the check against ID not preventing the driver=
 probe to succeed. We have a lot of similar chips with different IDs, so it=
 can be helpful. Otherwise, I can switch to checking against ID and add all=
 known IDs.

Thanks.
Jean-Baptiste

From: Jonathan Cameron <jic23@kernel.org>
Sent: Sunday, May 14, 2017 16:49
To: Jean-Baptiste Maneyrol; linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: test whoami against invalid val=
ues and do it first
=A0  =20
On 12/05/17 13:45, Jean-Baptiste Maneyrol wrote:
> SPI bus is never generating error during transfer, so a simple way to che=
ck
> if a chip is correctly connected on a SPI bus is to check a fixed value l=
ike
> whoami against valid values. 0x00 or 0xff can never happened. It is bette=
r
> to do this test first since if there is a problem with a DTS and an incor=
rect
> chip is wired instead, a write can be more damaging than a read.
>=20
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Hmm. I'd a little unsure on this one.=A0 If we start getting into the
general game of protecting against every wrong DTS it may be a slippery
slope.

Is there an actual platform out there that you know of that this will
protect?=A0 If so I can probably be persuaded.

If not I would actually prefer if we checked against the specified ID
rather than relying on a different chip producing either high or low
consistently when hit with this query.

So perhaps make the ID check a failure if it doesn't match any of the
supported parts?=A0 Bit of a pain for new devices as they won't work
immediately but conversely protects them against issues due to incorrect
identification as well.

Jonathan

> ---
>=A0=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 19 ++++++++++++-------
>=A0=A0 1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu=
/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..42fb135 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -774,23 +774,28 @@ static int inv_check_and_setup_chip(struct inv_mpu6=
050_state *st)
>=A0=A0=A0=A0=A0=A0=A0 st->hw=A0 =3D &hw_info[st->chip_type];
>=A0=A0=A0=A0=A0=A0=A0 st->reg =3D hw_info[st->chip_type].reg;
>=A0=A0=20
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
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (regval =3D=3D 0x00 || regval =
=3D=3D 0xff) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(reg=
map_get_device(st->map),
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "invalid whoami probably io error\n");
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EIO=
;
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(s=
t->map),
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 "whoami mismatch got %#02x expected %#02hhx for %s\n"=
,
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regval, st->hw->whoami, st->hw->name);
>=A0=A0=A0=A0=A0=A0=A0 }
>=A0=A0=20
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
>=20

    =
