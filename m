Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605673;
	b=C7ij5pP5InBs/I33yJdZHBDq0DbsD6fo788ExEp8Chfnd8BnImeSoof7qF35XGkj7ZVg
	 e+uCivZDK1nECtF8Ssmy4bggVHtdlzxL2K8tB5LJPPkxaT8MG4dUid3zzSPDLIIQDB4W1
	 C3UhBcyK3pSuUt5WHEtoS+SEJ18JIAuF4hTH/whnbdZ+v5fI/va/0tTre8Yg73hr0riek
	 QmwbT7D3IvYd60BF1/yq6wdZx5UMrRNnTNuNq1HSSr2y+QKo70UUpoB8QmFQbwvwqAqJ1
	 hvP8Zc+/YtUFbBkU65NFAZLGjSgwCvsrtW6/UzCjWvM8frF3N30/dwjePKf6npkhM+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605673;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=EQgB7Ymd+fLPzCCXTdlf20s2pSdfk7pjaO9SMb1ZYts=;
	b=xCNLXmr+pbEoF3GlDJGCIotBsMVXnpuFqEhwQO0nnEikWyos6nCgJPiBnqsQcli5/eLX
	 yPvAqbj69GzVKfwteqZYZhkB8gc3Amn2hPl7jGi6dnn0J4ErcDked9zXavKJl4SPoJ6CS
	 JI5e1foL9FqHedXJdVYkkOAGyhzAXfzskWraBNwBXFfhhJxw+vMxha5jJ5U8XzltDljrl
	 d248B7uNuvei8d61d6w7YtaZgMFSQ+TFCTMQ5ILeoZeM5F3LuriZvLGmQHX1DmLeWavYf
	 5iV9EwnndoUB018HdOy95h0AQ1vtLO5M5S6Jdyo/t10U13MBCZPHW7vv1MxBYLDGAJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=SQ+OKXSi;
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=MEk6d+TC;
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86665606A331
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86665606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=SQ+OKXSi;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=MEk6d+TC
DKIM-Signature: a=rsa-sha256; b=SQ+OKXSiBOuOEIzZ3u1EVWR1aNcfDvECMkZvsNsaVfsuES5iF7cebsRIvMIh6cj05GFp7y40wCjfsn7kRQeg7145ex+gTwbJhi/7F+fntzGQIcvOvYLTgp7cWvA7XItATDVv2+Y1Ea40Bmd/ft7XyLOFX0oobVFr5bAnbGiXg1QiPI7Y4tmbn1ZCBaguFjQajvc8mUeQxHOjwdSKORs8hG7tvzr3QxH5GyzLXKlLEs8QazJbRoGd/C3qyCLl43p60QuGcLQq9OQZIdqBUhyvZrwrZHSLPGuCCSkARrouoetcby9eWk0v0EWkJPvSOudod9r+8EQlbf4hBWcLlqWBdA==; s=purelymail2; d=arkamondal.net; v=1; bh=GmGZH8whE4wcJYRb/27cdLgLfp23NjLnMdb8HMiYNzw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=MEk6d+TCwHZB1q2VfN7JKTE2b6Bq2IVHGPuBWTxGNY6L378FBt3z7aZMrZ91nkG/JA4HOxN/abcJHj/i2v4lrO5x5ClP8KohWZps6GUktL5to/kt7xsF7AMLN5WrID6mGJljTp/xrK9OcY+GYkyIucGvqZY99uYC3/X8jDE4gh/bdhi9QHnHdZ0RfMuT9JMBENG0lrkLYTG6gKQV6GQGfMGCubCZhNea5Y/jBjCkdPZNxdolByi2p7W+gfEg+mQgGBIeORJB7rUZU2gWfQ8SE1BLzgwXRCCYecYwzyL+PDldKqtgP4lFvpFgLQnHpiCbcBuhpTydD521how+G4eDNw==; s=purelymail2; d=purelymail.com; v=1; bh=GmGZH8whE4wcJYRb/27cdLgLfp23NjLnMdb8HMiYNzw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1269390563;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:26 +0000 (UTC)
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
Subject: [PATCH 3/6] iio: light: max44009: Report the integration time via read_avail()
Date: Mon,  2 Nov 2026 16:46:57 +0900
Message-ID: <20261102074700.63075-4-arka@arkamondal.net>
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

The light channel has IIO_CHAN_INFO_INT_TIME in info_mask_separate,
so userspace reads the integration time from
in_illuminance_integration_time. The values it accepts are listed by
a custom attribute called illuminance_integration_time_available.
That name lacks the in_ prefix the core puts on the attribute it
describes, so it is registered at the device level, and userspace
looking for in_illuminance_integration_time_available finds nothing.

Report the list through read_avail() and drop the custom attribute
along with the string it printed. read_avail() wants the values as
IIO_VAL_INT_PLUS_NANO pairs, while max44009_write_int_time() rounds a
request to the nearest supported value with find_closest_descending()
over a flat table, so the two forms stay as separate tables.

The eight values do not change. The core prints them with nine
decimals, so the attribute now reads 0.800000000 down to 0.006250000
instead of 0.8 down to 0.00625.

Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/light/max44009.c | 48 ++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
index 82b8a806c5fa..c27f0f9ecc44 100644
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
+=090, 800000000,
+=090, 400000000,
+=090, 200000000,
+=090, 100000000,
+=090, 50000000,
+=090, 25000000,
+=090, 12500000,
+=090, 6250000,
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
+=09=09*type =3D IIO_VAL_INT_PLUS_NANO;
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

