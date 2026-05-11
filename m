Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE52439A808
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778502402; cv=none; b=OBxLRO4uEQ213VCmNCuGKggOoMh3iGiShAo2rr5iGsRmbCuqXlVP7kQudZLcIEJXQpJgiO3opsdLy6+dqaCzo+UvzcAmQyIxosU9iEHsjakk3LNuNwalCrgVHn3fgbJ0r3NuOI+Zq0i/WzuBir9BsygM6D6y9aH1o/HYMC1VQQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778502402; c=relaxed/simple;
	bh=nSZcj2yYQaeRzk6N+kOkm3GS91s5Kw6/WI/khK3dvKY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBjrHJaZRMssahnq9hn4MRzH1zfVlceVTKzZ0YqqJOTrOsOCkHDaxXWV7LFqc6P68N1WHBXqs14PUAK8ihRnLEqktXptbPxIBjpUZOcjP4rP63FX2H2FqN1TsUGA9V7FyH2FynqwpzXW/eM56V0bdWjUcNH1nfDiI1wJqI+LPF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCy9O2cQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCy9O2cQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0C8C2BCC9;
	Mon, 11 May 2026 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778502402;
	bh=nSZcj2yYQaeRzk6N+kOkm3GS91s5Kw6/WI/khK3dvKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCy9O2cQYYrPHCzgXGZZoM2xNBj0RUzMwyTq/k/mh+27QLJzRkQyN9L4mc70dcLL1
	 noXjNkQ2nbLwKlTB3aXW62LO2QzQJDyRy5OGE6XwiXJY9Qq0V33zBuV91wn3+WCu1n
	 NylWOYGZb1404JkblT5/uhsyld5Pnq9HyLdJV7LUSpfPoDsNC6TvYOqVV7LsIet0G2
	 vtRFUh6/scW1KZE0nIfH8T1nJpKvxty/3S/C47yprJWckVSkKElZdvGG9F4+ob5PJm
	 tqzkKg789R7BwokxEBrlP9iANw9RZ4DWhmi/ElyXNkvnduRHLtR2mogX3HpPxIA7Cl
	 vGkO1NOB/Prbw==
Date: Mon, 11 May 2026 13:26:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [RFC 1/4] dt-bindings: iio: light: add DT binding for Broadcom
 APDS9999
Message-ID: <20260511132635.7f0855c4@jic23-huawei>
In-Reply-To: <6acd3ce2a0e417699a8184817a4a8eb381450beb.1778491503.git.azpijr@gmail.com>
References: <cover.1778491503.git.azpijr@gmail.com>
	<6acd3ce2a0e417699a8184817a4a8eb381450beb.1778491503.git.azpijr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:14:44 +0200
"Jose A. Perez de Azpillaga" <azpijr@gmail.com> wrote:

Title doesn't need to mention binding twice.

dt-bindings: iio: light: add Broadcomm ADPS9999

> Add Device Tree binding documentation for the Broadcom APDS9999
> ambient light sensor.
> 
> Proximity and RGB features are not yet implemented in the driver
> and therefore not included in this binding.
> 
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

Can you combine this with the existing avago,apds9300.yaml binding?
Other than the missing interrupt in this file they look identical.

Note that a separate driver doesn't necessarily need a separate binding
doc.  May not be worth doing given the extra supply this part takes
(which you are currently missing by the look of it)

Other comments inline.

Thanks,

Jonathan

 
> ---
>  .../bindings/iio/light/brcm,apds9999.yaml     | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> new file mode 100644
> index 000000000000..b20ef3677670
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/brcm,apds9999.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Broadcom APDS-9999 Ambient Light Sensor
> +maintainers:
> +  - Jose A. Perez de Azpillaga <azpijr@gmail.com>
> +description: |
> +  Datasheet: https://docs.broadcom.com/docs/APDS-9999-DS
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,apds9999
blank line.  In general add some more above as well. Just follow style of
other similar files.

> +  reg:
> +    maxItems: 1
Blank line normal here.
> +  vdd-supply: true
and here
> +additionalProperties: false
and here
> +required:
> +  - compatible
> +  - reg
and here

Power supply should be required
Also you need to fully describe the part where possible. Here there
is an interrupt and a vcsel-supply by the look of it.

> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        light-sensor@52 {
> +            compatible = "brcm,apds9999";
> +            reg = <0x52>;
> +            vdd-supply = <&vdd_reg>;
> +        };
> +    };

