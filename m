Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF7388E55
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348515; cv=none; b=NqnHqGkCIfRy9RUkVl8YHpHfbSswDKW9+fy4jIemC2HGkKG4cEGbopemOYKIgRykVXXXZIzLKLLYVyfTWx08WrWHCzeCbtSzWAPQPwXaeOEAZf+k0VLNkEPfken4/VTA0aqUtFTEGCl7zaqAE/h9NXMSIILm+dds2hu4g/XJ4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348515; c=relaxed/simple;
	bh=rsC7ZAU+lWgrhECQQExmehmWD+SEeAIJdEoJyeBSByQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n91rYWut3hzGqnI6djC+yb3TZ0NRXQX3ONjmSYnV7A+0G2xnI75vtcx4G2KAtFsKZUfK/Enmz3oj8DU2ebTcPHKASU1i39i0buFcM9BTcitpfh1Tdt3hvkOjZWtHgCcecIpDIU5OevUvRfaPcx1kbqb130/liqmeo/dXPcIBRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZS1CsYj; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZS1CsYj"
Date: Mon, 10 Aug 2026 10:55:03 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348511; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=S4/DNiYy9MWkTc1iQO/io8PRq7s6kyJYqDekbNN2XwQ=;
	b=fZS1CsYjEetBOcgSDvpORR8l5XxJyvSGctyCXXkC6nO0eYlWysS1OxeneAz0bB0WGTRN6g
	dyKchDUcCY7v9MdN9vWZfRgRA9OzleAAmN7DlIKrWFJAt2cJ2rzLNzOrxeGyM1zX0HsPSg
	zWiop3rLr2YQ2hhYAFH9WPcjBHKngac=
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
Subject: [PATCH 11/12] iio: accel: kionix-kx022a: Prevent memory leak and fix
 state
Message-ID: <85e6bd3998863e0247c52dcf0c1486b2cddff567.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F6/KSGT0MhpUJjYQ"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--F6/KSGT0MhpUJjYQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The driver allocates memory for samples at buffer enable path. If regmap
operation fails in the kx022a_fifo_enable() at the buffer enable path, the
allocated memory is never freed. Furthermore, the state information and
previous hardware configuration(s) aren't undone, potentially leaving
WMI interrupts and buffers enabled, or driver state flags wrong.

Free the memory and revert the hardware configuration and state flags on
error path.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add ch=
ip_info structure")
---
 drivers/iio/accel/kionix-kx022a.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 8a13f78aeab0..49e8b4b943da 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -980,26 +980,43 @@ static int kx022a_fifo_enable(struct kx022a_data *dat=
a)
 	guard(mutex)(&data->mutex);
 	ret =3D __kx022a_turn_on_off(data, false);
 	if (ret)
-		return ret;
+		goto err_free_out;
=20
 	/* Update watermark to HW */
 	ret =3D kx022a_fifo_set_wmi(data);
 	if (ret)
-		return ret;
+		goto err_free_out;
=20
 	/* Enable buffer */
 	ret =3D regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		return ret;
+		goto err_free_out;
=20
 	data->state |=3D KX022A_STATE_FIFO;
 	ret =3D regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		return ret;
+		goto err_wmi_out;
=20
-	return __kx022a_turn_on_off(data, true);
+	ret =3D __kx022a_turn_on_off(data, true);
+	if (ret)
+		goto err_on_out;
+
+	return ret;
+
+err_on_out:
+	regmap_clear_bits(data->regmap, data->ien_reg,
+			  KX022A_MASK_WMI);
+err_wmi_out:
+	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+			  KX022A_MASK_BUF_EN);
+err_free_out:
+	kfree(data->fifo_buffer);
+	data->state &=3D ~KX022A_STATE_FIFO;
+	__kx022a_turn_on_off(data, true);
+
+	return ret;
 }
=20
 static int kx022a_buffer_postenable(struct iio_dev *idev)
--=20
2.55.0


--F6/KSGT0MhpUJjYQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g9cACgkQeFA3/03a
ocVxLgf+L4sKnnXX2zgpws7llF5AQpcUzcmAMoiF8/NLGnUPgiS7yXnl0vDFiv77
KII2TA2JWnonePhWLkXADj0ADUzEJ7wqUxTnxsJ8bRuqrFD6cHSvxcB5QpT/yUu2
gc/cvyEwl4Xin3XGVUAsixOHehH7oV19iq0mWJCIBS2zzOXzcTYxPtRrcbU/XOJW
kT5473PBPBJJ0bq3QgOfveWypdYrGHfdVrmCqsqtcuQ2m4qbE9ZaPEYrz1vt6VI2
lo005mlVj4lxxIps8DJY+cZioSRjZfpPdmxZlABBq37OdjauU5i/662yzwD4M7jT
OC3NOD5GNUzFjt4tDHeDr9E3qaKrtA==
=jKJR
-----END PGP SIGNATURE-----

--F6/KSGT0MhpUJjYQ--
