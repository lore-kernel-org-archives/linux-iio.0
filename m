Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CB430BB9
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 21:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772400585; cv=none; b=eJIkICBzGsSjsHGfK5x5rXAQiPb7HHE1/t4RxImm5Zdp6wY41Ey6FPfFPLiHTKs4etTOtLm2c4QzfOY7dEOaQKYMLwqoxju6zfzgASIr0pHEZtV5RVijwt199lCDcW8Wth7ujINqsYCV61x4ML3MqoXtUbQBCssdCr+txs/DCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772400585; c=relaxed/simple;
	bh=DjYyhyMvixTabW49k7cEmN17HvSCk8isqnqLv/Us3XY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ofevHD8q0zsbQozfIQFrJalF0H6U09KZ6Q+KA0IrAIp2xySKGqh2ZwC5/Kl2GY+4peoPhIfD/wMjhtpJmtE7xplbVqELFHbCHa8TRIYxv1536R/7NR7bjF+iv/LqO3UoHxLbeovzT/3H+kdeP/V/pmMpPfzYtbiKVJJQpP3Qa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=T5usw3IX; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="T5usw3IX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772400509; x=1772659709;
	bh=AlRoRmV8co/cARlAL1QjAIihx23BPQkCrLr+ZKe1xvI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=T5usw3IXZnmuznN11XRHV50QnhBLAfqBf9QZbJ/zcEnJO9Jhe4Eq3NCwt1TPUWlS+
	 AG8PpKCVhX9Xe4shM5lS28YuWBe1Iuyw38njh5tGTTEgj3g6TmQnWkTZezwBlbC5mm
	 Gecpy7QRQ5i2umsoyuWmGPtmD90wSRXTPuA7lrDs8n0r/u8J46BVCVXH0U7O5+szXz
	 hXpR3pm+JTQpJv8oJIgGmvRJbo4D5mSvxNaieHKm0EqQwLOD2UXQGjISGHEagbO0RV
	 Ed11J/dfnNYmxfrpynIhbqHbuBDiFLNRGkuq1NQSBbzw21SmQ/QXnalxg2B8RqNDkw
	 CWZpOBRjVri6w==
Date: Sun, 01 Mar 2026 21:28:26 +0000
To: linux-iio@vger.kernel.org
From: Bruno Martins <ehanoc@protonmail.com>
Cc: jic23@kernel.org, gregkh@linuxfoundation.org, Bruno Martins <ehanoc@protonmail.com>
Subject: [PATCH] staging: iio: ad7816: Replace sprintf with sysfs_emit
Message-ID: <20260301212819.98597-1-ehanoc@protonmail.com>
Feedback-ID: 4792375:user:proton
X-Pm-Message-ID: 691c69b9ad32bc558dd38545e0761cec51630cc7
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

As stated in Documentation/filesystems/sysfs.rst:
'New implementations of show() methods should only use sysfs_emit() or
sysfs_emit_at() when formatting the value to be returned to user space.'

Replace sprintf with sysfs_emit in the following sysfs show functions:
- ad7816_show_mode()
- ad7816_show_available_modes()
- ad7816_show_channel()
- ad7816_show_value()
- ad7816_show_oti()

Signed-off-by: Bruno Martins <ehanoc@protonmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7=
816.c
index 172acf135f3b..0e32a2295990 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -124,8 +124,8 @@ static ssize_t ad7816_show_mode(struct device *dev,
 =09struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
=20
 =09if (chip->mode)
-=09=09return sprintf(buf, "power-save\n");
-=09return sprintf(buf, "full\n");
+=09=09return sysfs_emit(buf, "power-save\n");
+=09return sysfs_emit(buf, "full\n");
 }
=20
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -156,7 +156,7 @@ static ssize_t ad7816_show_available_modes(struct devic=
e *dev,
 =09=09=09=09=09   struct device_attribute *attr,
 =09=09=09=09=09   char *buf)
 {
-=09return sprintf(buf, "full\npower-save\n");
+=09return sysfs_emit(buf, "full\npower-save\n");
 }
=20
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -169,7 +169,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 =09struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
 =09struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
=20
-=09return sprintf(buf, "%d\n", chip->channel_id);
+=09return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
=20
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -231,9 +231,9 @@ static ssize_t ad7816_show_value(struct device *dev,
 =09=09data &=3D AD7816_TEMP_FLOAT_MASK;
 =09=09if (value < 0)
 =09=09=09data =3D BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-=09=09return sprintf(buf, "%d.%.2d\n", value, data * 25);
+=09=09return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
 =09}
-=09return sprintf(buf, "%u\n", data);
+=09return sysfs_emit(buf, "%u\n", data);
 }
=20
 static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
@@ -281,9 +281,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
 =09=09value =3D AD7816_BOUND_VALUE_MIN +
 =09=09=09(chip->oti_data[chip->channel_id] -
 =09=09=09AD7816_BOUND_VALUE_BASE);
-=09=09return sprintf(buf, "%d\n", value);
+=09=09return sysfs_emit(buf, "%d\n", value);
 =09}
-=09return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+=09return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
=20
 static inline ssize_t ad7816_set_oti(struct device *dev,
--=20
2.47.3


