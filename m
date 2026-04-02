Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C7427E07E;
	Thu,  2 Apr 2026 08:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119540; cv=none; b=GmNoK9JYbMD3kHVxqZ4FB/tJIOw0m1TEB0bzoQmJ+kX5bHS2Q+K9k2W2vB93jEKWuBWfBD0q5ERV5MUxpFoL/dMexpTDpz3FIX5Brx1m+r/a5OrtIDlcYMnLqa1KfCBsPpUpU1gQ9D7nhZRX2JBe4FRvArwmhT9UGYIdrH/5wFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119540; c=relaxed/simple;
	bh=V3UdNh7a3zjzaowP6Plt+uXPgl/eEE5i/3NhvecpYUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujueUBNcTzyUEYRngO5N2IVHKZU/ZyWq1npcsfBFhgwtEbTUgXKuDt5Pks5kl8yg0UUkG23BUjmOes1CqX/IWIpiyYbZkghMTaT4TX93mhFDPzL9Od2CIaRqGOQq+TffABvPwLRNp2pAxuKm8ida3NXFiKV1PKKmBB6W9Sbo0mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL/5Ds+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL/5Ds+a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6CAC116C6;
	Thu,  2 Apr 2026 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775119540;
	bh=V3UdNh7a3zjzaowP6Plt+uXPgl/eEE5i/3NhvecpYUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fL/5Ds+aDJOkEcMyy54ZGxgK14oU8EZKkk4PQFVjvsiUwIM0aosQTdAGDdNWkq0yv
	 9FIIGUbvq8JqPqbNUmXEw4JNW2uk0JYHm2mGSWZ8aiqJCa2kStPu3nNpN7PBCyAfYS
	 bQRi4TpzmxGOzbJYcGDIfWYpkTHVFq9DY9vShJUHc8F2+gtp5AmxhX6bXEGUK6asQK
	 kruwzGXAQoSH4wXVmhV1YHYmjW6DBnydMG3E+4vYhtCaR7CZ37eGg6b6iLFaRez90c
	 n567VSipiN5rHvzpTYkN+eUDAr4RoS24IMKXhhM3CpWc7vPIKpSXODEHPpcfwBoxfb
	 mc8R6cFDQ1VEg==
Date: Thu, 2 Apr 2026 10:45:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sheng Kun Chang <nothingchang@mirrorstack.ai>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, gregkh@linuxfoundation.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: accel: add binding for
 adi,adis16203
Message-ID: <20260402-fair-wakeful-okapi-3c6dba@quoll>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
 <20260401162458.88110-2-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401162458.88110-2-nothingchang@mirrorstack.ai>

On Wed, Apr 01, 2026 at 04:24:55PM +0000, Sheng Kun Chang wrote:
> Add devicetree binding documentation for the Analog Devices
> ADIS16203 Programmable 360 Degrees Inclinometer, in preparation
> for moving the driver out of staging.

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18

> 
> Signed-off-by: Sheng Kun Chang <nothingchang@mirrorstack.ai>
> ---
>  .../bindings/iio/accel/adi,adis16203.yaml     | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> new file mode 100644
> index 000000000..6c5e2833c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adis16203.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adis16203.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADIS16203 Programmable 360 Degrees Inclinometer
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>
> +
> +description: |
> +  Programmable 360 degrees inclinometer with SPI interface.
> +    https://www.analog.com/en/products/adis16203.html
> +
> +properties:
> +  compatible:
> +    const: adi,adis16203

So everything looks exactly the same as adi,adis16201. Put it there. You
probably copied it already, because you made exactly same
issues/mistakes.

Best regards,
Krzysztof

