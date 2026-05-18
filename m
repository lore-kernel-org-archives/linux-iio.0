Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0653254A5;
	Mon, 18 May 2026 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090767; cv=none; b=asSU3yxVtlR1/V6iHxzmglldY9V0olNXi0K7kqvGVVIgzZFYXX0+vOMyL3zre8nvB7w0MzwdTbEolzGOP0/meDPF9/wKmR2RxtX3+wtoBSlPjrYxXpJZvrGgpB1lb0IMEJxo3Od1snw04sr/i8aPc5O4T5oADmIQfE0R5lMOKtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090767; c=relaxed/simple;
	bh=8HjDunrHGVNoAqAd2Ojw7ILFQ5qR9o3ddT3DgEWklq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq2JO0HPthtQvEljASIAL/OPyI67/usW9l/ijrP2ReFhrm7471vH0HI8AOcIBzHatcsdQywWN8MyhtDSdvsPwTYsyFvM9/6+lVhRRt72SKI0v3Xh7V7pwJwTOTq+MzQHDS5JN5LhlgrMQXuTxPMu+4bYWFJ/WDnnlJ1AEOSVygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcQns8Lw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcQns8Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B0EC2BCB7;
	Mon, 18 May 2026 07:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090765;
	bh=8HjDunrHGVNoAqAd2Ojw7ILFQ5qR9o3ddT3DgEWklq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcQns8LwzDfmgwrCFrwiXaiVkINvN5YIe9u9jhDZ2+G/cSH2BGX+/Ct/DPObrliVo
	 AJUX2x4ufQ/kB/OC26wzW1AqzVegOJCG9acxrL2F7LLwOBYsfF+FsR+wFiBwRf4JSw
	 LD1nFw9Z6gaCEJKQYmd18J6NuqFpBCkFFnZWrRaXdNpIhPZwQySqGx6cFTM4EZEKiO
	 sswCdc/TDQKz8GxJDRKAPLzgXseOcvNBpc3zRqtgk16lniwkEz5FSkZTw7xhzmTRXM
	 4veYWwF2bpKJ+I6KbdFWF5Xabh2PudKMH5eHtIQk7KRBEHu06gR7bi0/I1eL0DTTXp
	 fC+WitaKgkvYQ==
Date: Mon, 18 May 2026 09:52:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v5 05/13] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260518-zippy-ingenious-aardwolf-df46a2@quoll>
References: <20260517-ad9910-iio-driver-v5-0-31599c88314a@analog.com>
 <20260517-ad9910-iio-driver-v5-5-31599c88314a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260517-ad9910-iio-driver-v5-5-31599c88314a@analog.com>

On Sun, May 17, 2026 at 07:37:49PM +0100, Rodrigo Alencar wrote:
> +maintainers:
> +  - Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +description:
> +  The AD9910 is a 1 GSPS direct digital synthesizer (DDS) with an integrated
> +  14-bit DAC. It features single tone mode with 8 configurable profiles,
> +  a digital ramp generator, RAM control, OSK, and a parallel data port for
> +  high-speed streaming.
> +
> +  https://www.analog.com/en/products/ad9910.html
> +
> +properties:
> +  compatible:
> +    const: adi,ad9910
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 70000000
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: Reference clock (REF_CLK).
> +      - description: Optional synchronization clock (SYNC_IN).
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: ref_clk
> +      - items:
> +          - const: ref_clk
> +          - const: sync_in

So that's just items with two items and minItems: 1. Like you have in
"clocks:".

You got this comment already at v2.


> +
> +  '#clock-cells':
> +    const: 1
> +
> +  clock-output-names:
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      enum: [ sync_clk, pdclk, sync_out ]

Why are the names fixed? And why is the order random?

> +
> +  interrupts:
> +    minItems: 1
> +    items:
> +      - description:
> +          Signal that indicates that Digital Ramp Generator has reached a limit.
> +      - description:
> +          Signal that indicates the end of a RAM Sweep.
> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum: [ drover, ram_swp_ovr ]

Your "interrupts:" do not allow flexibility. Are you sure interrupts are
optional in the hardware?

> +
> +  dvdd-io33-supply:
> +    description: 3.3V Digital I/O supply.
> +
> +  avdd33-supply:
> +    description: 3.3V Analog DAC supply.

Best regards,
Krzysztof

