Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBD13A5448
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 05:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784785505; cv=none; b=s2FeueA5ixBAEDY+wpDzPrJOxNggL/q63kneJpxExIo17f5OHopAhQEcxGDGannRu9qq5QQEYYSTm+PqxsWEjGCzNGwkaRynlb6Bq1tNUaQDMCNk+rQB8T40S+j74XXEAj1aR/F2T8J5OuXq2zFR/gvb8nzl9plHpIrbnh3w0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784785505; c=relaxed/simple;
	bh=/v6lBhg1oIN3yUphI0k8bShUlANofncArNDCE53+BIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bbdPn0nwlKX9YfpXm6ugzK59lw7OVr8/X1KZFXqUlM+5tBzGvjzhSYUdByh/QCdBUMGAgH7ao1/mTwB1E8PI3FmX0A3czgSQ+TdBAJd3JZn0d2Qwv/Dk4Osu2eYEbWn5FCmWoMgenTHWPquFzFqSCLijW4UVqeq85J6h0RByfks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji3o5xLu; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji3o5xLu"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69a50b818c8so330017a12.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 22:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784785499; x=1785390299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/v6lBhg1oIN3yUphI0k8bShUlANofncArNDCE53+BIw=;
        b=Ji3o5xLun1yY+TY89Ep0SPDMxR8AopZ4mgGV0G4XE+oOXAQse62UmsgfhxgxQH4hq7
         qpTc6se0JWpBvewBdb7FEeD0DQsspl6SAtLdrZhygt3gXCJ+Iosme1eSV99/+yXZHcci
         1+6phrKr86MSgP+1PlQmiScVYESaLcKrJp1bVAnX7zGl9+sc87OOKjEZH9hWXrNy4qOF
         n+tajP7SvnT1I821IaBMwAVqGPucRHhwCwWLwdbC2wnioiIRcWBC8Rad0fuU8hiddKAI
         VxiDfjEZzGdZTd86jHaynGrEH96Iu31yfqPfduTWfA6Mpp0fRUN+BDYwuw8oiDgoo2vy
         fxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784785499; x=1785390299;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/v6lBhg1oIN3yUphI0k8bShUlANofncArNDCE53+BIw=;
        b=RsrK2+jmlrE9uKpXx5ioWLxBQeq/G5HeZSkzJHTl8BGIT+GqXodsYgEjIitPnEbcxW
         dUKj8Pa8rWiMDYPWMcS+Na+DrjH1UVwNuuV4z5r+nMuJtRMFusDk+Jeowy4aru/xb91p
         y4jQzLPjCzk9RR5VUpa9Qv91Y9T4eaLP5+ztNWyagV9lLKugfy7JG219/4fKeW2iA8Ni
         Iy/34wi/Wr5lhyFQOYLSYKveImvgoonWD1xw831vCJ4BNJUEbX0qUipujqJCyf/TN4WO
         fTlWwWJbY1bJebHGUuzZVPPo82dsVaPfAl3gHUWyN8tk60svFpxYy74L1kV4fT3xeHuo
         Clpg==
X-Forwarded-Encrypted: i=1; AHgh+RonfPgCvnuV23BjoOYZC+eEFy2azanNw1ftGNULSY1i0xow4sPaoJe8kqPSABp79W7nxDPPIQlF+Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL8FzqWCaMzAV33FU1Vti7IRPuCyFky2NQRkTPFme4mE/p1r9v
	VS18HtCgpyxmrfoOzhIuERipz0o1qkCNX/Q66ailOeR3e8X5k6Sm2tqF
X-Gm-Gg: AR+sD13c/L/gULYCJ92rvbCKe30K5AZofozpYp5GrtWJVImbdnPW6FwDXv15hDpUaA3
	KSKnOEUM88e8sguHuf7wg55AjqH88qJ/K4YuG/SPitASBD34FI2E8qpveFaTnVCMjlmbDeQxHBl
	YdWhB0cuZGeBNixDvRIoVV7gaALonwU2PiRoNU2mr6dGfl4bgZpeKefKIgbBeJZkw23fPCh7bEr
	qdV33NxaofDzraI4mcf2IqPWgkPNK85Fae92ECeYGMUqzGfHAzM4Ywt/C6e/KC6RV+twL+DjSI0
	ZG1W4LlO47wwdzYseUbNbsKHfpKnE9Fk9YsXNDKXxxJ24JiEYk9VsWtT+4xoFaq5PtdVUhQ0Qbr
	nzRBfZo7VIYApmMqpoY4WAVS5GoLE51ukftXjUP4qRUtAuAMm4nC8IBSYSyJXmgaAD+DabgOosN
	8/KTYNPyEGoshi0KTYWKeHGmu9u2xrIuhBIq/I6Dk=
X-Received: by 2002:a17:907:3e06:b0:c19:6d4a:4261 with SMTP id a640c23a62f3a-c1c50c9aa33mr70460666b.63.1784785498617;
        Wed, 22 Jul 2026 22:44:58 -0700 (PDT)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32ac8c3esm189241366b.23.2026.07.22.22.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:44:56 -0700 (PDT)
Date: Thu, 23 Jul 2026 07:44:52 +0200
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
Subject: Re: [PATCH v7 5/7] iio: adc: mcp3911: Add support for spi-device-addr
Message-ID: <amGqVEUujfo7errO@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MtfhSntS9TW1Vu1E"
Content-Disposition: inline
In-Reply-To: <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>


--MtfhSntS9TW1Vu1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 09:54:17AM +0200, Janani Sunil wrote:
> Read the generic spi-device-addr property when determining the hardware
> device address. Fall back to the deprecated microchip,device-addr
> property and then to the historical device-addr property to preserve
> compatibility with existing devicetrees.
>=20
> The device address remains 0 when none of the properties are present.
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>

--MtfhSntS9TW1Vu1E
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmphqk4ACgkQiIBOb1ld
UjLb6BAAsp7UZzSbFXMXGJBLOP8h0fXtzzfybl4Icf9WnS1tdMe9GfD0PknCvRRB
0CSbaxYBOVTFks+BWKYX0VgR+2hQ8bEl6UyHHOn4SQE/nunRyxMufzh9UZ2VAANf
iCg5geMkIYBgXNhW+LRgeVW03LyIPMUVdlrS3M5ef1297/e3BMgI6J7DJ4ppQ0V+
ZB67bGDEnyDlCHcSkO4PR2Qppbhr5ZLMdWnBBveHaIUa44jSDYD5Df5+6jMnLwE7
Y9qTbcxzzXrrxucd3GI8h05metm+adbUgSsTDMjprd5kxt4JzEnBhmPJPLMWBjRN
QqcbbtS7y+AXQHGcVCytNHbgD3Hw6fQD23yaYtz/H8pNAF7sTpux8BgYsz0BaMcl
yDZhsSFJPoAtJcol85vSc5TNPJby7Humys6289Q2B8qbi82uXK12rH7D/XNbpHqt
D5W0XE1hKlN3BPKPF6AmPLO62wpdmKRmDavjERt8YA4tWhdZkZ8cosvKhKIEXeIw
VZ2YEsr4LQJRSgWGLtbmUbg97vUyBMZ6/LeZUDova0Zt1IbmEI2FAOnHXbtqb+Lu
aosMxoA2doxH7nE7zPWcqQAc00gTQj8FzHXPdsKiIMn/017AqFVyIfquxCNHAWcw
MsAbqJWelsA2qe2ygt6uJnhoJxsIuRMrfgnqRPA1t3KPzy647QI=
=Nsy1
-----END PGP SIGNATURE-----

--MtfhSntS9TW1Vu1E--
