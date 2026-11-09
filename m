Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794200881;
	b=Me3ozMAcBgAH5XJXPVxUx9gSEPNp/Gd8SLAjw6QkYKA8Oyb3AL3uRPdwsubRZ4oqjOfg
	 A74Tx1KJFoRTblGN780Ez2GwvJcgSvLk6i5vHLaldgwVHXDXj7cbg8JsoA14k811XGpMa
	 MH27db9w/b6neR2ujWLUT9D8rgJFEhz8Ma3iNRoWgKK+kMo5KYbWonCfdDUoYiiyhyV0l
	 GJPYXIKnXHOo9Ex9kRQzT2ejMIeez22fvbqZZsYP/2JxM8vbzFDWKCpE5kuMxFNu3Qcwf
	 9AXjs6EAUvHbLKnym+BE8uYqfdAavpbLK5QHqSI43Hw4toieRVo88IAy6U+L1HWOc5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794200881;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=RNc3qCGq+/S1X88hLaUUw7mTPXjVUZIvJy21pAP+uf8=;
	b=STPQuGs8v88OfPOuGgMOa8g3SvMSGGX9xIB+HFjbA+wyyrolLNbze+M2sPWN037jH3KV
	 p/3xwDjcKQ7cO7FBVRaO3kyqdz+LTXprGvZeUkbzkgzs4Dmkk1Vy5NUpMFce7b177eoFb
	 sHAJ0cnooSdWlU3k8j7mJXXexaOWXSUXPAhEVyU19DyCPblcnyGKutjqwFAJLZoBg+2dO
	 G+Gs7un0Hz7Pe5nFWeN5YPHldl8J7UPGvMPexONAAFNXOjgrpvkuIeJYXxUHn/Tgv94Ay
	 jt4+5HOpuXtogltYDWV7tSAdBQ65Q25jCFCpYUZvPQjLMtqgc1zJLYbIapLLBExbFrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=iXRURjtO;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=nDyFA0UR;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD5606A31C
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 05:08:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6FD5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail3 header.b=iXRURjtO;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail3 header.b=nDyFA0UR
DKIM-Signature: a=rsa-sha256; b=iXRURjtOONHd0aAliAvCk+eU5syG8N/FdswLJmi2x6ZxlUf9jE+hrTTLeDmVRCXtgY3bSOUCgyuTLw2+7BRt5DuU7wvKCAmu1oe/D+oYlF4QarOcAugKDzPZ4I2axNZcK3gk6HMMMTVcONmyJyN7zA5EvzzVuQFuUtwlo/nCqRxA0LZADU0sTESxXv/d7TQERj2/+qPZ89SXqEfPYnH18QCiPwJjKAH/vikURfnTMi5PJ0iI8iTz2iGU8nGAURdFtxl0oqPqOkTWyKqVgYQBIoRa8BNN5jaZcQaRBL4v5OG/7AAfmmdulIrPjJoey3a19ffCJJjkx21wW4QdSsOGsQ==; s=purelymail3; d=arkamondal.net; v=1; bh=mahALXO//pswFVtPfmBPPDYiXicIg1M7bknkqEYN6Fw=; h=Received:From:To:Subject:Date:Message-ID;
DKIM-Signature: a=rsa-sha256; b=nDyFA0UR3qTW85k3V3d9ZZ8auulgUTL2HyTpNidI/BWZAxfBIGb3YlRzxqBX2zOIHb0J5+vo2FhXCor1taKVXxLSj5Gp4vMXvr+fi+2cNvbD/bOpwrW9sEeZJ3ZPBb1R6f8YrmvSyd1JXbERQ7HkSPjHEYS41wg0Ylm56kTSge19N+tlAotpk7dfRSnatczKf8wKgJjcPKKyO3cFMYMJkhs+ivrnObFq6MqNojph8FQFxw1fmvrtBhLOAd02oyyGxySB952pQJHa3PlyY/Vw/zBYMsBhAOfsrczbe7iJtGrjF3nWjv3aDAPBVuJCzQWG0aT1XpdIDdXhwwS8k5T6bg==; s=purelymail3; d=purelymail.com; v=1; bh=mahALXO//pswFVtPfmBPPDYiXicIg1M7bknkqEYN6Fw=; h=Feedback-ID:Received:From:To:Subject:Date:Message-ID;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -864015764;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 09 Nov 2026 05:07:51 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Robert Eshleman <bobbyeshleman@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 1/2] iio: light: isl29125: Report the scale list via read_avail()
Date: Mon,  9 Nov 2026 14:07:37 +0900
Message-ID: <20261109050738.93424-2-arka@arkamondal.net>
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

The scales the intensity channels accept are listed by a custom
attribute built with IIO_CONST_ATTR and named scale_available.

Report the two values through read_avail() and drop the attribute
group. The available bit goes in info_mask_shared_by_all_available,
the sharing level the core names scale_available, so the file keeps
the name it has. The scale itself stays in info_mask_shared_by_type
and is still in_intensity_scale. veml6030 and ti-ads1015 hold
IIO_CHAN_INFO_SCALE in info_mask_separate and list it under
info_mask_shared_by_all_available, so the pairing is already in use.

The two values and the text they print do not change.

Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    No hardware available. Loaded against CONFIG_I2C_STUB under qemu:
    in_intensity_scale and scale_available are both present,
    in_intensity_scale_available is not, and scale_available reads
    0.005722 0.152590.

 drivers/iio/light/isl29125.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index 9e0b7e6a3ecf..35a378cc3990 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -58,6 +58,7 @@ struct isl29125_data {
 =09.modified =3D 1, \
 =09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
 =09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), \
+=09.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_SCALE), \
 =09.channel2 =3D IIO_MOD_LIGHT_##_color, \
 =09.scan_index =3D _si, \
 =09.scan_type =3D { \
@@ -198,21 +199,31 @@ static irqreturn_t isl29125_trigger_handler(int irq, =
void *p)
 =09return IRQ_HANDLED;
 }
=20
-static IIO_CONST_ATTR(scale_available, "0.005722 0.152590");
-
-static struct attribute *isl29125_attributes[] =3D {
-=09&iio_const_attr_scale_available.dev_attr.attr,
-=09NULL
+static const int isl29125_scale_avail[] =3D {
+=090, ISL29125_SENSING_RANGE_0,
+=090, ISL29125_SENSING_RANGE_1,
 };
=20
-static const struct attribute_group isl29125_attribute_group =3D {
-=09.attrs =3D isl29125_attributes,
-};
+static int isl29125_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D isl29125_scale_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09*length =3D ARRAY_SIZE(isl29125_scale_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
=20
 static const struct iio_info isl29125_info =3D {
 =09.read_raw =3D isl29125_read_raw,
 =09.write_raw =3D isl29125_write_raw,
-=09.attrs =3D &isl29125_attribute_group,
+=09.read_avail =3D isl29125_read_avail,
 };
=20
 static int isl29125_buffer_postenable(struct iio_dev *indio_dev)
--=20
2.56.0

