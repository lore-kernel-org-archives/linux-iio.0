Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793779763;
	b=wmDMu4BHDoks/jAnZWUelkbMlKfwDIgLJSJwI1hqIQLVKFwqunYlWxRu/yd1W3fbRFZg
	 oUuMd0/2Tt9lWkYNx5sCn5SbINwNz6oUbHA/C0jn2400G1AiHDHxTPQooh8A3WFkZVHxa
	 Ye7xQ0iZ86oZEXtP9HxMibeBtI7ECSChi3sf9JfEEiOwA8iG2hANoRIOuPJhlC2Z47MSn
	 9uQ38Hzi0x4d3/KbkQoz/WTJcxxDnVBxU/ZZXKJLnf+Tl+/qeERh292xU8oG9wOHaVm6/
	 tUS8XJ0E+pyC5AI/WRP/tycCUMFRvk4rtTX1OLcUwG/326TaHoGnitPsoaC8P27Jffw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779763;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D3rpizKg9tVnjRCzjSz+putMSv33a6JsQ1St6jLrI3o=;
	b=HglGGDqOwqKhtGLTdA0p0SjtubJbqTQKA63GBaFoJgAUMb8NskgSPKUEcZdy2baDNwSf
	 ET9OUmq5BdtyjYmLuDCDaLYWzbCZssVEDq7Sb4oTH3gQXIA+tU7/ZKoKX+P1WUc8wTlRz
	 GlCmPOPyJun3hLDzTJRpcH4a9okeCScOQ35wAeK7CtJ+/KkH6GWm3yAtbC741ibFKbfzR
	 0L6023dv9Cq17TUMwygJncfbwSKLr3zCyHM2tO3ZWJyUgUQGVg5AEvYUYLgJjxTXGF8Cj
	 /jxSY1RwQ3QiyYSlLR2KwQusxUSWAz6hVH4svgN8XzgGZLfNsrPapNgLiRcaxtMGLWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JG6/EEHQ";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61126606A329;
	Wed,  4 Nov 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JG6/EEHQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793779763;
	b=zI+lI7d6/9MGJPzvkuKuSXzQbAVcVnWhHw+rYb0Pxe+5x1Mf8elVx4+kAdmlD52y+Ypm
	 CfyxGBicSdGnyBw8Fvf1JbN0Ro16DL6fgGNABGzk3gL8yp1fZHm9mlqxXvk0wIuf4bvHl
	 KQBOX1xZuxCVnhOgeOYvoyPRdR/EMIlDQw+SHtry/wVCSfc2LwmW/cpxquwICnMUwaj5m
	 SBMLlHvT2JTVKC4btIVFN2jcrRCGs7jswysa9CyTu8hwN1Q5aJ+ViA0PnQ1g4YB44qG3H
	 LIP/Dx79ysUbZnP+joErX7ksLUYzsE7pEvWPuC/WhbgqHLAcXILAxOW0+jLRog1RuBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793779763;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=D3rpizKg9tVnjRCzjSz+putMSv33a6JsQ1St6jLrI3o=;
	b=moK5RAGlGwIMZyGvhQ4NAAwSC2zzLLbBKU+b14C7qyf6aF7sjcUs+AeG6pig0TYxtelD
	 9FEcHtLmqhRnXKXAxhGXHuzyGjB3dNEe/2BXstZulaimTT05uhVQhVX6Rr3oqqnUavvWB
	 hXw/iA1l22aiThgebP/o3VE6V9awXyMse/kjbGD/L1h2sWI9Qdjs7o0pi94Qo+mQOFT/9
	 kyTnHGipPUBwmH2nxA3p5SOG41Q9NKYsYWFxRzUZ14xf9PJdGKifryHb7ChYdE2uzUfby
	 VdyHQUQMUNsxr33vvnUxjRglRQud8GIrI7NkLRwVnXydLsubBq5EYnErK8s7LGW/roA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 3E7881F000C1;
	Wed,  4 Nov 2026 08:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793779762;
	bh=D3rpizKg9tVnjRCzjSz+putMSv33a6JsQ1St6jLrI3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JG6/EEHQobu8X1YvcxdpD3gEG2Q2GsQ22VzS0IhM62pq9a6iHPOYpxSVAAS+7xsvf
	 Nl2LFYLUABeuq+3XVap26L/AtK8PwnxXV/mmVKw99uQ0yGOBL2vvYfzosLU+mKgNbO
	 r1r5cuEktEEHAYm32R9tpYKlYhvOOaBNlHEswH4PGGfpORYZcWP/1hWSTkJKENG0il
	 CaBjLoRaqq8NhXHbnZAVphgIarfd2qAq7VseA/nSQXuCOYy+LG7TYo9FL/o4A/s5Kr
	 Lo7BHDsN6dBHqTfLLiPJb3L1Uhi5RZoYl+dQjSt8tYMnj88WV9wAtGM97+fiYFBwxi
	 X5XJKlrcIkuGA==
Date: Wed, 4 Nov 2026 09:09:15 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4134: Fix duplicate data_read mux state
 request
Message-ID: <20261104090915.00004ebb@kernel.org>
In-Reply-To: <20261104044719.4120078-1-nichen@iscas.ac.cn>
References: <20261104044719.4120078-1-nichen@iscas.ac.cn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Nov 2026 12:47:19 +0800
Chen Ni <nichen@iscas.ac.cn> wrote:

> devm_mux_state_get(dev, "data_read") is called twice in a row. The
> second call's result is stored directly into
> st->mux_st[AD4134_DOUT0_INPUT] without error checking, and then
> immediately overwritten by the first call's result.
> 
> Remove the duplicate call and check the return value before saving the
> state.
> 
> Fixes: f12ecb3e147b ("iio: adc: ad4134: Support SPI 4-wire mode")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
