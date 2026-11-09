Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200887;
	b=VBN45CoZIwhJBOJilUrArPKtT417hgJ68N+CaEXKfgWUNqea+IFkP12zRlO5Ma0VCBXn
	 8/EOZP2sFRjbNm/fwsfNiunpmwQqLmkLUf5/TBLiOBO63QXXThATuHm8kJ0qCa0rhcMra
	 mwQz74U9RHC9oVk5FBVZbQp0oj4uo7SntNfoH3P/H6q5dKN0Ld8NDgXVCVfaMBRUCwWj4
	 hygPuO+L9tqMU9r6UFQiCjGaNwL4mJ7FmbFbFprQ+yypk4utHz5dAwL/rWxTM9yaMb8x3
	 JLBTYT7wd5CitfFX+WvzgWUHhsYYo1euP/8Ef+l3Ej/k6hjr13d0LZXyqyq9H4JiGtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200887;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=7Z5GB7KMsVdvr80fZDQSyd8pLgimkJUbwSwFJkbP3+c=;
	b=cH0QDB87CKb2Odgk0Mx7BfqbXgO5Sw/V4fkbVUCzCcd1Zg5WbvAZNoXPBlnqby1iPKKC
	 vv6qXQZMCGh3mCYJxUPLpuyO2FnUVcjr7vk6eKUoGFEMnXeoiV7O3BChoyaPVYPToYTDU
	 Nsk1sCr9bJgNT3lyCcdP6Q12GXD5a7BqxaT4aptByvIOxuxSWb5vDeXPN11yVDvISiHKF
	 rRQIOttKZYz3WCDVqbSzjvjuCHoQJqFUD4Kp8VWoX2qP5UTc1tNlqwz9GVQBA4QBK51q4
	 rpNSytrrdfsOARb4RM0hwLtAW18IhPEkxJibU15RLHowbvD3hodOoB1U5XhGKziWTBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=jxjF+qan;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=afA633Xb;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC405606A321
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 05:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC405606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=jxjF+qan;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=afA633Xb
DKIM-Signature: a=rsa-sha256; b=jxjF+qanIipKbz2pNxsO5MTWscrejUfI4E2wyyWv9dVK0WQKNJWM9r/QezXhOiea2hIu8UkYoGvZIR2vGwNazyUzRi3sg2CSFoXCZy6Py+yr46ZkOszCxcCe6kNOZHuGDkDlou+4x50eIpI3sAm4xv7OTDZZ9mfwOq7CrYJk7XF2sIa0BeNJeXYxM5bBUsM0e24u3rPVNtXA6uLrvTj/T3rvq1qb2m+KhwJtAxQRv5jhAlw3N3Unquh5lUh9LjywA8p4xLQJMsx9fJ2JiSzGUVgsE3ucbI2SjSVcFUxTiav6MsA26PGiWopdHk+cK5uCx+n6fAlCDLPzvkilvIYkfA==; s=purelymail3; d=arkamondal.net; v=1; bh=pE/qw8FfkqhChHBlz0WOVn3qQtoKxR6VjHusmcRAR4A=; h=Received:From:To:Subject:Date:Message-ID;
DKIM-Signature: a=rsa-sha256; b=afA633Xb3cx1g5jL96s+ZdLj6iZQnZUgQ1TAwPrTUfOLtml4JVBrQG0jhLml2RZyN6eY9txBCAMGaMmubht+PvEXnSq0Jy+8sjOnx0GtUH5XVEYHiGJoqpaN+wRUab+FMiF2vnFnGgngUNDulyr4brHQbtXtLVRF+03c+myWM0XPa6SY1Aa3iVdEzI690mGbiyA54/Qsqo4736BoRxhGyZXkAJ6F241ft9IsB3FumVp/G4rZb0fn3/4O0aUU5ADQWUNCBMV6Whw1sxSeniAxe1SQ///sNBXRzUPennWOir+iauEJg48hHGZJ7rUl3Mng6tu+qqBYOxcARkJDwZhxDQ==; s=purelymail3; d=purelymail.com; v=1; bh=pE/qw8FfkqhChHBlz0WOVn3qQtoKxR6VjHusmcRAR4A=; h=Feedback-ID:Received:From:To:Subject:Date:Message-ID;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -257840358;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Nov 2026 05:07:53 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 2/2] iio: light: max44009: Report the integration time via read_avail()
Date: Mon,  9 Nov 2026 14:07:38 +0900
Message-ID: <20261109050738.93424-3-arka@arkamondal.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109050738.93424-1-arka@arkamondal.net>
References: <20261109050738.93424-1-arka@arkamondal.net>
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

The integration times the light channel accepts are listed by a custom
attribute named illuminance_integration_time_available. That name has
no in_ prefix, so it is registered at the device level instead of
beside in_illuminance_integration_time, and userspace looking for
in_illuminance_integration_time_available finds nothing.

Report the list through read_avail() and drop the custom attribute.
All eight values are a whole number of microseconds, so they go in as
IIO_VAL_INT_PLUS_MICRO pairs with nothing rounded. The values do not
change; the core prints them with six decimals, so the attribute reads
0.800000 down to 0.006250 instead of 0.8 down to 0.00625. read_raw()
still reports the time itself as IIO_VAL_INT_PLUS_NANO.

Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    No hardware available. Loaded against CONFIG_I2C_STUB under qemu:
    in_illuminance_integration_time_available reads 0.800000 0.400000
    0.200000 0.100000 0.050000 0.025000 0.012500 0.006250, and the
    unprefixed name is gone.

 drivers/iio/light/max44009.c | 48 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 82b8a806c5fa..8a57b9812f7f 100644
--- a/drivers/iio/light/max44009.c
+++ b/drivers/iio/light/max44009.c
@@ -66,15 +66,16 @@ static const u32 max44009_int_time_ns_array[] =3D {
 =096250000,  /* Manual mode only */
 };
=20
-static const char max44009_int_time_str[] =3D
-=09"0.8 "
-=09"0.4 "
-=09"0.2 "
-=09"0.1 "
-=09"0.05 "
-=09"0.025 "
-=09"0.0125 "
-=09"0.00625";
+static const int max44009_int_time_avail[] =3D {
+=090, 800000,
+=090, 400000,
+=090, 200000,
+=090, 100000,
+=090, 50000,
+=090, 25000,
+=090, 12500,
+=090, 6250,
+};
=20
 struct max44009_data {
 =09struct i2c_client *client;
@@ -101,6 +102,7 @@ static const struct iio_chan_spec max44009_channels[] =
=3D {
 =09=09.type =3D IIO_LIGHT,
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED) |
 =09=09=09=09      BIT(IIO_CHAN_INFO_INT_TIME),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
 =09=09.event_spec =3D max44009_event_spec,
 =09=09.num_event_specs =3D ARRAY_SIZE(max44009_event_spec),
 =09},
@@ -284,17 +286,21 @@ static int max44009_read_raw(struct iio_dev *indio_de=
v,
 =09}
 }
=20
-static IIO_CONST_ATTR(illuminance_integration_time_available,
-=09=09      max44009_int_time_str);
-
-static struct attribute *max44009_attributes[] =3D {
-=09&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
-=09NULL,
-};
-
-static const struct attribute_group max44009_attribute_group =3D {
-=09.attrs =3D max44009_attributes,
-};
+static int max44009_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09*vals =3D max44009_int_time_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09*length =3D ARRAY_SIZE(max44009_int_time_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
=20
 static int max44009_threshold_byte_from_fraction(int integral, int fractio=
nal)
 {
@@ -464,7 +470,7 @@ static const struct iio_info max44009_info =3D {
 =09.read_event_config =3D max44009_read_event_config,
 =09.write_event_value =3D max44009_write_event_value,
 =09.write_event_config =3D max44009_write_event_config,
-=09.attrs =3D &max44009_attribute_group,
+=09.read_avail =3D max44009_read_avail,
 };
=20
 static irqreturn_t max44009_threaded_irq_handler(int irq, void *p)
--=20
2.56.0

