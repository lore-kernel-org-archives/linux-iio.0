Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC72384CEF
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348350; cv=none; b=OyrJA5CeOghWqU9Vx32S5CRI9nwr/bthhAVyrwjfIUfwGy/pxX9JtSQrWSh27uAJmcfqc1pftSBPVvjV1DoejFsmVG9jG7otQzgWBVvc/x+6ieQ4jhGRJDHrSNMzy1bRTvGKMllvQH8bqiDoOazsYCmR67g8QPKP4CY8zjjbzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348350; c=relaxed/simple;
	bh=Sf0i42shFsIJxWpnZfQzTBN4eFSekniquXXbfx+XhWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PglOqQbzwGJHtun3UyJ8IGGAkrM7Cg//11Njz8cMjLL/2iijItDe4XM61FZyDKMB7Uad6KMsFJCArunE2KUwRbWvpHQxhLvf06xCDCT80nwz5lOSsz+vhdRpRka6O8jZtu6x2djGTPjvYmfamdxMHr5WKmELlIS0NycdGQQdxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aB0A6hzI; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aB0A6hzI"
Date: Mon, 10 Aug 2026 10:51:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348347; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=7Wj0jGHBOpOwOerk9TCXZGOWhMSAGjptDHTiW1Id/wo=;
	b=aB0A6hzIRD5WJ5ZiV1Syoq6g0ZTRt1k01IzIaMJmQAfjBRYsFZon9hUJsSEzU+DK6M5cd7
	oPJdoKHPVb3XpVkYGA2Ity3xnjmchAXgwFHzdsfq7HeF7NGz6Ifqv+NMmfCmZJ1NqCHh0J
	91pLiyXEQwFLTi1Dv7ubEgdjiaN16GE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: [PATCH 05/12] iio: dac: rohm-bd79703: Do not allow writing SCALE
Message-ID: <bf75f4bb0d3d620e5c613c04cfc874767a51ff38.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1xA2rRkbj2vi5ica"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--1xA2rRkbj2vi5ica
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BD79703 has adds IIO_CHAN_INFO_SCALE in the info_mask_shared_by_type
so users can read the scale, which depends on the used reference
voltage. This, however, enables users to try writing the scale as well.
This isn't really supported but the bd79703_write_raw() does not check
the mask, and if written scale values pass the validation, the driver
will proceed writing the DAC value when users writes the scale.

Prevent the unsupported scale setting and return an error.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: af6aca656a85 ("iio: dac: Support ROHM BD79703 DAC")
---
 drivers/iio/dac/rohm-bd79703.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/rohm-bd79703.c b/drivers/iio/dac/rohm-bd79703.c
index e91090e4a66d..68e66e7286d8 100644
--- a/drivers/iio/dac/rohm-bd79703.c
+++ b/drivers/iio/dac/rohm-bd79703.c
@@ -73,6 +73,9 @@ static int bd79703_write_raw(struct iio_dev *idev,
 {
 	struct bd79703_data *data =3D iio_priv(idev);
=20
+	if (mask !=3D IIO_CHAN_INFO_RAW)
+		return -EINVAL;
+
 	if (val < 0 || val >=3D 1 << BD79703_DAC_BITS)
 		return -EINVAL;
=20
--=20
2.55.0


--1xA2rRkbj2vi5ica
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gwoACgkQeFA3/03a
ocWYgwgAmdeguctzgeUh4DXpbnRsx4/scOnBDEh9zAV38f4dcSUk5OWLocamRAO/
BLzXtJ48H1Ng+/+CM3xtQGyIqOWCN5vmUzasJhYGwuQBhzNea2BHw0OjZGbi+0Hr
toNqBgBbwSKLHOm8TgiuVYRfdPbOfHHbhwqsbQlPg6u7lsVFF2LE0qSRXCGbC2Bg
73GOVypBsOWnQ7YpkuZtDL5kTDk12ybGdeG5VA+PvUTe7ichK80I3nSUfUoadQdD
xLyRAFb1wI2EJVIdPK3/rxKhR1Tj3tjG07rG2+blaclsipnHO6pOvfNiPGtvozoH
py1K+MlQcKgtiCI4nAJ1Sn6nxn/jVQ==
=4IUX
-----END PGP SIGNATURE-----

--1xA2rRkbj2vi5ica--
