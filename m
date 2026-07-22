Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093803EFFDB;
	Wed, 22 Jul 2026 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784742294; cv=none; b=EsULT36tJFjthGCgOFhotTtQ7609RF+mHupAfHrC8gXieRqssjmdpc5TUd/ixH4QhL+L9EtBQlDaUxoVPABEty8ST7f70rg1dJKUaYyCQZA0cCyfbPqPhmvv2S8W5feXVd8HfNz47KLY/HgJ9PQx+O1SjabssqRKCszv0x4bOOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784742294; c=relaxed/simple;
	bh=M9Do34EfW8/a/M4Ra0TGiyzwulvAgZe7AlUhFYxbx+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeMD6lC9lPWIvOXRKYM+hxL0yeq6mUCH5BsP2jTOar0ZIkk/vlPOlZBlKjfs22Y7MUMISCNhaUqCg52xHUnS3ry5qwEJaybtIa2zvzjsB3mbWkRP7Sh62gSyZAgru8KQeaCRseOZsKBcwmRPP4zFeRqdbVuSbuglz0uSH0AbJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtEAPQJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtEAPQJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE9B1F000E9;
	Wed, 22 Jul 2026 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784742292;
	bh=zo5RV9glOFJC3cST6CXl/oS8IzFV9x5o/1OkdUAbBp8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VtEAPQJUfU10L0vgXCaw4zUHYdyMDUAmjadpudj4J/O3oTonFAQyGrDgorfHJRVJe
	 Yg1g4VZb6XAvV0l4wFln2L7qLR9pf4O9JZROUCCsrXgbgM3QaSQFuraXqub85aE8uG
	 y7o/+lPvGF7X/oG55zzUoyTeAeiuLyAw4+8136KUvNLStjXdaJR9cUnqQzfJKMA4vu
	 h5dz7dL+V6pCNMqmPTHEBGzGuWxIwaa3ePBbwIXCxqk1vfv6+/251Oe9ekM1BezAQG
	 TussopeOmztVdiFQ7uOhveTL20j1f89iEeJG20b9cJ0M3ymwjkV20UrBdJoS7Mjp4V
	 N/DKNSA1PnCmQ==
Date: Wed, 22 Jul 2026 12:44:50 -0500
From: Rob Herring <robh@kernel.org>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260722174450.GA1261594-robh@kernel.org>
References: <20260716-iio-ad5710r-upstream-v1-0-e848a4bb701f@analog.com>
 <20260716-iio-ad5710r-upstream-v1-2-e848a4bb701f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260716-iio-ad5710r-upstream-v1-2-e848a4bb701f@analog.com>

On Thu, Jul 16, 2026 at 03:59:26PM +0800, Kim Seer Paller wrote:
> Add device tree bindings for the Analog Devices AD5710R/AD5711R
> 8-channel 12-/16-bit Configurable IDAC/VDAC.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 150 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5710r.yaml
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
> +title: Analog Devices AD5710R/AD5711R 8-channel 12-/16-bit Configurable IDAC/VDAC
> +
> +maintainers:
> +  - Kim Seer Paller <kimseer.paller@analog.com>
> +
> +description: |
> +  The AD5710R (16-bit) and AD5711R (12-bit) are 8-channel, low-power,
> +  configurable current/voltage output digital-to-analog converters (DACs) with
> +  an on-chip 2.5V, 3ppm/°C reference. Each channel can be independently
> +  configured as a voltage output (0V to VREF or 0V to 2xVREF) or a current
> +  output (0mA to 50mA). These devices operate from a single 2.7V to 5.5V
> +  supply and are guaranteed monotonic by design.

blank line

> +  Datasheet can be found here:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5711r-ad5710r.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5710r
> +      - adi,ad5711r
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 20000000
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  vdd-supply:
> +    description: Power Supply Input.
> +
> +  iovdd-supply:
> +    description: Digital Power Supply Input.
> +
> +  io-channels:
> +    description:
> +      ADC channel used to monitor internal die temperature, output voltages, and
> +      current of a selected channel via the MUXOUT pin.
> +    maxItems: 1
> +
> +  ref-supply:
> +    description:
> +      Reference Input/Output. The voltage at the REF pin sets the full-scale
> +      range of all channels. If not provided the internal reference is used and
> +      also provided on the VREF pin.
> +
> +  reset-gpios:
> +    description:
> +      Active low signal that is falling edge sensitive. When it is deasserted,
> +      the digital core initialization is performed and all DAC registers except
> +      the Interface Configuration A register are reset to their default values.
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      LDAC pin to be used as a hardware trigger to update the DAC channels. If
> +      not present, the DAC channels are updated by Software LDAC.
> +    maxItems: 1
> +
> +  adi,range-double:
> +    description:
> +      Configure the output range for all channels. If the property is present,
> +      the output will range from 0V to 2Vref. If the property is not present,

2*Vref

> +      the output will range from 0V to Vref.
> +    type: boolean
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    $ref: /schemas/iio/dac/dac.yaml#
> +    type: object
> +    description:
> +      Represents the external channels which are connected to the DAC.
> +
> +    properties:
> +      reg:
> +        description: Channel number
> +        items:
> +          minimum: 0
> +          maximum: 7

How many reg entries? If only 1 then you can just omit 'items'. If more 
than 1, you need to define what each entry is.

Rob
