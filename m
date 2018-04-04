Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0046.outbound.protection.outlook.com ([104.47.41.46]:17591
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751412AbeDDPHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Apr 2018 11:07:25 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/2] iio: imu: inv_mpu6050: clean set_power_itg and fix
 usage
Date: Wed, 4 Apr 2018 15:07:22 +0000
Message-ID: <CY4PR1201MB0184AE5EB297A0621275BAAEC4A40@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184E53EA4D1632786ED4CE8C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0184E53EA4D1632786ED4CE8C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rewrite set_power_itg. Failing when turning power off is
no more decreasing the counter now and sleeping only happens
when effectively turning the chip on. Fix also usage in init
function (setting power on one time is sufficient to ensure
chip is effectively on).

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 44 ++++++++++++++++--------=
------
=A01 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 7d64be3..f17fbfa 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -185,26 +185,29 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_stat=
e *st, bool en, u32 mask)

=A0int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_o=
n)
=A0{
-=A0=A0=A0=A0=A0=A0 int result =3D 0;
+=A0=A0=A0=A0=A0=A0 int result;

=A0=A0=A0=A0=A0=A0=A0 if (power_on) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->powerup_count)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->powerup_count) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resul=
t =3D regmap_write(st->map, st->reg->pwr_mgmt_1, 0);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->pow=
erup_count++;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (res=
ult)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_=
range(INV_MPU6050_REG_UP_TIME_MIN,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count++;
=A0=A0=A0=A0=A0=A0=A0 } else {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count--;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!st->powerup_count)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (st->powerup_count =3D=3D 1)=
 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resul=
t =3D regmap_write(st->map, st->reg->pwr_mgmt_1,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BI=
T_SLEEP);
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (res=
ult)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count--;
=A0=A0=A0=A0=A0=A0=A0 }

-=A0=A0=A0=A0=A0=A0 if (result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
-
-=A0=A0=A0=A0=A0=A0 if (power_on)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(INV_MPU6050_REG_UP=
_TIME_MIN,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);
+=A0=A0=A0=A0=A0=A0 dev_dbg(regmap_get_device(st->map), "set power %d, coun=
t=3D%u\n",
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 power_on, st->powerup_count);

=A0=A0=A0=A0=A0=A0=A0 return 0;
=A0}
@@ -850,14 +853,11 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
=A0=A0=A0=A0=A0=A0=A0 msleep(INV_MPU6050_POWER_UP_TIME);

=A0=A0=A0=A0=A0=A0=A0 /*
-=A0=A0=A0=A0=A0=A0=A0 * toggle power state. After reset, the sleep bit cou=
ld be on
-=A0=A0=A0=A0=A0=A0=A0 * or off depending on the OTP settings. Toggling pow=
er would
+=A0=A0=A0=A0=A0=A0=A0 * Turn power on. After reset, the sleep bit could be=
 on
+=A0=A0=A0=A0=A0=A0=A0 * or off depending on the OTP settings. Turning powe=
r on
=A0=A0=A0=A0=A0=A0=A0=A0 * make it in a definite state as well as making th=
e hardware
=A0=A0=A0=A0=A0=A0=A0=A0 * state align with the software state
=A0=A0=A0=A0=A0=A0=A0=A0 */
-=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, false);
-=A0=A0=A0=A0=A0=A0 if (result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_set_power_itg(st, true);
=A0=A0=A0=A0=A0=A0=A0 if (result)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
@@ -865,13 +865,17 @@ static int inv_check_and_setup_chip(struct inv_mpu605=
0_state *st)
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, false,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BIT_PWR_ACC=
L_STBY);
=A0=A0=A0=A0=A0=A0=A0 if (result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;
=A0=A0=A0=A0=A0=A0=A0 result =3D inv_mpu6050_switch_engine(st, false,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BIT_PWR_GYR=
O_STBY);
=A0=A0=A0=A0=A0=A0=A0 if (result)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return result;
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_power_off;

-=A0=A0=A0=A0=A0=A0 return 0;
+=A0=A0=A0=A0=A0=A0 return inv_mpu6050_set_power_itg(st, false);
+
+error_power_off:
+=A0=A0=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);
+=A0=A0=A0=A0=A0=A0 return result;
=A0}

=A0int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
--
2.7.4
