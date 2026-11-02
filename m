Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.202.193.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793605673;
	b=DLAqwyR/R0r9g8ulIQ6NcpaXEl3FDWylc1vaP634VMSws4gSf4f6Ya6bWakaZECqflVv
	 n3XNvwOS7ywRyqNqQa4LL8lQ7EbyEBKpWTl+AYcQOun2v8lVpzNujspZjI2QY57HsJ4ZC
	 6aZcV5bqYT9+UhVypHpkmyMToR5GSxUJhbZsXVnJjensZdl8kEaCzICjtNvsFA66CXI4Y
	 UeEPUkoUQPlaKjqBFNA3937oixbp/MB9beJZyFSAm4gXx6OhaeJNMfljxb/bBjP6fgCZJ
	 +LdmaU1mwwIF7sTFz7Hq0tUY6aptUg9zdSs1gj7fCR2WDzv4Tjq8kcSIFeBfnjjqiNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605673;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:Feedback-ID:
	 X-Pm-Original-To:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MIME-Autoconverted:Content-Type;
	bh=Klj60h8HQ29wEudOMHcX3kt40+YhSZgfn82l8HFZq8M=;
	b=HgnizQwIp1bAPVvfISFyrRDv7VVndyd9k1G8ilQgZjVbAowRf3JTQY5gGX9XOkMl/x1e
	 6vRXWggApPaJc5NLVPsZ302SyLgi54o/F56YFRWXhZAxxBEsqiMUGum/Yv721pE0fptUz
	 XikdZGZxI8VbN8K0WxBQuJmxOGuAfSCKEZ2K2ywShUOURNIWu3yvP7S2nTd6rN2kXlBTS
	 I0ZvK1B0EqI11FX6ZwsJ11jP4LUzZZX+cBsAL+shAtNmLy6yywJpQjIWSvjgG6O51FJAk
	 AFGfVTTeOr1Pv7ruWCTcBTRgWOePEFcKtrWg5gmlHvmh/fADS+ljAxkO9xFSKWRW1kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arkamondal.net;
	spf=pass smtp.mailfrom=arkamondal.net;
	dkim=pass header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b="haxp/zWc";
	dkim=pass header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b="qYi1/rw6";
	arc=none smtp.remote-ip=34.202.193.197
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B180606A333
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 07:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B180606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arkamondal.net header.i=@arkamondal.net header.a=rsa-sha256 header.s=purelymail2 header.b=haxp/zWc;
	dkim=pass (2048-bit key, unprotected) header.d=purelymail.com header.i=@purelymail.com header.a=rsa-sha256 header.s=purelymail2 header.b=qYi1/rw6
DKIM-Signature: a=rsa-sha256; b=haxp/zWcKGfYLH+VveVSgQ0hsiXc77MlCCKlMmaOP1HTPi2dtRz6rNJWIK8ZHAOuc1wcyAwySLxs9fJSLSpUJ9sjwN4Vve+ZQhDSfCE6ySORGVFAeveRHm+GyBMZIzEYc3GVIkLX//wJ8yvuNDBseBzX8VXkkFh/ncnTU0trMziQ7w9vzB7/GKeu7Fa5dS4TtDtS3ZIaJf2h4blZ8QmOIUYdhYXVDnOY971p3ikXQn+V1OK+8NDGPkhS/W3FCCu4PiB7DTgnQifqOJOlVsf44cidZoThgHemM4JfwieEJdmGuFMqlkJgpBrgd4MIV/vO2BmMC1oan/PEbdtVYJXhvg==; s=purelymail2; d=arkamondal.net; v=1; bh=yPD7e72BxlzGACPvkfjqczpIsl4woKKtHuunQfa11Zw=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=qYi1/rw6TYgFBMhnDKQ0si5sGK29P8I7uebb1IJlT7PmjWjriYTSS8X9hYhULlfErEFca69kEyqEeNIoUd+rLfdCxv9GQfoPIgSqqdnHj9JCGV6s43LndBT/RAdxB+6H6hi8XYZoJrRXj4dJJwIKdQOWBNvRDNozwTlbKMWxr6EiAeth5Ll1wWDjn9H6EN2hKTq0Oqgbsv5oEERLTqH1gL6zsDpRc5fLcQFyo2AiOqTK+qKm6GVIort/PWCtey6CQxGBE0mK7Nn/UE/bVJH+CRaOCelAKDjnI+xsQulQjL6qGd6SAcAB1RSPyV8wWfWm/0s8Jqpb64LRE1xT9F0AEg==; s=purelymail2; d=purelymail.com; v=1; bh=yPD7e72BxlzGACPvkfjqczpIsl4woKKtHuunQfa11Zw=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -370655267;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 02 Nov 2026 07:47:29 +0000 (UTC)
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
Subject: [PATCH 4/6] iio: light: max44000: Report the available lists via read_avail()
Date: Mon,  2 Nov 2026 16:46:58 +0900
Message-ID: <20261102074700.63075-5-arka@arkamondal.net>
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

The light channel keeps IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_INT_TIME
in info_mask_shared_by_type, so userspace sees in_illuminance_scale
and in_illuminance_integration_time. Two custom attributes list the
values those accept, but they are named illuminance_scale_available and
illuminance_integration_time_available, without the in_ prefix the core
gives the attribute a list belongs to. Both land at the device level,
paired with nothing, so userspace that asks for either prefixed name
finds no such file.

Report both lists through read_avail() and delete the two attributes
along with the strings they printed.

Each list uses the format the write path accepts, which
max44000_write_raw_get_fmt() gives as IIO_VAL_INT_PLUS_MICRO for
scale and IIO_VAL_INT_PLUS_NANO for integration time. The scale
is read back as IIO_VAL_FRACTIONAL_LOG2, the same number written
another way. max44000_write_raw() still rounds a request against
the ulux table with find_closest() and against the ns table with
find_closest_descending(), so both tables stay and the lists are
separate arrays of value pairs.

No value changes, but the core prints each one to the full precision
of its format. The scale now reads 0.031250 0.125000 0.500000 4.000000
where it read 0.03125 0.125 0.5 4, and the integration time reads
0.100000000 0.025000000 0.006250000 0.001562500 where it read 0.100
0.025 0.00625 0.0015625.

Fixes: d5d8f49b6345 ("max44000: Expose ambient sensor scaling")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/light/max44000.c | 60 ++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index 8c344f1b3fe2..9f9046e127c0 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -104,11 +104,20 @@ static const int max44000_int_time_avail_ns_array[] =
=3D {
 =09     6250000,
 =09     1562500,
 };
-static const char max44000_int_time_avail_str[] =3D
-=09"0.100 "
-=09"0.025 "
-=09"0.00625 "
-=09"0.0015625";
+
+static const int max44000_int_time_avail[] =3D {
+=090, 100000000,
+=090, 25000000,
+=090, 6250000,
+=090, 1562500,
+};
+
+static const int max44000_scale_avail[] =3D {
+=090, 31250,
+=090, 125000,
+=090, 500000,
+=094, 0,
+};
=20
 /* Available scales (internal to ulux) with pretty manual alignment: */
 static const int max44000_scale_avail_ulux_array[] =3D {
@@ -117,11 +126,6 @@ static const int max44000_scale_avail_ulux_array[] =3D=
 {
 =09   500000,
 =09  4000000,
 };
-static const char max44000_scale_avail_str[] =3D
-=09"0.03125 "
-=09"0.125 "
-=09"0.5 "
-=09 "4";
=20
 #define MAX44000_SCAN_INDEX_ALS 0
 #define MAX44000_SCAN_INDEX_PRX 1
@@ -132,6 +136,8 @@ static const struct iio_chan_spec max44000_channels[] =
=3D {
 =09=09.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
 =09=09.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |
 =09=09=09=09=09    BIT(IIO_CHAN_INFO_INT_TIME),
+=09=09.info_mask_shared_by_type_available =3D
+=09=09=09BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_INT_TIME),
 =09=09.scan_index =3D MAX44000_SCAN_INDEX_ALS,
 =09=09.scan_type =3D {
 =09=09=09.sign=09=09=3D 'u',
@@ -383,24 +389,32 @@ static int max44000_write_raw_get_fmt(struct iio_dev =
*indio_dev,
 =09=09return IIO_VAL_INT;
 }
=20
-static IIO_CONST_ATTR(illuminance_integration_time_available, max44000_int=
_time_avail_str);
-static IIO_CONST_ATTR(illuminance_scale_available, max44000_scale_avail_st=
r);
-
-static struct attribute *max44000_attributes[] =3D {
-=09&iio_const_attr_illuminance_integration_time_available.dev_attr.attr,
-=09&iio_const_attr_illuminance_scale_available.dev_attr.attr,
-=09NULL
-};
-
-static const struct attribute_group max44000_attribute_group =3D {
-=09.attrs =3D max44000_attributes,
-};
+static int max44000_read_avail(struct iio_dev *indio_dev,
+=09=09=09       struct iio_chan_spec const *chan,
+=09=09=09       const int **vals, int *type, int *length,
+=09=09=09       long mask)
+{
+=09switch (mask) {
+=09case IIO_CHAN_INFO_SCALE:
+=09=09*vals =3D max44000_scale_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_MICRO;
+=09=09*length =3D ARRAY_SIZE(max44000_scale_avail);
+=09=09return IIO_AVAIL_LIST;
+=09case IIO_CHAN_INFO_INT_TIME:
+=09=09*vals =3D max44000_int_time_avail;
+=09=09*type =3D IIO_VAL_INT_PLUS_NANO;
+=09=09*length =3D ARRAY_SIZE(max44000_int_time_avail);
+=09=09return IIO_AVAIL_LIST;
+=09default:
+=09=09return -EINVAL;
+=09}
+}
=20
 static const struct iio_info max44000_info =3D {
 =09.read_raw=09=09=3D max44000_read_raw,
 =09.write_raw=09=09=3D max44000_write_raw,
 =09.write_raw_get_fmt=09=3D max44000_write_raw_get_fmt,
-=09.attrs=09=09=09=3D &max44000_attribute_group,
+=09.read_avail=09=09=3D max44000_read_avail,
 };
=20
 static bool max44000_readable_reg(struct device *dev, unsigned int reg)
--=20
2.56.0

