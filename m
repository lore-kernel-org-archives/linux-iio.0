Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784DF386562
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348498; cv=none; b=XP6qZDtUbsnAgFYacqqyRCmeET3wuYovDe0vvC/WZsqrcdqQT5Odx2jRJOwGg48YszYcue83esVm1NgugnNJQY5koJasztUNH7zm4nVrHZayLNQ3mSDSXq5gNe3nCY+sdlmnanbMmfSCgYfmAu5YyFgUezDmRzqcQGuMbvbmn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348498; c=relaxed/simple;
	bh=YtykBh5tS3V5E7niEnXyBQRrlY0P7/CZ5JFgVsb5gKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj62UagD2lHDeUmeWEeFsW4Aa4+dETJwoP7nK8n2KRHNsZtBMNbilw+w3JDoVKkbY5yXkg8mBNEXhBn8mLdGFakCNiihm4I8qZpkzUY3jtM6LKbORHMEM6n70VjI7lRG4vtiVBDn/M2SE/sYvvXS2GhBYIvckGuAlSuLNMN3ckU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PavIWh1z; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PavIWh1z"
Date: Mon, 10 Aug 2026 10:54:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348494; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=GYUM+yCl2IWol2CPXBtefVWVk+q0YpjCsmfy44rlLgk=;
	b=PavIWh1zNH3aSVmSHRhpVjFF8o0U4UmGvl6TYEtE71ObonyyD6BpwitIHndPDdPhwpjuwn
	kiBX69uCYAGpnlLtXlmgylcVqNzgDfNkmgHChw1usMIqV0DNeWCxZcw2RKs/WHinbjmW4v
	/oqtZ8ntgFiDUdwKj3x/rpib7/Ri4Ss=
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
Subject: [PATCH 10/12] iio: accel: kionix-kx022a: Fix array boundary check
Message-ID: <159f1048852afc74cfc2d219298a5a6f9d70cbb4.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L9D7vCdI1pJSxYKm"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--L9D7vCdI1pJSxYKm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The driver performs a sanity check for an array size, when converting a
register value to an array index. The check incorrectly accepts the
sizeof(array) as a last index, when last valid index should be
sizeof(array) - 1.

Fix the check by bailing out when index >=3D sizeof(array).

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
---
 drivers/iio/accel/kionix-kx022a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-k=
x022a.c
index 39485572a76b..8a13f78aeab0 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -649,7 +649,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		if (ret)
 			return ret;
=20
-		if ((regval & KX022A_MASK_ODR) >
+		if ((regval & KX022A_MASK_ODR) >=3D
 		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
 			dev_err(data->dev, "Invalid ODR\n");
 			return -EINVAL;
--=20
2.55.0


--L9D7vCdI1pJSxYKm
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g7gACgkQeFA3/03a
ocXo7Af+LlXYSGoycqVvzVxtYqz5E/z7dKDQNf7tuNO7ZBSNvUHVn3UxOQduHaU+
AH8rDUk3sMxN0GD9pqWREcny/l18w+SYTbYt2hk2jJ8+iCMzjLJbkzQFEvDUilia
kiIYF+cwRVfS+epiPCOeB8pb9m4VnkrVwtnMg0EsEei2ERxUeglNZZvdAy6mAoRO
KXgwT11G3oyA5yGRsk4spDsPL1+PBjAgwaM0uDvfsQhhjTCROXWyrnR92/hxO3E0
RJct6tNj0cZxQOrmjL9JpBudmPTtGmDf1daZrQMA5uvSADB5sv9rDhLCRa0aUG57
ZEmV7PrPeTucxybgBemjE5+QN5CCLg==
=j8ef
-----END PGP SIGNATURE-----

--L9D7vCdI1pJSxYKm--
