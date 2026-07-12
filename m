Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BD37E2E1
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783894497; cv=none; b=mU7irdYr48Djcq+xa/WCT2ebyJFbhaxvcxy9IvtcOlkci0odmmJWc5UNpMHTazsRwS+OyypnLlICLoluSxMs+syOCAIOTWlzTu7gFbns5mt5Tr1BXjXYhs91Kk85ZJHfmylsESDiz4Ig2WH9tLHPzr4vhquqfLr8VmSZqQgdGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783894497; c=relaxed/simple;
	bh=zL9CTPzN1W+fRigYMQva5W+av5/6jMQUnYv7czVB80s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXSPWc+HyuZd94EgNVS96FMXyMvJpOrKc/Yonro6FfMiQ8mrRGPDTEyopBfJAI2ea6HohaDiaKJpD2hu+Q46zviWuKg5zQq7MVuCjXD3llnr0axf/mrkC7vHO1mpjnL9SFzNpip8zCn0S45jZyMaBNaffTIaLsD5wU4eMB134mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=KX2c/i7Z; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="KX2c/i7Z"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f36a122fdso607545f8f.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 15:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783894493; x=1784499293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zL9CTPzN1W+fRigYMQva5W+av5/6jMQUnYv7czVB80s=;
        b=KX2c/i7ZHlswP0u7FQy6xJnWmXJWcs+P4QpJgXTk9+rtwhRJOj4HtgtydkUPgEn9z+
         2ITE4/QLQ91an9R+jFxZGjlXEdAKEYCuF7AUkFUsuZGE9XhZ/XD/Vd1Wge1Ub0eeH1a0
         Jm82By+jwyhL1f6MXIlIeZcbPhx9hKrRhWgPrlWcW5C+naD6rhhnHvt2F5/muMTV7auS
         N7Wbk1YmEKPK2LEEZ4GQvX0e4b60C8gH/pYM0sz6OYp7ppm5180w5AOUfeifPltp3umc
         UFrlVEws09DV/lbG5JqpBDAsfTxngkZRFn8Ez3QMB9P+2ROMwvLTSkNv9PhuKxDm4XKg
         XhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783894493; x=1784499293;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zL9CTPzN1W+fRigYMQva5W+av5/6jMQUnYv7czVB80s=;
        b=rz7cuyBJc26liNsuchE8v4yRKY84D9oINFgcMWmnvnWbJ9LsriAnjCRA/WMReyjfGB
         5D0Zb2Iuu3Ty7oGPt2YLar+BP+iKgS43wIdISAVDgfRP8lMZRT3FG8ZiAsxR6DqzRrp9
         wlnYa/Aq9ybKt9MOY/3upXOwDPY3X7qW4g5nTlucKAh3Xs+1lNZzSTxOdMtk3amX69om
         hE/5Y+G7GWL0nWoG3Wolr60oVNydWRxIgsOVsoUklFrhFLCe4EFbskYrZBpFmLwLZZA8
         tpb2O1G5qA52TcNzwQwb/utU/Q0qzDqu33ZfQ6oAXhAa0L3Egcw7aUtKdWDDl7mxUP/E
         bnwA==
X-Forwarded-Encrypted: i=1; AHgh+RrT7HBCWJXskRP4Scct+lHi+PiS/t2SZ0MLLLcOc/cfiWiSutFPeczNea7VAd/Uz2wN4AdhEQEmkaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry6u1YWt0r5prGgKJCm7jX/2FxOn47mqmY1BhSxu44TYgH1gT
	skeo1WEeeaJ1Qf3R2+0kYx4Id0l63PWarPXR+hnZ7pyvhl1SGkhH4GUr8opnOymmBdE=
X-Gm-Gg: AfdE7ckXOnhnZddriycTaad//dGSop3tdXUYRmIjxAqxIw+6O/OboAF9NxugYn2tAKg
	bpxiNqidP63NJdYImq9ooBzL52v+2imnSorAFlYSDhyEyDhLmKLZtc9Bpaar1S4uNwHivs04IRu
	v4gw+kTsx+S6cXs/AUy7F1pdJIfeiTB2zHN4JDz4bKY2vutCENdh53dbJ8QSSx9tLdhTISLVDKw
	TnhfrfC/l7muUiplImD/I0ix84xXVsPkKF/ZLZ1JpxmNGjkoEP8Sk0wKk5qy6+eyERlAvcQLM5b
	frbL53MHTPpl/zFC6TN2VZ0VXARR9lyZVASaFP7SzvRgmuMJmgUfGpmXGxKJkETixxYUAZllrk1
	BEruzVjTb3lW3A1DpJqGyyXKIJIvlpL5gS7pOjWxghyUHAk6kTaRwMDeulxyz2A3MojBMNwJ/C6
	pYL/giDJvmQU7xn0RIRw==
X-Received: by 2002:a05:6000:310d:b0:478:19e7:22a2 with SMTP id ffacd0b85a97d-47f2dcebce6mr7408847f8f.25.1783894492402;
        Sun, 12 Jul 2026 15:14:52 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47aa039afacsm74519074f8f.19.2026.07.12.15.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:14:51 -0700 (PDT)
Date: Mon, 13 Jul 2026 00:14:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] iio: adc: mt6323: remove unused header
Message-ID: <alQRYcO5grXoEk39@monoceros>
References: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o43h3f7zpw65y6ht"
Content-Disposition: inline
In-Reply-To: <20260712-mt6323-adc-rm-header-v1-1-d96395d1a323@protonmail.com>


--o43h3f7zpw65y6ht
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] iio: adc: mt6323: remove unused header
MIME-Version: 1.0

On Sun, Jul 12, 2026 at 09:26:36AM +0300, Roman Vivchar via B4 Relay wrote:
> From: Roman Vivchar <rva333@protonmail.com>
>=20
> Remove unused mod_devicetable.h header.
>=20
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
> A small cleanup for mt6323 auxadc driver.
>=20
> This patch is based on top of iio/togreg branch.

The only device-id struct used in this driver is of_device_id and this
is ensured to be available by (e.g.) <linux/platform_device.h>. So:

Acked-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.co=
m>

Thanks for supporting the effort to get rid of that header,
Uwe

--o43h3f7zpw65y6ht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpUEdIACgkQj4D7WH0S
/k6EWwf+JU+Xlhg3mTVFtgHxRhXyUFEZ/eNALPq36VofXr9hBEjKS9koXNFoSJYi
cBT87TumeE/ZTkywvoVgMl30uhh4jJPQphc1gC+HtJQ6maKVM/oYe7LEiYLP6rhj
sVZBLT9HeeQy2+F+bV8hU72ZdZD8Md1tEUX4NgYeDyk6/2RJgfbVvkGjnGbfsgkt
/HseMZuPsts+4wgnmMfEEfZKAP9phGc0QlIMSR7/pnBlykd6Jvu9AheSD6SmVM3I
VBIHs+2/parSkTSXBvZ8E8tbEbh+pmintZ3pydhXzzBLq3VEKgus3uvZf6XFqNU0
PuiejVzWydHXlYkI11do565DXsq55g==
=vgse
-----END PGP SIGNATURE-----

--o43h3f7zpw65y6ht--
