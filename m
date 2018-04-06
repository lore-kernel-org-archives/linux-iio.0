Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:46910
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751344AbeDFIFK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Apr 2018 04:05:10 -0400
From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: [PATCH] iio: imu: inv_mpu6050: use devm_* at init and delete remove
Date: Fri, 6 Apr 2018 08:05:07 +0000
Message-ID: <CY4PR1201MB0184436AEE0F374831D9BDFFC4BA0@CY4PR1201MB0184.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use devm_* for iio_triggered_buffer_setup, iio_device_register,
iio_trigger_register. Delete unneeded inv_mpu6050_remove_trigger,
inv_mpu_core_remove, and inv_mpu_remove for spi driver.

Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c    | 32 ++++++-----------------=
----
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     | 12 ++++------
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  2 --
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  6 -----
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  7 +-----
 5 files changed, 12 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_core.c
index 7d64be3..c0a075d 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -940,10 +940,10 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,
 	indio_dev->info =3D &mpu_info;
 	indio_dev->modes =3D INDIO_BUFFER_TRIGGERED;
=20
-	result =3D iio_triggered_buffer_setup(indio_dev,
-					    inv_mpu6050_irq_handler,
-					    inv_mpu6050_read_fifo,
-					    NULL);
+	result =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
+						 inv_mpu6050_irq_handler,
+						 inv_mpu6050_read_fifo,
+						 NULL);
 	if (result) {
 		dev_err(dev, "configure buffer fail %d\n", result);
 		return result;
@@ -951,39 +951,21 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq=
, const char *name,
 	result =3D inv_mpu6050_probe_trigger(indio_dev);
 	if (result) {
 		dev_err(dev, "trigger probe fail %d\n", result);
-		goto out_unreg_ring;
+		return result;
 	}
=20
 	INIT_KFIFO(st->timestamps);
 	spin_lock_init(&st->time_stamp_lock);
-	result =3D iio_device_register(indio_dev);
+	result =3D devm_iio_device_register(dev, indio_dev);
 	if (result) {
 		dev_err(dev, "IIO register fail %d\n", result);
-		goto out_remove_trigger;
+		return result;
 	}
=20
 	return 0;
-
-out_remove_trigger:
-	inv_mpu6050_remove_trigger(st);
-out_unreg_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-	return result;
 }
 EXPORT_SYMBOL_GPL(inv_mpu_core_probe);
=20
-int inv_mpu_core_remove(struct device  *dev)
-{
-	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-
-	iio_device_unregister(indio_dev);
-	inv_mpu6050_remove_trigger(iio_priv(indio_dev));
-	iio_triggered_buffer_cleanup(indio_dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(inv_mpu_core_remove);
-
 #ifdef CONFIG_PM_SLEEP
=20
 static int inv_mpu_resume(struct device *dev)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_i2c.c
index fcd7a92..c9ed082 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -137,14 +137,12 @@ static int inv_mpu_probe(struct i2c_client *client,
 				 1, 0, I2C_MUX_LOCKED | I2C_MUX_GATE,
 				 inv_mpu6050_select_bypass,
 				 inv_mpu6050_deselect_bypass);
-	if (!st->muxc) {
-		result =3D -ENOMEM;
-		goto out_unreg_device;
-	}
+	if (!st->muxc)
+		return -ENOMEM;
 	st->muxc->priv =3D dev_get_drvdata(&client->dev);
 	result =3D i2c_mux_add_adapter(st->muxc, 0, 0, 0);
 	if (result)
-		goto out_unreg_device;
+		return result;
=20
 	result =3D inv_mpu_acpi_create_mux_client(client);
 	if (result)
@@ -154,8 +152,6 @@ static int inv_mpu_probe(struct i2c_client *client,
=20
 out_del_mux:
 	i2c_mux_del_adapters(st->muxc);
-out_unreg_device:
-	inv_mpu_core_remove(&client->dev);
 	return result;
 }
=20
@@ -167,7 +163,7 @@ static int inv_mpu_remove(struct i2c_client *client)
 	inv_mpu_acpi_delete_mux_client(client);
 	i2c_mux_del_adapters(st->muxc);
=20
-	return inv_mpu_core_remove(&client->dev);
+	return 0;
 }
=20
 /*
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_iio.h
index c3d6225..f680d00 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -288,7 +288,6 @@ enum inv_mpu6050_clock_sel_e {
 irqreturn_t inv_mpu6050_irq_handler(int irq, void *p);
 irqreturn_t inv_mpu6050_read_fifo(int irq, void *p);
 int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev);
-void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st);
 int inv_reset_fifo(struct iio_dev *indio_dev);
 int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 m=
ask);
 int inv_mpu6050_write_reg(struct inv_mpu6050_state *st, int reg, u8 val);
@@ -297,5 +296,4 @@ int inv_mpu_acpi_create_mux_client(struct i2c_client *c=
lient);
 void inv_mpu_acpi_delete_mux_client(struct i2c_client *client);
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type);
-int inv_mpu_core_remove(struct device *dev);
 extern const struct dev_pm_ops inv_mpu_pmops;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/in=
v_mpu6050/inv_mpu_spi.c
index 74506e5..93fdd17 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
@@ -69,11 +69,6 @@ static int inv_mpu_probe(struct spi_device *spi)
 				  inv_mpu_i2c_disable, chip_type);
 }
=20
-static int inv_mpu_remove(struct spi_device *spi)
-{
-	return inv_mpu_core_remove(&spi->dev);
-}
-
 /*
  * device id table is used to identify what device can be
  * supported by this driver
@@ -97,7 +92,6 @@ MODULE_DEVICE_TABLE(acpi, inv_acpi_match);
=20
 static struct spi_driver inv_mpu_driver =3D {
 	.probe		=3D	inv_mpu_probe,
-	.remove		=3D	inv_mpu_remove,
 	.id_table	=3D	inv_mpu_id,
 	.driver =3D {
 		.acpi_match_table =3D ACPI_PTR(inv_acpi_match),
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_trigger.c
index f963f9f..2ec1215 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -141,7 +141,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev=
)
 	st->trig->ops =3D &inv_mpu_trigger_ops;
 	iio_trigger_set_drvdata(st->trig, indio_dev);
=20
-	ret =3D iio_trigger_register(st->trig);
+	ret =3D devm_iio_trigger_register(&indio_dev->dev, st->trig);
 	if (ret)
 		return ret;
=20
@@ -149,8 +149,3 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev=
)
=20
 	return 0;
 }
-
-void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
-{
-	iio_trigger_unregister(st->trig);
-}
--=20
2.7.4
