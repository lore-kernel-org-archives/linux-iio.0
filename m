Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AED403E96;
	Fri, 24 Jul 2026 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784931044; cv=none; b=gmk9n15ahtFpXtMT0jSvIztYqrsUl4Skeu5XzQthWOlXYtw0BR74MkOtVAtn4sm2tY24KlFVks8VBHFKiZwHGkU5QZUNKSbp507bKr3MlWjzDRLhxGMy5QaCRMLdcqc4VCLXiY1JhpUHO9WsxtsP0UlZZ3bOgXg0lbfh1/0EsSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784931044; c=relaxed/simple;
	bh=mBm3EcRVqAOQ2K/VCdgNIZErUNkWjAQ+Ofy+lvWH+vk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ieuna4z3SfXtGuuiGDG6+fe8Kcb0MoT9ze5ixonuyDT+eaaVIS5+Zdae5DrNiRbwYTko0/VMzV7nmqviw9fN1pE/vBmVqUutXGBLZWdQDE3Tpp3XyAYXBRy9aZETelbT/wHt8jU2U0DRkH97lQF62UGAxRTI9ZL1OWZfW42Hcug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlPQTBAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlPQTBAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8C71F000E9;
	Fri, 24 Jul 2026 22:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784931037;
	bh=qBIA1it3lI9AWpRxJEGcJOkd4hsVMIO+r6aaOdjQsxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YlPQTBASSYdhL4Y+ObzoRv/TwFpLi3n/XLFNFfW04QZSjCHtY5zRB4rNTH8wL/3ca
	 DGflDREJUrq7mo0toGsfKTDk5pvTZSxDpskpZt/7hl94bkUeFfwiVkzarWxBxZmOH9
	 biTh2N1ufLhRcLJ8lOe9nAmz2QpZCPssuBeVMbrZ+nCnGa6m3ZlnHt7VOR2gYvGHvm
	 27/qvqPa47jMqp71Cfr72a3nnxW49UdpzywilGvD4dQVDa+s8YML8WYKmxMlEPjCIa
	 CTPOTrNrcOoYLlC72eXpBuWhQ2uwMkzVqFQa6E/5N1gQaaGPK2K/5gqtFzLPinfx8f
	 49jrcRBCWjYew==
Date: Fri, 24 Jul 2026 23:10:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260724231031.1614f40b@jic23-huawei>
In-Reply-To: <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
	<20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jul 2026 16:47:11 +0800
Kim Seer Paller <kimseer.paller@analog.com> wrote:

> Add device tree bindings for the Analog Devices AD5710R/AD5711R
> 8-channel 12-/16-bit Configurable IDAC/VDAC.
>=20
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++=
++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 144 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b=
/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
> new file mode 100644
> index 000000000000..17c1bf009242
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/dac/adi,ad5710r.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5710R/AD5711R 8-channel 12-/16-bit Configurable =
IDAC/VDAC
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> +  configurable current/voltage output digital-to-analog converters (DACs=
) with
> +  an on-chip 2.5V, 3ppm/=C2=B0C reference. Each channel can be independe=
ntly
> +  configured as a voltage output (0V to VREF or 0V to 2xVREF) or a curre=
nt

I'd put spaces around the x

> +  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
> +  supply and are guaranteed monotonic by design.
> +  Datasheet can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad=
5711r-ad5710r.pdf
...

> +  adi,range-double:
> +    description:
> +      Configure the output range for all channels. If the property is pr=
esent,
> +      the output will range from 0V to 2Vref. If the property is not pre=
sent,

Use the 2 x Vref form for consistency.

> +      the output will range from 0V to Vref.
> +    type: boolean
> +
