Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605675;
	b=lJa+P5ORmkf6sG7gTBGUg0yZkPf6wRVAQVP6rav/UC/g/pFaS2Mgq5+sTwFuwF/46Kdh
	 0VZkSq7tK46tewfUpIcu0lPemgYe2OMcdyM4k2Yylg0CsUllCs0rK/GPJKKSOe1rqU8zR
	 LFy0Mim95T4xUBrLfu82RbhaL6+UJdIF250u/w5XrLqM9k8sVjEAYlAVi02fTOFMFmcuU
	 lIMLbcq4YJN1fXG4x65KchJavBv6NNzXopMXo14KlyPbTE/MrBrUnxguGqCD94olhSRg4
	 H8Xw9E8t4cq+M8Cjf/t7fuGDnSkYvqmII+f85YevAnOPtJHPrMhlBkANZ6NW1wcXIuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605675;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=P2WHQc6zM3YpFYZ7gdc6FJKerdajDKeyE4O3ZrIVA+E=;
	b=EEYbetB+Wiq6pZK1tm3mUTj5TXHX/M942Y70jYtFDcG8L5f2AgrkIfu+03CZNYdaZPf2
	 dsUdLyk5EqG0oRHLdg3EBfQK+j8RJ1tBTrlKCYF9KXcKj8TuukrFxDVTWGOC5jDBoC294
	 X1wI62ksL7SUuXLAHJiYZTRhqRy9x8rkk+mo/AzqeWvxJoa19LWaiKO8W+zigQYAqjqxf
	 W1B1Dq/C+Tuk67uOuIUBM2PA9YoDr55gc629vfVGk67flh4xFCBcUOYu+Oksjw4RV/pxN
	 bzhORCevf+CfbnjtDb2qEtp7Bz0MveXy0A2gkiyNd8zg4aeJdeGJJFgGVKBu1xnG3GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=wBD3WBa2;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=HQZYvZ07;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743060A2614
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8743060A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=wBD3WBa2;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=HQZYvZ07
DKIM-Signature: a=rsa-sha256; b=wBD3WBa2Xa+9cx3oUsQMcXeOxl1hO241sSuxHZUm3hDtC7XXOYg7otNl57tWw/Vynrzs/LrwHe4CpmhXKL3Xcc0u4v/vyeGaFnwgEhW4Hxcc5FtyROqE9qyn3WSRHyPQTCk1WRu4HyG2TelJQ9VoOtnWyljohqTwG6y1q5EVT6ycifJSnRv57cvGtdQVX0EyTp9fpo2Rov8iILku8E7AmO/e/hePfvl9Wn7hT1iwj5ytLQORnFqaubxhI0FG46QDwlMzsugmGJutQLtzwT9Noi9f/yIHTuE9d8tGcg918VTYA8v3A+kTHdDNe6nYgWzOp2tkOXsw6OU8Xp144Fmseg==; s=purelymail2; d=arkamondal.net; v=1; bh=qDJDGnNh0VyDniUgB1appHqn7rBPmTAD4rGUcCjsp0w=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=HQZYvZ07K/X4Bn+Kpc7BiVTtGzwQCFHgwbaZjFKFBbvDWPaSnex+Ln//58Nx/0p1r4KvTEOzaSKAdDy9lhiRoMk2flcWYkigs6rs34zyrrTlovFv+THyAZMePHgwH8dV2FEO8j9jNwjpJoImtWqA79EJKCnVEZobJjeToyChWka7xY8r03+wA48qZ6gfbtFGFt66NTCNYXf+60Fzoq5L/wnBXDg5WmziptQcDV/tmqWn4hi+pTjnmNDcp0y7weA2M9m05ise6yVNJ65o/Vocdf051ZmThqxTET8DWUyHV90SnSLxjSFxl5rqlu/eOII4ac/wJaq1IJ0Mcm5KfzHivQ==; s=purelymail2; d=purelymail.com; v=1; bh=qDJDGnNh0VyDniUgB1appHqn7rBPmTAD4rGUcCjsp0w=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1778885788;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:33 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	Leonard Crestez <cdleonard@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH 6/6] iio: gyro: mpu3050: Fix the scale list and report it via read_avail()
Date: Mon,  2 Nov 2026 16:47:00 +0900
Message-ID: <20261102074700.63075-7-arka@arkamondal.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102074700.63075-1-arka@arkamondal.net>
References: <20261102074700.63075-1-arka@arkamondal.net>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

The angular velocity channels keep IIO_CHAN_INFO_SCALE in
info_mask_shared_by_type, so userspace reads the scale from
in_anglvel_scale. One custom attribute lists the values it can take,
and that list is wrong in both its numbers and its name.

The four numbers were computed against 2^16 while mpu3050_read_raw()
divides by U16_MAX, so not one of them is a value the channel ever
reports. The list gives 0.000122070, 0.000274658, 0.000518798 and
0.001068115, where the channel reports 0.000122072, 0.000274662,
0.000518806 and 0.001068131.

The name, anglevel_scale_available, has neither the in_ prefix nor
the anglvel spelling the core uses for IIO_ANGL_VEL, so it sits at the
device level and userspace that opens in_anglvel_scale_available finds
no such file.

Report the list through read_avail(), built from the same
IIO_DEGREE_TO_RAD() terms and U16_MAX that mpu3050_read_raw() uses so
the two cannot drift apart again, and delete the attribute along with
the comment describing the hardcoded factors.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/gyro/mpu3050-core.c | 40 +++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-cor=
e.c
index 07c0f9011c63..0dfb5e6039fb 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -701,6 +701,8 @@ static const struct iio_chan_spec_ext_info mpu3050_ext_=
info[] =3D {
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |=09=09\
 =09=09=09BIT(IIO_CHAN_INFO_CALIBBIAS),=09=09=09\
 =09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),=09\
+=09=09.info_mask_shared_by_type_available =3D=09=09=09\
+=09=09=09BIT(IIO_CHAN_INFO_SCALE),=09=09=09\
 =09=09.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),\
 =09=09.ext_info =3D mpu3050_ext_info,=09=09=09=09\
 =09=09.scan_index =3D index,=09=09=09=09=09\
@@ -736,29 +738,33 @@ static const struct iio_chan_spec mpu3050_channels[] =
=3D {
 /* Four channels apart from timestamp, scan mask =3D 0x0f */
 static const unsigned long mpu3050_scan_masks[] =3D { 0xf, 0 };
=20
-/*
- * These are just the hardcoded factors resulting from the more elaborate
- * calculations done with fractions in the scale raw get/set functions.
- */
-static IIO_CONST_ATTR(anglevel_scale_available,
-=09=09      "0.000122070 "
-=09=09      "0.000274658 "
-=09=09      "0.000518798 "
-=09=09      "0.001068115");
-
-static struct attribute *mpu3050_attributes[] =3D {
-=09&iio_const_attr_anglevel_scale_available.dev_attr.attr,
-=09NULL,
+static const int mpu3050_scale_avail[] =3D {
+=09IIO_DEGREE_TO_RAD(250) * 2, U16_MAX,
+=09IIO_DEGREE_TO_RAD(500) * 2, U16_MAX,
+=09IIO_DEGREE_TO_RAD(1000) * 2, U16_MAX,
+=09IIO_DEGREE_TO_RAD(2000) * 2, U16_MAX,
 };
=20
-static const struct attribute_group mpu3050_attribute_group =3D {
-=09.attrs =3D mpu3050_attributes,
-};
+static int mpu3050_read_avail(struct iio_dev *indio_dev,
+=09=09=09      struct iio_chan_spec const *chan,
+=09=09=09      const int **vals, int *type, int *length,
+=09=09=09      long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D mpu3050_scale_avail;
+=09=09*type =3D IIO_VAL_FRACTIONAL;
+=09=09*length =3D ARRAY_SIZE(mpu3050_scale_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
=20
 static const struct iio_info mpu3050_info =3D {
 =09.read_raw =3D mpu3050_read_raw,
 =09.write_raw =3D mpu3050_write_raw,
-=09.attrs =3D &mpu3050_attribute_group,
+=09.read_avail =3D mpu3050_read_avail,
 };
=20
 /**
--=20
2.56.0

