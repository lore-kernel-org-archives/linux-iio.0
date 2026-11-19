Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795113474;
	b=M4dQDv4Tse33I1iKfbHAO1uKDtMiBH1YFLhaDo2H+FHuT4dMRMN1nlXF3N0oiLSGDhZ5
	 7Nci9BMO2ftaUpU0Z0XK9LOUnB1cq4LTfDqF7kCr4qZirGCXy3dRy96mnagX+7x51fcKZ
	 KGuDoxB2GTFi8TXc1xMd67YAdgIMtH37HWIfEYRlgNPIO7TbJuBhUi+pVseCzphtUCoWv
	 4GEx0UL6xCR9u/pESkqyBTnsv/95G3SQ9Lk+xNgxHy8wJPSaJDUoAY5Q3zCj3bfY4KLog
	 8EkaqHLpzSHV9R+peWpF/f4a/p4La7cD989pp4LnNktjRT7IKt/xTUTHJtfFxcja+Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113474;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gLO/oqmV4DgN6TSlCCTIto3brNJsLk1Z5wCWirBFpeQ=;
	b=K6MQDMS5gtgbqXcfbhZAVK7IySg+4V5koYaBQLlJAagiKj9oC1y+wsmhvHoXSOZ8GWpp
	 jnQ3tJh6JoQvo4DhZtroRbwdVcCalJUaEH2fb9ClhIyL/FHMm7DCc4p39QtzCViqrVOnp
	 WAY14cOHLFr3xKqg88+UA+f8KL4QAG7bHPjOBLIzDiqYr/Sdi571VCavZ2jjmNaUHDrw4
	 y4FdJUB07j9tLSYFvYtSX9thDLJLRJm4GmXYHBs82gSG9YWczJ5NDFpe+oMO94hmomwu1
	 gtZzquofD8hbV8OG9m+7pXZ4mdtG+JeNydph3fShXWwA3JyTxH/bYUE2+yn4ZaU4BlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V9/QmJnN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49487606A33C;
	Thu, 19 Nov 2026 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9/QmJnN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA1761F000C7;
	Thu, 19 Nov 2026 18:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113474;
	bh=gLO/oqmV4DgN6TSlCCTIto3brNJsLk1Z5wCWirBFpeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9/QmJnN2JlChDE1K/HsoFTxGK8BUntAFRsQKrrwAQ13j2/3wadDh4OnJkqW+pux6
	 bZ3lbbHiovC3hstNVVKyFWze8GZYT6RS6h4CezG1VghnqLkdj8odVKmNP1o56t+WVK
	 qRJ8ASFD14PTrrW9HutLbcH9djJujhcYKKkW9zrIFErzeCfdRUUcwLmFmofeNNMW8O
	 N9Wm1QM96dx1beV6qK9srRD5Q3l0Lj+nOsKF5U4xSBFq2U3jgj5UxlM96qNfNbH/eG
	 sbsmHAuwwvMwzwlv54x+i9tF537LfR4fFDFJhhW4tAatXHjVk/SL256cJmhKMDrJHY
	 LAu/xtTf2NXiQ==
Date: Thu, 19 Nov 2026 18:37:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 00/11] iio: adc: stm32: add mdf support for stm32mp2
Message-ID: <20261119-stick-armored-64cd8e1cea62@spud>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
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
	protocol="application/pgp-signature"; boundary="LpL/rArroYRlxrrz"
Content-Disposition: inline
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>

--LpL/rArroYRlxrrz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 04:17:45PM +0100, Olivier Moysan wrote:
> This series adds support for the STM32 Multi-function Digital Filter
> (MDF) found on STM32MP2 SoCs. MDF converts bitstreams from external
> sigma-delta modulators and PDM microphones into samples for IIO and
> ASoC consumers.
>=20
> The drivers support direct IIO conversions, cyclic DMA acquisition,
> CIC configuration and scaling, synchronized and interleaved filters,
> and external timer triggers. An ASoC DAI provides PDM microphone capture.
>=20
> This revision addresses the v1 review comments listed below and splits
> the driver patch into smaller functional patches for readability.
> It retains the existing IIO backend interface for external sigma-delta
> modulators, pending agreement on the preferred abstraction.
>=20
> These changes do not resolve all v1 review comments. In particular, the
> frontend/backend architecture, DT child-node model and complete clock
> topology remain open discussion points.
>=20
> * Open questions: MDF topology (backend/frontend)
>=20
> In Analog Devices use of the IIO backend framework, the AXI ADC is a
> hardware backend, while the AD9467 is a hardware frontend. The external
> sigma-delta modulator is actually a hardware frontend in the MDF signal
> chain. The difference from the AD9467 use case is which driver owns the
> aggregate IIO device.

My red line here, that I probably made pretty clear on v1, is that what
is done needs to make sense when the ADC is feeding the MDF, it cannot
only work for the data coming in from sd modulators or w/e you connect
to the SITFx inputs.

> Option 1:
> One option would be to generalize the existing backend abstraction to
> represent components contributing to an aggregate IIO device,
> independently of their position in the signal chain.
>=20
> The existing framework appears to provide the required mechanisms. None
> of these mechanisms inherently requires the provider to be a hardware bac=
kend.
> A generic component/provider model would support both topologies without
> duplicating interfaces or requiring reciprocal dependencies. The key
> point here is to preserve the compatibility of APIs and DT bindings.
>=20
> Option 2:
> Alternatively, if the backend abstraction should retain its hardware
> meaning, we could introduce an explicit frontend-provider abstraction
> sharing the existing infrastructure. Frontend operations would cover
> analog-side control and conversion parameters.
>=20
> Would generalizing the existing abstraction be acceptable, or would a
> separate frontend interface built on shared infrastructure be preferred?

For either of these options, do you envisage the data being retrieved
=66rom the mdf sysfs files rather than from the modulator?

>=20
> Option 3:
> An aggregate IIO device based on the component framework, as discussed
> in previous threads, could also be considered. I currently regard this
> as a fallback solution:
> https://lore.kernel.org/all/ec411432-4b77-4410-b0aa-b29f73b82c84@foss.st.=
com/

You option 2 in the earlier thread had:
| 2 - DFSDM managed as a "hardware accelerator"
|=20
|=20
|    +-------------+
|    | Sysfs       |
|    | - Scale     | +---------------+
|    | - Raw data  | | IIO char dev  |
|    +-------------+ +---------------+
|             ^             /\
|             |             ||
|             |             ||                         Userland
|   -----------------------------------------------------------
|             |             ||                         IIO fw
|             |             ||
|             |             ||
|   -----------------------------------------------------------
|             |             ||
|          +--|-------------||--+     +----------------+
|          |  |             ||  |     |                | Drivers
|          |  |             =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D    |
|          |  |                 |     |           ||   |
|          |  +-----------------+-----+--+        ||   |
|          |          +---------+-----+--+        ||   |
|          +----------|---------+     +-----------||---+
|                     |                           ||
|   -----------------------------------------------------------
|                     |                           ||
|          +----------|---------+     +-----------||---+
|          |                    |     |           ||   | Hardware
|          |    sd modulator    |     |  DFSDM    ||   |
|      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   |
|          |                    |     |                |
|          +----------+---------+     +----------------+
|                     |
|                     |
|                    Vref
|=20
| The DFSDM is a consumer of the SD modulator.
|=20
| In addition to its complexity, the main drawback of this approach is=20
| that it is unsuitable for interleaved mode.

Two mails prior I had theorised a way to deal with the interleaved mode
https://lore.kernel.org/all/20261015-attentive-conflict-1a1f538de77d@spud/
but I never saw a response from you as to why something like that cannot
work. That's twice in that thread you said it was unsuitable without
providing the actual explanation for why?

Cheers,
Conor.

>=20
> * Driver implementation
>=20
> Serial interfaces (SITF) are shared resources managed directly by the
> MDF core and no longer have separate platform devices. This revision
> retains their DT nodes to describe configuration and clock connections,
> and to allow filters to reference their input bitstreams without
> duplicating shared settings.
>=20
> This revision also retains a platform device for each MDF filter, as
> each filter manages its own registers, interrupt, DMA channel and IIO
> acquisition state, with a separate suspend/resume lifecycle.
>=20
> * Clock management
>=20
> Several clock-management review comments are addressed in this revision:
> - The provider-side clock-frequency property has been removed. Consumers
>   request CCK rates through assigned-clocks and assigned-clock-rates.
> - The clock-names property has been removed. The core acquires its single
>   input clock by index, and CCK gating uses regmap-based clock operations.
> - Remove the unused clock-ranges property, as the core now explicitly
>   shares the kernel clock with the serial interfaces and filters instead
>   of relying on parent clock lookup.
>=20
> Clock topology point remains open, awaiting clarification of the MDF topo=
logy.
>=20
> Changes since v1:
> - Split the large IIO driver patch into smaller functional patches.
> - Replace provider-side clock-frequency with consumer-assigned CCK rates
>   through the common clock framework.
> - Remove the platform devices for serial interfaces.
> - Replace the interleave phandle list with a filter count, covering
>   consecutive filters starting at filter 0.
> - Simplify clock-output-names, remove clock-names, reset-names and
>   filter-level clock properties, and move mdf-dai into an explicit
>   property outside the conditional schema.
> - Rename the binding to match the STM32MP25 compatible, sort compatible
>   entries, and simplify the binding patch subject.
> - Use unsigned long for match data, improve probe error reporting and
>   wrapping, remove a probe-success debug message, and add kernel-doc for
>   exported core functions.
> - Use scoped spinlock guards.
> - Remove empty serial-interface runtime-PM callbacks.
> - Remove the redundant ASoC platform module alias.
>=20
> Additional fixes since v1 (following Sashiko review):
> - Compute the settling-time discard count with 64-bit arithmetic.
> - Size cyclic DMA periods in complete scans and validate buffer and
>   period alignment before starting DMA.
> - Fix backend-enable rollback so backend zero is disabled as well.
> - Use managed allocation for the conversion buffer and managed IIO
>   triggered-buffer setup.
> - Release temporary synchronization and serial-interface firmware-node
>   references. Replacing interleave phandles also removes the associated
>   stored node references.
> - Avoid unregistering secondary interleaved filters that were never
>   registered as IIO devices.
> - Use managed acquisition of the optional serial clock.
> - Replace the GCD-based CCK divider selection with a search for the
>   largest valid divisor, allowing non-power-of-two divider values.
> - Remove the selection of the undefined COMMON_CLK_REGMAP symbol.
>=20
> Previous discussion:
> https://lore.kernel.org/all/20261001145702.2628429-1-olivier.moysan@foss.=
st.com/
>=20
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
> Olivier Moysan (11):
>       dt-bindings: iio: adc: add stm32mp2 mdf filter
>       iio: adc: stm32-mdf: add core registration
>       iio: adc: stm32-mdf: add cck clocks provider
>       iio: adc: stm32-mdf: add serial interfaces support
>       iio: adc: stm32-mdf: add digital filter device support
>       iio: adc: stm32-mdf: configure cic filters and sample rates
>       iio: adc: stm32-mdf: add direct iio conversion support
>       iio: adc: stm32-mdf: add dma buffered acquisition support
>       iio: adc: stm32-mdf: add external timer trigger support
>       iio: adc: stm32-mdf: add dmic audio filter support
>       ASoC: stm32: add mdf dai support
>=20
>  .../bindings/iio/adc/st,stm32mp25-mdf.yaml         |  341 ++++
>  drivers/iio/adc/Kconfig                            |   29 +
>  drivers/iio/adc/Makefile                           |    3 +
>  drivers/iio/adc/stm32-mdf-adc.c                    | 2080 ++++++++++++++=
++++++
>  drivers/iio/adc/stm32-mdf-core.c                   |  899 +++++++++
>  drivers/iio/adc/stm32-mdf-serial.c                 |  223 +++
>  drivers/iio/adc/stm32-mdf.h                        |  275 +++
>  include/linux/iio/adc/stm32-mdf-adc.h              |   19 +
>  sound/soc/stm/Kconfig                              |   15 +
>  sound/soc/stm/Makefile                             |    3 +
>  sound/soc/stm/stm32_amdf.c                         |  375 ++++
>  11 files changed, 4262 insertions(+)
> ---
> base-commit: d922ed738439e1d5b4701df7f4cdd49a09925624
> change-id: 20261112-upstream_mdf_v2-76040d99138e
>=20
> Best regards,
> -- =20
> Olivier Moysan <olivier.moysan@foss.st.com>
>=20

--LpL/rArroYRlxrrz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCav9B+gAKCRB4tDGHoIJi
0nrLAP0dW7n5X9s3iyUz2lxPDPplj9Was9TElWS7BopK6xw12AD9FHCRYp+BpumB
phGv0h7oTawzrzkeZT7WJK6s4SXVGQM=
=/5Gs
-----END PGP SIGNATURE-----

--LpL/rArroYRlxrrz--
