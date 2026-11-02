Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605673;
	b=UF/e4KgqQv1Oi5heXZFm0toWVrfVUINvGATuF2GatO5XMV49SVifLtyjVH3v92EZddyR
	 MG76ifX4D94M2WSnn24x15aXeuZzzV1atsTRbxDvrlp2pJ7sKyvc3kCf+OEc5dSMbtMNt
	 VIEfjSnqIRH2MFQq0cflEj4LeBg0DN9fvdHbIpdU5/QFul2akZjUCqpA9xDemoACcjIcb
	 jJqQ23LMguXcs1RwwzCX0cBxgAjtCHVCnFsvejAjp8xDKLDMTIRYL7K+FJTeIQ9mb5VOu
	 h/SzPxMIO0FL7jVInmw7LeESPrt4TEMrrAYubrFewdMgZGH7F+hFCr6025bAoIvfbEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605673;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=FeIx4dzmURooP5wG8/54evVP3vGrvxb91slTM/ZxWFA=;
	b=424kE4udZDahdJ8W66bhobbYNoZ27g+AC4Al6LlJOa2+YPlx5OQ22QIYuVAMKgAxIfLz
	 ysKyopyoSwX2xgb07HW8jUMQNjCVjOJ7zLjE8ACLSUrQtVWOHwje3INjFfYX2dbYSx5/z
	 U6kO41QnjJI+sasAOseJ8nAU+oVTKi0RddAWv9J5PYPbRe5X2wuX+cbtpl1LXZTe16Cxy
	 zLOQP/19RCJWhkdpGNQYMmEyVJwg28850mys/fO60rtrux2Vw3z9nuXMa2AWO9COKNr2r
	 xzDx9aDhGO49swIo6sjEEsz5C4LYoUQGRUUKXfPhIwEgfcEuC6ezpZ3sAP3qFBY1bnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b="vNQFqCq/";
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=m9xDYiDs;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C15606A334
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83C15606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=vNQFqCq/;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=m9xDYiDs
DKIM-Signature: a=rsa-sha256; b=vNQFqCq/fEslY6fX/cxvQiCwQ3lLbMp9DhfaLSz9b2PvfxWarebnH5/Efx/55gpjfkCS5GumQV2I9malxRQTM85dOCb7FtYYZzUY0wv8juiHttBOE++lYVHYjJyo4AfMRxUW+w+ol+ZUHN1a7odPiktUCcIMqtTMjxxerSExPW5JQwqrHU98KX+aF/VdcugTle8FCyY02pRUrNd7TS8F8B723H9jvF7H3M2Yt9F9LWkTxQ97Fu/5fvPcIvMZ/9f7FcR66/w/7u9IX2kBFSn8alP1p7ktijqX9jgbmtAkPUQH+G6j6FIg2e9qksIyJZGmLsEmKFOV2xa5y9nWkaK3GQ==; s=purelymail2; d=arkamondal.net; v=1; bh=N4w/bqepOp7PYyP7DJC2XK6cVydXAwSld8Bu6X8bkVY=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=m9xDYiDs1RUYCSJ4ZfkJTquDJb1KGakUson2WjxKnrdmVjQ9lX7Ba9bo7MZBI9e1h9EWyrGckMcaQbXU4nj9STki7dM1zdpjBAEVtm3fdgzxhYB162WPEe8nLFKnBEXCdADe3Lgvq1cIT/sfQ/YwtA6iVXR+6MCRJQiqLlbSoE1LVnCaDk4tz/Qxi1MgEYimnJjUPJMaquIOqCBV/4YSDH7upfs1xDRfDNod7d/102ETkn5SlOvcmiy+hFxwTTOYM2ocyTy8Iwds/ERXfcaozXs7ZHS0q7OJ71aBCVAUQd1LPWyRJgs474CjBIRixerhIHWhbh7/9R5R16I/YJv4Hg==; s=purelymail2; d=purelymail.com; v=1; bh=N4w/bqepOp7PYyP7DJC2XK6cVydXAwSld8Bu6X8bkVY=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1618937125;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:31 +0000 (UTC)
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
Subject: [PATCH 5/6] iio: humidity: hdc100x: Report the available lists via read_avail()
Date: Mon,  2 Nov 2026 16:46:59 +0900
Message-ID: <20261102074700.63075-6-arka@arkamondal.net>
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

The temperature and humidity channels have IIO_CHAN_INFO_INT_TIME in
info_mask_separate, so userspace sees in_temp_integration_time and
in_humidityrelative_integration_time. Two custom attributes list
the values they accept, named temp_integration_time_available and
humidityrelative_integration_time_available. Neither carries the in_
prefix of the attribute it describes, so both sit at the device level,
and userspace that opens either prefixed name finds no such file. A
third attribute, out_current_heater_raw_available, already has the right
name and keeps it.

Report all three through read_avail() and delete the attributes and the
group that held them.

The two time lists hold what hdc100x_set_it_time() accepts. Its loop
ignores a zero request, so the padding entry in the temperature row of
hdc100x_int_time cannot be selected, which is why the temperature list
has two entries and the humidity list three.

No value changes. The heater list still prints 0 1, and the core prints
the times to the six decimals of IIO_VAL_INT_PLUS_MICRO: temperature
reads 0.003650 0.006350 where it read 0.00365 0.00635, humidity 0.002500
0.003850 0.006500 where it read 0.0025 0.00385 0.0065.

Fixes: 4839367d99e3 ("iio: humidity: add HDC100x support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/humidity/hdc100x.c | 61 ++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.=
c
index bc452cc8fbcf..e2780e436655 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -69,26 +69,19 @@ static const struct {
 =09},
 };
=20
-static IIO_CONST_ATTR(temp_integration_time_available,
-=09=09"0.00365 0.00635");
-
-static IIO_CONST_ATTR(humidityrelative_integration_time_available,
-=09=09"0.0025 0.00385 0.0065");
-
-static IIO_CONST_ATTR(out_current_heater_raw_available,
-=09=09"0 1");
-
-static struct attribute *hdc100x_attributes[] =3D {
-=09&iio_const_attr_temp_integration_time_available.dev_attr.attr,
-=09&iio_const_attr_humidityrelative_integration_time_available.dev_attr.at=
tr,
-=09&iio_const_attr_out_current_heater_raw_available.dev_attr.attr,
-=09NULL
+static const int hdc100x_temp_int_time_avail[] =3D {
+=090, 3650,
+=090, 6350,
 };
=20
-static const struct attribute_group hdc100x_attribute_group =3D {
-=09.attrs =3D hdc100x_attributes,
+static const int hdc100x_humidity_int_time_avail[] =3D {
+=090, 2500,
+=090, 3850,
+=090, 6500,
 };
=20
+static const int hdc100x_heater_avail[] =3D { 0, 1 };
+
 static const struct iio_chan_spec hdc100x_channels[] =3D {
 =09{
 =09=09.type =3D IIO_TEMP,
@@ -97,6 +90,7 @@ static const struct iio_chan_spec hdc100x_channels[] =3D =
{
 =09=09=09BIT(IIO_CHAN_INFO_SCALE) |
 =09=09=09BIT(IIO_CHAN_INFO_INT_TIME) |
 =09=09=09BIT(IIO_CHAN_INFO_OFFSET),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
 =09=09.scan_index =3D 0,
 =09=09.scan_type =3D {
 =09=09=09.sign =3D 's',
@@ -111,6 +105,7 @@ static const struct iio_chan_spec hdc100x_channels[] =
=3D {
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
 =09=09=09BIT(IIO_CHAN_INFO_SCALE) |
 =09=09=09BIT(IIO_CHAN_INFO_INT_TIME),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_INT_TIME),
 =09=09.scan_index =3D 1,
 =09=09.scan_type =3D {
 =09=09=09.sign =3D 'u',
@@ -122,6 +117,7 @@ static const struct iio_chan_spec hdc100x_channels[] =
=3D {
 =09{
 =09=09.type =3D IIO_CURRENT,
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
+=09=09.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_RAW),
 =09=09.extend_name =3D "heater",
 =09=09.output =3D 1,
 =09=09.scan_index =3D -1,
@@ -328,10 +324,41 @@ static irqreturn_t hdc100x_trigger_handler(int irq, v=
oid *p)
 =09return IRQ_HANDLED;
 }
=20
+static int hdc100x_read_avail(struct iio_dev *indio_dev,
+=09=09=09      struct iio_chan_spec const *chan,
+=09=09=09      const int **vals, int *type, int *length,
+=09=09=09      long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09switch (chan->type) {
+=09=09case IIO_TEMP:
+=09=09=09*vals =3D hdc100x_temp_int_time_avail;
+=09=09=09*length =3D ARRAY_SIZE(hdc100x_temp_int_time_avail);
+=09=09=09break;
+=09=09case IIO_HUMIDITYRELATIVE:
+=09=09=09*vals =3D hdc100x_humidity_int_time_avail;
+=09=09=09*length =3D ARRAY_SIZE(hdc100x_humidity_int_time_avail);
+=09=09=09break;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09return IIO_AVAIL_LIST;
+=09case IIO_CHAN_INFO_RAW:
+=09=09*vals =3D hdc100x_heater_avail;
+=09=09*type =3D IIO_VAL_INT;
+=09=09*length =3D ARRAY_SIZE(hdc100x_heater_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
+
 static const struct iio_info hdc100x_info =3D {
 =09.read_raw =3D hdc100x_read_raw,
 =09.write_raw =3D hdc100x_write_raw,
-=09.attrs =3D &hdc100x_attribute_group,
+=09.read_avail =3D hdc100x_read_avail,
 };
=20
 static int hdc100x_probe(struct i2c_client *client)
--=20
2.56.0

