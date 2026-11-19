Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057196;
	b=INtz+TjgCYU5vmQm8WMUmr1x85T8QaAvezNYXUoNYQwCFdApWxSpnqaOgkHglPFJAlRc
	 N6z39OHmXlL2EMsub0l9Dqs2U6DVKD5Ykn89tJQYhl9ZrSHcab17ixZYe/F+67YA9DL19
	 1xX2GjYnWUtfDniUMvjKLrBIbjOZ4TPJ40lEYllvClGxnC3F73zvq49aRoLWPPRHcxWMd
	 iKbOsyvEgNv1UvJ2VsEsljLXMNKalJkXUZtDaGBEvCuhfvviT3VirEKkjRAznTCPPTpkn
	 QqATjF8tiLOXWtfjbAqGwIJH/qwNcBP8XcUhOYWhr1u/jIvpGQD9ozc6RHxvDoAle5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GWjdwg97jtKYZUSdtxJMhSsjE1aTAuzLSMKha3trRwE=;
	b=zngHMBdy2wiKR84CLDa9FgUYIYUv82uBNqwFkuf6/sqaFmQ1tEtbmbDj/zYJc6CJXGq5
	 QVsCqoxEyCNQgV3ruazW4Ob/OFj6hp7riN91SO3HDz4LphahcoNBjLhh6DK4mCOadggzs
	 yVKAXL5gvlgLPVAHrNwTtOSoznEwBtHjF8MqOAC0sz0vNtwjArlbasEFmcaqrTeaqF2Cq
	 qVu/WDnCJ0IK5/Eq1GTvfHLPgO9aM0O/0otS/dfjhi/Ys2Z+jHPNUG1A0eUkWe6DjMPah
	 P6tNDteHEfieRdDxbJ0eP7YwUfDDwuXr0y3HAtfBAkAUDHEOMhXZ9fGgaGArek8bQ7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkwVPbfQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAAA606A331;
	Thu, 19 Nov 2026 02:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FkwVPbfQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117C71F000CB;
	Thu, 19 Nov 2026 02:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795057195;
	bh=GWjdwg97jtKYZUSdtxJMhSsjE1aTAuzLSMKha3trRwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FkwVPbfQsC1oUR3dy3XVEUSqOZv+yA7uwi5cSr3A0f/IP6b84eUaXbFH7VkEb3mgZ
	 14rqUvwpokWJRDF8pNwqQMeD2kkM41pq+Gj/JwonxzwMpcHxBpPwz4n9pKu9wJY+kE
	 dZ3HSxv3aDZhGWw8GHtjLWAeCy8InXPxeahPC9aXGJqZCCljDY1RhT93xtCCo0Nb6E
	 iN3eek/tR1L+VWDaQ5K+4OYgkeHURh0FBHBQgHLwt/di/TFa+bKitf5qFS/0zjC3kd
	 qEHeTlPlG/LEYy84ZSNJda1G38tY20zVEyzZVaI8DxkP4MnHYjnqviTxwcxBHTiftA
	 9ZI6kEeV/vVKw==
Date: Thu, 19 Nov 2026 02:59:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux@analog.com,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, eblanc@baylibre.com,
 dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, olivier.moysan@foss.st.com,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 4/5] dt-bindings: iio: adc: Add ADA4355
Message-ID: <20261119025950.456dc645@jic23-hlaptop>
In-Reply-To: <20261118-liver-decompose-434eedb257b8@spud>
References: <cover.1795003864.git.marcelo.schmitt@analog.com>
	<c7be62089d2b54dbf7fb57cdea189bdb1cade7c5.1795003864.git.marcelo.schmitt@analog.com>
	<20261118-liver-decompose-434eedb257b8@spud>
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

On Wed, 18 Nov 2026 17:39:46 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Wed, Nov 18, 2026 at 10:04:13AM -0300, Marcelo Schmitt wrote:
> > The ADA4355 is an integrated analog front-end and 14-bit analog-to-digital
> > converter with a serial LVDS data interface.
> > 
> > Document how to describe ADA4355 devices in device tree.  
> 
> Please explain why the 4356 differs rom the 4355 such that it cannot use
> a fallback compatible.

Also mention it in the patch description!
I was briefly very confused at Conor's comment :)

> 
> Thanks,
> Conor.
> pw-bot: changes-requested
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,ada4355.yaml         | 104 ++++++++++++++++++
> >  MAINTAINERS                                   |   7 ++
> >  2 files changed, 111 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> > new file mode 100644
> > index 000000000000..d169619fef25
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,ada4355.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices Transimpedance Current to Bits Receiver
> > +
> > +maintainers:
> > +  - Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +
> > +description: |
> > +  ADA4355 programmable transimpedance, current to bits receiver and similar data
> > +  converters.
> > +  Specifications can be found at:
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4355.pdf
> > +    https://www.analog.com/media/en/technical-documentation/data-sheets/ada4356.pdf
> > +
> > +$ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ada4355
> > +      - adi,ada4356
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 50000000
> > +
> > +  spi-3wire: true
> > +
> > +  spi-cpha: true
> > +
> > +  vcc-supply:
> > +    description: 3.3V power supply.
> > +
> > +  vea-supply:
> > +    description: 1.8V analog power supply to ADC.
> > +
> > +  ved-supply:
> > +    description: 1.8V digital power supply to ADC.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  adi,vld-en-gpios:
> > +    description: GPIO connected to the VLDEN pin for VLD output enable.
> > +
> > +  adi,gsel-gpios:
> > +    description:
> > +      GPIOs connected to the GSEL0 and GSEL1 pins, in that order, for
> > +      transimpedance gain selection.
> > +    minItems: 2
> > +    maxItems: 2
> > +
> > +  adi,lfp-gpios:
> > +    description:
> > +      GPIO connected to FSEL for internal low pass filter bandwidth selection.
> > +
> > +  io-backends:
> > +    description:
> > +      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the
> > +      ADC. An example backend can be found at
> > +      http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vcc-supply
> > +  - spi-3wire
> > +  - spi-cpha
> > +  - clocks
> > +  - adi,vld-en-gpios
> > +  - adi,gsel-gpios
> > +  - adi,lfp-gpios
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            compatible = "adi,ada4355";
> > +            reg = <0>;
> > +            spi-max-frequency = <100000>;
> > +            spi-3wire;
> > +            spi-cpha;
> > +            vcc-supply = <&supply_3_3V>;
> > +            clocks = <&ref_clk>;
> > +            adi,vld-en-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
> > +            adi,gsel-gpios = <&gpio0 86 GPIO_ACTIVE_HIGH>,
> > +                             <&gpio0 87 GPIO_ACTIVE_HIGH>;
> > +            adi,lfp-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH>;
> > +            io-backends = <&axi_adc>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 02015eaec312..692f1e6d56ec 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1794,6 +1794,13 @@ W:	https://ez.analog.com/linux-software-drivers
> >  F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
> >  F:	drivers/iio/amplifiers/ada4250.c
> >  
> > +ANALOG DEVICES INC ADA4355 DRIVER
> > +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ada4355.yaml
> > +
> >  ANALOG DEVICES INC ADE9000 DRIVER
> >  M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
> >  L:	linux-iio@vger.kernel.org
> > -- 
> > 2.39.2
> >   

