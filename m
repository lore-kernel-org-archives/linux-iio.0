Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFC0344DB5;
	Tue,  2 Jun 2026 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417310; cv=none; b=gv05InPZpaLQ2w4x+Wmptro7jvyiz4EQAahxFO7yIvbBbI7a1BORSRcjXZWtqhX7spkp3WlfJ589skUoXhec/TO31/KHzvpZvN7Z7uLG0ATE0R7bN00fIbPUaFIBg5nidY/AByaGBIcSlfT0K7x5FLRsOjZtBtZ6UZS8yvwfgyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417310; c=relaxed/simple;
	bh=UHhslRdCb64uAeyYNctM3W9sIiDue6c1zUXUsmVQdDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVtYtF75e/wRxL+V3NJLTztbJh6GBBr1MJ2F9JTLCBzFGFPpeW/4vIHOMO+2ToJZ/0xl6Y34NQSaHUKt+af9iXlMk5CLeMCRPvxTKTmm+4i5EnBp7pr3/+yzxGAX+Jjg5muFmVfXf+nqSGN6wGye9CFyVokDtv+sDHei7grPbX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6OMW+cK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6OMW+cK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294731F00893;
	Tue,  2 Jun 2026 16:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417309;
	bh=UHhslRdCb64uAeyYNctM3W9sIiDue6c1zUXUsmVQdDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i6OMW+cKx7zXo90uE8WPiS/OcVuI7uDGylbGIqiWQu/iVicaSM+DeEqQXJGZgk1OM
	 IwDdZDUjqr9ntqqtBnHhSlVGJ3pjMA5BuvXq52ZMR7U7t3oZQUNF8jtZk+ZwcRP9hc
	 D61ZQrbLjbtT5RO3hyuYOkE7XNJAIp/9EfedL7TXY87GOrYpVa/Sv5OVr/lSqUti5d
	 72u7DVutWn4bGcGII3fkV4HtfWPqmtqV7oJK0yYoPS9cthoXN2w+wtVcLxSGNSg6XS
	 v6M/90d4HVUGBK/JsRPbA15VcpcWK0jZYLMglbsTdx8mWmoqkjwg+39Vo6paf66FZ6
	 7Qy55uJv251Ig==
Date: Tue, 2 Jun 2026 17:21:44 +0100
From: Conor Dooley <conor@kernel.org>
To: rva333@protonmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 1/4] dt-bindings: iio: adc: mediatek,mt6359-auxadc: add
 mt6323 PMIC AUXADC
Message-ID: <20260602-paramedic-savor-d18b45241914@spud>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com>
 <20260602-mt6323-adc-v1-1-68ec737508ee@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IJiwimoZW+P1otaL"
Content-Disposition: inline
In-Reply-To: <20260602-mt6323-adc-v1-1-68ec737508ee@protonmail.com>


--IJiwimoZW+P1otaL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--IJiwimoZW+P1otaL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8DGAAKCRB4tDGHoIJi
0kW+AQCQIb8fbQspyzRXQ31z317U3glZxhw+7Cyj4mh7Xu2LSgD/Q+ATNfJMuTbI
u1ybBxzqgJ6j/WnDdxqpZN+NAU2qIww=
=Hak5
-----END PGP SIGNATURE-----

--IJiwimoZW+P1otaL--
