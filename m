Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62F24293C
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 17:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785085331; cv=none; b=lT6RiC91Nq7Ua46G3VV3Cx/5FkfbABEi0ZovcELMWynygbHye5AixrmI+qmRRiz3HyoMLZi2RKXZMPGy2RNE73vjkNMAatonIVnJkutPjFEkexgiSYJP75xRAfXdcgc+pCoK6z/jSp6k0q98+3kavzFejnDAQK86QWxF5kpYDcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785085331; c=relaxed/simple;
	bh=ziYas+ROfEygSIAY0fcmd767VnpHhnG30/U6D8UWZ30=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=C2dLMpHw5ft9V5rc4KOFw7WuWLIQslcF+oAcRQ3g+ATosmyDbjkgySOjUH4dZlbz1Dc56rRdPlZJKtXZLnxVG/1PvQ1RL5GflmGwr3N2HVxSFnutRfO+0ybI95W0Hwr+C0CWkW3bVuIEyIQKD8pxqH20vv/rWT/FuelyqEEa3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/VYhach; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/VYhach"
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785085317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rPOSbC7krROGCJWQ/tEAsHlzXAU8juhi74M+ai8d9U=;
	b=O/VYhach9RFo7G90RoTgxhxm91nzKvH+a5nbUjtM94zb190DoDFzN+fiqDzAxGs4f8LX7A
	6CJQK5EmL+JDbqiBm7w2AkvCWWhkZw3CT8dpHHFFBwSJUrzKhDFI8+Qs1GwPPPd/vAgzOv
	OesIijJzK+tpwPCTuw9cmsVFl1yKZpA=
Date: Sun, 26 Jul 2026 17:01:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Siratul Islam" <siratul.islam@linux.dev>
Message-ID: <6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
To: "Lukas" <lukas.metz@gmx.net>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, "=?utf-8?B?TnVubyBTw6E=?=" <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <amYVZtbxu4fjhBkx@berta-MS-7693>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
 <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev>
 <amYVZtbxu4fjhBkx@berta-MS-7693>
X-Migadu-Flow: FLOW_OUT

July 26, 2026 at 8:10 PM, "Lukas" <lukas.metz@gmx.net mailto:lukas.metz@g=
mx.net?to=3D%22Lukas%22%20%3Clukas.metz%40gmx.net%3E > wrote:


>=20
>=20On Wed, Jul 08, 2026 at 09:58:13PM +0600, Siratul Islam wrote:
>=20
>=20>=20
>=20> +
> >  + const struct reg_default reg_defaults[] =3D {
> >  + {
> >  + .reg =3D CMD_SET(CMD_WRITE_UPDATE, 0),
> >  + .def =3D info->default_output_reg,
> >  + },
> >  + {
> >  + .reg =3D CMD_SET(CMD_WRITE_UPDATE, 1),
> >  + .def =3D info->default_output_reg,
> >  + },
> >  + };
> >  +
> >  + const struct regmap_config regmap_config =3D {
> >  + .reg_bits =3D 8,
> >  + .val_bits =3D 16,
> >  +
> >  + .max_register =3D CMD_REF << 3,
> >  + .cache_type =3D REGCACHE_MAPLE,
> >  +
> >  + .volatile_reg =3D dac8163_reg_false,
> >  +
> >  + .reg_defaults =3D reg_defaults,
> >  + .num_reg_defaults =3D ARRAY_SIZE(reg_defaults),
> >  + };
> >  Why are these defined inside probe? Should be defined outside the fu=
nction.
> >=20
>=20The default values after reset are different for the compatible devic=
es
> (0 for the dacxxx2 devices and mid-scale for the dacxxx3 devices).
> So these are runtime dependent. The alternative would be to have two
> regmap_configs for the two device types and add these to the chip_info.
> Or do you have another suggestion?
You don't need two regmap_configs. The way I would do it is, move the "re=
gmap_config" out of probe and name it something=20
like=20"dac8563_regmap_config". And in chip info struct, replace "default=
_output_reg" with "reg_defaults[]".=20
Then=20for each "dacxxxx_chip_info" define the appropriate "reg_defaults"=
 configuration.

This way you can do

struct regmap_config regmap_config =3D dac8563_regmap_config;
...
regmap_config.reg_defaults =3D info->reg_defaults;
regmap_config.num_reg_defaults =3D ARRAY_SIZE(info->reg_defaults);

A bit of work, but it would ensure most of the work is done at compile ti=
me,
and we avoid reconstructing these sructs everytime probe runs.

>=20
>=20Best regards
>=20
>=20Lukas
>
--
Best regards,
Sirat
