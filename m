Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2F33BBA7;
	Sat, 28 Feb 2026 11:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772277537; cv=none; b=iNbyupxfWWQ6NF93kXZSb5mvc2S5iRcZYLj2wQVVRmgRBqiVoOUz0J3NtIGEszlMB67X6zkebibLw9OWA+oxDw2jxzuW3WA+ojdtCdWV05WHUWLAE2MjNN++QRk+Jbkvu4UPU4t8R6j9bOP35anDcBbAp9OBBabXj5s5QoO2KW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772277537; c=relaxed/simple;
	bh=9WvqtL0XRV/J/pFOTM/obGeTWs649hf3DIq3OlXX5TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ztx7Jn08NQi3tnQjIz8YqOEogx3xnTqedYeaPo4tDnTBmHgk3PS8lgy17mrkc4jWUuf+eSNn5A2xVKAg6lOuKKNOF/FA+BB3LFNeui4p5FRTK3lFoccimUC2L8hN6zTPD/F8OC+x4o3K2H4jqww4YxBi52dYORE5zJZY+hjTYPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8aOAgZd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8aOAgZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FA0C116D0;
	Sat, 28 Feb 2026 11:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772277537;
	bh=9WvqtL0XRV/J/pFOTM/obGeTWs649hf3DIq3OlXX5TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8aOAgZdcBT0lhMCNjBtv4dov7hucHpzamAk3cZZDONjkSHwTTMu99ppcHbajMMlN
	 qu15pRxP74PXrh+pgClDDR0SWY3MRbuswvqii29p3QHupChnjHJs3FYW1sZJbit7qP
	 Szr4qGs2pBWJ3SKaP+WoszMEW8+B/ZX339Qh+ctDjRgk9WX/XQxtOdA9xXqYtcBrjc
	 rbEsMU8o8qVs0WA71SlY8y6tDgYKTtYge2hrx0nARpgWTWD0d94RMTPyPhysmN9ovY
	 Q7ZjQGSuQHV/mqk7wjLLeC5W4PnDb/p2sGwlxfNNmw7LG9heLuRcs3ur+JViltGbDS
	 3z5ufnKh0lQ1w==
Date: Sat, 28 Feb 2026 12:18:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Xie <nick@khadas.com>
Cc: neil.armstrong@linaro.org, khilman@baylibre.com, 
	martin.blumenstingl@googlemail.com, jbrunet@baylibre.com, krzk+dt@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	robh@kernel.org, conor+dt@kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieqinick@gmail.com
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
Message-ID: <20260228-quirky-lemon-reindeer-1045f6@quoll>
References: <20260228065840.702651-1-nick@khadas.com>
 <20260228065840.702651-2-nick@khadas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260228065840.702651-2-nick@khadas.com>

On Sat, Feb 28, 2026 at 02:58:37PM +0800, Nick Xie wrote:
> Add the compatible string for the SARADC (Successive Approximation
> Register ADC) IP block found in the Amlogic Meson S4 SoC.

... which is fully compatible with g12a?

Write proper explanations.

> 
> Signed-off-by: Nick Xie <nick@khadas.com>
> ---
>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index bb9825e7346dd..5496a0dc714aa 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -27,6 +27,7 @@ properties:
>                - amlogic,meson-gxm-saradc
>                - amlogic,meson-axg-saradc
>                - amlogic,meson-g12a-saradc
> +              - amlogic,meson-s4-saradc

If this is compatible with other device, you need proper fallback.

>            - const: amlogic,meson-saradc

And this one is now kind of fake - how does this device use it?

Best regards,
Krzysztof

