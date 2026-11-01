Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555302;
	b=Xkd+C7MhaiEEFg7BL2spbOk84hpo7nJyWmqslLXHZhyveskNqziTRrO2q/C2IoH1AQyI
	 jUPZtxl/TnDhqk6n9+6us7U8Z5wpDrWfW04U19vErQ9A84aQoPl6cbMncf+b3gUWnB/xa
	 5BpsXkeMsz5Wk8pci8F+AFtu41zYYPiblHCEXK1wjxjUsjTAEG6as78XvqC9riaiHZXsr
	 fH1D6U/oLeKcDmiQNcTRanlq02bIox3NgLNyu2VjRIdZwo70gvQ+WwDBZjeb5PSWfiWQa
	 w0fY4JowYfMf7JdkyyR6geSvfqnVBjNW7KP/Aaqr7VHTRTPlOyIAknM5LEfb2ecrD7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555302;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UBm1kiri62EaTC8wl1H2p7PsuwOTdHeeIjuWlRIq8zk=;
	b=eqD2c6uXqM4yr+d3H2Q8avriDOu0lvpHs/h/4aiEwiCO88biay2h8RO7P5CXRmGM2vbw
	 GixdmEhC4aLanvzjSlLQPpgPtT52Yrm7AWczkUY9VU64d5QLfWVCl5r6z4Dyww9o14gby
	 W54pW+twrtuWjHM20b9lBqyc0ZxWtrV8c+qclXTAN01R8oPTr/hVe7L0D/0V8T/anivgE
	 AQYRzjNouPHrh92KHim9iR2ICAedDwund3dU4mgzsRBIIkpKZ9lmHOp0jDbFzwsTxCHeJ
	 teB4yMFYhKT2gJKj8eR82SvO46gxSaMQ20NxyVPt6PdGJVF8LXxcsX9/rw+WlkkDvcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT0m98k3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EC4606A324;
	Sun,  1 Nov 2026 17:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT0m98k3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11141F000C1;
	Sun,  1 Nov 2026 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793555301;
	bh=UBm1kiri62EaTC8wl1H2p7PsuwOTdHeeIjuWlRIq8zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KT0m98k3UOR0hY2Y+WT+ZObsDmEhEMolcBLNHvMhwchKY5dLNlekLEFg38RjMmkzw
	 DCA4V5Cwc63T1GXyTtwdCnnJSBRuI7lR5R3OgexiyPw+WwbREeVzyE0OFSHYKy0m9w
	 I6yqJPVWmzG9rm839BPgzort49dF90MwsNpqjnlTFiM8KYITEEYSZMbNT4OiHY4mCt
	 P3hq6I6JDHHUZf+Q0NM8z4EmLvLIhJwYDN2VPEUS3k0oFHh1hL1kveANOQFUoAN60j
	 xVMknE0mwOBWqfd9+O9j6+Kv6zlgiS5l+6bi5P5wVVKYHTEAL5kusm2s86vg9l6l35
	 YVRK/0ZAbtCjA==
Date: Sun, 1 Nov 2026 17:48:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Cc: admin@tsv-stahl-riesa.de, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Kevin Tsai
 <ktsai@capellamicro.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: light: Add Capella CM3217
Message-ID: <20261101174818.2aada52e@jic23-hlaptop>
In-Reply-To: <20261101-upstream-iio-cm3217-v1-1-5e1724cae7b7@tsv-stahl-riesa.de>
References: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
	<20261101-upstream-iio-cm3217-v1-1-5e1724cae7b7@tsv-stahl-riesa.de>
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

On Sun, 01 Nov 2026 15:46:06 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The Capella CM3217 is an ambient light sensor with an I2C interface but
> without registers and without an interrupt line. It always answers on
> the two addresses 0x10 and 0x11. The node describes the first address;
> the second one is fixed and claimed by the driver.
> 
> The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
> Tablet.
> 
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>

Hi Patrick

One small thing inline. 

> ---
>  .../bindings/iio/light/capella,cm3217.yaml         | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> new file mode 100644
> index 000000000000..b2ddb14d657b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm3217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella CM3217 ambient light sensor
> +
> +maintainers:
> +  - Patrick Fischer <admin@tsv-stahl-riesa.de>
> +
> +description:
> +  The CM3217 is an I2C ambient light sensor without registers or interrupt
> +  line. It always occupies the two I2C addresses 0x10 and 0x11; the node
> +  describes the first one.
> +
> +properties:
> +  compatible:
> +    const: capella,cm3217
> +
> +  reg:
> +    const: 0x10

Put the documentation about using who I2C bus addresses here rather than
in the introduction. This is where anyone wondering about allowed reg for
a device that sits on two addresses would look.  Maybe add a little
on what goes to each address.

> +
> +  vdd-supply: true
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
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        light-sensor@10 {
> +            compatible = "capella,cm3217";
> +            reg = <0x10>;
> +            vdd-supply = <&vdd_2v85_sen>;
> +        };
> +    };
> +...
> 

