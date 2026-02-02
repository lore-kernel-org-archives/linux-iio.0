Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1292E1743;
	Mon,  2 Feb 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770074586; cv=none; b=AUk+BuUDLyrPu6ZSwg4SdQQuRrUNlARumya3wQMiHZ7JQoKD1lZJlH+7v8wiDmfcqzOFowplUhXhqpHdd2PFBDjDLZz8kxqHF/Omp5txeiapzXVLMqFjmoMKt22oTBNJc3HQmuT/6Y+LMWYzhYQqbKukTi+thhbRVBlJPnoCRFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770074586; c=relaxed/simple;
	bh=3Iu8brpI4tChFP4pMAm50wy5Qo2Vd2Ele1ye8TxHhc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KD73MOVMqTXJUvsARIpSirJIyEzBimDafTQ4vT2SPydHNVzkb4LsdsMuetfgKyEM/Wv78WCdabjmqrGrFbkLbqIBCAaILSNfBair/6weVU+BcCOIffzfCLGVQzpYbgG89rA7q8MR6qyTeUlSlP68lVe3rjQu0l7vwnlD3MzXq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlpdREAa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlpdREAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EBEC116C6;
	Mon,  2 Feb 2026 23:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770074585;
	bh=3Iu8brpI4tChFP4pMAm50wy5Qo2Vd2Ele1ye8TxHhc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlpdREAalrzMAm25i1T2HdjpGwznFedXcHWFxapntyqPyX2szYX23DSIoba/ShJMP
	 6Uh5IWl/ColuRysV3TxmNqU4JtSqEp3ATY9FAT8rj/U9sKyIVdidqW/l+iSumP97A3
	 XlUTz7Le1UC6lkfEM0RE8ZRAqNA1ykHjrcwpy42J3U56yaLqI51lECrSdzG/KBbH7y
	 iEL5xM2jGvGEwQkYqPKeYOwLwUjK+U1cwf2/ZvC1mLaThoe+ifzzGHDhtFQewSTGIC
	 2oszyHjsN1uG71kq9KophdTF11dP4ZYY8Cgmx0nXLdNPL2i3hEyX+bYf//JdFfGuTM
	 Y4LOorDrGoSBg==
Date: Mon, 2 Feb 2026 23:22:59 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v6 0/9] spi: add multi-lane support
Message-ID: <ed1331d4-2e34-4b30-a0d7-f0e1d6093af8@sirena.org.uk>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0MMXqhB0JZpPctVx"
Content-Disposition: inline
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
X-Cookie: Bedfellows make strange politicians.


--0MMXqhB0JZpPctVx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 23, 2026 at 02:37:23PM -0600, David Lechner wrote:
> This series is adding support for SPI controllers and peripherals that
> have multiple SPI data lanes (data lanes being independent sets of
> SDI/SDO lines, each with their own serializer/deserializer).

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-multi-lane

for you to fetch changes up to 0ec5ed7c95d1ba6a74491928ff38abb351dbed36:

  spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE (2026-02-02 12:12:47 +0000)

----------------------------------------------------------------
spi: Add multi-lane support

This series is adding support for SPI controllers and peripherals that
have multiple SPI data lanes (data lanes being independent sets of
SDI/SDO lines, each with their own serializer/deserializer).

----------------------------------------------------------------
CL Wang (1):
      spi: dt-bindings: Add support for ATCSPI200 SPI controller

David Lechner (7):
      spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
      spi: dt-bindings: add spi-{tx,rx}-lane-map properties
      spi: support controllers with multiple data lanes
      spi: add multi_lane_mode field to struct spi_transfer
      spi: Documentation: add page on multi-lane support
      spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
      spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE

 .../bindings/display/panel/sitronix,st7789v.yaml   |   5 +-
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  42 +++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |   5 +-
 .../bindings/spi/adi,axi-spi-engine.yaml           |  15 ++
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   6 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   6 +-
 .../bindings/spi/andestech,ae350-spi.yaml          |  87 +++++++++
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   6 +-
 .../bindings/spi/spi-peripheral-props.yaml         |  40 +++-
 Documentation/spi/index.rst                        |   1 +
 Documentation/spi/multiple-data-lanes.rst          | 217 +++++++++++++++++++++
 drivers/spi/spi-axi-spi-engine.c                   | 145 +++++++++++++-
 drivers/spi/spi.c                                  | 144 +++++++++++++-
 include/linux/spi/spi.h                            |  30 +++
 14 files changed, 724 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
 create mode 100644 Documentation/spi/multiple-data-lanes.rst

--0MMXqhB0JZpPctVx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmBMdMACgkQJNaLcl1U
h9DFLAf/eDN1MHKzlDzHEkX7Kc/MuMXQ34+KLKm8zo8/idWiep9CDuUDVmzqf2Ig
tgXs6Tj3jSvEwoXNDUYVZu6d5FOUmvHgla/qoYMgkOZq3IGuIcGJESeiJr5G+pBv
FgfTyGv8Z2W2pup/pbFvj13osctJAg4DccA8i5zPqlIOFH6mbdpRKPVqLgJEFKyc
aPhUkoo9y0TyysPK+1nDym8ZNMSv1EzCcn7c6paeZrExJzccu6XAbA99YTNzb5fC
RESsFzN9eJCS1hc1oHtkfw7HxnFX/6Qm8lT3QD1332dsjSdnwa5pBY2L/6lt61dL
aXTQ8FRPXxuJn0gphdi2oKoEkQpYwg==
=11c/
-----END PGP SIGNATURE-----

--0MMXqhB0JZpPctVx--
