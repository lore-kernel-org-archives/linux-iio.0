Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26A3A0B05;
	Tue, 20 Jan 2026 10:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905566; cv=none; b=Be7GgAH/QKqiQZGKus89q/5Qmvzh20pDvPz585i4swmifhe7BE2bwIdpqPLv8Q1yo5rYjX44w2IoHbgNzuY0gj2wuQqHMeVFOPQvWU2S6cryrwn8QBBWPnkWLcujFAvGJ4f7U9OS0pL8B1adWpKSvoHuhb84LQ6Vons1yTAxZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905566; c=relaxed/simple;
	bh=W+om7RL8N0lULYju5H+uWp2Ph67OexRWj0npB8w1FgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXebBesCshUuwPe1qVxplrit11LEA9Im5e8YLVKlTPdsjFqp70WygZTFECuYa4OjwOgISCg8SpX0k5uEg49qKraftWuqWIZ+9NvYArsp2/xLto5ecqI9DoRGjOkQ/wt1Tg+yBHtqP/DN6Z9kLEuA7xgeNtXfnB4u3yk1qHxKk+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy5g/EoF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy5g/EoF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EEEC16AAE;
	Tue, 20 Jan 2026 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768905565;
	bh=W+om7RL8N0lULYju5H+uWp2Ph67OexRWj0npB8w1FgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hy5g/EoFOoQ0UvEHGD/NCKlVWv/Og+Q0T4YhzpkKpoo9kAsReSoK7uCocfmdswQoA
	 sQEZgo9kCjb0GIkdQubZz763udJj7RuY/H7G+P7ZBug5zNeeiKnbHbFS645pN6p6v+
	 MdnMSEIwrAOgVluXwflZQ8OlJB9lUiFiY1Hl9LocPqcGzQsMx4u9zAXivWZqDuf9a3
	 /VFXLNlJeXIEA2yE+AIRT8erkZJeIXs6vH1QYOtCdFvqBU/x8v7nQp/bTK4aoveHkI
	 YerMgUNaQXZl/4Wro7k+qrLxJeu92R6QuZ8INNhb+QAtyQn2t9zxRCZHR5/tAMR6d9
	 XultqoGLtrksg==
Date: Tue, 20 Jan 2026 11:39:22 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 2/8] dt-bindings: iio: dac: maxim,ds4424: add
 maxim,rfs-ohms property
Message-ID: <20260120-spiked-wapiti-of-certainty-89a462@quoll>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-3-o.rempel@pengutronix.de>

On Mon, Jan 19, 2026 at 07:24:18PM +0100, Oleksij Rempel wrote:
> Introduce the 'maxim,rfs-ohms' property. The full-scale output current
> of these DACs is determined by external resistors (Rfs) connected to
> the FS pins. The driver requires the physical resistance values to
> calculate the correct current scale (Amps per step) for the IIO
> subsystem.
> 
> Keep it optional to avoid forcing updates of existing DTs; without it
> the driver cannot derive a correct IIO scale.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/iio/dac/maxim,ds4424.yaml     | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> index efe63e6cb55d..b7af8464a4fc 100644
> --- a/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
> @@ -27,6 +27,17 @@ properties:
>  
>    vcc-supply: true
>  
> +  maxim,rfs-ohms:
> +    description: |
> +      Array of resistance values in Ohms for the external Rfs resistors
> +      connected to the FS pins.
> +      - For DS44x2 (2 channels): 2 values required.
> +      - For DS44x4 (4 channels): 4 values required.
> +      Typical values range from 40000 (40 kOhm) to 160000 (160 kOhm).
> +    minItems: 2
> +    maxItems: 4
> +    $ref: /schemas/types.yaml#/definitions/uint32-array

Drop. You should see a warning, so I claim this wasn't tested/checked.

Best regards,
Krzysztof

