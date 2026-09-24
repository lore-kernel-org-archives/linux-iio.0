Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59AE47DF9B;
	Thu, 24 Sep 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790251576; cv=none; b=CJF6SR6elxQ9xhVdtlROwUsdJUbVzDE1OyBRDKZh8sU5UczPhOwfH07ADY7FDyJFA+xbt+DnhZE4fxB1iN9GtAcH56c5O7XiURk2WmckpyessQtD3A92v2g3k+Wm9c7kfC+U7+6NqRmKHiWjndQqPfdpbH1h25Kolndtf/d0AFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790251576; c=relaxed/simple;
	bh=HeUaHytR2Ny8G7lalHxUgGrqgTcsuuwdRy3p0d5VQIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XB3xzXVC5i32j/6ALizR6xgZSDohiXfTcHa6ahNyCwtbHebg9ZQfHuFqGqMjs+T9pKay13KMy0vB/JefJVD2/+wz7qykrD8U8jrKAdXn/5qTPSqo1sxabmUEHX28GqnlYE/rN9iDqcd1WsxKjRw+j9aGQy8lKRk9rDMOECgaklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCwRACh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCwRACh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78AB21F00893;
	Thu, 24 Sep 2026 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790251574;
	bh=ft+OTCES8ugvjkrYuU/qZLvMsblsf5K47aGXq7gU7cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RCwRACh+iJhhqvlt9Qar7j4l8eYQ15/7ck+6CFCU+l01gPu0DvkTsZO4xtegvyA+H
	 RGHM/E/UQeieIqmMplyK2wBpTmu2+Io2a7yw4mJNCFi9ZQXA0r67B6DEp9xNz4dqIC
	 s0738sWCmQdf/0vyD6TKMJp0u8V4hbzE3hy/uG19MMSUhs+EErpH9hD4P5WSuj3BUp
	 kpDwe2YXiXGTqH1g1yXWHb93SjMTyC6r424gjGTpTzuNjCpINfW1yyQLCf2DDCufYE
	 tRYjvH5wbE/7LcUda7FZr1t6ffzxBcKy3MGgKVnSXH0I1lJccXM4wpbVb0FFSuTChp
	 3BoCmqPwoEO0A==
Date: Thu, 24 Sep 2026 14:06:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, mfd@lists.linux.dev, 
	Roman Vivchar <rva333@protonmail.com>, Luca Leonardo Scorcia <l.scorcia@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: adc: mediatek,mt6359-auxadc:
 add mt6397 PMIC AUXADC
Message-ID: <20260924-brass-kraken-from-uranus-cbbe5f@quoll>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
 <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-1-c00edacbee64@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-1-c00edacbee64@gmail.com>

On Sun, Sep 20, 2026 at 12:31:51AM -0500, Ryan Brue wrote:
> The MediaTek mt6397 PMIC includes a 10-bit AUXADC used for battery voltage
> and battery temperature measurements. It is not register compatible with
> mt6359: a conversion is requested by writing a channel number to a select
> field and pulsing an edge triggered start bit rather than by setting the
> channel's bit in a request register, and the results live elsewhere.
> It therefore gets its own compatible rather than a fallback.
> 
> Add the binding and the header naming the channels a consumer puts in
> io-channels. The battery channel is named for the input it measures,
> ISENSE, which is what mt6323-auxadc calls the same input.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
>  .../devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml      | 1 +
>  MAINTAINERS                                                      | 6 ++++++
>  include/dt-bindings/iio/adc/mediatek,mt6397-auxadc.h             | 9 +++++++++
>  3 files changed, 16 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

