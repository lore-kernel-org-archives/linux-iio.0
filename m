Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657287;
	b=O9V+eZoC9DpXLLWHtZncOci3fXk/QdlxvJZ0vTDI2hgom4u4t+bwbRSfrsblhhSJStqz
	 4vFPMSRyplfzzXYL27tBP54Q1JWno+W9h2bwc+tmwAiEKLIajMIrSCk5l//wM45JGf7aB
	 Fpkt4NzbG+xUfAyaEshgvdA6eEnwgOKrJfLJKwAxFQeYj1dn2udKBTSjFsGvQcx/hdjSC
	 NNRVnU1BqIEYdtRpfOGUIHxprbVO568LfA25O5FIXC1LraXMrmAC5DhWffzAAJuRoIiGz
	 0B5mTJmaKKQqWeFcfHyksfRWZAmaQ/Z3p7Z9vV5+39Q4Owd5LVVKS3aqKBx6qilXg/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657287;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=HbyBlYoSc4oQNkMHH7+GzwCjpt+AsrusHMpyq+R+lm8=;
	b=zuStBusbgqQw0TwNYEUutWk+wfc8BBl+/QnyTgW5t4mVRx30rpu90Bbrj4YcIHHgir0Y
	 HEBIj29ySg4VRtLle3AOFqhhz0pBPesHAiogpBO0NlnUkGL5Nu7ViomG99pOso31q9OpU
	 h01lwYX2flm7SOizN1HuI19qZcJ3HwgmR9J73j87giAzdizO39Nrxj/xrRy++/1/Gk0tT
	 55VmqpphPO+WEHXVQHhfEFbKAXNzowTuPzPGB+C+aaa9h5rRszGXyUm54/d511xnJZVay
	 /tOO9cko1ZOjy8mfC2vZAhFTONKxVuLguo1gDgP+fTSexLBtMIQ+5TV7ep76GtjTH4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGZMx2+9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD743606A321;
	Thu, 26 Nov 2026 01:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGZMx2+9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FDD71F000C4;
	Thu, 26 Nov 2026 01:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657287;
	bh=HbyBlYoSc4oQNkMHH7+GzwCjpt+AsrusHMpyq+R+lm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fGZMx2+9wN474RbdEH0dBdNmm7KD9n4vNxooWNmcLHTHs3/RU1zISmcGg1x8d9+Aw
	 YeaOGlasmDT9e6xuUjxYcuE6nfNA2mW0OzePjygEI8QcSmZmQmbE66Nt7oIjI9YUVh
	 xOsCrlzUvfw7kRo+1iZJMFRCu9eg68QjgUa/BVxNK5sTqwrZrEXbkNePnYN5+9aZOd
	 GNwryei3TmXwO3sAUf70Z+R4Uubi9Ja5tNTXjKzfmqyYIwNfWMYlN62h3eYi2ERVJM
	 6OZI5DN5qVUOOZXcx1MWQaJ8NjN1j6FtzjFJD06okBp48/DMH6QcCjQvBcK/ZeWr/p
	 ddF6eTdhZ8Gyw==
Date: Thu, 26 Nov 2026 01:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Adil =?UTF-8?B?SMO8c3Jldg==?= Tepe <tadilhusrev@gmail.com>
Cc: Alexey Klimov <alexey.klimov@linaro.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Peter
 Griffin <peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Exynos850 ADC support and soc thermistor
Message-ID: <20261126014118.6eb12fea@jic23-hlaptop>
In-Reply-To: <20261125193122.747908-2-tadilhusrev@gmail.com>
References: <20261125-exynos850_adc-v2-0-26de1c6f1717@linaro.org>
	<20261125193122.747908-2-tadilhusrev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Nov 2026 22:31:23 +0300
Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com> wrote:

> On Wed, Nov 25, 2026 at 02:23:32PM +0000, Alexey Klimov wrote:
> > This small series adds support for the ADC block found in the Samsung
> > Exynos850 SoC and enables the Murata NTC thermistor on the WinLink E850=
-96
> > development board. =20
>=20
> I tested patches 1-3 on a Samsung Galaxy XCover5 (SM-G525F, Exynos850),
> with an ADC node equivalent to patch 4 (same reg, interrupt and clock)
> and the board's three NTC channels.
> Readings match what I get with the vendor-style sequence (re-init around
> every conversion, SOFT_NON_RESET after reset) to 1-2 LSB on the static
> channels, the NTC channels follow the temperature, and 200 back-to-back
> reads per channel show no stale values. So initialising once at probe
> works fine here.
>=20
> One small thing: channels 8 and 9 always read 0. The downstream driver
> uses 8 channels for this SoC, so MAX_ADC_V2_CHANNELS (10) may expose two
> channels that don't exist.

Other than that thing to chase down this looks fine to me.  So I'll wait
for Alexey to confirm if the magic channel pair exist before picking it up =
;)

Thanks for testing!

Jonathan

>=20
> For patches 1-3:
> Tested-by: Adil H=C3=BCsrev Tepe <tadilhusrev@gmail.com>
>=20
> Adil
>=20

