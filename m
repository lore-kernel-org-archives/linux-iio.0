Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB170480325;
	Tue, 21 Jul 2026 10:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784629451; cv=none; b=fPPQQ39JE1bO8x024r2WwkNFBpWYd9JMdF9O9nVucxQylQV1OPSOuE2SzIkQLGE9clFVK+HNci6WT14JtQOd7BfDTvANieEatnnCEaMS6g5zut5TDTJaTLBmMVMNaWKaCVIDC1PKcWCixNe2Sxaf5+wR+XkuvXSAM2n/XQBloug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784629451; c=relaxed/simple;
	bh=qoSMfaCk1q4jWlVdm/iTyeGFA7yN/v6saP+aGSMOkv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myd/gQTTKDkDxi9pJil2hKTVeXo1wqyBXn1JNw+/PbrE4BmEs3pAsbaods+lePXG5GYtQFNBc/CHpj88JA4LSPmuJxc2BsfP8s+OYw2vtl5qlothYsnQK1TiA98q9VO7ccfWoyC+qASXy+snQWSGxensy8TwhOZjpzPsefSRowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=og0K3nf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="og0K3nf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685F51F00A3A;
	Tue, 21 Jul 2026 10:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784629449;
	bh=grGufETkn5ag+tMn6dsPdKgKKNOIBKRh7eK6WBz/AxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=og0K3nf2wsONWGWhExZlfDMMYVlNoExKZi5PMgzNM9mGVfNcWXDtrnOOi7/6sMxE9
	 YC2LAQY3pkpi6QavK3+m2N7yvSUC7V1pWMfV2Mk0/y7CHZgwWje3Bs4xYz/q1A64Qw
	 A1hhyuc1XpSvnTWmA/mPZJ2jKe+uotHGJgOqJ0NMaEGncNV9tw4LGmyUVyWsP31HY0
	 KNfO8IHDL2alakysWYVx9W+wuU5LxIMTXVGf62FnFC5+MupbULwSBqg1jKePaNvfwi
	 mGP/Q8Y5qkL4KuYiXR0rBo6IG2eeIGrQ1+AoX6JWMH01GbcW8Te3xcmVqGg24BLMnC
	 pIPASGnTBMnXg==
Date: Tue, 21 Jul 2026 12:24:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yahya Toubali <yahya@yahyatoubali.me>
Cc: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:ANALOG DEVICES INC IIO DRIVERS" <linux@analog.com>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: iio: dac: fix spelling of 'reference'
 in adi,ad5791
Message-ID: <20260721-auk-of-ideal-acceptance-eb8a0e@quoll>
References: <20260718151913.1892547-1-yahya@yahyatoubali.me>
 <20260718151913.1892547-3-yahya@yahyatoubali.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260718151913.1892547-3-yahya@yahyatoubali.me>

On Sat, Jul 18, 2026 at 04:19:09PM +0100, Yahya Toubali wrote:
> Fix misspelling of 'reference' (was 'referance') in vrefp-supply and vrefn-supply descriptions.
> 
> Signed-off-by: Yahya Toubali <yahya@yahyatoubali.me>
> ---
>  Documentation/devicetree/bindings/iio/dac/adi,ad5791.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

This is somehow confusing  - this is second posting of v1 I see in
Patchwork, but there was also somewhere v3 and the entire threading here
is looking random.

Please read submitting patches document and start using 'b4' for
contributions.

Best regards,
Krzysztof

