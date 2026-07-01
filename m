Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CBD191F91;
	Wed,  1 Jul 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870351; cv=none; b=LKpH7ZDIQbCZ8uGO9qlI4DA9yk4NU6YrlWQxlTNd6zoVWmFnAMQq5R99/z+gJBhmQjTp80eONXMsIn6Gwum3NfXpod2ay0lMVZT/bc9R1b/N11Ji9Qs80YVKJxJJU2Esoo55L0cT1Ok4zqauGUTSECNS9UuAmuUVKzSiMcteBbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870351; c=relaxed/simple;
	bh=1AeLBQjozVGpARvL89v3o46dr2jO6zMJvZHerW1zbrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p2rYLGDorzEeFF/Ra/k8jpnsLe7qvn+BEl93gbeEpUB9+f53xOXGzRA23YF39jmVtznrqoLnNMgZ8VarJZXLQK2zlEKdPdtL4uVyQPVaT7GEECyY8Wh5JMPvlavWHx94TCUAIJVPVquynRb/zRuR+DVXlXn01ToLpwW/xhYRHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngZx6fJc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngZx6fJc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AC61F000E9;
	Wed,  1 Jul 2026 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782870350;
	bh=vS2FCRo1N9v6ZdiYKY8wR+oYYGUC31EvaCyaf5bbLwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ngZx6fJc90korLaSesRc5fXUEQdYVY96saS7Sdoy0ukfkgNjOWFhCePCriBcqgxt9
	 zyDbAGB+SYeBT7P5rdmPoJ3CEJsaoF+c4hUmXkZGNvjN2ZJAgCmoOKraHsiT7EqH5z
	 ZMIeCLXFgffbw90ETamDvEvKgchELWLkfovLNbU8oDssJswukR4c20FOquGY+WdYJb
	 4ks4kqwVM1VDuNGZMykpCCEZg600OwObI+WCOb+PjG+WR2cLHhaHyKEHOZqVW5L1og
	 wPCHYupCBnV5AXE+XUR7vSlWI+53ynh9ECbUlpXhhIJiqbfaXGc2vbvVf0l3h02UMY
	 AamL/3nDVDShA==
Date: Wed, 1 Jul 2026 02:45:45 +0100
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
Message-ID: <20260701014545.BI-mltBbi8z8pL98EX0zDKw8H4JPJhiLQZlK-euOOhY@z>

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

