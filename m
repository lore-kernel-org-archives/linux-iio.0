Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E94F25771;
	Wed, 12 Aug 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786503892; cv=none; b=hnuE2QLFvMheUHgqh0SVsPL7YdcY2DRRXQ7Kfa4pmHLTGvq0CwceP1H01QX7nhVp0AFPZVJROxg93cQvWryKDxg9Q874xmUzCess9ujCvJdY8BkbByEonqbqdXGYUYHWzChYsSqxA4mDTu7hdhhZHc2t+7p/L8OP/LXv+9qe25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786503892; c=relaxed/simple;
	bh=g+KH7xhdWTwRuY5Zv8H2cUrKLi1jZIh71Zm/dEWG/Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq8PG/EZTYlFiOTH4JNG0oARzfReHDfPKrUbGbrRVM2zHgWISa0lkqzdwrpwriT5daIgoEkFHMio0AvAnUEbQobK8SYA7cOadYONruCW5XYrOUKf5mpz3h53GVqjpx6PmxryxewqFi2YMyxNNQ6WBKUQjziHzTtVFPldovf2IBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAVtPH87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAVtPH87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4201F000E9;
	Wed, 12 Aug 2026 03:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786503890;
	bh=Helgc0RR0eU5VEs8A4hFTvWBw/QzizHPBSXD0ehussI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAVtPH87pGbLZ124ZsqIYnj5JYcGoh4PBpD4SDmh8fJPYNireI+I89ZQFRRGqnu67
	 oM+yYnJC2etH9seOBmBONiYIxpx6qblPdNAL5LpwEBf1Xd+A2CrSLbdJCUIIPlp/JM
	 rMnRy8D9PJ/YRBcB3lxVasZtHJLhuha5UvsIEPysPUZZX74qbxqJHdCZdWTHQvADpn
	 ZZdbxEttr2ypft4QJcD/09EaVFxq9rUURvrfRMB3F140Zw4dLhBZdR5lU7+1LnbET1
	 rmFwHyOIJAhehJAIVLy8FR929xamDQEbqm7d9LIou8ce2QJ/2xl2QpJD1+mQnd/zpu
	 +2RpKtUHTPukg==
Date: Tue, 11 Aug 2026 22:04:49 -0500
From: Rob Herring <robh@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: iio: adc: Add AD7768
Message-ID: <20260812030449.GA639830-robh@kernel.org>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
 <20260806-ad7768-driver-v2-1-027ac5e2a641@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806-ad7768-driver-v2-1-027ac5e2a641@analog.com>

On Thu, Aug 06, 2026 at 05:41:20PM +0200, Janani Sunil wrote:
> Devicetree Bindings for AD7768-4 (4 channel) and AD7768 (8 channel)
> simultaneous sampling ADCs.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  .../devicetree/bindings/iio/adc/adi,ad7768.yaml    | 343 +++++++++++++++++++++
>  MAINTAINERS                                        |   7 +
>  2 files changed, 350 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> new file mode 100644
> index 000000000000..8688b94c1ec0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768.yaml
> @@ -0,0 +1,343 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7768.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7768 and AD7768-4 ADC
> +
> +maintainers:
> +  - Janani Sunil <janani.sunil@analog.com>
> +
> +description: |
> +  The AD7768 is an 8-channel, 24-bit simultaneous sampling ADC with configurable
> +  power and performance modes. The AD7768-4 is a 4-channel version.
> +
> +  This binding covers SPI mode only (register access via SPI). Pin control mode,
> +  where configuration is set via hardware pins rather than SPI registers, is not
> +  supported.
> +
> +  The io-backend represents the high-speed data output interface, consuming the
> +  DOUTx data lines, DCLK (data clock), and DRDY (data ready) signals.
> +
> +  Datasheet at:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768.pdf
> +
> +  HDL reference design:
> +    https://github.com/analogdevicesinc/hdl/tree/main/projects/ad7768evb
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7768
> +      - adi,ad7768-4
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Master clock (MCLK). Can be supplied as a CMOS clock on the XTAL2/MCLK
> +      pin, a crystal oscillator connected between the XTAL1 and XTAL2 pins, or
> +      an LVDS differential clock on the XTAL1/XTAL2 pin pair. The clock source
> +      is selected by the CLK_SEL hardware pin.
> +
> +  avdd1-supply:
> +    description:
> +      Analog supply voltage for the AVDD1A and AVDD1B pins (5V ± 10% with
> +      respect to AVSS). Powers the analog front end, reference input, and
> +      common-mode output circuitry. Both pins must be tied to the same
> +      potential.
> +
> +  avss-supply:
> +    description:
> +      Negative analog supply rail for the AVSS1A, AVSS1B, AVSS2A, AVSS2B,
> +      and AVSS pins. This rail is referenced to DGND and all AVSS pins must
> +      be tied to the same potential. In single-supply operation AVSS is
> +      nominally 0V; in split-supply operation it can range from 0V to
> +      -2.75V with respect to DGND.
> +
> +  avdd2-supply:
> +    description:
> +      Analog supply voltage for the AVDD2A and AVDD2B pins (2V to 5.5V with
> +      respect to AVSS). Connects to internal 1.8V analog LDO regulators that
> +      power the ADC core. Both pins must be tied to the same potential.
> +
> +  iovdd-supply:
> +    description:
> +      Digital supply voltage IOVDD (2.25V to 3.6V with respect to DGND).
> +      Sets the logic levels for all interface pins and powers the digital
> +      processing core via an internal LDO. For 1.8V operation (1.72V to
> +      1.88V), IOVDD must be tied to the DREGCAP pin.
> +
> +  ref1-supply:
> +    description:
> +      Differential reference voltage supply for the REF1+/REF1- input pair.
> +      REF1+ voltage range is from (AVSS + 1V) to AVDD1; REF1- voltage range
> +      is from AVSS to (AVDD1 - 1V). The differential reference voltage range
> +      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
> +      channels 0 to 3; on the AD7768-4 for channels 0 and 1.
> +
> +  ref2-supply:
> +    description:
> +      Differential reference voltage supply for the REF2+/REF2- input pair.
> +      REF2+ voltage range is from (AVSS + 1V) to AVDD1; REF2- voltage range
> +      is from AVSS to (AVDD1 - 1V). The differential reference voltage range
> +      is 1V to |AVDD1 - AVSS|. On the AD7768 this reference is used for
> +      channels 4 to 7; on the AD7768-4 for channels 2 and 3.
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description: GPIO connected to the active-low RESET pin
> +
> +  start-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the START pin. An active-low pulse on this pin
> +      synchronizes the device to other AD7768 devices. When not used, this
> +      pin must be tied to a logic high level through a pull-up resistor.
> +      When used, SYNC_OUT must be wired back to SYNC_IN on all devices in
> +      the synchronization chain.
> +
> +  sync-in-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the SYNC_IN pin. Receives the synchronization pulse
> +      generated on SYNC_OUT in response to a START pulse. Must be synchronous
> +      to the MCLK clock domain. In multi-device or daisy-chained systems,
> +      two successive synchronization pulses must be applied to guarantee all
> +      ADCs are synchronized.
> +
> +  sync-out-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO connected to the SYNC_OUT pin. Outputs a synchronization pulse
> +      synchronous to MCLK in response to a START pulse or SPI_SYNC command.
> +      In single-device configurations this pin must be wired back to SYNC_IN.
> +      In multi-device configurations it can be routed to the SYNC_IN pins of
> +      all devices in the chain.
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  adi,data-lines-number:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +    description:
> +      Number of DOUTx lines used for the high-speed data output interface
> +      (distinct from the SPI control interface). AD7768 supports 1, 2, or 8
> +      lines; AD7768-4 supports 1 or 4 lines. Defaults to the maximum number
> +      of lines for the selected variant if omitted.
> +
> +  regulators:
> +    type: object
> +    description: Container for the on-chip VCM regulator.

Move additionalProperties here.

And then a blank line after.

> +    properties:
> +      vcm-output:
> +        type: object
> +        description:
> +          The VCM pin provides a buffered common-mode voltage output used to
> +          bias the analog inputs. It supports three fixed output levels of
> +          1650000 uV, 2500000 uV, and 2140000 uV, as well as a
> +          supply-dependent (AVDD1 - AVSS) / 2 output derived from
> +          avdd1-supply. Select the voltage by setting regulator-min-microvolt
> +          and regulator-max-microvolt to the same value. Use
> +          regulator-always-on when no DT consumer node references the VCM
> +          output. The VCM circuitry is associated with channel 0. When VCM is
> +          used externally, channel@0 must be present and kept enabled because
> +          placing channel 0 in standby disables the VCM output.
> +        $ref: /schemas/regulator/regulator.yaml#
> +        unevaluatedProperties: false
> +    additionalProperties: false
> +
> +  io-backends:
> +    maxItems: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  "^channel@[0-7]$":
> +    type: object
> +    description: |
> +      Represents the external channels which are connected to the device.
> +      AD7768 supports channels 0-7, AD7768-4 supports channels 0-3.
> +
> +    properties:
> +      reg:
> +        minimum: 0
> +        maximum: 7
> +        description: The channel number
> +
> +      adi,prechargebuf-pos-enable:
> +        type: boolean
> +        description: Enable positive input precharge buffer
> +
> +      adi,prechargebuf-neg-enable:
> +        type: boolean
> +        description: Enable negative input precharge buffer
> +
> +      adi,refbuf-pos-enable:
> +        type: boolean
> +        description: Enable positive reference buffer
> +
> +      adi,refbuf-neg-enable:
> +        type: boolean
> +        description: Enable negative reference buffer
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - avdd1-supply
> +  - avss-supply
> +  - avdd2-supply
> +  - iovdd-supply
> +  - ref1-supply
> +  - ref2-supply
> +  - io-backends
> +
> +dependencies:
> +  gpio-controller:
> +    - '#gpio-cells'
> +  '#gpio-cells':
> +    - gpio-controller

The core schema enforces this. Drop.

Rob
