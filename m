Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78B44105C;
	Mon, 11 May 2026 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518517; cv=none; b=BAipHf9hQs+t5P0HjHkI+5iflFDfj+YDPJfKQeyEODHrHVrdp66zHer9RyHWog5vB0RfrYkujQUcqf9+BneHHTWmqDHDV5verGUStSdHscByg9r24wTPwXJW8TnWtWgg7chpJYZ0OD7TpIbZJpjGfVSDX10NmRR7h6uHyEjF270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518517; c=relaxed/simple;
	bh=HYhaXruBZoz+hb124UXwHI1TKBnKnY7E0zHAbwDkiGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgDZ2AasOv1rTLbm7QwdMSUb6NZ1KoDbyLegVr06zIq6FL6rszGfMeAVIFHNe3nHFJj4LAIKZkI6aPIKKPWioJjO3QNEL3FEoQ8Je1+TrNQn5Zr+Z2PLYt0uXvl85PcrKiBCk2SxN9+2dLssbJnOXtJXoXjSI9CDyhE2DvOpO/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugydx+fx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugydx+fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3171C2BCB0;
	Mon, 11 May 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778518517;
	bh=HYhaXruBZoz+hb124UXwHI1TKBnKnY7E0zHAbwDkiGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ugydx+fxItsKbV/xD6b0vJ3Rb+pxKZ47oQdD8WxDH6yLI+efRlIUA/9esBMa7pnf/
	 6yxK+MfhabbqraVRB4JfFc8WO/xnXLsLOtQThmy315VOzfetNFx14J2u2KhmqwLIWF
	 2oQ1mNLGo3DXEmL/DaD8jR2NOtbtt3tQBh6Z1NAId2HJr9r5JE/sd53xRceASpmr3i
	 AbmEQmgoGRZJ2LoMDOtNXvbb+5l7mWf2e06/bgYWMe10OTNo8QwwDaPQ+Dkv7JpjVO
	 cGJ6DN1Pc35j7TM0aPBCnvgFlbOxgemN70neEMW/J0hkVXPA1ZbDh+b+b/RAe1TQxj
	 KJngDIJyL0bIg==
Date: Mon, 11 May 2026 17:55:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Message-ID: <20260511175509.4f76da87@jic23-huawei>
In-Reply-To: <20260509-backdrop-contented-b81438c518f4@spud>
References: <20260508233730.77834-1-dennylin0707@gmail.com>
	<20260509-backdrop-contented-b81438c518f4@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 17:00:35 +0100
Conor Dooley <conor@kernel.org> wrote:

> Jonathan,
> 
> What's the story with adding bindings for things that are in staging?

In the past we've only done it as part of the final series to move
them out of staging.  Whilst the driver is in staging we've always
treated them as somewhat unstable at best.

Of course if we know another OS is using them the binding might
need to be there anyway.  Never actually had that happen however!

DDS chips are normally big and complex beasts. I'd love someone to take
on getting these drivers out of staging but it's probably not a small job.
We do have one modern DDS driver under review at the moment and that
is at least forcing us to figure out the userspace ABI - so maybe it'll
get easier when that lands.

Jonathan

> 
> Cheers,
> Conor.
> 
> On Fri, May 08, 2026 at 11:37:30PM +0000, Hungyu Lin wrote:
> > Add devicetree binding documentation for AD9832 and AD9835 DDS devices.
> > 
> > These devices are SPI-controlled direct digital synthesizers
> > requiring AVDD, DVDD supplies and an external master clock.
> > 
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  .../bindings/iio/dds/adi,ad9832.yaml          | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> > new file mode 100644
> > index 000000000000..7e2eece086d0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
> > @@ -0,0 +1,66 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dds/adi,ad9832.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD9832 / AD9835 DDS
> > +
> > +maintainers:
> > +  - Hungyu Lin <dennylin0707@gmail.com>
> > +
> > +description: |
> > +  Analog Devices AD9832 and AD9835 are SPI-controlled direct digital
> > +  synthesizers (DDS) capable of generating programmable frequency and
> > +  phase output signals using an external master clock.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,ad9832
> > +      - adi,ad9835
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency:
> > +    maximum: 20000000
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    const: mclk
> > +
> > +  avdd-supply:
> > +    description: Analog power supply
> > +
> > +  dvdd-supply:
> > +    description: Digital power supply
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - avdd-supply
> > +  - dvdd-supply
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        ad9832@0 {
> > +            compatible = "adi,ad9832";
> > +            reg = <0>;
> > +            spi-max-frequency = <20000000>;
> > +            clocks = <&mclk>;
> > +            clock-names = "mclk";
> > +            avdd-supply = <&vdd_3v3>;
> > +            dvdd-supply = <&vdd_3v3>;
> > +        };
> > +    };
> > -- 
> > 2.34.1
> >   

