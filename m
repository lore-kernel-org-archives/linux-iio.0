Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779E27F010;
	Sat, 28 Feb 2026 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772314526; cv=none; b=gmuCroIhYwBeb9IZqzZ5l6KbzOVUX49Zc6GrRWf5+1QcimoSzB5dxI/CjSM38gr62v0tnp7KeKxXQpjXR2qCU3mAqxArtprzcXJOU0dq/bNF32ad4mxOTcIW6LhzRnFNdOm1i7XnffRLzas40Hc2eT8S5MlqYW4NvvjIbeVR0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772314526; c=relaxed/simple;
	bh=uE+NY26oLrKW+yztywRPuIT9/z0NETykFwOtblclvtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pp83kdnj6YsU6HGtNwAykEVp6/8sX/5VQ4DBaSQJoOkqfb2O731tyLCBHDPYTce8/pdaLsQXUwRzF/qePRKsIrcKG9ruu/TpMYMrEo/u+SqxfJEsn3kfi0Np9RMXM+N6jwbW1B7cB2wjPF2UBShT3jqenfMenKw15nm0oNYlVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8Oej7sk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8Oej7sk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2271DC116D0;
	Sat, 28 Feb 2026 21:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772314526;
	bh=uE+NY26oLrKW+yztywRPuIT9/z0NETykFwOtblclvtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8Oej7sk73HAJfyxRZvzVKcQAKmPIkq4fCNxQfOFS7UUa1vixkF7JZc9o2s8oOP80
	 Uz4oYrtshFQMGJk8HzzD4vGd+lBvBSoNSpsqhYL69pUBWqHa7uBJDf2AQxFNGfPUog
	 BKTPDaydA3JvPcd5oeAutnfEaENsxpqywrh0S4Y5+vQ4OHfKtzKxpuTYSWlz578Ldx
	 JJGA4nslyioZh2rfHOipND6OKARHmyk1IALOzgkxYh3sw0EVcJBV4ibTuZvkzXxn2x
	 csk8XYXZAx5ULBypR7aG18tz7SUCFAEYUk2fx0hMoTZZI4Jt/T7qgq6KKJ+O2yZ+kS
	 43I1cvKsKmCng==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 251761AC597D; Sat, 28 Feb 2026 21:35:23 +0000 (GMT)
Date: Sat, 28 Feb 2026 21:35:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 0/5] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <aaNfmu8Wubizo5Go@sirena.co.uk>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TMuLw1nB3GMyikBv"
Content-Disposition: inline
In-Reply-To: <20260223162110.156746-1-antoniu.miclaus@analog.com>
X-Cookie: Think big.  Pollute the Mississippi.


--TMuLw1nB3GMyikBv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2026 at 06:20:59PM +0200, Antoniu Miclaus wrote:
> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC from
> the same family as AD4080.

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-devm-ancilliary

for you to fetch changes up to e02902dd493bf9c9b05353c761737ac514ad7a5c:

  spi: add devm_spi_new_ancillary_device() (2026-02-24 17:41:42 +0000)

----------------------------------------------------------------
spi: add devm_spi_new_ancillary_device()

Add a managed version of spi_new_ancillary_device()

----------------------------------------------------------------
Alain Volmat (1):
      spi: stm32: fix rx DMA request error handling

Andy Shevchenko (1):
      spi: pxa2xx: use min() instead of min_t()

Antoni Pokusinski (1):
      spi: omap2-mcspi: add support for 3-wire transfers

Antoniu Miclaus (2):
      spi: allow ancillary devices to share parent's chip selects
      spi: add devm_spi_new_ancillary_device()

Charles Keepax (1):
      spi: cs42l43: Don't support sidecar properties on device tree systems

Cosmin Tanislav (1):
      spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs

Krzysztof Kozlowski (1):
      spi: stm32: Use NULL instead of 0 for pointer

Patrice Chotard (1):
      spi: stm32-ospi: Remove exec_op() callback debug log

Pei Xiao (1):
      spi: atcspi200: Remove redundant assignment to .owner

 .../bindings/spi/renesas,rzv2h-rspi.yaml           | 16 ++++-
 drivers/spi/spi-atcspi200.c                        |  1 -
 drivers/spi/spi-cs42l43.c                          |  4 +-
 drivers/spi/spi-omap2-mcspi.c                      | 17 ++++--
 drivers/spi/spi-pxa2xx.c                           | 11 ++--
 drivers/spi/spi-stm32-ospi.c                       |  5 --
 drivers/spi/spi-stm32.c                            | 10 ++--
 drivers/spi/spi.c                                  | 69 ++++++++++++++++++++--
 include/linux/spi/spi.h                            |  1 +
 9 files changed, 101 insertions(+), 33 deletions(-)

--TMuLw1nB3GMyikBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmjX5oACgkQJNaLcl1U
h9D+TAf+Ipw8Gc/+B70hMbEpqZhtsYP7GT49dptCsIuN0RBputuTYeqcfujd+mNs
psu87ms4bHWnarM7TseX1h2QqCF4q5kbZFfLxalWKzuk/99jsBSIZGOUYi0y/DJP
PeCCXBEj4OWUK7cRGUISyDHTe5TpB4kQMpL79GuODzifE0z6d2HwIXywUmUBcIlD
mHxXyRQGiuRmPVcaVEIGJCdiADujd7+cL6sjPP4r2iz0FD9gYtlGtgLU2/I5/ECi
li8nxM9cqvREqAk0u2zv/0HTnXrdtyQVZHFO5gzUXKE9K0EwrQTYyNpAvvPnmVJH
BF/SDVfqiPmhvQlVhSp95yMy+/a/jg==
=hOiC
-----END PGP SIGNATURE-----

--TMuLw1nB3GMyikBv--
