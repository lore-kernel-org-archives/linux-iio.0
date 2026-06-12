Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7722F7EF9;
	Fri, 12 Jun 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255423; cv=none; b=svaYC5oaTTKhA2wdUu/AUitcy5vByQ+3cEtcVqt616lpsFW5QB2QtVKv91vZ/LU4KyxYCkjMUDzRsUys7VT+pdmL/KjDjU/XhVZz+3sSu8lvoUDxyLYZ7ujhtKyd8Qt3OQjCde9CsXhWXiNFRymq3QBYenw9o9tQxUywufvdrvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255423; c=relaxed/simple;
	bh=izuWVILo6Sdebuw2iX/sfQUD9kqWjeoTvfhVvOCVE5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNDsUrvgE7O6cd9REzNh+KxiOIjGznLpqJV43pDePej0iZrj87pe1rV/iU3kSdQRP52W20VJ0L0J7h1TFSQ6bnCtzYslCgKUAJ6yKBK99SYg8e/nU7WHW7qQS+R49ABNEwE6OK/yUfnXv8hO8ZtrEkAh+s1sC/l+nDkJqQxJwMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjjksfCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjjksfCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4167D1F00A3A;
	Fri, 12 Jun 2026 09:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781255421;
	bh=DezVWNKSu/AY5pSw4ed9TOXCTrXmewc1pizcle6oTuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YjjksfCuVY/uTQjzwARxqlczXYB0pU0icuSYdxSxqgsJGsWeN0f29Z+QIEE9y0uYU
	 OH1nUOXZ7OSxmRudhj5tNaXjKpLuLIfTTdG7vQICbj/HdcxNg5Aj1MEExe0RQSPLHT
	 rS/DVoyk47mDXqi94m33CghvsiK1XmAK1H2cZdh0B9vm59HvzXM+6z8mJiZ1fd6Akp
	 Zr6hkeR1WZHTiWJ4JC/M/h//a5Azc81pmSqWEffPVyPf+4wNry3rebs23ovTIS9fcg
	 RvkzJATG3dQFEaZ8YLzW+3GIdGkc9E6N2hauzVGk38vmwti/UdUyWu5+BU3DB7Hl/S
	 221Z92roiDjrg==
Date: Fri, 12 Jun 2026 11:10:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linusw@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: convert lis302 binding
 to YAML schema (v2)
Message-ID: <20260612-fuzzy-quartz-tench-c2f915@quoll>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
 <20260611154105.3727-4-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260611154105.3727-4-shofiqtest@gmail.com>

On Thu, Jun 11, 2026 at 06:41:05PM +0300, Md Shofiqul Islam wrote:
> Replace the plain text lis302.txt with a YAML schema for the
> LIS302DL/LIS3LV02D accelerometer family.

There is no "YAML schema". There is DT schema. See submitting patches
doc in DT dir.

...

> +description: |
> +  WARNING: This is a legacy binding for hardware that predates modern DT
> +  practices. It is documented as-found in upstream board files. Do NOT use
> +  this as a template for new drivers or bindings.
> +
> +  The driver lives in drivers/misc/lis3lv02d, not in IIO. Many properties
> +  listed here represent run-time driver configuration that would normally not
> +  appear in device tree. They are documented here only because existing
> +  upstream board DTS files use them.
> +
> +  Compatibles st,lis302dl-spi and st,lis3lv02d were previously listed as
> +  deprecated in st,st-sensors.yaml. They are moved here with their actual
> +  hardware configuration so validation works correctly.
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: I2C variant (original part)
> +        const: st,lis302dl

This wasn't in the old binding. You need to explain in the commit msg
changes done to the binding during conversion.

> +      - description: I2C variant (larger range)
> +        const: st,lis3lv02d
> +      - description: SPI variant; including the bus type in the compatible
> +          string is a legacy naming error, do not copy for new bindings
> +        const: st,lis302dl-spi

Best regards,
Krzysztof

