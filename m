Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BDC3B42C0
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785692; cv=none; b=bDoA/OOWysPZcAqHK0Y4IHSUe+WOis4ohifntQPlPKLGCs1JLBlozqVKOHbWDoMAPWcq42IbS1RTXMuXB6teHWlMBOeRcTl7DhgAZOIgCnkTJeMcPIJz4oeZ9VfPFIRt+e4oCNyf+v2u/2UoQIUaUfm6rsjglRhvivT6moTC2I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785692; c=relaxed/simple;
	bh=zce5IFfhttwWk06VN2f2OD/gINXjjX8JKvsn94S7gdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgOjMzufDOKaCcPyBjjXilQCTD55oMkOghkttvurd/8KGGhOpQQ0MU4oHTo4NLTvoEGxSeQSRyD/eHVfJF1DuXbt3gA7amWsklUPpfRlk+XkTVRrNLN1ey4puj+wlO2fmJnDfa+I6mDEzpOLQLlQTfCmG53hN3ULxzSLDks/ngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc+qepLF; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc+qepLF"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b0117dda13so229371e87.0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 22:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784785686; x=1785390486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zce5IFfhttwWk06VN2f2OD/gINXjjX8JKvsn94S7gdQ=;
        b=Rc+qepLFxkjmNblAHiAkUx5YIc7rXdsM0QsiFLSXUktSq7g4cU4jEZvFpEk4EQS8Nj
         JRdsY7Dr0/WdQBDgocDnyGP5cUiYWb4DlejqFqRyeR3aDeI/+gbfRbI1LPZnTMTnif1o
         Z+V6N66u/BFoiJlxXyrg5ll73yPsMcdUekVhqeaoU01zttG8MPfsmgUJvPlu7J3C1Inh
         XEZ0yf3UVoYuWIUOFfyeNdHoVdrxIzNSpn+Lmi63JuhtdZ3pK6RUdfszcOPpO2gHimj+
         9tuwfqCjyvvK5uT3AAcBEZE3PMoRvJltciad7i5AeZrEQyyxBLbSIqg0mc1xBh7+957o
         3sPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784785686; x=1785390486;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zce5IFfhttwWk06VN2f2OD/gINXjjX8JKvsn94S7gdQ=;
        b=MgK/zl7eeECCzqA9SyIEWyn2c2f2OAnlvtdLU1CYe1GbUc95EpAgBRCZiXzLUlJmIB
         bb/QNd41TvmhoHYZHGbHR6KbWzP0l5opuAXu15wOTHRc2ar7zSfgeIJyyqHHOJDVRPOg
         NYcrL0/IOS1b17D0vOQE4QHVOuH9ev1WjXnh8zrCIDGDXZx7gKgw2JSQ/h1FOYOukZRP
         1xgPD0AYgUzfxMiyMeNZJXco/VcJw8f3H1emHeQ9gIDCiO6jPvxvvJUIxOebQEbDnKuz
         MzeHyUGLf0N5myJao+Ax0GkPdxxR2Z4VhsOy2AzuDIoi9Mifjzb53gJZK6CDjyI9u1Lr
         fdDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ros4CsA80mrmgptwvquqbwUcXd33scWWOE6eoqGmX/fwAGAMvBF9J1LFuLdw5XFL7nhJHDESdzKSxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwYuCMkqnPYYip1ywHsTqTLAXpQ1VU9KHO0wT/LhcFmKPjj1wE
	wEL1/+5jA9eq+8+Jl/DwkmLy1O0TnzhR0uuA59qiLXkGC/8tzM5KPVp5
X-Gm-Gg: AR+sD13irZSAewP1AFYuGZzYmbaZvXPKO/VwGJB5Z42eiYN0EB7nj2E+GGqUOM1UC1r
	Qx1DrQZnzCzEKgmJxv6OudIs0ewlHMzhjbKMWiFEKc29cvM03nrMIEjO+2E3D28S1ljRTASDajI
	HCuMWXTqTVSjw/DRlqs9rRLZa1f9Kc39zZdqgqEox8cJLbKADdcrUn7ov7AGBlVXCb7G0ecEHTD
	bT0JvLTaVwV36yHIuxwqKNzrf7ZlW6xfBs0f0/Syu0mziqHyAvWHLDnozfWQ2hH4sywlXcQ+Tw0
	8/1Iy5hYegodzkNmwJrgtrsRPpp1PRBJavOgiPk57LqqII1QLkRuN0RilJeeKTAG/TXHxLtq7Xa
	8qo4oJTs/83vv2s5mF7UTNpJF+9fYsdWF3BZgFx7P/v6qh1Nxeb6SYCHcNDEVdyLcaWapVx64Gf
	GovYIImJGxL8261hbMzAnn8iElt2JYI3xE5hvJXPUhIP756VA4JQ==
X-Received: by 2002:a05:6512:3d1e:b0:5b2:a396:1793 with SMTP id 2adb3069b0e04-5b2b2f869e8mr233093e87.37.1784785686291;
        Wed, 22 Jul 2026 22:48:06 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b9b68fsm824147e87.24.2026.07.22.22.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:48:05 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:48:02 +0200
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 1/7] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <amGrEkxHn4_0MbHS@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VXZ0ra7nT7yUfaG9"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-1-7781cd74ad75@analog.com>


--VXZ0ra7nT7yUfaG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:13AM +0200, Janani Sunil wrote:
> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--VXZ0ra7nT7yUfaG9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmphqw0ACgkQiIBOb1ld
UjIChhAAu2asYHZA4jhvennduFJOblAaqs3zqLqRDsO8sv+D7Ruh4jD1o5Is1vuH
NM4NQFJ9MSe9p9+bMGIc3r/Xbtsbb96A1EXh7bIRlWgM55b+D3aBDQppIdvj8ZyJ
0wbv3d8VZrPo64ijaGXcWP0lftjCQR5/B0I90wjTUehW54F192JVVCF/s1TzNz9b
mIqB4VY/R3nmCSRQ4JER9/W3sOmA+ExCTV5AAVEUUxBJc+l/n9m1Cxx2Twv8tHEh
186HPqNLh45QWL0SQi+guDZxSfgN9zHgdmr9TAtbU0mg4mfps7w+k+n9truYcyJH
4A9RAtTllIX2fxN7gIxKPnm2LNCV7zn5xiTPAZQWcCxTFv9O15NQMGNczr7pGW7b
SyVYMkl0du029zeL7x1xL6SdzCtEKj+qlUrqpT89vyjtOiVh14f/lHe6glQdwJbj
LmMQC6+fmma8YsTGVpbDzTMxqYr8teQAfKyUagM74QuX+FJYJrqm5qn92aB63Ua2
rNvDClNDuTerhBxf5NAyWJLbat+Mo0PFqSOR3fHm/9Dc2ltj0Q4F1s3pQ5PbByk3
6ew1+trRN9Xzf0jHogsLjlC3JNexpiMQauX7K6FBHR+ABRqb71zBXSrCjJNX8Sqk
Ug9nnylKQRN6bh7qzSHEj/VWPqJcUUXHu2g6CpbhQHao62kzrsY=
=fFxV
-----END PGP SIGNATURE-----

--VXZ0ra7nT7yUfaG9--
