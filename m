Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566800;
	b=m5eDrd/J9LDcEnKFtVnjHY1PhRbghMMjaJBeprBLyUUyVroMhx8dYdqzIyaHfBvamJ+r
	 6fzqAlD+MaR1vUm69O7nNNqM4PatAdWdiE7tssv4eN7tu80C7KxC+ilslAD6yVZPhxp5l
	 7tvOttbTF9Mdq7yFaPV/KMjn6wkLnIN/PT/tIIwmOEvwxh7RRVqD3Sh383k9f1Q9JDIh1
	 gqfYFdAwAH596QCK3IlvTZKGhuQx5iDw5qktatqAQ9QC2v+zJH5QLuU7DgRgrWI4Dfg6I
	 mPf8KQW/H3+i3+s0tr8N45gZH4uJTfYt9l8iQhOR0BGLSRSWkUZJqFt8liTKOwf3waA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566800;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XczvsKfXdTFmV2DxL3CKTLf3/akob6g9zYogIKwkEhs=;
	b=Jsg/ba/nIhyaOT9+nMFVWnci2kIyGAzO90GtgQqeJVKuZEjKMevzHzzrZ3TPb3DCIRNr
	 gDDVGQcDrxApNa9wHrejd0k6tqKn10He+lIHRbCixn7Jk3eo3qgk3IZyKZOCilmPLWwYX
	 HCPqeHHmhMnrwWfe76vVV1uz2EY7CC7aIiAG1uZNuydtvEYxKMT3NQm31cGDKI6l0ILL1
	 pFtiJfnZ8zwckcvOKcrlg6MGOu5dznVj47/kQ5k/rjwZKRoKIamcNqKbb9g0yPUX1ouhU
	 RqPUPIrRTxNe94Fx1p3rzWo+3Px++Wj7sL7q4Aonm82K55tsRxQ0hyMz3B3KGtSh0JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7QF+2dy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346C606A31C;
	Fri, 13 Nov 2026 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d7QF+2dy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052211F000C4;
	Fri, 13 Nov 2026 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794566800;
	bh=XczvsKfXdTFmV2DxL3CKTLf3/akob6g9zYogIKwkEhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d7QF+2dytAP776yfunWBlKYTgAtsWDIDtZXMZyS4/VuR+GhWurzUlZicXFhiGrS/x
	 42pv++p06ej1a9Sf1mRh01LI26X9fYat/YsFnILpbndEgsxBSEgmssVbngbOZ0CI8L
	 KsDNTtlEv0JZb2JMFyj4p9dF+ENib/nIAuKzbvcMlYYbALFvyD2nQHBUwhQbuwCT4L
	 VJoFbz7r2pI7/pUHgFK8rCt92Qhu1xF8AcKKsIRJoBN3iUXTGhBzy5Sa33ZXOi5UBk
	 D62L8nTjIgz5OElv+owJJgrSLsMTQKUD/DfWTYAytUSHELfW8VBb1LkL4eoZQjD9gt
	 BCoq6svkonaFg==
Date: Fri, 13 Nov 2026 11:46:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: lltc,ltc2497: Make vref-supply
 optional for LTC2305/LTC2309
Message-ID: <20261113-zircon-taipan-of-health-d4170d@quoll>
References: <20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com>

On Tue, Nov 10, 2026 at 04:42:59PM +0800, Kyle Hsieh wrote:
> The LTC2305 and LTC2309 have an internal 4.096V reference, so their REF
> pin does not need to be driven by an external supply. The LTC2497 and
> LTC2499 have no internal reference and require one.
> 
> Only require vref-supply for the LTC2497 and LTC2499, so boards using
> the internal reference can be described without a dummy regulator.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> The ltc2309 driver already uses the internal reference when vref-supply
> is absent. This is needed by the Meta Ventura2 BMC devicetree, which
> describes LTC2305 ADCs that use their internal reference:
> https://lore.kernel.org/all/20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com/
> ---
>  .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml      | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index 4df5aadd1e1d..22abc6885b5a 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -47,14 +47,28 @@ properties:
>        - lltc,ltc2499
>  
>    reg: true
> -  vref-supply: true

Blank line

> +  vref-supply:
> +    description:
> +      Reference voltage supply. The LTC2305 and LTC2309 have an internal
> +      4.096V reference which is used when this property is absent.

Blank line here as well.

>    "#io-channel-cells":
>      const: 1

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

