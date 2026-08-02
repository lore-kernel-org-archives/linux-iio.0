Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711632B114;
	Sun,  2 Aug 2026 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785696907; cv=none; b=aoEIG6LDXGUASsOF+eCCMwDut7bSRrREoqbZv492br57GLqRVYiEFIOqFupt8CJsGqBJe8voicWlBWvT4h9yIFwddcxdiKqUXOUMEzHazd3Dgl7Q1hL4zg698xStMtZg6BLLvwMcSJNp4Bx/bTUav0j7IbvTn9KuYSdHMoKk9Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785696907; c=relaxed/simple;
	bh=Bq6yp/eJGdGP7+AnSxzEIuSQd6W59CyC6vlQdm2yxM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgGMuHHqHJ1oZ66RAASAIV+VGy8cbJahGdMx9h71EgdyYn2kyYcBdBoEw2j/UbGF15cmql3jj1TZTm19dnEJckl6jC42eSCZn7/C+O1oxx5Dt3dkvrzP8QvXgE4BemkoqrelZ7Q7S8MUJPrSRSWE9GN/9nXwUrMq3rSfUD+US5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B27JC05k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B27JC05k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453B71F000E9;
	Sun,  2 Aug 2026 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785696905;
	bh=FlpGuN12+hkk7tAZ8HJMocgyXbwTSi4Xgln7/+gDXp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B27JC05k1aIn9VE+Yiv2LAxhdU+DK9OJy8rbXN/IMWASEeCc/KYOm5ZGuHa86tddj
	 WGu+rgNb0+rCTPKGKyrC067fd2Fdh8/QH7MjtvZuY09uvCybOzpjp/n7kBrBiDGZLo
	 /QVzc9+jbK3dgGCoB6NhU78xK4CHzlPJVIrnNZixswTsP6PfCyboGp/D34DljTCL8e
	 xSWZROwwXjL2hm/xx909tw4LbMOZpFLTtI5C5LkTtiAOxhhaFege4LozTI2Sfdo7gy
	 d3+RxT+BQT7gKkdpoAiMKNEGBiQEoRLKnUgQPlEtX4IdAu1LVudUSxrJO8XwF5SInJ
	 muSP7+FLqShUw==
Date: Sun, 2 Aug 2026 19:55:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lukas Metz <lukas.metz@gmx.net>
Cc: Siratul Islam <siratul.islam@linux.dev>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: dac: Add DAC8163
Message-ID: <20260802195500.5edf9001@jic23-huawei>
In-Reply-To: <20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net>
References: <20260802-dac8163-work-v3-0-3ecc7bc66d0d@gmx.net>
	<20260802-dac8163-work-v3-1-3ecc7bc66d0d@gmx.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 02 Aug 2026 18:07:22 +0200
Lukas Metz <lukas.metz@gmx.net> wrote:

> Add device tree binding for the Texas Instruments DAC8163 family
> including the DAC7562, DAC7563, DAC8162, DAC8163, DAC8562 and DAC8563.
>=20
> Signed-off-by: Lukas Metz <lukas.metz@gmx.net>
> ---
>  .../devicetree/bindings/iio/dac/ti,dac8163.yaml    | 87 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  6 ++
>  2 files changed, 93 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml b/=
Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> new file mode 100644
> index 000000000000..ba4099c78e06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/ti,dac8163.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/ti,dac8163.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments DAC8163 family of DACs
> +
> +description:
> +  The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-outpu=
t,
> +  dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> +  respectively. These devices include a 2.5-V, 4-ppm/=C2=B0C internal
> +  reference, giving a full-scale output voltage range of 2.5 V or 5 V.
> +  None of these devices are fallback compatible because they differ in e=
ither
> +  resolution or output register values after reset. The sync pin on the =
device
> +  acts as chip-select pin.

Rewrap to a consistent length. For dt-bindings that's normally 80 chars
I don't suppose it matter but we generally keen the non fallback bit for
the patch description because it may well become incorrect in future
if extra compatibles are added.


