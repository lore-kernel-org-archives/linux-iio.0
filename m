Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53478376A0A;
	Fri, 21 Aug 2026 07:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787297227; cv=none; b=HepbnbBJqZBUcNeyPus+JzRfy3NBTMNW1hfZ0oBUMmQYnQkXbSv6+c7q3WTC+AbEwJ0wYkH5B2gb3iKutSuTNV4+jqwIAYzd59RIRdXw/zH6rF66zO6N/93n06TFpZ1QRnREb6Ygr/fwJrlhKkzpwOk9enj+TZlvOei4x0pVW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787297227; c=relaxed/simple;
	bh=h7rFeYUaGNKZrBJCb7xToyMjMwWljlaz038Kr5v1tpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeXxMTIqq66sn4JOTHZW/Y3gU7K9epKsyoAm9Wf6iH0hD6OdZze98VjZ8ty/3sIfhIxW+EKheVNYHuredEha5rbWBLM1mtzXp8iQWFdtRq1yDcVFfG4km0YaCoYSAhOpa5swob749tfANftoHdjdamlFpAJrVWn3+/NOi29flaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWVtrVHs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWVtrVHs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B11F000E9;
	Fri, 21 Aug 2026 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787297225;
	bh=yUdIZCjzGdQCUoVnSmJ5ekBkqW8+FEP5GNixuQZzy7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eWVtrVHsQR9xJOfNnb79lgmzA0sUhKpRNHGY2f51sjp4udKyWjKXlkTW6M4yD784i
	 4fzySkyox3pzR3qkj09hvX/UMSGfaQhO+NnLtFYuYj2biw/YiXqtJ16LxxAYumygx1
	 oQxziV5j0xAu5d6vXYCiIt0aE93BY6yMNjFPmnY93XRyO45otuwH/rZSipA4jUqdF0
	 /xNQBbpMutPguzUXjU6b/gA3kHFQ8VhlKIU7ir+3kE+YRMCfNn4t2xGYnEruQLmkRX
	 bNHVw4LKQNwWbWjEJXAcAFc/ZKfoFQIhaZbOVfPGV/ohRvserZFOreUY6H85vqH2w+
	 0IxoniNoLH2tw==
Date: Fri, 21 Aug 2026 09:27:01 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vladislav Leonov <vlad@zlab.su>
Cc: Jonathan Cameron <jic23@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Simon Glass <sjg@chromium.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: rockchip-saradc: Fix RV1106
 compatible
Message-ID: <20260821-bouncy-sticky-dalmatian-4f72c2@quoll>
References: <20260816113636.33635-1-vlad@zlab.su>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816113636.33635-1-vlad@zlab.su>

On Sun, Aug 16, 2026 at 02:36:36PM +0300, Vladislav Leonov wrote:
> rockchip,rv1106-saradc was folded into the fallback enum together
> with rockchip,rk3576-saradc, falling back to rockchip,rk3588-saradc.
> The two IP blocks are not equivalent, though: per the RV1106 TRM v0.3,
> chapter 20 (SAR-ADC), RV1106 only has 2 channels at 10-bit resolution,
> versus 8 channels at 12-bit on RK3588. Documenting it as falling back
> to rk3588-saradc allows device trees that would bind against the wrong
> channel table and report an incorrect voltage scale.
> 
> Remove rockchip,rv1106-saradc from the RK3588 fallback enum and give
> it its own standalone compatible entry, matching the dedicated match
> table entry added by the driver patch.
> 
> Fixes: bdba14f6122c ("dt-bindings: iio: adc: rockchip-saradc: Add RV1106 compatible")
> Link: https://lore.kernel.org/all/20260810090826.146758-1-vlad@zlab.su
> Signed-off-by: Vladislav Leonov <vlad@zlab.su>
> ---
>  .../devicetree/bindings/iio/adc/rockchip-saradc.yaml         | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> index f0551d665916..dc56855527b8 100644
> --- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.yaml
> @@ -22,9 +22,7 @@ properties:
>        - const: rockchip,rk3562-saradc
>        - const: rockchip,rk3588-saradc
>        - items:
> -          - enum:
> -              - rockchip,rk3576-saradc
> -              - rockchip,rv1106-saradc
> +          - const: rockchip,rk3576-saradc
>            - const: rockchip,rk3588-saradc
>        - items:
>            - enum:
> @@ -35,6 +33,7 @@ properties:
>                - rockchip,rv1108-saradc
>                - rockchip,rv1126-saradc
>            - const: rockchip,rk3399-saradc
> +      - const: rockchip,rv1106-saradc

So this goes to an enum with all the other single-entries.

Anyway, where is a driver binding to above compatible (see DT submitting
patches). git grep on a week old next gave me nothing.

Best regards,
Krzysztof

