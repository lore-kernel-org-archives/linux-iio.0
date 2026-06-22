Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0003B42D3
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782135154; cv=none; b=dUhHr/uK1VxX+l52u/6Pd6vsbdJvq/atcFfHxP+Hd66yTqHFM2PjipLsxrysRShMxQj7vj3yHJwfHatK8kb5d4d4A2WQZqBMSfn+o+JwxAemYlxlXB8Q6uwSHd7ECvhIBTUyaqUaOUXGNWEZ1MncVoO5ataPeklLTxry0AsIszA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782135154; c=relaxed/simple;
	bh=tbZVVOtwFYLwxLichiaXb/anhWmg2HaAr18TFUDTHVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkhXxS06VCygpQjYSHGSZqJTUxuJVw9f8z9/pAKgwDNA7/6BS6ftHDAA4iSjpEEuNbJHMOw1HZr3T93bNi/jrVQu0zJtLakIegh8cwoV08ALhdbzr/7bI8pKkMsKKCO8ujz76S46AZwD8fNBCyy5euUNEiFNH26rhzWplJiDm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h4rkmYUH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h4rkmYUH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45fd464d51fso2626339f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 06:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782135148; x=1782739948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jc5HSn+4K0JdQCOT1UOHDiDsJE6hyDUtS3E6IsWkNE=;
        b=h4rkmYUHVLaK6oJMFCFO0Xi6U3R9YAJDh8o8xSF0Gb36QkXqN9t6nCjiAyhAiqw5CW
         7HN0t89dT0E/VzPj6f7slbxUVGiKvdbJbNqnfjDxelyQAbfx5ai1Nya4ZxU5xBy968yj
         Bl+3Gqoffxl+yWR7bfLfTbYmmhobbWwmMxrso88rAHIqgVvBgSJ7S5akK5ZuhSugrue0
         Lf59Gg+rlGP5hvLd5dGagzpTo1j5NYDZaOU2sc7OJVjSTAT8JKbFX8t4ReJQQestvrrq
         x33lV/O5sGRZWL+0jTC9sacqSqjDSDoD7N7DaQSDlQ6T2dipClK5tDu39yVeURdTuhP7
         uFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782135148; x=1782739948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jc5HSn+4K0JdQCOT1UOHDiDsJE6hyDUtS3E6IsWkNE=;
        b=aogT9i2RwIwOvT65DcKyJxmoy9b/RI+Q+yY9+26GtgJ2wzgohctFRrNOLzTg9732EC
         n0Pm367dG1jIeD1ppKwYlAuZ9Mw8Kb646SMYmG3yoGQdMgssDKN52eXUSuqeNFbtHNmu
         puA8CY8EtQI4LjzTZ0FOPL5NgOy2CGrkkUzKiwC3k8aI89mNZNCk5VPzn2/NhDimy8bC
         0lCPqy4/BW1SQLEE628xwEAXO2FCoRDvluXccBfxhMc9Hkz3amRz04rsEVrvo1K0mg1i
         OPOZ9RMLr3H7IukwL4vBE//np+n+cv34l0Q4TSsMpz6kL2ZdnWQN+baAqIl2wCu7ZqwQ
         J7UQ==
X-Forwarded-Encrypted: i=1; AHgh+RonE7an/Rm12UtkmSRJu+WaNeaxWzml7eP4FY3DWAnMy8kX5kaJLGXmG9yPCEXGB7Z7G0idoZckn+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUsm9R/QrU1RVK+pxo4NgOtTD6zZld2orY4QEhdrnSeUcYVS0U
	fAGtTHMijc7ahzWfMHPzztFIqNjkr4ggLYQMUDssnfbbKZ+1ttsr/xAQAF8ZneAVCYE=
X-Gm-Gg: AfdE7clSFwxZUSIfrlIOgWq4jpVRn7Q9Xr6PsUh2CH79P2k2tyZJ87Jp6alGtsDJOpC
	NkyKA8SuPtKOoCh1dL66iY5aMWar2w0oF6bsA2PTxuzsdlaB/E/so7lkY/xVkfY3/yHgD6IHZPp
	QzIW379XQmWKaeKzUMIq/peU3uWt12O+gBZYknztK0jQ02HmnwI9MxBJb1F9AbAWzqoHDhyyu5z
	SUjfysYksqlua3UH6YtaGPOrpwAi21kWl1gDjlM9lqBF1uKCULx3jTf40KxhLOAcd3RNYvGxoM5
	XuekYFGBMpbr7lUEFycqd9E6SHdxUUBTkB4t3uzsVcnIwg0A/tcwqzNTgagjtNJelSPk/a9DuIo
	/ObhycjW7JmS5TR4Ho0m6rSpnu2PT8m+B9RJsmpjqajYBNVEKg3gTB7GVvZmTo2hjoIPy8MTrXM
	3z1BmWKOZ2beItdpfoVFMesM+U9w+P6LpVVjA/tW9TcenF0SUkyHDgYPVLlhRHbp3UvFK5+w8WM
	L/U
X-Received: by 2002:a05:6000:2386:b0:460:1967:abed with SMTP id ffacd0b85a97d-46503646b28mr23423097f8f.39.1782135147573;
        Mon, 22 Jun 2026 06:32:27 -0700 (PDT)
Received: from localhost (p200300f65f47db0439f7453c727e8fab.dip0.t-ipconnect.de. [2003:f6:5f47:db04:39f7:453c:727e:8fab])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46667221da1sm25881623f8f.36.2026.06.22.06.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:32:26 -0700 (PDT)
Date: Mon, 22 Jun 2026 15:32:25 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/13] iio: adc: ti-tsc2046: Drop unused member from
 private data
Message-ID: <ajk3fihWcjRedEWa@monoceros>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
 <f90ca5b6d8b694ccd0649d36d590e5d64ae52d9d.1781883685.git.u.kleine-koenig@baylibre.com>
 <ajkOsT8QCAL-0_hK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="stbh7ln7otlrn7lo"
Content-Disposition: inline
In-Reply-To: <ajkOsT8QCAL-0_hK@ashevche-desk.local>


--stbh7ln7otlrn7lo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 03/13] iio: adc: ti-tsc2046: Drop unused member from
 private data
MIME-Version: 1.0

On Mon, Jun 22, 2026 at 01:30:09PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 19, 2026 at 05:54:31PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > .dcfg is a write only field and thus it can be dropped.
>=20
> Why isn't squashed with the previous one?

Because they are two different logical changes. But I don't feel strong
here and can squash them together.

> Also, what about struct field and the accompanying data type
> definition?

It took me a while to understand that suggestion. I guess you're talking
about

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 97ecc429db27..125f6d7e2d84 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -121,11 +121,6 @@ struct tsc2046_adc_group_layout {
 	unsigned int skip;
 };
=20
-struct tsc2046_adc_dcfg {
-	const struct iio_chan_spec *channels;
-	unsigned int num_channels;
-};
-
 struct tsc2046_adc_ch_cfg {
 	unsigned int settling_time_us;
 	unsigned int oversampling_ratio;
@@ -213,11 +208,6 @@ const struct iio_chan_spec name ## _channels[] =3D { \
=20
 static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
=20
-static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e =3D {
-	.channels =3D tsc2046_adc_channels,
-	.num_channels =3D ARRAY_SIZE(tsc2046_adc_channels),
-};
-
 /*
  * Convert time to a number of samples which can be transferred within this
  * time.
@@ -738,7 +728,6 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc=
_priv *priv)
=20
 static int tsc2046_adc_probe(struct spi_device *spi)
 {
-	const struct tsc2046_adc_dcfg *dcfg =3D &tsc2046_adc_dcfg_tsc2046e;
 	struct device *dev =3D &spi->dev;
 	struct tsc2046_adc_priv *priv;
 	struct iio_dev *indio_dev;
@@ -767,8 +756,8 @@ static int tsc2046_adc_probe(struct spi_device *spi)
=20
 	indio_dev->name =3D TI_TSC2046_NAME;
 	indio_dev->modes =3D INDIO_DIRECT_MODE;
-	indio_dev->channels =3D dcfg->channels;
-	indio_dev->num_channels =3D dcfg->num_channels;
+	indio_dev->channels =3D tsc2046_adc_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(tsc2046_adc_channels);
 	indio_dev->info =3D &tsc2046_adc_info;
=20
 	ret =3D devm_regulator_get_enable_read_voltage(dev, "vref");

on top of my changes. Yes, that makes sense.

Best regards
Uwe

--stbh7ln7otlrn7lo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmo5OV0ACgkQj4D7WH0S
/k4p6Af/SZg0/AqIJrKcgKI/q7SnZ69RMvMCHHDxKiNdlK4ejPyuIwfxvZpT8fjd
DCUlqvNIX83EEFBha4DTCyGYkytoigmyP53CYg/DjxmrMpANcgqCcGrn/kGWMS+S
6Sm6y0QsyIfYUoHI9oTc+RN9bb0ucUetcLpGSIo1zFQALOKEOCll/HfWee+E6c3Z
EkZk5t7gPGUIyr1n1emAmjlKHKyEXRIMTBQ1ptAJINPmT3Vin+02LTU+7eIByG5I
3sYWsbzE8XJzY/qTo1Wz/iZ7MM4WJY+Z38XfguMBU0ZwTAZWo80CDrJHPbUPN5MR
HYB994+aDn4LBQX8yIy+KONYxcOPkA==
=1nqN
-----END PGP SIGNATURE-----

--stbh7ln7otlrn7lo--
