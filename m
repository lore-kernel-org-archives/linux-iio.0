Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F923A2540;
	Sat, 17 Oct 2026 18:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260172; cv=none; b=SE2t9jMyseAWUokI5RSmDkNBzIPWvNx3TzcLBzneFeDsTlndfDOYLMzF/EcUl0x7hbIWBzbN8Y+0eE6flfSUfc2BFaBWA5kYVMdGkqVtfnJBuom2wnB6e69gGCaiWlk4bnW4PLKtE01Kju5h7jdGD/RXLQlFB8jCAT7Co8iVLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260172; c=relaxed/simple;
	bh=K5CQW9KMZh4n/IaCHOSjYnbprWVSvLY5XH52Y8qdg0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k1QmXR1Y5A5MdyqOgFeNDaMqLvYqtIjToNJDBAaTjSef4xnGsdRoyMLJwINj5aurM65QxwgqgfJb8EwmzERoDphKPRjJUTIP+jwSIGRn2OOwV4fFxpraC1dY36YMI4WeU8Axxp6ASQ/cgl4Nd9Zp55SZhdyNy9HXqLwvuqWKELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMfDXvS7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMfDXvS7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29161F000C5;
	Sat, 17 Oct 2026 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792260171;
	bh=AvwTybRucX4YEWHZ5kNNl+AY2yjPsmV1vHIOnygHf8Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LMfDXvS7/QFZ1URVM5WXC+rIUCx55LF5JsXE3Q2ruNDtifnoegBu6l8ueqPSvyOo+
	 M9ngnzXLxFbli19PX6uyPwAYZLQ+MCWycvL1DUN2XwooQk5eDxNXgdWSMUI2uRcJz9
	 Q5CRDgzTVpw/zr8ORUocPnXrQ0jjP9OCKODGnAZl36BdAeXE+YYuwaGyTMSUhEG8Lf
	 LS5ZwTgYw4ZyZotzYPCPBNIgXmhfosmFjPysasMOkDOAoCvzD/o9DO4beYGZN/ayt0
	 eqX71XuZUfDM4x8DIuYLamgl2qWNjL7Dl7UD+jxzyFuY4oG9UOVPbBgjiLb2oSE4VJ
	 HuvxUMnc6Uqeg==
Date: Sat, 17 Oct 2026 19:02:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: gp2ap002: add vled
Message-ID: <20261017190244.26e61b63@jic23-hlaptop>
In-Reply-To: <20261017-iio-light-gp2ap002-v2-1-d6879767a446@rudorff.com>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
	<20261017-iio-light-gp2ap002-v2-1-d6879767a446@rudorff.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 19:27:41 +0200
Christoph Rudorff <chris@rudorff.com> wrote:

> According to datasheet page 8 "Recommended external circuit",
> it can have tree supplies: vio, vdd and vled. As vdd and vled wants the
> same voltage, they may be connected to a single supply.
> 
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>
> ---
>  Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> index 99bddf31cbed..f5b2c6a4d7e3 100644
> --- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> @@ -33,6 +33,10 @@ properties:
>    vio-supply:
>      description: VIO power supply a phandle to a regulator
>  
> +  vled-supply:
> +    description: LED power supply a phandle to a regulator
> +      Optional. It may already be connected to VDD.
That's a board wiring thing - the DT really should have just listed
that supply twice.  So drop the optional bit.  We can leave
it as not being in required for historical reasons but no need
to call out that is is optional here!

Given confusion on v1, I'd mention it is the pin called LEDA even though
the supply is called vled on page 8.

Thanks,

Jonathan

> +
>    io-channels:
>      maxItems: 1
>      description: ALSOUT ADC channel to read the ambient light
> 

