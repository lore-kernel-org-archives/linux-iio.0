Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792980309;
	b=b+uUnjU3XBPevJsKjVIRXanuZVhN5Jjgc5zVkqYZE/T8zMXA7xbpPhAyqn2v+FaRnRrJ
	 eaEbm3D0iFGYrkBa5bX9DViHtU7AAe3DnwXdVfC5Zo3cZpAmHpTfhrpbiCQh90y61ASVV
	 Wkuhgzdp6i94al6yKamXRF1lSicfrNk1DKnwKRJLWmehBz+gqdvdiI7ROMfog+gZ51dRa
	 bA4VH4GWiYVy2ZWF+Q6Sy2cS4kRiOz/CH4X5SzupnZDLFerGx7IXxrcaLp03mIpRJbakO
	 9imNZKhMceO9oYbf6jGj4jhzhzrHfWYK2fUyXRCkiZsro1R1Er9bRa3SmmIu16Ve5nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980309;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0+dbgBcIv97uEUp0MbCajYmBNDR2lPq6k0YhLiIX2so=;
	b=npfPQmpGUnr5AxpKD0ZTUkSeIIamihpLHUvmCXMD3qGHoF+rgMZuklsP6/lh2Zjmkix5
	 aGLfln7ihSgL6XGjbSgTLCsn7UJ5YoS4nZnJfbrCX+1//RAJD7upSICR5ZOhpAOldsbnY
	 DKn0Iq9hyksL5AQxX4QnJts2C9enIzmyen0Dix5nLr0JUagTAk5TqMScRnzkrm85BikYX
	 R/YpHs0e14/vV6Jc7NLyGi1DqIqP6/464dhKoutyzQ2hwUxOFQs6TB7XP9gHA0lKC/26Q
	 OF3vX9ydEtBNPXp5lPj84toAMmc1jIIHRcnffytqdnOwBvZ+AhjTj7Ex005rmbMSK4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKqTLC5L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE7C606A31D;
	Mon, 26 Oct 2026 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKqTLC5L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7D1F031E0;
	Mon, 26 Oct 2026 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792980308;
	bh=0+dbgBcIv97uEUp0MbCajYmBNDR2lPq6k0YhLiIX2so=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aKqTLC5LnYtbWM9udYgadXlyfX78XLPlI5YAwRt+ln/DeLeS4fifwvBlVTiJvis6y
	 X0XE1gLEUekUhHEzDuAYXIOvheYNXDNU6DfxNmh163yRMNjp4A/hxczsYnJSe9VbG7
	 tKjjtv/FVQeqmPtWy7LKE0MXvfnfluusdT3/VBCfXxI5gZ4keQ0R/zS22SMmb+b9ql
	 2kv2IMJyarK5eNpmwxzxP95d0pDHGf8xoHJq78wYVPrupRfzkqN8Zl4CRZdbPmqj/X
	 Gs5znf23b3NqB4ewtL/wrF+PUChKr+PvV6CdQ0sQsiP1KZB41pPdlSPgVv7abOhRTE
	 wisg/DHgGSO5g==
Date: Mon, 26 Oct 2026 02:05:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <linux@analog.com>, <broonie@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <Michael.Hennerich@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: iio: adc: ad7768-1: Document
 multidevice support
Message-ID: <20261026020500.6c13c0e6@jic23-hlaptop>
In-Reply-To: <6e2176d5547c59c39bb692e9768d7ac079b40f71.1792435248.git.Jonathan.Santos@analog.com>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
	<6e2176d5547c59c39bb692e9768d7ac079b40f71.1792435248.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 22:56:56 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> The AD7768-1 family supports aggregating up to four devices on a single
> SPI controller, with each device occupying a dedicated CS line and a
> single data lane.
> 
> Extend the `reg` property to accept up to 4 entries (one per device).
> 
> Add `spi-rx-bus-width` property to declare the per-device lane count.
> Since each lane is bound to one CS, the number of entries must match
> `reg`. Make it required when `reg` has more than one entry, along with
> `spi-cs-composite` property.
> 
> Add an example for a four ADAQ7768-1 aggregation, with shared DRDY and
> SYNC_IN pin.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

I'd suggest some asci art might make it more obvious what you mean here.

> Changes in v4:
> * Include spi-cs-composite property to the bindings. The reason for going
>   this route is stated in the cover letter.
> * We decided to keep the spi-rx-bus-width property because assuming 1-lane
>   per CS would break controllers that don't support multiple lanes.
> 
> Changes in v3:
> * New patch.
> ---
>  .../bindings/iio/adc/adi,ad7768-1.yaml        | 80 ++++++++++++++++++-
>  1 file changed, 79 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> index 7b72d14e104c..64c1cbeaa576 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
> @@ -26,7 +26,10 @@ properties:
>        - adi,adaq7769-1
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4
> +    description:
> +      Chip select number. For multi-device setups, one entry per device.
>  
>    clocks:
>      maxItems: 1
> @@ -109,6 +112,12 @@ properties:
>    reset-gpios:
>      maxItems: 1
>  
> +  spi-rx-bus-width:
> +    description:
> +      Bus width per CS. For multi-device setups (multiple reg entries), one
> +      entry per device must be provided. Required when reg has more than
> +      one entry.
> +
>    spi-cpol: true
>  
>    spi-cpha: true
> @@ -203,6 +212,16 @@ allOf:
>        properties:
>          pga-gpios: false
>  
> +  # Required properties for multi-device setups
> +  - if:
> +      properties:
> +        reg:
> +          minItems: 2
> +    then:
> +      required:
> +        - spi-rx-bus-width
> +        - spi-cs-composite
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -244,4 +263,63 @@ examples:
>              };
>          };
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/iio/adc/adi,ad7768-1.h>
> +    /*
> +     * Four ADAQ7768-1 devices aggregated on a single SPI controller.
> +     * Each device occupies one CS and one data lane; DRDY and SYNC_IN
> +     * pins are wired together across all four devices.

For DRDY, wired together how?   I assume that only gets set when
they are all ready?

> +     */
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@0 {
> +            compatible = "adi,adaq7768-1";
> +            reg = <0>, <1>, <2>, <3>;
> +            spi-rx-bus-width = <1>, <1>, <1>, <1>;
> +            spi-cs-composite;
> +            spi-max-frequency = <2000000>;
> +            spi-cpol;
> +            spi-cpha;
> +            vref-supply = <&adc_vref>;
> +            pga-gpios = <&gpio 10 GPIO_ACTIVE_HIGH>,
> +                        <&gpio 11 GPIO_ACTIVE_HIGH>,
> +                        <&gpio 12 GPIO_ACTIVE_HIGH>;
> +            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-parent = <&gpio>;
> +            #trigger-source-cells = <1>;
> +            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
> +            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
> +            clocks = <&ad7768_mclk>;
> +            clock-names = "mclk";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            #io-channel-cells = <1>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            channel@0 {
> +                reg = <0>;
> +                label = "channel_0";
> +            };
> +
> +            channel@1 {
> +                reg = <1>;
> +                label = "channel_1";
> +            };
> +
> +            channel@2 {
> +                reg = <2>;
> +                label = "channel_2";
> +            };
> +
> +            channel@3 {
> +                reg = <3>;
> +                label = "channel_3";
> +            };
> +        };
> +    };
>  ...

