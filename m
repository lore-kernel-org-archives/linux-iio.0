Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42F356762;
	Mon,  1 Jun 2026 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780314808; cv=none; b=dYrO+bxQT7AunDACmfz6j3qsyKzcXbCxUgs5sfoLk84QQWjwvMvANuHcaelMKUVk8buIVVqHNQFd4KTiKiD/z0K73YhS9Y5Nd+BTJ4altU3hc/qDnYWvpkASxn6iTkP+v0AICZa3GgHuRVlTd06LGD0iZoKqh/J2zIMjqlOHl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780314808; c=relaxed/simple;
	bh=IQzxV7pCkFhNEhgkgV5APM8VCjuD4xO5y1RWLdYIFCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnJoXJXCgZI9seozSBd3dM3KPg52tx6i7RJpzwh4uMF8yOIJGzQ7NV4GPN/kObaXkjSP65DReX8UveVbRedzVI4Q9OtzrTdMrFYix99i64ueArFKUkfNKzuuSoyLVBMmvD6PlMinEwJlhxRqXAFhDV114Nf0RA9B4Cc9UXkkv+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0pnmlmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0pnmlmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6C21F00893;
	Mon,  1 Jun 2026 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780314807;
	bh=nYp0fOvWMWcbYwMIvi/eCpOgf7cfplqgKaznYttRV9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e0pnmlmis7soHJ7KmYW1gO8dOhVZ1+7y/zojXBE6r+87SrhxhekXYLGvmr8nuwvuh
	 uo/AkbjAsTTOcmSYuY70ihPcODiG1PJk0mK60a2FLEATQKH/xycohW2bF3DhG+9m8D
	 77l1PzwL3gU21AjwMJ3K5w32hHXeZ+ZSfEllb3riTBv6EM8PIWmK3NPw/xMtEqD6L8
	 jcqiiVuSQgQA3dzs7q2qQG4m+7u6EktWP3DnDQLvgqo0QOWMfsJcgbRmwD6JyY4zin
	 mFBlqLuM+dc1sVsOGs2eMDQNzcxsSQML1ClyPDAAiibEotsSLt1UTloqSHD/6PNR+P
	 rQwEY7G7v24ew==
Date: Mon, 1 Jun 2026 13:53:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260601-banana-narwhal-of-music-0b4d3a@quoll>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530205435.37326-3-wafgo01@gmail.com>

On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:
> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> 
> The driver auto-detects the variant from the product-information
> register at probe time; the per-variant compatible strings exist
> for documentation and dt_binding_check purposes.

Here...

> +description:
> +  Family of digital liquid-flow sensors from Sensirion with I2C
> +  interface.  All family members share the same register map; sub-types
> +  differ only in the flow scale factor and the calibrated measurement
> +  range, both of which are detected at probe time via the
> +  product-information register.

And here...

> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,slf3s-0600f
> +      - sensirion,slf3s-1300f
> +      - sensirion,slf3s-4000b

And here something else. Confusing. Didn't you say device variants are
auto-detectable? So you have only one compatible sensirion,slf3s.

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flow-sensor@8 {
> +            compatible = "sensirion,slf3s-0600f";
> +            reg = <0x08>;
> +            vdd-supply = <&reg_3v3>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06a8c7457..222a03b6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24187,6 +24187,14 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  F:	drivers/iio/chemical/sgp40.c
>  
> +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> +M:	Wadim Mueller <wafgo01@gmail.com>
> +R:	Maxwell Doose <m32285159@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> +F:	drivers/iio/flow/slf3s.c

Basically almost the same comment as before. Drop. There is no such file.

> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> -- 
> 2.52.0
> 
