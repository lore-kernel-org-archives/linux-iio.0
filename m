Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859633C188;
	Mon, 13 Jul 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960094; cv=none; b=TxL2rbXjEJIAFszNRxRkhObJuZCI8EIumLcnvUWvcC4gIC/8LtVSLh3+oqbLSw1ixjINUX9yEcSxn7t/ZBzPNNqP79H2Rg9c0zwS915+0vyXwk4QfXu7kHLxNiq5YJLnQrbfaQiIBqWy30wa4Mi1tidN5t6lvV6COwIAw9tNc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960094; c=relaxed/simple;
	bh=tgNvHW2KjwQf7O/YXfsljb+i78r8AxX15QYnYz0YagE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv8vkxUoXcofkXE9GUsHK1LKOuT4umGlLq2i3vp1YC3M/YCfETOcHMoBVnFXeAM2WrrWSCOqWD69HtxbdSr4WegPLyqOUL1uRAFDCOEAk1fXwCbHE2jAedATuQsizOyI1sb/q1PQlHMLWZeLsNLjuLJOlQCLJ3wqlBcqN4areQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBsay+ac; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBsay+ac"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3326F1F000E9;
	Mon, 13 Jul 2026 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783960092;
	bh=tgNvHW2KjwQf7O/YXfsljb+i78r8AxX15QYnYz0YagE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oBsay+acaT03ezCWTftdOrWndCRkkXiyEUXzzD4TW0PcBMipeyudLYfE7tsrdIdLK
	 dGI0zyYVPuM66sgygN57V8sM4thWku4OXgcZWVmNo59P+pL8rPiUUkSROkU6XL49rg
	 4NxYPg3rh8aAl2F0bfE2hDysN7O8SUzgGVVW/jo/ldFbmSwnLTkSRkUin59rYArj3p
	 lYUdgILsQrA3wYjqxDL2zGPiJNKT8BlqLs53qwH1ABRt2ycOXe7EAn+TQ/VcBwp+IP
	 3HQHbecC9QHC4ed6hvm/tNq8hlWrFNiNO6cFRXVxCN5JnGDbZTZWVSiPKpEdsR+lFy
	 f1IFyZrIK8y1w==
Date: Mon, 13 Jul 2026 17:28:08 +0100
From: Conor Dooley <conor@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260713-remix-jailhouse-bcebf6257fd0@spud>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
 <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vozGJFcg6Vl4LdY9"
Content-Disposition: inline
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-5-746d52cbf1d0@baylibre.com>

--vozGJFcg6Vl4LdY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 05:50:38PM -0500, David Lechner (TI) wrote:
> Add new bindings for ti,ads122c14 and similar devices.
>=20
> This is an ADC that is primarily intended for use with temperature
> sensors. There are a few unusual properties because of this. In
> particular, the reference voltage source and current output requirements
> can be different for each measurement, so these are included in the
> channel bindings.
>=20
> The REFP/REFN reference voltage is usually just connected to a resistor
> that is being driven by the ADC's current outputs, so there is special
> property for this case rather than requiring a regulator to be defined
> to represent that.
>=20
> ti,vref-source is reused from ti,tlv320adcx140.yaml (otherwise might
> have preferred an enum of strings).
>=20
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---
> v3 changes:
> * Fixed channel@ pattern.
> * Adapted to input-chopping property rename.
> * Made sure to use items: on array properties.
> * Added reg to required list.
> * Fixed missing space in example comment.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--vozGJFcg6Vl4LdY9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalUSFwAKCRB4tDGHoIJi
0nptAQDVv8lNHWFb/SCIGEHA9RkWhrdKqRzyFfCw4p2oUW20FAD+KVglMkMeVcFi
uLc3wheeeqlgn3uWQqyRUwysv6vJ+gY=
=0+Ow
-----END PGP SIGNATURE-----

--vozGJFcg6Vl4LdY9--
