Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2862472AA;
	Tue, 21 Apr 2026 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765073; cv=none; b=aK3r8Ktq7GzMIqWp/jIIZ5wO8zlvGjIb8Z4hWWQOMYoOxee60zW+IN/y54lOfQJLdH8bZ03uzlpmU7HxiCHexbtsUDL2hWLX1ubEQvwLhQ9BCu3VqWF5vOUeGZ8N8E+a6wIMyJqtlyVzRLDxodpvVATPFPsheuswE+fd1/SPEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765073; c=relaxed/simple;
	bh=VtkQ1i0kAqBUciLoNuo/gKk3cDHAmSHLUuMH5VOnMOk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmTOEBfY2p9zm4vhl8QCdFtntU2P4r37rTJqzrCCvbz118R1xiD6o2XJO9hhW8a8h05EIcdbE6SJJmgKMG3VO9FgBFPlU+d1167wGQ20Qa/YbzE3V7IZCDyXnBjPpN2zcJ0B3ejyEiDwMBqwf+5h9l1dIN+zptvAg8kdJbPO87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdFrDMJW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdFrDMJW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906D5C2BCB0;
	Tue, 21 Apr 2026 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776765072;
	bh=VtkQ1i0kAqBUciLoNuo/gKk3cDHAmSHLUuMH5VOnMOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kdFrDMJWgkALWv1eAW1AKxT9k7qcx3gNv3FL/C8W0J19NTYR+xBeE73JGwPIGkQiT
	 xm3VNrMgm+GJXfVUIvX//rdPdocqBzGY2bh1SRQxCkNy7ACC6N9Ec8foChYJW1Fg+c
	 4gl2hNaH31uT2THEL5GZq5yjPXJRi0g6ikbezFWuyiZCGtMTqnfhV9hW0R64+Deg8P
	 ILfR82VuoAqQ5kjBBOh6Wf8W7tWjnPC7nSCGyh6ft6NHZp/8mPj9djlnLJab10aLkg
	 s2FRYWyoO0O70ir1jrp073u7a2wFC+7Yn4ctebQbn98++8wwnDGkSEL0B+EbasgGi4
	 E5Q5dW2yvqMpA==
Date: Tue, 21 Apr 2026 10:51:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sudharshan <sudharsanam346@gmail.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: adi,ad7816: add binding for
 AD7816/7/8
Message-ID: <20260421105104.199b2162@jic23-huawei>
In-Reply-To: <20260421060011.12917-1-sudharsanam346@gmail.com>
References: <20260421060011.12917-1-sudharsanam346@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Apr 2026 11:30:11 +0530
Sudharshan <sudharsanam346@gmail.com> wrote:

> Add device tree binding documentation for Analog Devices AD7816,
> AD7817 and AD7818 10-bit ADC with on-chip temperature sensor.
> 
> The devices communicate over SPI and expose:
>   - up to 4 analog input channels (AD7817)
>   - on-chip temperature sensor
>   - a busy GPIO to signal ongoing conversion
> 
> Signed-off-by: Sudharshan <sudharsanam346@gmail.com>
> ---

I'm a little confused on why this is v2 as I can't find v1 and there
is no change log here.

There are various things missing. I'm not even sure you could make the chip
work with the subset represented here. Note bindings should be as complete
as possible even if the current driver doesn't use everything.


>  .../bindings/iio/adc/adi,ad7816.yaml          | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> new file mode 100644
> index 000000000000..6780510aaeb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7816.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7816.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7816/AD7817/AD7818 temperature sensor and ADC
> +
> +maintainers:
> +  - Michael Hennerich <michael.hennerich@analog.com>
> +
> +description: |
> +  The AD7816/AD7817/AD7818 are 10-bit analog to digital converters
> +  with an on-chip temperature sensor. They communicate over SPI bus
> +  and are commonly used in robotics and industrial applications for
> +  temperature monitoring and analog signal conversion.
> +
> +  Specifications on the converters can be found at:
> +    AD7816:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7816.pdf
> +    AD7817:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7817.pdf
> +    AD7818:
> +      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7818.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7816
> +      - adi,ad7817
> +      - adi,ad7818
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    maximum: 1000000
> +
> +  busy-gpios:

The data sheet calls out he most likely use of this which is not sensing when
it is busy but:
"The signal can be used to interrupt a microcontroller when a conversion
has finished."  That is how it is used in the driver in staging which reinforces
that view.  So make this one an interrupt.

However, there are other pins... For instance the !CONVST signal which I think
is best represented as a gpio.  There also seems to be a rd/!wr pin which you
don't have in this binding.

Hence this is far from complete and you should go take another look.
Also included power supplies which should be 'required' in the binding
if they are needed for the chip to work (at least some always are!) even if
the driver currently doesn't turn them on and off.

Thanks,

Jonathan


> +    description:
> +      GPIO connected to the busy pin of the AD7816/7/8.
> +      The line is active high and indicates the chip is
> +      performing a conversion.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        adc@0 {
> +            compatible = "adi,ad7816";
> +            reg = <0>;
> +            spi-max-frequency = <1000000>;
> +            busy-gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +        };
> +    };

