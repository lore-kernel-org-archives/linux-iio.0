Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27310334C39;
	Sun, 13 Sep 2026 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342349; cv=none; b=YLCrsK++2Ky69jEG6eVCCcpF8qciKzl+7pLDAjP07GcPJlLnvQG86AdSnGT2jPM4Z5JQbbgrTqCsLwLVrkvusnZTSO9IxYNf80SwLJbJKqEboCOi/nzkx4CXw5auzbavQLIggQoNJpZ/vOMh0hQWdBB5SSyMfjWIqSbRedy0Ljc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342349; c=relaxed/simple;
	bh=OpAyLekwhiW4ygtDd4G9l/WBcYi1nDRlWCITe8lKiJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGT+qtUgQEmhFaxlBSb7l/bs2FKBKU/zLzsA2IoCrMipV7M9Q8lLs81KEBKD276Hs4ddax1LUncwWk0NWYdrYAaKHG4EPc5nmgZxD9bryRlZl6bAJM/M7YMoSMkierBq7RKDks/CsLl8JUZKXd81tTq0NcY2RyosEc4gxXZ2cZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yq/+Esnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yq/+Esnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D9A1F000FF;
	Sun, 13 Sep 2026 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789342347;
	bh=Ys5iACeya2xI8St6gjTY2DbZlM+LA1KDlI0TMxzHFmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yq/+EsnjsWqFqit4NdfM94Nc6t4XS9M2Go6waunVuAgXzY/CZJEWgVMBQr69jRp+L
	 yZZojL3KpgJ3DkJYTa3Ve9Rx3f/GQ03jcsqyKdEcAJ5u0w9P+WQp6wb2+VW3JbOf9y
	 x1vdTuYWzkXsp7MvqjKS7ghmstzBlxrAkfiDiK6B+tNwEF2N+hqlXjBnueg/TzXdjr
	 D3n8wU3zye+0RdrYQcool22rsUIp8sQTMER5cJ6YRhdazGO1pHJt5w1+76BqPN37zj
	 tz9HMOddiaNTO2SOMdjUtijyTPKU6tflsV9hvqQOvopAAFiMCO2aV+qnxe43digntf
	 2aqEKYDExiWDQ==
Date: Mon, 14 Sep 2026 00:32:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: iio: adc: lltc,ltc2497: add LTC2499
 to title
Message-ID: <20260914003221.746d6f2b@jic23-hlaptop>
In-Reply-To: <20260909082755.366269-2-andrei.stancovici@analog.com>
References: <20260909082755.366269-1-andrei.stancovici@analog.com>
	<20260909082755.366269-2-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Sep 2026 11:27:50 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The LTC2499 is already listed in the compatible enum and covered by the
> description, but was missing from the binding title. Add it so the title
> matches the set of devices the schema documents. No schema or property
> change is needed.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
> Changes in v4:
> - No change.
> 
>  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> index c884b6e03767..8aa1ba0a8728 100644
> --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
> +title: Linear Technology / Analog Devices LTC2497, LTC2499 and LTC2309 ADC

Sashiko correctly points out the LTC2305 is also supported but not in the title.
Can we give up on this and just make it "LTC2497 and similar" like we tend
to always end up doing in bindings with a large number of supported parts.
Keep the full list for later in the doc.

>  
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>

