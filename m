Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605671;
	b=I6Nyc9cfztqKsxthdxtCbXGUoOAh1daWlEBYr4VGwh5bvSnmBjbaMkLH4Ede1n69tRAY
	 P9+KAu9q2XJlfU0DtTG0w9476GfI+FP62GmSAmpeXWTD3jal/H6TswbuBLE2RmUz7ArYK
	 /FKWx7LlFSekglSHkR4JAt7veuPBZGVI/6eFllN8Fl9sRTcTUSQaz29mxeGdByUWJNVQh
	 j8brXkvLC7tLiBI8/cuwoRKCUPDGf6opmTWchI/d07plHh/xiMSnU2YG4sW6TDURsiL9I
	 GmncNaf1nTpwQdK2VBQp/2OhDHUOfxx5lCOT2wa2V9EYGFs3sax3FCztkQQZHsV6DWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605671;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=NVCONaY5z4ZFgwcXES3HKygeAOGw1+MgNQJI3khRZ6o=;
	b=XumM0tMAluGwMLkNq6g57wxiOQVMK3qxeYzRtc+6jJgOmFVIcxrW6vAAUM1LQRY8Baqf
	 C8QH4MH7zMUDTV7KnhdOXVk9HNJ7OBPSEtmf/bOEZ/1Hqkm0iPn5Z5cxsPSNq9LTgDyiT
	 yrn4S+PqSI217tg2v/l/p+pvJA2kuy0RrWfPB05vtKtaNWbxnyzAjEnfCGmcA/hsHUJG3
	 l0Ej3IbhkL5AaNLbnBJbC4p6P28uOOSeE9vcfkqCf/Lub8qPPN2zS5QeqqiV8RddoyQIB
	 K8vuW4W1yC7hVjxrLEhBL8cQrWDt4/JbDJeBxHvNhzyfmn5N7Mejt0INEoq7gNeLmzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=Z4Ic6Khq;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=R0zVm3wP;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2244606A327
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2244606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=Z4Ic6Khq;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=R0zVm3wP
DKIM-Signature: a=rsa-sha256; b=Z4Ic6KhqoLLPjpYomvGQGzbnceOB+qxnV7Sm59QIs+r1r3dnBofm4rpHFR6xF/eUmgBfy9rQdpRrTfxC18LmktzLauJuaKE7PGIyRqT0vM0GDNargelD7C5s2rDzEiZh3QPbThBx9+zt4+L2uhcpiAm8gsrqcKmYOgjaFr67POQBVIlCiIdQiIkeb+sUBRBQLvSX5q9J2SxXQCcbseDHWJPw8pPHrn0dPAkihcZ024QFQqC85vlY2bDWbmbM4AOhQgtgmppusmLnE1wXrIRIl+dWTniXhXQ6CT/dY0iR2e+lrJVaVU5e54+H5clo/Ibp3dX9G5b839TSrR5uguJBJA==; s=purelymail2; d=arkamondal.net; v=1; bh=0fLlRHl/dzI82cbWStQRGi+3gA6yE9Uxex1br6bkHqA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=R0zVm3wPZTerqrFE/rtUEER48VAOFmuyA4/0LTu3pGI8ENQa4n+kRsgGoqyk56TBicQiv7rQSZjfc/WeIlvPdc0xZhCUmW87Sh31MsCsDf6EIj9rIgF002DzDbeeyv+pVjfExs4sKajubQJqJa67gI00PUWb86UZHrXmrkg3AYJaf0suNIM2TlEidkIlB9cpSecLwMFWyjfD2RaHu55u7//uaH3IFy9oZpTbRlBhPexc7NXcpOIPHPML3xyTc/N8LhpDLiTBNKkdJDZhuxy9bWSRxKDq0WMdp6wMBsiYag+PpLE63wivqa8y1OPAl5nEr1I8ttypFbW4uhCLKAq93w==; s=purelymail2; d=purelymail.com; v=1; bh=0fLlRHl/dzI82cbWStQRGi+3gA6yE9Uxex1br6bkHqA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1322764464;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:23 +0000 (UTC)
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
Subject: [PATCH 2/6] iio: light: apds9960: Report the available lists via read_avail()
Date: Mon,  2 Nov 2026 16:46:56 +0900
Message-ID: <20261102074700.63075-3-arka@arkamondal.net>
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

The proximity and intensity channels put IIO_CHAN_INFO_SCALE in
info_mask_shared_by_type, and the intensity channels put
IIO_CHAN_INFO_INT_TIME there too. The values those attributes accept
are listed by three custom attributes: proximity_scale_available,
intensity_scale_available and integration_time_available. None of the
three carries the in_ prefix that the core gives the attribute it
describes, so all three are registered at the device level, and
userspace looking for in_proximity_scale_available,
in_intensity_scale_available or in_intensity_integration_time_available
finds nothing.

Report all three through read_avail() and drop the custom attribute
group. The two gain lists keep their exact text. The integration time
list becomes 0.028000 0.100000 0.200000 0.700000 instead of 0.028 0.1
0.2 0.7, because the core prints IIO_VAL_INT_PLUS_MICRO with six
decimals. The values are unchanged.

Fixes: aff268cd532e ("iio: light: add APDS9960 ALS + promixity driver")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/light/apds9960.c | 56 +++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index afe520de60e2..496678c4d338 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -289,6 +289,8 @@ static const struct iio_event_spec apds9960_als_event_s=
pec[] =3D {
 =09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
 =09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) | \
 =09=09=09BIT(IIO_CHAN_INFO_INT_TIME), \
+=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE) | \
+=09=09=09BIT(IIO_CHAN_INFO_INT_TIME), \
 =09.channel2 =3D IIO_MOD_LIGHT_##_colour, \
 =09.address =3D APDS9960_REG_ALS_CHANNEL(_colour), \
 =09.modified =3D 1, \
@@ -304,6 +306,7 @@ static const struct iio_chan_spec apds9960_channels[] =
=3D {
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
 =09=09=09BIT(IIO_CHAN_INFO_CALIBBIAS),
 =09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
+=09=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),
 =09=09.channel =3D 0,
 =09=09.indexed =3D 0,
 =09=09.scan_index =3D -1,
@@ -322,6 +325,8 @@ static const struct iio_chan_spec apds9960_channels[] =
=3D {
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
 =09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
 =09=09=09BIT(IIO_CHAN_INFO_INT_TIME),
+=09=09.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE) |
+=09=09=09BIT(IIO_CHAN_INFO_INT_TIME),
 =09=09.channel2 =3D IIO_MOD_LIGHT_CLEAR,
 =09=09.address =3D APDS9960_REG_ALS_CHANNEL(CLEAR),
 =09=09.modified =3D 1,
@@ -370,19 +375,11 @@ static const int apds9960_int_time[][2] =3D {
 static const int apds9960_pxs_gain_map[] =3D {1, 2, 4, 8};
 static const int apds9960_als_gain_map[] =3D {1, 4, 16, 64};
=20
-static IIO_CONST_ATTR(proximity_scale_available, "1 2 4 8");
-static IIO_CONST_ATTR(intensity_scale_available, "1 4 16 64");
-static IIO_CONST_ATTR_INT_TIME_AVAIL("0.028 0.1 0.2 0.7");
-
-static struct attribute *apds9960_attributes[] =3D {
-=09&iio_const_attr_proximity_scale_available.dev_attr.attr,
-=09&iio_const_attr_intensity_scale_available.dev_attr.attr,
-=09&iio_const_attr_integration_time_available.dev_attr.attr,
-=09NULL,
-};
-
-static const struct attribute_group apds9960_attribute_group =3D {
-=09.attrs =3D apds9960_attributes,
+static const int apds9960_int_time_avail[] =3D {
+=090, 28000,
+=090, 100000,
+=090, 200000,
+=090, 700000,
 };
=20
 static const struct reg_field apds9960_reg_field_int_als =3D
@@ -786,8 +783,39 @@ static int apds9960_write_event_config(struct iio_dev =
*indio_dev,
 =09return 0;
 }
=20
+static int apds9960_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09switch (chan->type) {
+=09=09case IIO_PROXIMITY:
+=09=09=09*vals =3D apds9960_pxs_gain_map;
+=09=09=09*length =3D ARRAY_SIZE(apds9960_pxs_gain_map);
+=09=09=09break;
+=09=09case IIO_INTENSITY:
+=09=09=09*vals =3D apds9960_als_gain_map;
+=09=09=09*length =3D ARRAY_SIZE(apds9960_als_gain_map);
+=09=09=09break;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+=09=09*type =3D IIO_VAL_INT;
+=09=09return IIO_AVAIL_LIST;
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09*vals =3D apds9960_int_time_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09*length =3D ARRAY_SIZE(apds9960_int_time_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
 static const struct iio_info apds9960_info =3D {
-=09.attrs =3D &apds9960_attribute_group,
+=09.read_avail =3D apds9960_read_avail,
 =09.read_raw =3D apds9960_read_raw,
 =09.write_raw =3D apds9960_write_raw,
 =09.read_event_value =3D apds9960_read_event,
--=20
2.56.0

