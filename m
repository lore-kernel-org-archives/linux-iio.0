Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EB3369D66;
	Tue, 16 Jun 2026 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614132; cv=none; b=JHWi40DEseAfAj6HEVmyUGJ5eyONiyO8mbFZAk/A2E8ekSXM0LTj1uehxzBDRz4MvSljE+JvfGIibMURVn+kT/ptqr0JnJZ9wMGT7zl82+0sBJUTrHt2pujPOdL1jDjHd0RHHszrP+rhTovmT7YxsNvJc2w1eQUJHxTSTvkvDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614132; c=relaxed/simple;
	bh=ptlGfy/lUDXS6Kd6BftR6iAAChpLwjOXNMssQw7so4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQCSV6GOBmxhWyJu4QamOMl4B2Hmy5LaSNK052E8d2Bsml2I5ksHkMqSZah1Jzb+tJBXc7s9fmf+/tA4dFL95vvpDqmxMerkWD1ssX94GQgjxvIQN+KWRXrCCWb7lbxa+MVhMhQ973bn76/aL7AB5k9v87185rns9M+9toykYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLovY09p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLovY09p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CA41F000E9;
	Tue, 16 Jun 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781614131;
	bh=BCDH1/TFXIBzrlHpB57SMH7DJDpo4r6QcyhDMjLB3vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GLovY09pAx/Y2NhjWy7LCjpFRVrMY9Q3gmMJ77NlU+z6mQjS8EbT08ibXjbKjxyMw
	 E12umMiG8lchyDgoY99NYcX8DwEvM305yxo11f79q3VNLjFVRVO21OKUClrkNerX+6
	 8x3JyFlJ0dtLqGwkNiiDaN56k8S5bt4jcx7xshWaT09QPbVLiFx9+tO+S1gMIIYp5c
	 cVszUHYQWf1toplkypkJrEkiyOAYzVb0GVGj+AHNo5KpalRl9upz9rEhGdxVAN9Q/r
	 dE0RnMy0GwuePXEJVmhewWo4GELsEilgN5buiFTG2364SKMLrAwl+LZK8JzhUdDy+J
	 dtsVGWEFidhEQ==
Date: Tue, 16 Jun 2026 07:48:47 -0500
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
Subject: Re: [PATCH v3 01/12] dt-bindings: iio: dac: ad5696: add
 reset/ldac/gain support
Message-ID: <20260616124847.GA2142515-robh@kernel.org>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-1-f829fb7e9262@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616-ad5686-new-features-v3-1-f829fb7e9262@analog.com>

On Tue, Jun 16, 2026 at 09:21:07AM +0100, Rodrigo Alencar wrote:
> Add GPIO property for RESET, LDAC and GAIN pin. RESET is active-low, LDAC
> is used to load DAC channels with values from input registers and GAIN
> can double the voltage in output channels. The gain-gpios property is
> not available to all supported parts. The adi,range-double property
> indicates that GAIN pin is hardwired to high in case gain-gpios is not
> set, otherwise it sets the initial value for the gain setting.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 41 +++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index b5a88b03dc2f..c55158c464fd 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -37,14 +37,52 @@ properties:
>      description: |
>        The regulator supply for DAC reference voltage.
>  
> +  reset-gpios:
> +    description: Active-low RESET pin to reset the device.
> +    maxItems: 1
> +
> +  ldac-gpios:
> +    description:
> +      Active-low LDAC pin used to asynchronously update the DAC channels.
> +    maxItems: 1
> +
> +  gain-gpios:
> +    description:
> +      GAIN pin that sets a multiplier for the DAC output voltage. When high,
> +      the DAC output voltage is multiplied by 2, otherwise it is unchanged.
> +    maxItems: 1
> +
> +  adi,range-double:
> +    description:
> +      Sets the initial voltage output range from 0 to 2xVREF. On devices that
> +      have a GAIN pin and no gain-gpios property is set, this indicates the pin
> +      is hardwired high.
> +    type: boolean
> +
>  required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            anyOf:
> +              - const: adi,ad5311r
> +              - const: adi,ad5691r
> +              - const: adi,ad5692r
> +              - const: adi,ad5693
> +              - const: adi,ad5693r

Just 'enum' instead of anyOf+const.

> +    then:
> +      properties:
> +        gain-gpios: false
> +
> +unevaluatedProperties: false

sashiko is correct. No need for unevaluatedProperties here.

Rob
