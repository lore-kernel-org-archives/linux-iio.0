Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam01on0046.outbound.protection.outlook.com ([104.47.34.46]:64834
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752065AbdFLJSN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Jun 2017 05:18:13 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and against
 all known values
Date: Mon, 12 Jun 2017 09:18:11 +0000
Message-ID: <CY4PR1201MB0184D24BB25046C8B2883FB3C4CD0@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <BLUPR12MB06572FF309979BB42C095E07C4CB0@BLUPR12MB0657.namprd12.prod.outlook.com>,<20170611135844.7deb0c51@kernel.org>
In-Reply-To: <20170611135844.7deb0c51@kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


>From: Jonathan Cameron <jic23@kernel.org>
>Sent: Sunday, June 11, 2017 14:58
>To: Jean-Baptiste Maneyrol
>Cc: linux-iio
>Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: test whoami first and again=
st all known values
>  =20
>On Tue, 6 Jun 2017 10:29:52 +0000
>Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:
>
>> SPI bus is never generating error during transfer, so to check if
>> a chip is correctly connected on a SPI bus we enforce whoami check
>> to be correct. In this way we can assure SPI probe is failing if
>> there is no chip connected.
>>=20
>> Fixes: cec0154556f8 ("iio: inv_mpu6050: Check WHO_AM_I register on probe=
")
>> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
>> Cc: <stable@vger.kernel.org>
>Hi Jean-Baptiste.
>
>I'm happy with the patch, however it's a fix for an issue with a platform
>rather than the driver itself. That needs to be explained in the patch
>description.=A0 In particular do you have some examples we can list to
>justify the change?
>
>Otherwise, I'm thinking this is a 'nice to have' that wants to go via
>the next merge window rather than going in as a fix.
>
>Jonathan
Hi Jonathan,

I think that this is really a driver issue. Having a probe function that do=
esn't
return an error when there is no chip responding is more of a driver issue =
in my
own opinion. This makes things more difficult to debug it there is any hard=
ware
issue.

This is affecting our internal test platform which is completely custom. I
don't know if adding this example is interesting or not.

In any case, no problem with me to have this going only into the next merge
window.

Thanks for your review.
Jean-Baptiste
>> ---
>>=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 33 +++++++++++++++++++++=
+--------
>>=A0 1 file changed, 24 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_core.c
> index 96dabbd..af1b536 100644
>> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
>> @@ -770,27 +770,42 @@ static int inv_check_and_setup_chip(struct inv_mpu=
6050_state *st)
>>=A0 {
>>=A0=A0=A0=A0=A0=A0=A0 int result;
>>=A0=A0=A0=A0=A0=A0=A0 unsigned int regval;
>> +=A0=A0=A0=A0 int i;
>>=A0=20
>>=A0=A0=A0=A0=A0=A0=A0 st->hw=A0 =3D &hw_info[st->chip_type];
>>=A0=A0=A0=A0=A0=A0=A0 st->reg =3D hw_info[st->chip_type].reg;
>>=A0=20
>> -=A0=A0=A0=A0 /* reset to make sure previous state are not there */
>> -=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_H_RESET);
>> -=A0=A0=A0=A0 if (result)
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>> -=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
>> -
>>=A0=A0=A0=A0=A0=A0=A0 /* check chip self-identification */
>>=A0=A0=A0=A0=A0=A0=A0 result =3D regmap_read(st->map, INV_MPU6050_REG_WHO=
AMI, &regval);
>>=A0=A0=A0=A0=A0=A0=A0 if (result)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>>=A0=A0=A0=A0=A0=A0=A0 if (regval !=3D st->hw->whoami) {
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->map=
),
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "whoami mismatch got %#02x expected %#02hhx for %s\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* check whoami against all possib=
le values */
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 for (i =3D 0; i < INV_NUM_PARTS; +=
+i) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (regval=
 =3D=3D hw_info[i].whoami) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 dev_warn(regmap_get_device(st->map),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "whoami mismatch got %#02x (%s)"
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "expected %#02hhx (%s)\n",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regval, hw_info[i].name,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->hw->whoami, st->hw->name);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 break;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i >=3D INV_NUM_PARTS) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(re=
gmap_get_device(st->map),
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 "invalid whoami %#02x expected %#02hhx (%s)\n",
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 regval, st->hw->whoami, st->hw->name);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EN=
ODEV;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>>=A0=A0=A0=A0=A0=A0=A0 }
>>=A0=20
>> +=A0=A0=A0=A0 /* reset to make sure previous state are not there */
>> +=A0=A0=A0=A0 result =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_H_RESET);
>> +=A0=A0=A0=A0 if (result)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
>> +=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);
>> +
>>=A0=A0=A0=A0=A0=A0=A0 /*
>>=A0=A0=A0=A0=A0=A0=A0=A0 * toggle power state. After reset, the sleep bit=
 could be on
>>=A0=A0=A0=A0=A0=A0=A0=A0 * or off depending on the OTP settings. Toggling=
 power would
