Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC81286D5E
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 19:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769974556; cv=none; b=IQ0wMyQV78cp/vhDa3vSglfcPLGPNWlExguEcA0F7aTziKprpiq06Ux7IKWxgR8vg3752OVgKdS5ae7gWhEbnWtMt45NlA/AWZxsrq5BPu8D1JLi7zlbGNA3Ds17bWa+IcMx8IGDAjm4aa6um3lNmv6RBTgUm2llruuWF9YyCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769974556; c=relaxed/simple;
	bh=xC4JNj83DSwZKQi7KDrsXy/44m8OkG40SekgE4vI2lQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pKUSfc00Pg/4vv2kSKnM8Z1WuWkTZNVWkzBwXMT1JeRt1dQ92TAzX/PW1LP4yOVZRe85ZyfCBEqVEYxmSuf1GJvOHCwd5cePOAilWprMdboS/4nP6lv6Of7huc4qhQBvs2L0DfYeKHE/iumeM8JUwP0m/WJKF+cTCKcGq8a0x7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=dd+jNqO9; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="dd+jNqO9"
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id 3A36E6D6B6D;
	Sun,  1 Feb 2026 20:35:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1769974551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lm4iZS+oXCLm1KU7ievUyN4UL/jPfvgVlKcZCbDt3GM=;
	b=dd+jNqO9l2TrqwSoIX0d+XKQIOFIT3Z5jo+o7LJ2LRNyImfpmEo/mQtBYsz513QayIUI0a
	EfZi/Y1adVLtX4wP+zL9yeErFGjW6/ARjpIzE4yGsZQi2u0fasvwKTlvVrA9end9TLX/L2
	EeHwMnySgCdEhVIvk3CxEe3xDYMfxv5S52StdonOucIN6tmz/aOiDHDRLY4dmt9f23zGRV
	fgaDEWS3HjllYWgG1FTUr1qpkgcOGsNodqaMdUYNED6opvNFpJYizHiaFniA6SvssG2BCy
	NODfGIwpDThcUx+jBiUNuDGAC+DufvyS7rhuhGdSKscLWproeYx2b7ca5nzv9Q==
Message-ID: <3b444835dcf4f4600bf5cbb9c079e4920137a960.camel@svanheule.net>
Subject: Re: [PATCH v3 7/8] iio: dac: ds4424: convert to regmap
From: Sander Vanheule <sander@svanheule.net>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Andy Shevchenko
	 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Date: Sun, 01 Feb 2026 20:35:50 +0100
In-Reply-To: <20260128153824.3679187-8-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
	 <20260128153824.3679187-8-o.rempel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oleksij,

On Wed, 2026-01-28 at 16:38 +0100, Oleksij Rempel wrote:
> +static const struct regmap_config ds44x2_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.cache_type =3D REGCACHE_MAPLE,
> +	.max_register =3D DS4424_DAC_ADDR(1),
> +	.rd_table =3D &ds44x2_table,
> +	.wr_table =3D &ds44x2_table,
> +	/* Seed cache from HW during regmap_init */

Nit: You're seeding the cache (manually) in ds4424_init_regmap(). But you c=
an
also just drop this comment as far as I'm concerned. The comment in
ds4424_init_regmap() explains it sufficiently.



> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read hardware defaults\n");

Nit: "hardware defaults" -> "hardware values"


Nothing too serious from my side, so FWIW, with these things addressed:

Reviewed-by: Sander Vanheule <sander@svanheule.net>

Best,
Sander
