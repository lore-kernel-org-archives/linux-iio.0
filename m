Received: from mta0.migadu.com (out-124.mta0.migadu.com [91.218.175.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725613F410D
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338953; cv=none; b=mhcYdcZU0MdPEcHckRxyMOQRcSuLxw7W2Px2bD/Pam23BbLS2yqmy80NiZXD+qbkO99miaMkjMHAXEpxPfevuxWcVZZ/MUAEuJ/bJViPhImBBCgbY9nw3wPAqa++D8axlH3c94OD5xwxaOCnZsOHQIa/tp/xq8IcFr9Zla+wsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338953; c=relaxed/simple;
	bh=f2w/exKd+WcPfD8TsUEpGLX2tdskAkF4cBe0xDl9JDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkjqj3w/1VQcMWHzLkx3r9I22Tr7uMI57FoMAlTa+5Vqnbv1EbzqsboX3OF+t9nmm2w/kpU+5pIYAhUutnKloZzxzZn4fBuNdf6+VrERSKqAERlVEhvILfsbiYdG9N4UEnTMemGHgVrM/K1lmVhcr9JLoVAFv48tP4tSsMfLWd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nnBeO/5m; arc=none smtp.client-ip=91.218.175.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nnBeO/5m"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f2w/exKd+WcPfD8TsUEpGLX2tdskAkF4cBe0xDl9JDY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788338949; v=1; x=1788943749;
 b=nnBeO/5mdINlx2GixxU24jzRMqCen5qLp3avBs0maQCKuEUX6/lA94uN8u2nxhFYm5KJQnpA
 0iNNSDbo35rTXymrdMuVV7dxfKWF8fUUn/p8SPk+1ycSJxDqYJIABtxO0Hf8mKF/8evHszTWntL
 Wncozj3rtbNzkSTaogyvzYhw=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9143ef27d57fefb4;
	Wed, 02 Sep 2026 08:49:09 +0000
X-Mizu-Trace-ID: 9143ef27d57fefb4
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 11:49:05 +0300
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
Subject: [PATCH v3 2/3] iio: accel: kionix-kx022a: Prevent memory leak and
 fix state
Message-ID: <d01b5c2d1aa3dc06dac7cb69e44b4caeda0936aa.1788336588.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8p/Ptea5Jbk6Fz4j"
Content-Disposition: inline
In-Reply-To: <cover.1788336588.git.mazziesaccount@gmail.com>

--8p/Ptea5Jbk6Fz4j
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

Fixes: e7123a4dfcd7 ("iio: accel: kionix-kx022a: Refactor driver and add ch=
ip_info structure")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reviewed-by: Mehdi Djait <mehdi.djait@linux.intel.com>

---
Revision history:
v2 =3D> v3:
 - Make all of the fifo_enable unwinding goto labels describe what
   clean-up action is to be taken.
v1 =3D> v2:
 - Fix unwinding the fifo enabling
 - Move Fixes before the SOB.
---
 drivers/iio/accel/kionix-kx022a.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 8f2810c8ffeb..00482cb4451f 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -981,26 +981,44 @@ static int kx022a_fifo_enable(struct kx022a_data *dat=
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
+		goto err_turn_on_out;
=20
 	/* Enable buffer */
 	ret =3D regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		return ret;
+		goto err_turn_on_out;
=20
 	data->state |=3D KX022A_STATE_FIFO;
 	ret =3D regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		return ret;
+		goto err_buf_disable_out;
=20
-	return __kx022a_turn_on_off(data, true);
+	ret =3D __kx022a_turn_on_off(data, true);
+	if (ret)
+		goto err_wmi_clear_out;
+
+	return ret;
+
+err_wmi_clear_out:
+	regmap_clear_bits(data->regmap, data->ien_reg,
+			  KX022A_MASK_WMI);
+err_buf_disable_out:
+	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+			  KX022A_MASK_BUF_EN);
+	data->state &=3D ~KX022A_STATE_FIFO;
+err_turn_on_out:
+	__kx022a_turn_on_off(data, true);
+err_free_out:
+	kfree(data->fifo_buffer);
+
+	return ret;
 }
=20
 static int kx022a_buffer_postenable(struct iio_dev *idev)
--=20
2.55.0


--8p/Ptea5Jbk6Fz4j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqX4wEACgkQeFA3/03a
ocUpjQgAt8OXBc1s/x1b58941krvZvMgyRfQx08SAVekxM0zLYbZ60mPsELjSzgq
AqFn85bCMMDdJBFW/QHOCbzbayn52r/nq7J0mLsLnv6JG1HwxudL92yxwzNuJJgh
bjFAfxfRR+lO4ldpEu3fZqQcon6PDdZA7ZI+acsDrorvwAFCbWDnIfz/poF0vsfT
uC/ib89IP8/RQOGy3y/WhfGnbqPEoogsyrHdMCtxI+3T6btuAcUZIQaSfoOYIsz7
kbx4YVXTMmLrwIt5ct5OrO4gpgxLi8cOGNJ0rQxUAqts8pFTUhetPVTCR5TTjduZ
emD0Y+3yVnFGoL5TWkrOYLz4vRzYuw==
=IjZp
-----END PGP SIGNATURE-----

--8p/Ptea5Jbk6Fz4j--
