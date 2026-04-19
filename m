Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27A279DC9;
	Sun, 19 Apr 2026 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776637985; cv=none; b=De/opYfE3afyr4GQVZQ8Yf1wQZL0jJ2W1pd4HWHkj4okOhDDcXWL8dJDho/ABwS9W9vm/ha8DSkpxLZekoU71Id6XyE7lX1Qei75bbU04Xp7qAa0aw+FBHAaa27sm83p8oD9tO6YYFtgSxvurwsW2o9FNBbyBbWX6HGmpcIECC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776637985; c=relaxed/simple;
	bh=a8ZGYGuefHGOs5YQ/RdZh+1MbmDGMOH4isE8RgypgcY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmR4F89pMqlg2g6r0My89ocEj1mUWkWvEvYR9NBeGNccqwO/A7+oSU7tEk9gDKfvrDZ6QDQWv5mzKkOjnXMC9RkaiV5TdcUW1muzoDdK7wxZsoHuvDH9NPxtRhJ3Bigi1X9cO4IyeSrcHzzzmzWaOxow+lh69AYbCShc1o3FpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=GtgzBV8e; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="GtgzBV8e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1776637982; x=1776897182;
	bh=2x7EboPkNic0+Mq4adzJ5RyZZdI9Rg7BjDNqD1bzzBA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GtgzBV8eyRd2JGlWtEaJhrV7p0QcBCFF0CoNIv2HY8h+1ab/djBWdLiYqpdNna3Xh
	 Hjf4Ne6jtgKmicUEs+rZdM6kl2n1O6LLEvN8mgkXQUqnhav9uc2Sa6o0thD4JQJrhP
	 Ojk64PEk8Owbtu46sKHRx5Q1cm478a2ThVgp6Uv9q2hPGV100OnbT91sjepizN7lNG
	 Qu4PlIoRDGj0MJcTr5bhOHLyk6K6P9lX/+cj5r5JtnM0uM1tGW5xdikWLLrk4ZIw9k
	 u8J1Vx+bqpa3uV1GfBougoD9THdQBPZw9DpdWVegZ1VDIrALomIEvYJ9bTU1qxhu4T
	 MWLiW1DIXHLtA==
Date: Sun, 19 Apr 2026 22:32:56 +0000
To: gregkh@linuxfoundation.org, jic23@kernel.org
From: Hardik Phalet <hardik.phalet@pm.me>
Cc: andy@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dlechner@baylibre.com, krzk+dt@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, me@brighamcampbell.com, nuno.sa@analog.com, robh@kernel.org, skhan@linuxfoundation.org, Hardik Phalet <hardik.phalet@gmail.com>, Hardik Phalet <hardik.phalet@pm.me>
Subject: [PATCH v3 4/5] iio: magnetometer: qmc5883p: add oversampling ratio support
Message-ID: <20260420-qmc5883p-driver-v3-4-da1e97088f8b@pm.me>
In-Reply-To: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
References: <20260420-qmc5883p-driver-v3-0-da1e97088f8b@pm.me>
Feedback-ID: 166659585:user:proton
X-Pm-Message-ID: 20cd3cfe6bb6b0447260ccc827e3e999713a35c1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Expose the CTRL_1 OSR field through IIO_CHAN_INFO_OVERSAMPLING_RATIO so
userspace can select among the four oversampling settings (1, 2, 4, 8)
supported by the device. Read, write and available handlers mirror the
existing SAMP_FREQ plumbing and use the already-present rf.osr regmap
field.

Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
---
 drivers/iio/magnetometer/qmc5883p.c | 46 +++++++++++++++++++++++++++++++++=
+---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/qmc5883p.c b/drivers/iio/magnetometer=
/qmc5883p.c
index e4a76ae7c2cf..d0e4a1a600b6 100644
--- a/drivers/iio/magnetometer/qmc5883p.c
+++ b/drivers/iio/magnetometer/qmc5883p.c
@@ -4,7 +4,7 @@
  *
  * Copyright 2026 Hardik Phalet <hardik.phalet@pm.me>
  *
- * TODO: add triggered buffer support, PM, OSR, DSR
+ * TODO: add triggered buffer support, PM, DSR
  *
  */
=20
@@ -119,6 +119,13 @@ static const int qmc5883p_odr[] =3D {
 =09[QMC5883P_ODR_200] =3D 200,
 };
=20
+static const int qmc5883p_osr[] =3D {
+=09[QMC5883P_OSR_1] =3D 1,
+=09[QMC5883P_OSR_2] =3D 2,
+=09[QMC5883P_OSR_4] =3D 4,
+=09[QMC5883P_OSR_8] =3D 8,
+};
+
 static const struct regmap_range qmc5883p_readable_ranges[] =3D {
 =09regmap_reg_range(QMC5883P_REG_CHIP_ID, QMC5883P_REG_Z_MSB),
 =09regmap_reg_range(QMC5883P_REG_STATUS, QMC5883P_REG_CTRL_2),
@@ -277,6 +284,13 @@ static int qmc5883p_read_raw(struct iio_dev *indio_dev=
,
 =09=09=09return ret;
 =09=09*val =3D qmc5883p_odr[regval];
 =09=09return IIO_VAL_INT;
+
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09ret =3D regmap_field_read(data->rf.osr, &regval);
+=09=09if (ret < 0)
+=09=09=09return ret;
+=09=09*val =3D qmc5883p_osr[regval];
+=09=09return IIO_VAL_INT;
 =09}
=20
 =09return -EINVAL;
@@ -306,6 +320,18 @@ static int qmc5883p_write_odr(struct qmc5883p_data *da=
ta, int val)
 =09return -EINVAL;
 }
=20
+static int qmc5883p_write_osr(struct qmc5883p_data *data, int val)
+{
+=09int i;
+
+=09for (i =3D 0; i < ARRAY_SIZE(qmc5883p_osr); i++) {
+=09=09if (qmc5883p_osr[i] =3D=3D val)
+=09=09=09return regmap_field_write(data->rf.osr, i);
+=09}
+
+=09return -EINVAL;
+}
+
 static int qmc5883p_write_raw(struct iio_dev *indio_dev,
 =09=09=09      struct iio_chan_spec const *chan, int val,
 =09=09=09      int val2, long mask)
@@ -323,6 +349,9 @@ static int qmc5883p_write_raw(struct iio_dev *indio_dev=
,
 =09case IIO_CHAN_INFO_SAMP_FREQ:
 =09=09ret =3D qmc5883p_write_odr(data, val);
 =09=09break;
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09ret =3D qmc5883p_write_osr(data, val);
+=09=09break;
 =09case IIO_CHAN_INFO_SCALE:
 =09=09ret =3D qmc5883p_write_scale(data, val, val2);
 =09=09break;
@@ -357,6 +386,12 @@ static int qmc5883p_read_avail(struct iio_dev *indio_d=
ev,
 =09=09*length =3D ARRAY_SIZE(qmc5883p_odr);
 =09=09return IIO_AVAIL_LIST;
=20
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09*vals =3D qmc5883p_osr;
+=09=09*type =3D IIO_VAL_INT;
+=09=09*length =3D ARRAY_SIZE(qmc5883p_osr);
+=09=09return IIO_AVAIL_LIST;
+
 =09case IIO_CHAN_INFO_SCALE:
 =09=09*vals =3D (const int *)qmc5883p_scale;
 =09=09*type =3D IIO_VAL_INT_PLUS_NANO;
@@ -382,6 +417,8 @@ static int qmc5883p_write_raw_get_fmt(struct iio_dev *i=
ndio_dev,
 =09=09return IIO_VAL_INT_PLUS_NANO;
 =09case IIO_CHAN_INFO_SAMP_FREQ:
 =09=09return IIO_VAL_INT;
+=09case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+=09=09return IIO_VAL_INT;
 =09default:
 =09=09return -EINVAL;
 =09}
@@ -452,9 +489,12 @@ static int qmc5883p_read_chip_id(struct qmc5883p_data =
*data)
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |            \
 =09=09=09=09      BIT(IIO_CHAN_INFO_SCALE),           \
 =09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE), \
-=09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+=09=09.info_mask_shared_by_type =3D                               \
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |                    \
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),            \
 =09=09.info_mask_shared_by_type_available =3D                     \
-=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ),                     \
+=09=09=09BIT(IIO_CHAN_INFO_SAMP_FREQ) |                    \
+=09=09=09BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),            \
 =09}
=20
 static const struct iio_chan_spec qmc5883p_channels[] =3D {

--=20
2.53.0

