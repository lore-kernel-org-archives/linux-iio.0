Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA39623F40D;
	Wed,  1 Jul 2026 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870339; cv=none; b=PBFeDWjdUfrCHpLhgGyZEGauLMMhEqgBm+ycv+YQoEz4I89UdIIpzIHe2vY5LNieGQQz1MDNpychOtvXmzV3f0o4AoHiLCH68b5bXtrGAdOAfDcxboOhK+Cm2nBwjWx4gJASoJwtuWo92BxTCjbTObv5ZIUEd4tAQ5Zqt9SPNdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870339; c=relaxed/simple;
	bh=1AeLBQjozVGpARvL89v3o46dr2jO6zMJvZHerW1zbrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTDMQzspoRPoipDDRnQlSooZyUWfoX5bP1Xo4s/3zc8Et+nsHibFdmkGQvmDUth0cFQA+PLmWqNGNblUhvxPampNxN5/u4+Yzuqw4jvup0g65wSMC3TGP7Sz0m8U3iqwHw562+ZNq/tNfjpKbEe3G08MDIn5VEI/6AkuQiEtRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcEdo9TA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcEdo9TA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C1B1F000E9;
	Wed,  1 Jul 2026 01:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870338;
	bh=vS2FCRo1N9v6ZdiYKY8wR+oYYGUC31EvaCyaf5bbLwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mcEdo9TAFBMoIV5lSGa25ooiWQ8V50ijW65iUHTSiVHQErABu7Nz6/0qtsD6vin/q
	 jhfCm3H+09gjFZ6GrQBn1xEqqN3r+lhNjBDLFhKnXGiLwon3lN96etiKWuaeetbK5M
	 dW9ZmGnTPBGbJlyx4LbCE1zWv8aousKq3ASGk53YAIrwNwFs5pv7V4muJtz/dOiaAz
	 C7AZbOb1y0ZCU1s64FUhVF90NglX8N8Kn3OBjWx5rhoQyR+cYtwaGSvLi80g/72Imv
	 QHB9XZV91H+HcI/G22CVJHCQCBThQHQveqgFq8QqfZ5Smq/MJEuxYDczP1Gtr3ICBg
	 qqwH1WvfP1L7A==
Date: Wed, 1 Jul 2026 02:45:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH V15 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Message-ID: <20260701024532.3ad3712e@jic23-huawei>
In-Reply-To: <20260626161230.93069-3-macroalpha82@gmail.com>
References: <20260626161230.93069-1-macroalpha82@gmail.com>
	<20260626161230.93069-3-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 11:12:23 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the ICM42607 and ICM42607P inertial measurement unit.
> 
> This device is functionally very similar to the icm42600 series with a
> very different register layout. An interrupt is not required for this
> specific implementation and is not present on my test hardware
> (a 42607p).
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

A follow up on that sashiko thing from v14.
I think the requirement for interrupts is nonsense and it should not
be there for the other devices supported by the binding either.

> ---
>  .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 9b2af104f186..81b6e85decd5 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -30,6 +30,8 @@ properties:
>        - invensense,icm42600
>        - invensense,icm42602
>        - invensense,icm42605
> +      - invensense,icm42607
> +      - invensense,icm42607p
>        - invensense,icm42622
>        - invensense,icm42631
>        - invensense,icm42686
> @@ -67,10 +69,24 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>  
>  allOf:
>    - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - invensense,icm42600
> +              - invensense,icm42602
> +              - invensense,icm42605
> +              - invensense,icm42622
> +              - invensense,icm42631
> +              - invensense,icm42686
> +              - invensense,icm42688
> +    then:
> +      required:
> +        - interrupts

I missed this entirely until the sashiko related discussion on v14.
interrupts are almost never required for an IIO device. The only exception
I can think of is a device that only does events - and has no usecase without
interrupts, or where the interrupt is the signal - I think we have one device
where that is true.

So I think we can just drop this if block and never require interrupts.
It doesn't matter that the other driver does - that is not something we
need to reflect in the binding.

Jonathan


>  
>  unevaluatedProperties: false
>  

