Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A0E372663;
	Wed, 30 Sep 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770506; cv=none; b=Nt5KNu1PmFfv10Jv75R6wOnFyRB+zTtu4avQGA8TN829eDg414IEj9JBglxk3deh1jBrBwjZUbeygkxkiZPXIPAEK/B0hpq9JLUbkhJZ+LtvkYSuVZUuQPgqbSCi2w+xYFrJRhZNH4Z13XXe3R23RvFWtKHeWW7TkYmk0hlQzf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770506; c=relaxed/simple;
	bh=xv0RqiOiKwlaT0J82cr/0v5YvERfM3N4VNRX1rS/bg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/qqG0mlp3cFwIUbbfrxK31phJMLHa1DltfaWgrOTTuatS02Y0kyiMVgKeilHRTsRXWqjeAscI/hnboqWNY8nGvc4Ua25pkupM5cxgNQQDP7wGyKFJRhKfc8fb2r779XkdN4elHjSseHEOLvLRfQPJBdoU0Co19R6kIYEFwuFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9VxevWX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9VxevWX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55151F000FF;
	Wed, 30 Sep 2026 12:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770504;
	bh=Nc/fukDyXazndbYcPYi1K6bg0O60HvWUrSB7JCmYXcg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a9VxevWX5+tyC0lAYyQhbtuNuG60oulZbAJ18Kc7HkkaVy5TnineeBk6utelzOqIe
	 /rGKfA3+RMvNjbL5bEq0CArAuB23/raRAOUuLN7aSPo1WxTMzIerD5hW5YWgZtcg7k
	 ulzYB8vCEpasQ//khaB8A8V2q+pHqE8o0VC8OcF+oQ4XadEBvw3fNhlroGMmesvntm
	 OdMuY27shJHFHI+AATFV5nJvc28gbtgAH2PGkQg2xe8rqAU0tPe8dW4sGvaHmjYBaz
	 3ilkXEzXic6OhX0BfqNwOlwYntSF41nwRVgP7AOGyRVi5jV/XRZzpfYVZjZ96i78cG
	 f67do4nYc8DGA==
Date: Wed, 30 Sep 2026 07:15:02 -0500
From: Rob Herring <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com, jic23@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, andy@kernel.org,
	Michael.Hennerich@analog.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v3 08/13] dt-bindings: iio: adc: adi,ad4134: Document SPI
 connection mode
Message-ID: <20260930121502.GA2207237-robh@kernel.org>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e5af9d96f6c5e800ad860d3cfa6ac8006a22e2.1790719425.git.marcelo.schmitt@analog.com>

On Tue, Sep 29, 2026 at 07:44:22PM -0300, Marcelo Schmitt wrote:
> Document how AD4134 chips are connected to the host SPI controller
> according to different wiring configurations.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Adjusted spi-rx-bus-width constraints.
> 
> Unfortunately, I missed SPI connection mode properties when introducing AD4134
> dt-doc and the device driver defaulted to a no-CS configuration. Due to that,
> conventional 4-wire mode can't be made default without leading to a regression.
> Still, updating the SPI mode default to 4-wire is a sensible thing to do later
> on if acceptable.
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 51 ++++++++++++++++---
>  1 file changed, 44 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> index ea6d7e026419..0b2a2cbfadae 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
> @@ -131,6 +131,26 @@ properties:
>      enum: [ free-running, gated ]
>      default: gated
>  
> +  adi,spi-mode:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ no-cs, 4-wire, one-channel-chain, two-channel-chain ]
> +    default: no-cs
> +    description: |
> +      This property indicates the SPI wiring configuration.
> +      * no-cs: The datasheet calls this "minimum I/O mode". In this mode, the CS
> +        line is not used (tied to GND).
> +      * 4-wire: Specifies a conventional SPI wiring configuration.
> +      * one-channel-chain: In this mode, the DOUT0 line of one chip is connected
> +        to DOUT2 of the next chip upstream in the chain. Only the data interface
> +        of the upmost device in the stream is in direct connection with the
> +        digital host.
> +      * two-channel-chain: In this mode, the DOUT0 and DOUT1 lines of one chip
> +        are respectively connected to DOUT2 and DOUT3 of the next chip upstream
> +        in the chain. Only the data interface of the upmost device in the stream
> +        is in direct connection with the digital host.
> +
> +  '#daisy-chained-devices': true
> +
>  required:
>    - compatible
>    - reg
> @@ -141,13 +161,30 @@ required:
>    - clocks
>    - clock-names
>  
> -oneOf:
> -  - required:
> -      - ldoin-supply
> -  - required:
> -      - avdd1v8-supply
> -      - dvdd1v8-supply
> -      - clkvdd-supply
> +allOf:
> +  - oneOf:
> +      - required:
> +          - ldoin-supply
> +      - required:
> +          - avdd1v8-supply
> +          - dvdd1v8-supply
> +          - clkvdd-supply
> +
> +  - oneOf:
> +      - required: [adi,spi-mode, '#daisy-chained-devices']
> +        properties:
> +          adi,spi-mode:
> +            const: one-channel-chain
> +          spi-rx-bus-width:
> +            const: 1
> +      - required: [adi,spi-mode, '#daisy-chained-devices']
> +        properties:
> +          adi,spi-mode:
> +            const: two-channel-chain
> +          spi-rx-bus-width:
> +            const: 1, 1

This is not valid. I think it evaluates to a string. You want:

items:
  - const: 1
  - const: 1

Rob
