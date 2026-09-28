Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650CD4EDCDC;
	Mon, 28 Sep 2026 16:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613363; cv=none; b=sp2uh1qzDIhKZRJm4qAinnaDc13727jK4u12xjVzOY9gpEpCSz23AakkA9j7OeZ2DbIn7J1DCvqRWJcYvCcTmc8BEP0cL79/nKlaASt9JoOkRGYzd9EQ8da1KpS5d4MDNhATm4L2yvMxgoWmMioqGM19dl0jA5diZWZMVFhfRa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613363; c=relaxed/simple;
	bh=3ymhdO7c53RowO1f4ym0vbL1qjiyHuE93wGnpX1fE8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWQrC+MxSpvZa3n942VekllTtvjd5cLT0182xVPgkonjNww0AlSQftdav+Kgj+YqiPRBd0NsHpPRlORmj/UVRFA8IXAvP/Pp/+TmANeMBtbOqMUR6MkKEEG+St4OJce9MTpVTCjzW1Ja9Drs7VmCVKVj1YrrIpWNG7uqWDTxEu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/KkB1wK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/KkB1wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16581F000FF;
	Mon, 28 Sep 2026 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790613362;
	bh=3ymhdO7c53RowO1f4ym0vbL1qjiyHuE93wGnpX1fE8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a/KkB1wKMJ5sEnkqyWNIIH8f129Td3p1BA2TzfgxYV8nUkX8Nu/5/CB2paTCIOIHM
	 xdsM+L06V8n8L9rLX8y5V3hS/HLfjppFr/yL4/PP8+CFzgy1Wy8J7nDEGl51fWDa8j
	 YakQMmBibg5+Mkw5ktdPU2T7sq7Ocbkvw3WkVEH+LJDhyLMPWJ2jCl8AR4robdI1KC
	 MVGdzsgiA4CoposnoaCXcR5MBcgVLn5Jbbpro5Lo51OnHnosEWYejXn1n0iLYcPsRk
	 kKWck8Ixxk576BLbWxxKIokiI2A6wsTN2l0cAMwfQAV93x2VDWy5v80rqpSEvIqQRs
	 zV4LahirkJLPQ==
Date: Mon, 28 Sep 2026 17:35:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ad4080: add AD4886 support
Message-ID: <20260928-zookeeper-boss-7bc39c0e5186@spud>
References: <20260928104806.9330-1-antoniu.miclaus@analog.com>
 <20260928104806.9330-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dhzbCwTw3k3+ZpNd"
Content-Disposition: inline
In-Reply-To: <20260928104806.9330-2-antoniu.miclaus@analog.com>

--dhzbCwTw3k3+ZpNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--dhzbCwTw3k3+ZpNd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarqXbQAKCRB4tDGHoIJi
0qybAQDkmtF0FPuwEHWu8YBgPdFMRCIgTG6Dp6/4PbB7Ht8peQD9E/6prMd8UtWt
yqbqx5WiVAUfUMkpNj1T84d8q4eY2gU=
=YxIl
-----END PGP SIGNATURE-----

--dhzbCwTw3k3+ZpNd--
