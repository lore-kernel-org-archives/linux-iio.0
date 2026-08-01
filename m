Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72473DA7C3;
	Sat,  1 Aug 2026 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785627984; cv=none; b=Ew1xbQ60Fd/3DCI8GxHBbfB5ien72UtO3eLjfWP1QrG9ySWsofHCHG0P0wMS+GM/nwEJ1JZXWRULT/k2oSBY6ujFxvOkjY1VCFOaSnbLQlUTuiJ6luMz37oae1Bp8hgwaRW2IO6idH3kejRfVwg17KkjEzolFEZm7d95v81R4ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785627984; c=relaxed/simple;
	bh=JnJuiR0JWYtbX1tR+PspE7sckWrdy+4EPs9wXERewUk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j49n6Ly5raTh3dsqROuiDTLeuV9p9In+rXdPMnKTQn+fX5po2ZybUhT+vQM2BIykOfo/eZFqHg1vOhuIQLDLPEfljV43I6rio8COyeQZNt5ULlO2sNydviVZbvJV4Gw/l5wHyHYI/JGbI6rDkwg6MG8Bq5l9MJ5ywo33SLFNu2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5XvI8MU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5XvI8MU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6B51F00AC4;
	Sat,  1 Aug 2026 23:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785627980;
	bh=HeE/t9xrv9DqIQ9OSKeeh2U7hnhTxo26v+r6kRTJCO8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N5XvI8MUKVVAi3PQHFD3IoutAhoAyoPStBfNacR7gBCP9/wHfiXhz6PKcllt5ozeU
	 1Tzp+NxBCJeS4D+hEVvXcJWDwJFf6KCp73mItoznsDc0wSCZla+/BFMfyC0gOYa6vj
	 f9Q6cSn/h7K+QADUB4aasT9GApeUUP14/MNlIifnXUvaQCPzjt0t1TP3cS2G6fHHi1
	 zOcntDsghbu+ki5nVhgFNBoNgCsL8D9l4BRkHYoaVdxfkpROtrPfE7CAfPGo/Mn28y
	 8ZkaGPXsMB8lrRu4pqx205kWLqam/EEXhrIo4tbaseULtLU1SPRU3JBU+f3/M82BHh
	 FR+CfGDqcxrHw==
Date: Sun, 2 Aug 2026 00:46:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 maxwell@maxwelld.cc, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com,
 455.rodrigo.alencar@gmail.com
Subject: Re: [PATCH v6 2/4] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260802004615.2193f11b@jic23-huawei>
In-Reply-To: <20260728214943.29820-3-wafgo01@gmail.com>
References: <20260728214943.29820-1-wafgo01@gmail.com>
	<20260728214943.29820-3-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 23:49:41 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Document the bindings for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  The family currently covers the
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.

FWIW there is a false positive from Sashiko on this where it says
there is no interrupt pin.  I'll guess that it found a datasheet
talking about one packaging option perhaps?

The first one I checked has the interrupt pin.

Jonathan

> 
> All variants share the same register map and differ only in the flow
> scale factor and the calibrated measurement range, which the driver
> reads back from the product-information register.  Since that lookup
> is needed in any case, a fallback compatible would buy nothing, so
> each variant gets its own compatible without a fallback.  A future
> drop-in compatible part can then claim one of these compatibles and
> work on kernels that do not know its product ID yet.
> 
> The active calibration medium (water / IPA) is runtime-switchable
> via the in_volumeflow_medium sysfs attribute and therefore not a
> DT property.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  .../bindings/iio/flow/sensirion,slf3s.yaml    | 55 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> new file mode 100644
> index 000000000000..79718f4f98bd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SLF3S liquid flow sensor
> +
> +maintainers:
> +  - Wadim Mueller <wafgo01@gmail.com>
> +
> +description:
> +  Family of digital liquid-flow sensors from Sensirion with I2C interface. All
> +  family members share the same register map; sub-types differ only in the flow
> +  scale factor and the calibrated measurement range. The sub-type can be
> +  identified from the product-information register.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,slf3s-0600f
> +      - sensirion,slf3s-1300f
> +      - sensirion,slf3s-4000b
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flow-sensor@8 {
> +            compatible = "sensirion,slf3s-0600f";
> +            reg = <0x08>;
> +            vdd-supply = <&reg_3v3>;
> +            interrupt-parent = <&gpio0>;
> +            interrupts = <0 IRQ_TYPE_EDGE_RISING>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ce020ded5fd3..497492825f70 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24583,6 +24583,13 @@ S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
>  F:	drivers/iio/chemical/sgp40.c
>  
> +SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
> +M:	Wadim Mueller <wafgo01@gmail.com>
> +R:	Maxwell Doose <maxwell@maxwelld.cc>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
> +
>  SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained

