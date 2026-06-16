Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30748366DC1;
	Tue, 16 Jun 2026 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614257; cv=none; b=uSWmdgZCvQh8+dThBv9f3n0/TKntC9xS1xTO/EDtexucTZWmUoxy1EtbNLRgZF3fIdC+M/Vrp+XnEO+8s8ACnLtF7DEivR3NUsUxIUuGBw4saVcf9oUqz836CPysoT148iAepFTSWK7BjYVF4dGqD0tPjzladcsNF8qaik+gvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614257; c=relaxed/simple;
	bh=WdTbRohIJp+J0+HovuDcRU1SvBGZVBR/rOte8Qw8fWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W47fJL3AJjfCr9olZaUq7ezU+/sike4uULzq8OX8UNyj3IkN11pNlfcu1Zhr5sv5L9Wb6o2ZcRLuwyb3Z8QeYSP4zHZj8pAv0czohOe/wf/JBq8KJ7ALexL+gV7j2PWgi3YE2hYYUMCNtAJZmSZSpKO7fiLDPJxnJGAsZMhHE5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjX0WWuW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjX0WWuW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26A81F000E9;
	Tue, 16 Jun 2026 12:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614255;
	bh=D/uL7ccNv8hLbk4DhZvmPMACt/+EDCqsBiFwWLvr/P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NjX0WWuWND5mig2GSR+jIBOMpvNc4iCmkL6fnsPATHzz3hgAwQZgGmqGICjg6uqIM
	 31ksKm9X0h7CUm4VpS5Rgr4yTva9DVQpTdR/bqYVyP9rblUQAH8upZ4Se4E7vgGpAn
	 TmsFpoVavrESWhH+bMBcPlLYj86boNTOoUrT0CSbBrUO2PrfVWoZX+LFPMVoHB0n2f
	 oW3L+BElmmPH0bPwt7HxOPpg5PKXGtQQcsA7/efMyFnS2lHT4LdqZRnN1u20n30cnv
	 9hKWI1cUT7iy6qUCeEXKS7uUDfSFftfIW3zm2uRSAyuk34/q1401kIJ+x9RFM+IijA
	 Zt+cWm7qRSXbA==
Date: Tue, 16 Jun 2026 07:50:52 -0500
From: Rob Herring <robh@kernel.org>
To: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <20260616125052.GA2147234-robh@kernel.org>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-2-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-2-f829fb7e9262@analog.com>

On Tue, Jun 16, 2026 at 09:21:08AM +0100, Rodrigo Alencar wrote:
> Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> property is deprecated, once it does not really exist as none of the
> devices describe any power input with that name. VCC is also misleading as
> it sounds like the input power supply, but it is being used as an external
> voltage reference, which should be called VREF. Certain devices require
> vref-supply to be available once an internal reference voltage is absent.
> For correct operation vdd and vlogic supplies are required.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 34 ++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index c55158c464fd..7b936824917e 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -33,9 +33,22 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vdd-supply:
> +    description: Input power supply.
> +
> +  vlogic-supply:
> +    description:
> +      Digital power supply. On some tiny package variants for single-channel
> +      devices, this supply is internally connected to vdd; in that case, specify
> +      this property with the same regulator as vdd.
> +
> +  vref-supply:
> +    description:
> +      Reference voltage supply. If not supplied the internal reference is used.
> +
>    vcc-supply:
> -    description: |
> -      The regulator supply for DAC reference voltage.
> +    deprecated: true
> +    description: Use vref-supply instead.
>  
>    reset-gpios:
>      description: Active-low RESET pin to reset the device.
> @@ -62,8 +75,21 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - vdd-supply
> +  - vlogic-supply
>  
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: adi,ad5693
> +              - const: adi,ad5694
> +              - const: adi,ad5696

enum rather than anyOf+const.

Rob
