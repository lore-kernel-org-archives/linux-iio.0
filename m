Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6613F351C22;
	Thu, 23 Apr 2026 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966455; cv=none; b=aP5Jg8uqBjVo3/fHZ+BaHd3g9j2sZ5N7cSrclE0NyZwKN3itrxZbBfWNw+27FFhrcbC2LPNjEbVNnT1sArWC1v7+yd0RuPOKTqq3EInLygd1W5A6y2RsB2z7yzUaKRfeRwWr7Nj955XBndotzAYBDuYX11cviQKqWjvCZDt4nTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966455; c=relaxed/simple;
	bh=drWxfBZSOVpa9kupE9PJ7W9/Yaa2usdxmvDAQDRpTmc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goeL7nBJoGeqGIIpz75+gYPqi1utj07TNM3gxi3PTzA4jLoMvzTlb2GvHG+JwBGnFZVszdd6ASg0xswStakUV67TwmeI1r0LOAUDjehsJMuJUmKndiHHnmyX2U45OZU00Rmc2wsXsGsmqq7i1UiiS4WOT1LkSHdvzkDdh0TQ3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBgmMBre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBgmMBre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4648EC2BCAF;
	Thu, 23 Apr 2026 17:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776966455;
	bh=drWxfBZSOVpa9kupE9PJ7W9/Yaa2usdxmvDAQDRpTmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBgmMBreJ87HdkKA4WawOgpUz8e6vhdsm6kjLhqTHMsXsWYnnFFOCCdrRvHtsD491
	 vOtoeRERs4KBE6wJaggL7zl0is7c1ygzQ5UN1NipxsEr4Jw/yTxodzAwaiwTn5XAmK
	 FeFf5kDVpqCCfVrEpvwEvTv8AlmLhre49+wTPgiSu5HZ/5GBniFjp9mjRdvX4DZexf
	 jJX4j85Y29inxwwEHfiqARG0WEWHx4Hvkd+uL2EonN56uMZnW2QqTEmc+mjHg8DvHh
	 RBKs3xwmE37kJTy6Oa+fFcJFV5GoaQfR7OaRa+DSmle+ZDEfx2sX2o5PYOxjJHV1Zt
	 c6+A4LpXf4gyg==
Date: Thu, 23 Apr 2026 18:47:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 03/22] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Message-ID: <20260423184723.54ddbd67@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-3-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-3-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:37 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> property is deprecated.

Please provide some information on why? Was it always just wrong and that
naming was never used for any of the supported parts?

> Certain devices require vref-supply to be
> available once an internal reference voltage is absent. Still, this patch
> does not add those as 'required' so that the ABI is not broken.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5696.yaml     | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> index f286e5072abc..21b80fe597d1 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
> @@ -38,9 +38,22 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  vdd-supply:
> +    description: Input power supply.
> +
> +  vlogic-supply:
> +    description:
> +      Digital power supply. If not supplied, it is assumed to be the same as
> +      vdd-supply. VLOGIC may be hardwired to VDD in some board designs or
> +      internally connected in small packages.
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
> @@ -88,7 +101,9 @@ examples:
>        ad5696: dac@0 {
>          compatible = "adi,ad5696";
>          reg = <0>;
> -        vcc-supply = <&dac_vref>;
> +        vdd-supply = <&dac_vdd>;
> +        vlogic-supply = <&dac_vlogic>;
> +        vref-supply = <&dac_vref>;
>          ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
>        };
>      };
> 

