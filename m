Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147CB4F5E0;
	Sun, 20 Sep 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789864840; cv=none; b=BZUo5MHZ2Lu51xyC5cDughWHh0OodxUnIPHgO3PCrp20dst+XezTBMzalQEj4rZ4gXUlASjwnPO3pxGXWfRVs93ODLlYdYEdQNgxS6b3xw8warzx/3TXmvzS5Zef0MaSvaPg9Ngjn3qmcyR+/x+b6//s+fTZzcNcZkJTWYhnn8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789864840; c=relaxed/simple;
	bh=S91OagKm2Y6lfsnFhl0UdEnwZC59lz6/JtKLd6i4MNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjY61smY2kBjAw5qljjgkQlLm6PpJthaihzCC9j8WykqU+lYRcvUDyx8YX5sOpUnMQ3pAYUzKshXd+xQJMy5jOz7MflSy/gVG3ED84TDijQbC87dKkgRmrkTcz4z+3d2cbXeH97iLUHvDPvKJrXoX9xI51TTmgf0LvxSdh5W9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgis9zG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgis9zG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D61F000FF;
	Sun, 20 Sep 2026 00:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789864838;
	bh=G/wLiSXkSZo/0ssqbP54/aQU7edRNTd1W/xW203sC7w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kgis9zG4/MzD/Mmi+a2F1lVX92iVrt40ANuAjwilvfxNbEXDYMDsasFGJSArm2ER/
	 SODe8LZeD3vYwvIbUFLRhTBkrnoi3RjplqFLHk219X8CK3UqEGDylubIquGns35Zrr
	 38rup9vG58aF/0ByiC47E3RmE5F/pq+0tCT8zmFuuhqIob2ScF7lclwCZvHOBHvdli
	 fycamuiLpeogglT8cooChgnsY+aqT8aYOoc/F/W6P8D9AuLJerSIbBAOEt5uzIyMqH
	 TsS2lt5Unx0tREhPQxw6Y+kpvZb92VCcpY3MJCZ/OXK9UD1igQKDH4P+olu7kvEddJ
	 l+pXL4NA0jiBg==
Date: Sun, 20 Sep 2026 01:40:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Message-ID: <20260920014032.2cc3c851@jic23-hlaptop>
In-Reply-To: <20260919223854.13437-2-m.abubakar365@yahoo.com>
References: <20260919223854.13437-1-m.abubakar365@yahoo.com>
	<20260919223854.13437-2-m.abubakar365@yahoo.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 03:38:53 +0500
Muhammad Abu Bakar <m.abubakar365@yahoo.com> wrote:

> Add device tree bindings for the Sensirion SDP31 differential pressure
> sensor, an I2C device that also reports temperature.
> 
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> ---
>  .../iio/pressure/sensirion,sdp31.yaml         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> new file mode 100644
> index 000000000..fc646eca2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SDP31 differential pressure sensor
> +
> +maintainers:
> +  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +
> +description: |
> +  Differential pressure sensor from Sensirion with an I2C interface.
> +
> +properties:
> +  compatible:
> +    const: sensirion,sdp31

It looks like there several similar parts that only differ in
range.  Would be nice to support them all out of the box.  Fine
to just test on one in a family like this.  If there are more differences
then ignore this feedback!

> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +

Where is the irq?  Even if a driver doesn't yet support all the
features, the dt binding should describe them if at all possible.

> +required:
> +  - compatible
> +  - reg

Sashiko correctly points out that devices tend to need vdd-supply to work.
Hence it should be in the required.  That's not to say in practice it needs
to be in the dts given the regulator subsystem handling of missing regs
is to fake one on the basis the power is probably always on.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      pressure@21 {
> +        compatible = "sensirion,sdp31";
> +        reg = <0x21>;
> +        vdd-supply = <&vdd_3v3>;
> +      };
> +    };

