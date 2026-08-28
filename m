Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7893C1400
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902830; cv=none; b=SofwsgZ//a/03QqYB9mqnyVPpxN3ETFGBb7oMe0iKUliYAInO4tz5HHwAsjJtClyq9kAZ3++8QOYxlry879RozWBUsn1cciL7Io7s5tSOm6srLwOWWaLYlM2iPFF3GViCpI/tYGTaZo0CNyqyc5PFGvsLhtK1MzGAplPaUo5sbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902830; c=relaxed/simple;
	bh=WiHmKiduUpKlnP5Po+j7XyvB9JPEn6BsDP5e1SZg/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+0FyisJQUMdJSHd2b/otEp9fokssc1RmhqrpTFzS2/uYXyPTdq4ZkwYLJNpCjNvozhckDTjFpcbJ4gEqMc/6OlYvE2IZhcmaCMmfs3N9lsDnciDnqyhSWkHHkilzY7EpKzIC2OL8R1RBv8VPacuz770x3ZyOf1HlYTOPRPXyXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PnibB2CA; arc=none smtp.client-ip=95.215.58.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PnibB2CA"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WiHmKiduUpKlnP5Po+j7XyvB9JPEn6BsDP5e1SZg/Wo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902827; v=1; x=1788507627;
 b=PnibB2CA8LZMNHDRYeFs6XBkoOj4LJ5hSJ3avR6N2kzXZFn69JZwO8cQAw067hGMj7MjoBbl
 7o7OXB/JM8zyI8RcMapmzlXwgEzEFqAmksDUOW4xWZ4Zeq5ILprIT5Zg1QWsWza7Q4IauJTMczt
 6AStfBx14vk/Hl7jc7mez7vI=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e770f2a1a4a2e097;
	Fri, 28 Aug 2026 07:40:26 +0000
X-Mizu-Trace-ID: e770f2a1a4a2e097
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:40:18 +0300
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
Message-ID: <78db4d1cf1d63f6533d519e28059b981f98e5239.1787901813.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KXP85shw15DLAuOJ"
Content-Disposition: inline
In-Reply-To: <cover.1787901813.git.mazziesaccount@gmail.com>

--KXP85shw15DLAuOJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
field location is not taken into account, and value is written unsifted.
This causes the AVE_NUM to be initialized to zero.

Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.

Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
I believe this was already applied to Jonathan's 'testing' branch. I
didn't find that from public IIO repository though, so spinning it here
just for the sake of the completeness.
---
 drivers/iio/pressure/rohm-bm1390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm=
-bm1390.c
index d00d7ed54cb1..29454570f257 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -479,6 +479,7 @@ static const struct iio_info bm1390_info =3D {
=20
 static int bm1390_chip_init(struct bm1390_data *data)
 {
+	u8 regval;
 	int ret;
=20
 	ret =3D regmap_write_bits(data->regmap, BM1390_REG_POWER,
@@ -512,8 +513,9 @@ static int bm1390_chip_init(struct bm1390_data *data)
 	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
 	 * be fixed when IIR is in use.
 	 */
+	regval =3D FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
 	ret =3D regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
-				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
+				 BM1390_MASK_AVE_NUM, regval);
 	if (ret)
 		return ret;
=20
--=20
2.55.0


--KXP85shw15DLAuOJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqRO2IACgkQeFA3/03a
ocUgAQf8CprQW87BeQOSYHeD0fIHQjf5nlgVHDgY4164H+HMjQ3C2PkgQcxQlj89
l5FC8iJ4DVxcvl+ImABmqQu6bx4hHYzhjXVHC1zTSYRdkdwChFdV/GRXInNywb1g
8Y2dxhhqGVslwCXkbj1xI6v4qi5FK7PPrnJAHtwdG7GISjf+aGYvEUJ1cWeGnuRq
H7qkwl98ODTblEZiNSv2OGFZMXSWSoMtSVOqgZBDN0Fy/I6ew1uZmrY+3gRRxk31
QBNuycCJi9dI4yib2sDiN8fp42iF+hrQ+TQEmRcbMzdkoIQ0uOjcJw5koWlKUUVW
QY9Y0o15UF4qNuRKpfPPnN3XM2XrAA==
=n0Xu
-----END PGP SIGNATURE-----

--KXP85shw15DLAuOJ--
