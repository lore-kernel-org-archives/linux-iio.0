Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D22BEC4E;
	Sat, 22 Aug 2026 22:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787439062; cv=none; b=fv4JxKTGmttR9eDhawp8MW3D1h8Ebbdks9/IS7DXhtSdVALaauvb9vZ0L0gFrEJEFcRPutwBw2uYPARfj3Pl57gvqn1nAspj0QuugI5ecemZmrl8xHEISf976A5YzfzMbrN0CfJJltscsW3Uf0dBw3JZ1Ru1CHTX6RzuWnK1LbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787439062; c=relaxed/simple;
	bh=SU39tERxw+TuyQB3aFHtT1Bmkm9WSUgyyW7+Qa6od10=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYhsrSP0AknXmkHH2xmTps9YJ6oOwmAcwnY62N5YHPY4gib6ccrCuM11+aw5O9Sf6WHMYrWL+39bCKgHKys8iX3BN+MzNCdB4RDxIBnE7N1E6sIFt3u0TybxBM0EwrrO9maZW+TFD3zagYz6ua8G4yVDlO0SkGqmJuERcsrnIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zeb+bYZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zeb+bYZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C401F000E9;
	Sat, 22 Aug 2026 22:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787439061;
	bh=7I5UcHAvksMW3sEWXSvBAo/++MhDq3Os+LNWOAAUKM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zeb+bYZSu089TcI5xQKOt0cLpd0SXaY72pVYnW8QkMowXpZlfzc/L/N4QG+p9PtTl
	 Vwmr4e6FT9NXFr8I5URJPn6Q6tUZt6Z8ivIKWg00bm8Tvmp+FJV0boEe55NmAm0qf0
	 H1JXQAofxe/8DTi+vmTGlm0iHa6a4yB2g3HTc5dhpMjgyZfmZ07I0ctlyWuFS+QqHs
	 NGcg+ha77LO0mjbcr5QUBQIVnvThGfLggaoNAPGuFOj9gsy+GtB21laJDcH0G4/kN2
	 xTF7U0q68QM0hCfUYiBi0e2z6ZhmhOqvzPJ7fn5tudaNwsHaMJfpVqyjdxJnRBJYuM
	 ylssHPoxurHEA==
Date: Sat, 22 Aug 2026 23:50:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Philipp Zabel" <p.zabel@pengutronix.de>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@analog.com>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] Add support for AD5710R/AD5711R DAC
Message-ID: <20260822235057.7eb21dd8@jic23-huawei>
In-Reply-To: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
References: <20260817-iio-ad5710r-upstream-v3-0-3a4bf7b9c78b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Aug 2026 14:37:10 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> configurable current/voltage output DACs with an on-chip 2.5V reference.
> Each channel can be independently configured as a voltage output
> (0V to VREF or 0V to 2xVREF) or a current output (0mA to 50mA).
>=20
> This series adds support for these parts:
>  - ABI documentation for the high_z powerdown mode and the current-output
>    powerdown attributes
>  - device tree bindings for the AD5710R/AD5711R
>  - basic IIO DAC driver, supporting per-channel voltage/current output
>    selection, per-channel powerdown, software or hardware (LDAC) DAC
>    updates, optional output range doubling, internal or external
>    reference, and hardware reset (with a software-reset fallback).
>=20
> Datasheet:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad571=
1r-ad5710r.pdf
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>

I took another look and don't have anything to add.
If Andy hadn't left you with some choices (and I don't care either way) then
might have just tweaked them whilst applying.  Still need an Ack for the
dt-binding anyway so I can't pick them up today.  I'd suggest a v4 resolving
those opens in Andy's feedback.

Also, Sashiko got a bit confused in places on this one. I took a look and
don't think we care about any of the stuff it has raised, some of which
is incorrect anyway.

Jonathan

> ---
> Changes in v3:
> - ad3530r: factor the op-mode register/mask computation into a helper
>   shared by the powerdown access and channel parsing.
> - ad3530r: pass iio_dev into setup/parse and set channels/num_channels
>   directly, dropping the duplicated pointers in driver state.
> - ad3530r: use regmap_test_bits() for the powerdown reads and drop the
>   unused AD5710R_NUM_CHANNELS macro.
> - ad3530r: split the file header comment into separate AD5710R/AD5711R li=
nes.
> - dt-bindings: drop the redundant items wrapper on channel reg and tidy
>   the 2 x Vref wording.
> - Link to v2: https://patch.msgid.link/20260721-iio-ad5710r-upstream-v2-0=
-324949dc72da@analog.com
>=20
> Changes in v2:
> - Drop the standalone ad5710r driver and fold AD5710R/AD5711R support
>   into the existing ad3530r driver.
> - Add a preparatory patch parameterizing the DAC resolution in ad3530r
>   so the 12-/16-bit AD5711R/AD5710R can reuse the raw/scale paths.
> - ABI: drop the "high_z" powerdown mode, which is a synonym of the
>   existing "three_state" and use "three_state" instead.
> - Link to v1: https://patch.msgid.link/20260716-iio-ad5710r-upstream-v1-0=
-e848a4bb701f@analog.com
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=C3=A1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Michael Hennerich <Michael.Hennerich@analog.com>
> To: Kim Seer Paller <kimseer.paller@analog.com>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> Cc: linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux@analog.com
> Cc: devicetree@vger.kernel.org
>=20
> ---
> Kim Seer Paller (4):
>       iio: ABI: Add DAC current powerdown attributes and 15kohm_to_gnd mo=
de
>       dt-bindings: iio: dac: add adi,ad5710r.yaml
>       iio: dac: ad3530r: parameterize DAC resolution
>       iio: dac: ad3530r: add support for AD5710R/AD5711R
>=20
>  Documentation/ABI/testing/sysfs-bus-iio            |   5 +
>  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 ++++++++++
>  MAINTAINERS                                        |   1 +
>  drivers/iio/dac/Kconfig                            |   1 +
>  drivers/iio/dac/ad3530r.c                          | 302 +++++++++++++++=
++++--
>  5 files changed, 430 insertions(+), 22 deletions(-)
> ---
> base-commit: fc69c7ed31f2c36d0232a6d04750acec8f9e0c31
> change-id: 20260716-iio-ad5710r-upstream-e41c298614c6
>=20
> Best regards,
> -- =20
> Kim Seer Paller <kimseer.paller@analog.com>
>=20

