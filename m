Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196355;
	b=IEY5S7rwSzRaVbsxnYood/Nx7YFWLwNjsQNbek7/1XUCAEi0y27G8cS6C9jkvnox/SQd
	 i7mTgRxE5Vh4CIf36uNo8wffg2KXT1PqYXvY8FZrfFlpu5LAY4PCRhUTZ9av2OZAbU7tu
	 fw0MF5MVTwGMiCzqTQ0+iODm9kr73Haqzvf/R9FJQNAJw/AE3f7tj9T9nVmq7nd2uYS4j
	 F1nA4sHs7WIuJI4OTxtZT17u74JC5/8Bi5P7N7sn8QGBcWmVlSxRSSkAdd1SEXp9EmIF4
	 E3QwNyrhGFe+jmrCIv6PeXUldqFNW0goIBDbPbQMoewV8fza6ZnXh8ge809AvApt9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196355;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=efOmL/ac+19DmqOOXGAI2aqU8WZIeD1n+6/SOHoKPjQ=;
	b=F5iwO+/AjbpI4ZBByjYTkMB2Yr/w1Ok6HR2LR1b2LP7i5hscOM2QEKI0HPaFsT0gKXVx
	 7UI4uDuu5EDZ3GfXvubGPSi/Ys4TNKP5CmgfE56iolkcn7NGV/7PEXI0Tn5lg2nUAS6PY
	 DpkvuVKLvkKdvilI032DP/Nt0ntwmVkNL08WpqPAP80jqq71l93SUJKHjySbzrSBksA5z
	 6f4thFBtnJJLwOWLVI6o4UTNXUtO8f1G/K+5h+qi9MfRaFGi+6c3y03DTkOQzg5WGsO7E
	 zQ3fLxmkOJUKKmwFlYBgnwrj9lMAePLIDzzdnr0VqwFKnhHgVl1MhFrPMVaARTVL1oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzACEePL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8263606A339;
	Fri, 20 Nov 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzACEePL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE11F000C6;
	Fri, 20 Nov 2026 17:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196354;
	bh=efOmL/ac+19DmqOOXGAI2aqU8WZIeD1n+6/SOHoKPjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SzACEePLwFt0fhJplYRD+H1aQI4UDBpXwK3086+/l3/EKu4YwJ6IJ1Z3EMD48x7Jb
	 MVXKsqo3jJqhHQHraAI8ivGvCixPi3hq1h301q5knvNanMS+WERuQF8ZwnvDovhXG+
	 Z5NcAWZ0FjSL2aYgsfvJbmNFJkFu3VEfHV6AfXH0kLQFnwcwEpgn2DfcY5rY3oE8yv
	 Gf7RccLFd7PnyWj9Td3XnXKN2jEJdiqIs4nC2EKhJK1x1qvt1h9etA4mhhEftQv7RD
	 aEoJP7UQhRJy4JO0Z3TOY565fhONuTIz2aZzMsWtbJR/yD8ZWQouVkKME4/yp6Pdou
	 yH7hhjDbpltqg==
Date: Fri, 20 Nov 2026 17:39:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: Support ROHM BD79111
Message-ID: <20261120-sugar-stipulate-1cda698616fe@spud>
References: <cover.1795176984.git.mazziesaccount@gmail.com>
 <578cd514c24a47ffd5cb3e02b78aeaf2fd3838bc.1795176984.git.mazziesaccount@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2cApVkMlque8bc6p"
Content-Disposition: inline
In-Reply-To: <578cd514c24a47ffd5cb3e02b78aeaf2fd3838bc.1795176984.git.mazziesaccount@gmail.com>

--2cApVkMlque8bc6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 02:27:02PM +0200, Matti Vaittinen wrote:
> From: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ROHM BD79111 is very similar to the BD79112. Both are ADC/GPIO devices,
> where pins can be configured to be either used as GPIO or ADC inputs.
> ADCs are 12-bit SAR ADCs and GPIOs support input/output but not being IRQ
> sources.
>=20
> The main difference is amount of channels/GPIOs. The BD79112 has 32 pins
> for this use, the BD79111 has 16. Furthermore, the BD79111 data-sheet
> promises 0.5 MSPS sample rate with maximum of 10 MHz SPI clock,  whereas
> the BD79112 data-sheet mentioned 1MSPS rate with maximum of 20 MHz SPI
> clock.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> ---
> Revision history:
> v1 =3D> v2:
> Disallow additional properties again

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

fyi, changelog isnt quite right, but in this case I don't actually need
it so it is moot.

--2cApVkMlque8bc6p
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawCFvAAKCRB4tDGHoIJi
0pWwAP48OfpSyY+vDSGRyRewo5SdOJV2eS2aZ1Gq2dhyB5rCuwEAt1sz28Aq2br8
8h0fI4FRlFip8sehzY806Vn+/1rDmwM=
=PrfU
-----END PGP SIGNATURE-----

--2cApVkMlque8bc6p--
