Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AC430B97;
	Sun,  1 Mar 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772369468; cv=none; b=H9FEKlJDBi2T5WGYdKEp03z7H1enRrktIoDGwsFCrrO9ET1iuvUgh3RFh443we3mUFZs35LtPC4fiCJ5h0VU/whhipPvSe9fWoeVS2YPw05PGAEX0xAg2Y+jnJAmktkqVoFjieQVIwcZoTgUj/xTv1ox6zPL3WQbV7YCovHcGnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772369468; c=relaxed/simple;
	bh=hiaRyu2SX1TbEgbGhCvcmjdGPKQq2hv7PnIpBVdQ+SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omSDcZfyf+AZon7HNyyDL1Zx7O9ezFXxtNNkZwTjeiZTveySSipnqYwEWlYMSNhGc+ggvlVOH5+1AxhtspLb0fVfkIrWTN1XaQfefzAQybEIs1khng/gw3u7Sn7NxTuzDDup4rc6GkroMrkFo196DY+O/oYXXz4ofpBqcgsfb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEjnJze7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEjnJze7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77213C116C6;
	Sun,  1 Mar 2026 12:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772369467;
	bh=hiaRyu2SX1TbEgbGhCvcmjdGPKQq2hv7PnIpBVdQ+SI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEjnJze7K11rtqes0ILKN1Q50RSOPLJRlFakp0WH/ZqEGtDOGq46Nd/AZLFLAQ7BB
	 oBOHn6KWj23iiT3ps/c+X1RS3Dj1CNKFffvb1TwObZ9nYmwV32GZk7CN5RhrUwzXWH
	 InXMITEzRt2t0ztbfYGdvlyImlkG+xMaV4KTnAmAxMxlhyKCBPxTnvl6H09tTGn48R
	 oRZAJ2rtwAPP5ZEvRctNqFRacrEgRqbJ9/JYwEhJ63NsjHCQPKFAQet8061VEe6o7y
	 k70leV1cU1jJesWDBAV2Uyf3SKhWqC/tg70wepnHO6x15+CY7WMpkgouQ2+QPgMQYK
	 Sd8Bdyygmz8FA==
Date: Sun, 1 Mar 2026 12:50:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 1/8] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260301125057.3b06fd0a@jic23-huawei>
In-Reply-To: <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:46:05 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> DT-bindings for AD9910, a 1 GSPS DDS with 14-bit DAC. It includes
> configurations for the reference clock path, DAC current, reset and basic
> GPIO control.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo,

A few comments from me inline.

Thanks,

Jonathan

> ---
>  .../bindings/iio/frequency/adi,ad9910.yaml         | 236 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 243 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> new file mode 100644
> index 000000000000..43b21d1428ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml

> +  adi,pll-vco-select:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 5
> +    description: |
> +      VCO frequency range selection (0-5). When not specified and the PLL
> +      is enabled, the VCO range is automatically selected based on the
> +      computed system clock frequency. Typical VCO frequency ranges are:

Given this automatic mode. Why would need to override it?

> +      - Range 0: 370 MHz to 510 MHz (Auto-selected when <= 465 MHz)
> +      - Range 1: 420 MHz to 590 MHz (Auto-selected when > 465 MHz and <= 545 MHz)
> +      - Range 2: 500 MHz to 700 MHz (Auto-selected when > 545 MHz and <= 650 MHz)
> +      - Range 3: 600 MHz to 880 MHz (Auto-selected when > 650 MHz and <= 790 MHz)
> +      - Range 4: 700 MHz to 950 MHz (Auto-selected when > 790 MHz and <= 885 MHz)
> +      - Range 5: 820 MHz to 1050 MHz (Auto-selected when > 885 MHz)
> +
> +  adi,charge-pump-current-microamp:
> +    minimum: 212
> +    maximum: 387
> +    default: 387
> +    description:
> +      PLL charge pump current in microamps. Only applicable when the PLL
> +      is enabled. The value is rounded to the nearest supported step.
> +
> +  adi,refclk-out-drive-strength:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ disabled, low, medium, high ]
> +    default: disabled
> +    description:
> +      Reference clock output (DRV0) drive strength. Only applicable when
> +      the PLL is enabled.
> +
> +  adi,reference-div2-enable:
> +    type: boolean
> +    description:
> +      Enable the reference clock input divider. When enabled, the input
> +      reference frequency is halved before deriving the system clock.
> +      This is only applicable when the PLL is bypassed.
Often for these they can be derived from what the desired output
frequencies are. There tends to be a right answer for any combination on
input clocks and output frequency so we don't normally need them
in DT. If there is a reason we do here, needs more explanation.

> +
> +  adi,inverse-sinc-enable:
> +    type: boolean
> +    description:
> +      Enable the inverse sinc filter that compensates for the sinc roll-off
> +      of the DAC output. When it is enabled, the filter introduces up to 3 dB
> +      of insertion loss.

We probably need to improve our userspace filter controls for this one.
Why would it need to be in DT?  Maybe we even just decide to always
enable this one despite the attenuation.  I'm not sure how the term
insertion loss applies to a filter being enabled or not.

> +
> +  adi,sine-output-enable:
> +    type: boolean
> +    description:
> +      Select sine wave output from the DDS core. When not set, the
> +      output is a cosine wave.

That sounds like a userspace thing probably represented as a phase
offset.

> +
> +  adi,sync-clk-disable:
> +    type: boolean
> +    description:
> +      Disable the SYNC_CLK output pin. SYNC_CLK runs at one quarter
> +      of the system clock frequency.
> +
> +  adi,pdclk-disable:
> +    type: boolean
> +    description:
> +      Disable the parallel data clock (PDCLK) output. PDCLK runs at
> +      one quarter of the system clock frequency.
> +
> +  adi,pdclk-invert:
> +    type: boolean
> +    description:
> +      Invert the polarity of the PDCLK output.

Others have commented on these as clock providers. I think that
will make more sense.

> +
> +  adi,tx-enable-invert:
> +    type: boolean
> +    description:
> +      Invert the polarity of the TX_ENABLE input pin.

It's an input, so I assume you are referring to some chip control
that allows us to change what is expected on this pin from
active high to active low or similar?

Is this hooked up to the backend fpga signal and that has some
fixed output polarity?

> +
> +  adi,dac-output-current-microamp:
> +    minimum: 8640
> +    maximum: 31590
> +    default: 20070
> +    description:
> +      DAC full-scale output current in microamps.

Needs an explanation of why this is in DT.



