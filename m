Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF06258EC2;
	Sun, 19 Apr 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776638001; cv=none; b=aaBQCkM+/TD4ohKyyEoKKG10IGI5db6vDN6krulsPCLsUoEjcolAT22vwlVnxzCIQkG63jaw1yfIrmWcb9TDaZSUwv2OevTlXnHZbiS3V5OeM7iw4SGyii9BSwO1456XGf8SL2fhGW9VH0kjmTW/avhBI24ycsXyFiAooFF+G7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776638001; c=relaxed/simple;
	bh=jVHKcrdHgp2mPFVrsxUyuoHHQKHWNv48U5w4Ana3cX0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=os31JWZ7q9JAfdgtSETa9ydzlAEyIBjFec9XGw4h1A2GYz4W+fMhvmOdZ3OwqNx6/IcRqOyjM/IxrIJ1eaUhJDc7Z9aRuIPedI60yEJqUJscGGUXIK7cr3NS8Rn1qcZPyIzOFvMdjKJtaR2rhMSdNjXx5sJAu/+DOtpYdlbpkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=O26cj/vB; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="O26cj/vB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776637992; x=1776897192;
	bh=fY6tuBw83PLvCS7CgtqrueeoVYZLrpLZCqPb3f5s+wg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O26cj/vBj5E2Mrer2SEcbIfQfRbxXARf2Fk7KOoGFuKuGNfP8yB8Ef2+LiovlGmVF
	 3hHELKFCvoJnxCNmqKgZf5e20EEH5FRIOLJ9zjmkNbmbcAPYxo2L9wXcql7bK2Fhe/
	 SD1dL4zIkcliObqFBIWdGeFeoj72oEoPwdCgSNcePjlKRxQCdTqZb0qlu9NWN+75q+
	 3bPSrtWZZh+YkiDhQhDZ8zgCDh4wJJ/fAy7sT56Pdv5TzY/+dxjsyLjvsiyOGOyzjS
	 wRDjtopxII7n335ER/pYneiiBjFNzmHpFuYK38knrsR/DeYcnfqv8hxAlXRQArgquP
	 5AeV8fmQb90qw==
Date: Sun, 19 Apr 2026 22:33:06 +0000
To: gregkh@linuxfoundation.org, jic23@kernel.org
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3 5/5] iio: magnetometer: qmc5883p: add PM support
Message-ID: <20260420-qmc5883p-driver-v3-5-da1e97088f8b@pm.me>
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 3be41c2537fd802e31929c05de99c7bcd3c89245
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add runtime PM with a 2 s autosuspend delay. Per datasheet =C2=A76.2.1
the chip continuously samples in MODE_NORMAL; putting it into
MODE_SUSPEND when idle drops current from up to 1180 uA to ~22 uA
(datasheet Table 2).

Wrap qmc5883p_get_measure() and qmc5883p_write_raw() with
pm_runtime_resume_and_get() / pm_runtime_put_autosuspend(), converting
early returns to a goto so the put is always paired.

System sleep is delegated to the runtime callbacks via
SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume).

A devm action is registered before devm_pm_runtime_enable() so that
LIFO teardown on unbind runs pm_runtime_disable() first (freezing PM
state) and then suspends the hardware via MODE_SUSPEND.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 drivers/iio/magnetometer/qmc5883p.c | 69 +++++++++++++++++++++++++++++++++=
+---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/magnetometer/qmc5883p.c b/drivers/iio/magnetometer=
/qmc5883p.c
index d0e4a1a600b6..0ff635924abf 100644
--- a/drivers/iio/magnetometer/qmc5883p.c
+++ b/drivers/iio/magnetometer/qmc5883p.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
  *
- * TODO: add triggered buffer support, PM, DSR
+ * TODO: add triggered buffer support, DSR
  *
  */
=20
@@ -15,6 +15,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/units.h>
@@ -208,6 +209,10 @@ static int qmc5883p_get_measure(struct qmc5883p_data *=
data, s16 *x, s16 *y,
 =09u8 reg_data[6];
 =09unsigned int status;
=20
+=09ret =3D pm_runtime_resume_and_get(data->dev);
+=09if (ret < 0)
+=09=09return ret;
+
 =09/*
 =09 * Poll the status register until DRDY is set or timeout.
 =09 * Read the whole register in one shot so that OVFL is captured from
@@ -220,24 +225,26 @@ static int qmc5883p_get_measure(struct qmc5883p_data =
*data, s16 *x, s16 *y,
 =09=09=09=09       QMC5883P_DRDY_POLL_US,
 =09=09=09=09       150 * (MICRO / MILLI));
 =09if (ret)
-=09=09return ret;
+=09=09goto out;
=20
 =09if (status & QMC5883P_STATUS_OVFL) {
 =09=09dev_warn_ratelimited(data->dev,
 =09=09=09"data overflow, consider reducing field range\n");
 =09=09ret =3D -ERANGE;
-=09=09return ret;
+=09=09goto out;
 =09}
=20
 =09ret =3D regmap_bulk_read(data->regmap, QMC5883P_REG_X_LSB, reg_data,
 =09=09=09       ARRAY_SIZE(reg_data));
 =09if (ret)
-=09=09return ret;
+=09=09goto out;
=20
 =09*x =3D (s16)get_unaligned_le16(&reg_data[0]);
 =09*y =3D (s16)get_unaligned_le16(&reg_data[2]);
 =09*z =3D (s16)get_unaligned_le16(&reg_data[4]);
=20
+out:
+=09pm_runtime_put_autosuspend(data->dev);
 =09return ret;
 }
=20
@@ -341,10 +348,14 @@ static int qmc5883p_write_raw(struct iio_dev *indio_d=
ev,
=20
 =09guard(mutex)(&data->mutex);
=20
-=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+=09ret =3D pm_runtime_resume_and_get(data->dev);
 =09if (ret)
 =09=09return ret;
=20
+=09ret =3D regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+=09if (ret)
+=09=09goto out;
+
 =09switch (mask) {
 =09case IIO_CHAN_INFO_SAMP_FREQ:
 =09=09ret =3D qmc5883p_write_odr(data, val);
@@ -364,6 +375,8 @@ static int qmc5883p_write_raw(struct iio_dev *indio_dev=
,
 =09if (restore && !ret)
 =09=09ret =3D restore;
=20
+out:
+=09pm_runtime_put_autosuspend(data->dev);
 =09return ret;
 }
=20
@@ -533,6 +546,18 @@ static int qmc5883p_chip_init(struct qmc5883p_data *da=
ta)
 =09return 0;
 }
=20
+static void qmc5883p_suspend_action(void *arg)
+{
+=09struct qmc5883p_data *data =3D arg;
+
+=09/*
+=09 * PM is already disabled at this point (devm LIFO); put the hardware
+=09 * into MODE_SUSPEND directly so the chip is not left sampling after
+=09 * unbind.
+=09 */
+=09regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+}
+
 static int qmc5883p_probe(struct i2c_client *client)
 {
 =09struct device *dev =3D &client->dev;
@@ -584,9 +609,42 @@ static int qmc5883p_probe(struct i2c_client *client)
 =09if (ret)
 =09=09return dev_err_probe(dev, ret, "failed to initialize chip\n");
=20
+=09ret =3D devm_add_action_or_reset(dev, qmc5883p_suspend_action, data);
+=09if (ret)
+=09=09return ret;
+
+=09pm_runtime_set_autosuspend_delay(dev, 2000);
+=09pm_runtime_use_autosuspend(dev);
+
+=09ret =3D devm_pm_runtime_enable(dev);
+=09if (ret)
+=09=09return ret;
+
 =09return devm_iio_device_register(dev, indio_dev);
 }
=20
+static int qmc5883p_runtime_suspend(struct device *dev)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+
+=09return regmap_field_write(data->rf.mode, QMC5883P_MODE_SUSPEND);
+}
+
+static int qmc5883p_runtime_resume(struct device *dev)
+{
+=09struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
+=09struct qmc5883p_data *data =3D iio_priv(indio_dev);
+
+=09return regmap_field_write(data->rf.mode, QMC5883P_MODE_NORMAL);
+}
+
+static const struct dev_pm_ops qmc5883p_dev_pm_ops =3D {
+=09SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+=09=09RUNTIME_PM_OPS(qmc5883p_runtime_suspend,
+=09=09=09       qmc5883p_runtime_resume, NULL)
+};
+
 static const struct of_device_id qmc5883p_of_match[] =3D {
 =09{ .compatible =3D "qstcorp,qmc5883p" },
 =09{ }
@@ -603,6 +661,7 @@ static struct i2c_driver qmc5883p_driver =3D {
 =09.driver =3D {
 =09=09.name =3D "qmc5883p",
 =09=09.of_match_table =3D qmc5883p_of_match,
+=09=09.pm =3D pm_ptr(&qmc5883p_dev_pm_ops),
 =09},
 =09.probe =3D qmc5883p_probe,
 =09.id_table =3D qmc5883p_id,

--=20
2.53.0

