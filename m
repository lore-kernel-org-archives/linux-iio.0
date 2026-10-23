Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724976;
	b=U18mGCUEtIJ5omqkDOGzNsoIT/aItUpqkxWAXJyDCd0bht7fUHTKmMpVg9VeoGCt9u1W
	 1j/863EHdQXkuPmxPm69tKzEqtesA36CauU72yD8pgq+28rnFBOZrxAj6SjS4Z/sL6xzD
	 7gWxLwAPo1KpuEEPIRr1KeZfbASw9SMiOv1CBcc3XiyiHyOJFc6JbJWO07ZSX2A7MBJiD
	 O6QluisD6Igf2XVWPTfe+12hNfQbJ4QRM+mt3N9dTayRvlchFvOmWV1l1rle46dNXWVDO
	 6j3HW2w+M7iwCBvPR56RycCLWgm+USbcinXJvEMLeifO9m3doCdflCUhtkB1PmR1tTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724976;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bTogooys/aCuXpGBFbJ0DDf1484T7LdNyijVAM5kdYw=;
	b=NnJUu3+jjCEyknVVk9phpTrbB7jgXNOVi+uf4eJyESU74Ly00j73/GgqOvx+8tZgyg9l
	 Q69br+mZgqZEWfEeNC3mUiWFMKPxtzI7OYBH+phSZrd/KCFNGPo3RXaLCfYEhEu6/cG2F
	 MdNWRTFu7Mz5Bw56b6VnlAfg7O3X5n58hfFKUQ2dxr8QFGjzf5s6oCQNl99wRKxh6pZVn
	 zgKdy80g56kafGgXldt2gx4X+c8gwmvj0itJjSimeHeSNDvjnfH+/FKbk28YelFEeizzh
	 nv3+wXmzz/hp8TtkS7ytGehZq3d/lYPX4N2WtRwv7HQ5sTH6DdLW2xQx5M9ndOaYRMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+ihMNId;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951D606A319;
	Fri, 23 Oct 2026 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+ihMNId
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FAE81F01825;
	Fri, 23 Oct 2026 03:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724975;
	bh=bTogooys/aCuXpGBFbJ0DDf1484T7LdNyijVAM5kdYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M+ihMNIdYkf3SNZA1G3pvHcQ/0LvjTCiJWumTf9yWqNMjbEHF/YLQnx5lmZ1ExBqD
	 IMeQ1pXHsJUewnMGOdgHCs3dnXLZ12A6Jq+ZTrXoE+U2SW8+hKofRkWYKAHh/lMs5n
	 1v6PmptP0yTY4uyaxkfnqaEBlne3LeTfUOZFWBJybVOpII+wI5kQeQRyRUt6ujIMqQ
	 OC21rKZsB5+uRuFHi27qt3Yi7QOifdGZ7D/psg4izdJru2f1mPwxXye6QRnSk60X0j
	 OQRhDZawfWbn4ut+6WP0fxZvuUny3mys70cqmTZTueOnDKqAVDoBRzJk27OEAa9J37
	 MmW4JVzfw/vpQ==
Date: Fri, 23 Oct 2026 04:09:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: cdc: add Texas Instruments
 FDC1004
Message-ID: <20261023040927.1f142eea@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25283751BF4A06FF790BC114A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25283751BF4A06FF790BC114A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
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

On Thu, 22 Oct 2026 18:40:31 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

> Add device tree bindings for the Texas Instruments FDC1004
> capacitive sensor.
> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
> ---
>  .../bindings/iio/cdc/ti,fdc1004.yaml          | 44 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
> new file mode 100644
> index 000000000000..d22b7bc92a3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/cdc/ti,fdc1004.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments FDC1004 capacitive sensor
> +
> +maintainers:
> +  - Victor Chernyakin <chernyakin.victor.j@outlook.com>
> +
> +description: |
> +  The FDC1004 is a high-resolution 4-channel capacitance to digital converter
> +  that works over I2C.
> +
> +  https://www.ti.com/product/FDC1004
> +
> +properties:
> +  compatible:
> +    const: ti,fdc1004
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +required:
> +  - compatible
> +  - reg

Require the power supply.  The binding reflects that the sensor needs
power to operate.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cdc@50 {
> +            compatible = "ti,fdc1004";

As I mention in the driver review, I think this sort of sensor is pretty
much always wired up to specific external sensing elements. As such you
may want to provide channel sub nodes in here to make it discoverable
which channels are actually useful.

> +            reg = <0x50>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 360977678f70..69c23ae21016 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -27388,6 +27388,11 @@ S:	Maintained
>  F:	drivers/net/ethernet/ti/cpsw*
>  F:	drivers/net/ethernet/ti/davinci*
>  
> +TI FDC1004 DRIVER
> +M:	Victor Chernyakin <chernyakin.victor.j@outlook.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
> +
>  TI FLASH MEDIA MEMORYSTICK/MMC DRIVERS
>  M:	Alex Dubov <oakad@yahoo.com>
>  S:	Maintained

