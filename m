Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794619825;
	b=e9pP6/xsbFHgEXg0IBkYYNnKDGq17xkYqOCKNn808AxZRJqRz0pus/s6n1x0bShjKdaG
	 e05zZ76HfC8vLmYfViD8BI7k4VC1e8ctx8PEvLzbmMonWqnJRP4L1OdZrFYSDiiKUL0c6
	 wpNydBnWO/wJD5KhmshWdGNuqpHanIw4snkzVbYyZJIrwWZmewcszfw0XToaagYjDTn3i
	 Z4sOz27nZ/Uac2fBL3pcduQyj8FDNN7k12Jn0ZaryHHHwLMLnR9JfJgsKH6+fPZPAKIb1
	 k/UmvP/FqT1cJmn8+spNRKuoZN7Wq3beTMrAly/DdYoea2him+/WeQNxITGtP1biDwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794619825;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RQ3s44swT+hXZYasYMm7+mKbyW3BzrTQjbSMycRcEx0=;
	b=MgrzScaFWUpYf0TR+2C4exP5723lM9frKEoQ3G/oj4QZYbG4UpaGnAZQygKFnQWXuBNn
	 WmL0GD2tkzIbMnhIY1yqC5RDU3qJqCqdjXrjORL6QAEJhOGqXFO/po3uHPrTuTTrmsiNh
	 8cJw+9J2a2aHMN2vjpCvsa5QombWg20ktg5eMontuMds9RwCbD4YFE7CY8VEqtmQ/ATju
	 mYpG4mSlVpEGCtC8pj6P2tLQhlCkh3LScq3li7rniRMSIgkFCyVp3ThQv09FkYxs3ETo4
	 b+7GLjT3RowBWq7y5QqQCSARiy5zsBSRinKpdkSlKzMHZweump/40A1V6c1oDglxugA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcjpQsmr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2E5606A338;
	Sat, 14 Nov 2026 01:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcjpQsmr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177941F000C4;
	Sat, 14 Nov 2026 01:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794619825;
	bh=RQ3s44swT+hXZYasYMm7+mKbyW3BzrTQjbSMycRcEx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KcjpQsmrDziGTHiubQ1Zv+Y4P1GyC2iuzuyF7P/w7JrZZSZEh7Erw85/PiLv7IR6E
	 s0XoOkBb2wGeLEzRrTD86ZiaBOwW9IawL7/v/hwdUArmAsYD1+48PmN89wGlFJJPfz
	 6VatIw2H/tkdNSk96iKXtTlmUx594OWX6e3tZGJduLS0ndRWGmcvb2qCV8gutBccFC
	 LJhirO+ufqpkfon1oBIMMeJPbi+g2rHzS/A/rh8Td+hjgun4c4zq/sIUKqZLM8+v49
	 jNRpbtvgJKrsUIfYky5A6nPdvqJxWlLqUDGMc1qCbpqmubNdx8FYwXldT34XnhX+gj
	 zQ45LC/LDXjhQ==
Date: Sat, 14 Nov 2026 01:30:15 +0000
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
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: Add Capella CM3217
Message-ID: <20261114013015.3afcf109@jic23-hlaptop>
In-Reply-To: <20261113-upstream-iio-cm3217-v3-1-c4d5b2485dff@tsv-stahl-riesa.de>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
	<20261113-upstream-iio-cm3217-v3-1-c4d5b2485dff@tsv-stahl-riesa.de>
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

On Fri, 13 Nov 2026 20:58:59 +0100
Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:

> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
> 
> The Capella CM3217 is an ambient light sensor with an I2C interface but
> without registers and without an interrupt line. It always answers on
> the two fixed addresses 0x10 and 0x11, which are both listed in reg.
> 
> The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
> Tablet.
> 
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  .../bindings/iio/light/capella,cm3217.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> new file mode 100644
> index 000000000000..9aba05949a27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> @@ -0,0 +1,50 @@
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
> +  line.
I'd drop the 'without registers or interrupt line' as one isn't relevant to DT
and the other one is seen by there not being an interrupts entry in the properties.

Other than that, looks fine to me.

Thanks

Jonathan

> +
> +properties:
> +  compatible:
> +    const: capella,cm3217
> +
> +  reg:
> +    items:
> +      - description:
> +          Command byte 1 (shutdown and IT_T) on write, high byte of the light
> +          count on read. Fixed at 0x10.
> +      - description:
> +          Command byte 2 (FD_IT) on write, low byte of the light count on
> +          read. Fixed at 0x11.
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
> +            reg = <0x10>, <0x11>;
> +            vdd-supply = <&vdd_2v85_sen>;
> +        };
> +    };
> +...
> 

