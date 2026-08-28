Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A64B3B47CD
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902864; cv=none; b=MH6KFVRw0yKzfVrVL3RBX6YMnHefSVZtC+xe6ki57r0rWdySWjuwQx6XMfLkdX3vduA6wpa7YQ2TR3tOgVTaq/A0o1D3m5MRGIWhlilqYJOjBEsbNgjrDmi9iFJh1ddvf3d7kS7J7SIXAwj8LcLeka3AMS5twFTnS3/RDZADOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902864; c=relaxed/simple;
	bh=XYnOlZNecNU7j2jhNiOFeWbXe/IQi0ASVyCFakZh0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eceu9ela0Uahoyr3xPTCB8QEt94dGr3hpeREmCPNg/FVf7jmN7XLo4VNirbXtMa+Va7L4E04PGlmAgbKEn3sNUYYN+7MS7uHY+svR0wJeDKKfkqTrxflKMhofADdf5Rhf9k8zKIIXIad6AvZleuY5M1BUbVAx8wUDeRMCcmU680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OJkK/Qvm; arc=none smtp.client-ip=91.218.175.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OJkK/Qvm"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XYnOlZNecNU7j2jhNiOFeWbXe/IQi0ASVyCFakZh0vc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902861; v=1; x=1788507661;
 b=OJkK/Qvmo2RhRJM42FQR3G4/1ZGzX/8In6c8hDGAvaIYK+l3tA0NhE2VUXDf3Wr7mp3bzN93
 J3vTsF6arhsdU4rSDehW8YdOqGoxVBl5EpEv+gZ8GWyQ23UPmAAZLuw4OyTZYS7GqSwZzKVilzU
 DXYllHonK+VX3JvXgvwkVHXw=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 793fdaa71214d916;
	Fri, 28 Aug 2026 07:41:01 +0000
X-Mizu-Trace-ID: 793fdaa71214d916
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:40:51 +0300
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
Subject: [PATCH v2 3/4] iio: accel: kionix-kx022a: Prevent memory leak and
 fix state
Message-ID: <9e4453fcc00df6ec988207df8916226d18aecb20.1787901813.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ris3llGW6/HBkn17"
Content-Disposition: inline
In-Reply-To: <cover.1787901813.git.mazziesaccount@gmail.com>

--Ris3llGW6/HBkn17
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
v1 =3D> v2:
 - Fix unwinding the fifo enabling
 - Move Fixes before the SOB.
---
 drivers/iio/accel/kionix-kx022a.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 8a13f78aeab0..fa94bc0fd8cf 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -980,26 +980,44 @@ static int kx022a_fifo_enable(struct kx022a_data *dat=
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
+		goto err_wmi_out;
=20
 	/* Enable buffer */
 	ret =3D regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
-		return ret;
+		goto err_wmi_out;
=20
 	data->state |=3D KX022A_STATE_FIFO;
 	ret =3D regmap_set_bits(data->regmap, data->ien_reg,
 			      KX022A_MASK_WMI);
 	if (ret)
-		return ret;
+		goto err_buf_en_out;
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
+err_buf_en_out:
+	regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+			  KX022A_MASK_BUF_EN);
+	data->state &=3D ~KX022A_STATE_FIFO;
+err_wmi_out:
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


--Ris3llGW6/HBkn17
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqRO4MACgkQeFA3/03a
ocWihAf/Visbz6MOtiAwoNQaAWLhvKgXKE7aDu8W6zNRAGycFiU2TKW4cvMzkUpS
UIMkHym+MdtqGr2mkb2qj4IObYZfJO1Otyw8V6+luSc982pnjiTnCkG57Ah9GxFj
O0Ug1HsRO0ZkABSFvsku4sLrp3QvFsfbGWxZiWzEaox2Jrc3yNMwh6YjzzyQdaFK
l+otvT5389vCwwcEuk89wLSPUrnUdgFDbyJRD7xPm33vypAdHmFRCKHikYp4FOiB
evOOYgAL0PfVHT+/FEGqDiG/Bg66BzsSDYnKM2gr/lf8vdNxJTzMfj+Dn7ItVCXi
Y8UwZ/HZ4EecKcRekBsG5/Ye0Gab7A==
=pbN6
-----END PGP SIGNATURE-----

--Ris3llGW6/HBkn17--
