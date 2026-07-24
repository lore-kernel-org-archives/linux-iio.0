Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2D31A07B;
	Fri, 24 Jul 2026 23:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784934297; cv=none; b=P0bK0K+Q+2RTAsmw8u3g6kz/XIgIu/Ni5wfiM7kenir9LTY5bsJ+5HqP7er3pTDmUWPm0w18QHt0XHfTJn9YmrYT490t78cGBplk4sEQnmu19nO2Atv42cYi4ZJ+vBNUaD9JZmrDAeWJlxEw2KpmBibmVFkc+bbXGWVUhBirPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784934297; c=relaxed/simple;
	bh=YswN2yb4hyZpVp3JfyJZn1np+yu0ha3Xp40buFyCZig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BqpLhJULXK1uk8qQeH51mikSnwvEpk8nCeZrnwCzLYx5wfqeKC1JWOg7mYOHhkwwYrZ6e1Rq6LqGT130A+36ZPqWEVHJ3hHXQpB6fJLfnl/V0UALmnLdNBi7644zCswMDrkjfo1RWjSjbmIerKIHEtssSsaqgsFrcr/uJGaECDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzGKoVbR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzGKoVbR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E261F000E9;
	Fri, 24 Jul 2026 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784934296;
	bh=ksQFxE64qO54rNV34FZK8nV9gnk6ejElqDe/XL6zOJ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hzGKoVbRGeu6Au0fwV9ZwgR6/HYpkrtn+i9pvxqs6J+dUosfOVXlFT1YLs/vEyH9w
	 Idpv0fu/EWvLGY1eVZ+NIrx735roOks+Z3lxZW8B/kZlE8hJ27kwK/pSH+x6q5kK5w
	 Wk+kCSrjlmXApKjX6cFY67qvE2iaDxq94gz68iJnsVmAMJpHba13FF0iFVfe3f8dzI
	 +A5QdoWmhTbqYBuF6Clu5iZZnfgKJ683UaUgJn4gRWXYvHe92O5yjDChSO3eaOB2xl
	 yj3OqjMVQAtHF+gB8wH7/cLhphL8GDnkYnd5krrgt1qOc7RPD++rsLr/ESUV8hy1hT
	 kBDnpwUasv8SA==
Date: Sat, 25 Jul 2026 00:04:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for mcp47a1
Message-ID: <20260725000439.5ad6f4d1@jic23-huawei>
In-Reply-To: <20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
References: <20260721-mcp47a1-add-support-v1-0-da045a2567e3@gmail.com>
	<20260721-mcp47a1-add-support-v1-1-da045a2567e3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20260724230451.nH7nAZlVrz7XcuJtnM4SMO6_itM8Av2hlQ0N9tDEEjg@z>

On Tue, 21 Jul 2026 20:24:38 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converted
> which communicates via I2C.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47a1.yaml        | 56 ++++++++++++++++++++++
>  MAINTAINERS                                        |  6 +++
>  2 files changed, 62 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> new file mode 100644
> index 000000000000..3322fca03b3a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml

> +
> +examples:
> +  - |
> +    i2c {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          dac@2e {
> +              compatible = "microchip,mcp47a1";
> +              reg = <0x2e>;
> +              vref-supply = <&vref_regulator>;
> +              vdd-supply = <&vdd_regulator>;
> +          };
> +
> +          dac@3e {
> +              compatible = "microchip,mcp47a1";
Hi Joshua,

What is the advantage of the second example?  I'd drop it.

Thanks,

Jonathan

> +              reg = <0x3e>;
> +              vref-supply = <&vref_regulator>;
> +              vdd-supply = <&vdd_regulator>;
> +          };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1ec46c5919..b44693593b94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17699,6 +17699,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
>  F:	drivers/iio/adc/mcp3911.c
>  
> +MICROCHIP MCP47A1 DAC DRIVER
> +M:	Joshua Crofts <joshua.crofts1@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> +
>  MICROCHIP MCP9982 TEMPERATURE DRIVER
>  M:	Victor Duicu <victor.duicu@microchip.com>
>  L:	linux-hwmon@vger.kernel.org
> 

