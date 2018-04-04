Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0073.outbound.protection.outlook.com ([104.47.38.73]:23979
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751414AbeDDPIn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Apr 2018 11:08:43 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 2/2] iio: imu: inv_mpu6050: use set_power_itg function in
 i2c mux
Date: Wed, 4 Apr 2018 15:08:41 +0000
Message-ID: <CY4PR1201MB01842211DDAB2002860B7A75C4A40@CY4PR1201MB0184.namprd12.prod.outlook.com>
References: <CY4PR1201MB0184AB7010C925E3771F89D8C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR1201MB0184AB7010C925E3771F89D8C4A10@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Set power function is rewritten manually inside i2c mux select.
Better use the already identical existing function.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
=A0drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 33 ++++++++++++-------------=
------
=A01 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index fcd7a92..8a8a5bd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -29,25 +29,19 @@ static int inv_mpu6050_select_bypass(struct i2c_mux_cor=
e *muxc, u32 chan_id)
=A0{
=A0=A0=A0=A0=A0=A0=A0 struct iio_dev *indio_dev =3D i2c_mux_priv(muxc);
=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
-=A0=A0=A0=A0=A0=A0 int ret =3D 0;
+=A0=A0=A0=A0=A0=A0 int ret;

-=A0=A0=A0=A0=A0=A0 /* Use the same mutex which was used everywhere to prot=
ect power-op */
=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);
-=A0=A0=A0=A0=A0=A0 if (!st->powerup_count) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, s=
t->reg->pwr_mgmt_1, 0);
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ret)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto wr=
ite_error;

-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 usleep_range(INV_MPU6050_REG_UP=
_TIME_MIN,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_REG_UP_TIME_MAX);
-=A0=A0=A0=A0=A0=A0 }
-=A0=A0=A0=A0=A0=A0 if (!ret) {
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st->powerup_count++;
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, s=
t->reg->int_pin_cfg,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_INT_PIN_CFG |
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 INV_MPU6050_BIT_BYPASS_EN);
-=A0=A0=A0=A0=A0=A0 }
-write_error:
+=A0=A0=A0=A0=A0=A0 ret =3D inv_mpu6050_set_power_itg(st, true);
+=A0=A0=A0=A0=A0=A0 if (ret)
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto error_unlock;
+
+=A0=A0=A0=A0=A0=A0 ret =3D regmap_write(st->map, st->reg->int_pin_cfg,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 INV_MPU6050_INT_PIN_CFG |
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 INV_MPU6050_BIT_BYPASS_EN);
+
+error_unlock:
=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);

=A0=A0=A0=A0=A0=A0=A0 return ret;
@@ -59,12 +53,11 @@ static int inv_mpu6050_deselect_bypass(struct i2c_mux_c=
ore *muxc, u32 chan_id)
=A0=A0=A0=A0=A0=A0=A0 struct inv_mpu6050_state *st =3D iio_priv(indio_dev);

=A0=A0=A0=A0=A0=A0=A0 mutex_lock(&st->lock);
+
=A0=A0=A0=A0=A0=A0=A0 /* It doesn't really mattter, if any of the calls fai=
ls */
=A0=A0=A0=A0=A0=A0=A0 regmap_write(st->map, st->reg->int_pin_cfg, INV_MPU60=
50_INT_PIN_CFG);
-=A0=A0=A0=A0=A0=A0 st->powerup_count--;
-=A0=A0=A0=A0=A0=A0 if (!st->powerup_count)
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 regmap_write(st->map, st->reg->=
pwr_mgmt_1,
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 INV_MPU6050_BIT_SLEEP);
+=A0=A0=A0=A0=A0=A0 inv_mpu6050_set_power_itg(st, false);
+
=A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&st->lock);

=A0=A0=A0=A0=A0=A0=A0 return 0;
--
2.7.4
