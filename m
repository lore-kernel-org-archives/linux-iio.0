Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91B431E6E;
	Wed,  1 Jul 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935456; cv=none; b=C8Pv+/Rs3Dye86PjoFjtN+4Wb/lbzvKG/J5+BbUoZxCmJRHZ/R5E0lH82fXrUQ73URxMzgZ+pNM7rQGyeFbb6dfYzkapwk4er7EBLjXETiI+y7/neRyTdc01qkpvknJqsJL0FsC4FPxq4R7EUHrEATmcyh7UcSlIzIe0rHK6fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935456; c=relaxed/simple;
	bh=ZL04rW2lOpUtQbZUAHIEGyA2MY3+xD9c47lGiyEV5rw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WNa1saWDiBqQk7fOBQCsagij0QfWOTb1SZPYSZSxybViVvtumaMm0O1c1nZRIMB9nuypH61G+ysteDGQbRowvd+wwEXcpvMi0Bnqn3g2adY2O5gRKDcT0PNRhXFQ66fmdf3WX/2S8AYhi4H+dL5Q3a1dXhWVgmn7S1JZkL2Jtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgMOWnlc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgMOWnlc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD341F000E9;
	Wed,  1 Jul 2026 19:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935455;
	bh=5iu5nSlMeaof8aog72g44V4kaJldF8rafxjZk+x4crI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fgMOWnlch7EfKTuKbsc4v2NRr5fS32UyvRxJEidzSro4vQ16x3Lo26lGGkY3GlDgG
	 /HV5uZv4ta0csU1j2j0xqlARRiHxY6fnTspg4uYetnkDOs/X2vF9EhmqPQ6GB0jDNt
	 OzS+I8/nSgS8EA/Y0SMeAuCysc1iwPZp67uip9vOxjq1vys7mX2B0T/sBoZ05Fgpfp
	 GeXagcON9Rr/LjJqbSMvU+ASVgamDUZgmT8o8Yfxm0o39H5qJq5v41mgaV74Xa40GJ
	 xWzwHrWF1iFinFbMCXEZoshwFmxxQyfs21H3qhhNBCctvMmQszYeFvmhIb3/04fXam
	 83NdChjHAW9bg==
Date: Wed, 1 Jul 2026 20:50:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris Hall
 <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, Kurt Borja
 <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] dt-bindings: iio: adc: add ti,ads122c14
Message-ID: <20260701205048.5ddb22ac@jic23-huawei>
In-Reply-To: <20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
References: <20260625-iio-adc-ti-ads122c14-v2-0-ceb9b0b561cb@baylibre.com>
	<20260625-iio-adc-ti-ads122c14-v2-5-ceb9b0b561cb@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

 diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml
> new file mode 100644
> index 000000000000..59ee4d652a08
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads112c14.yaml


> +examples:
...

> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@40 {
> +            compatible = "ti,ads112c14";
> +            reg = <0x40>;
> +
> +            avdd-supply = <&avdd>;
> +            dvdd-supply = <&dvdd>;
> +
> +            /* Resistive Bridge Measurement With a Thermistor for Temperature Compensation*/

space before */

> +
> +            refp-supply = <&avdd>;
> +
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                diff-channels = <6>, <7>;
> +                bipolar;
> +                reference-sources = "external";
> +                label = "bridge";
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                diff-channels = <1>, <2>;
> +                reference-sources = "internal-2.5v";
> +                label = "thermistor";
> +            };
> +        };
> +    };

