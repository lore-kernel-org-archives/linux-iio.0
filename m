Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793019871;
	b=HGZAY6c/hYwUyte1lAqm4JCHy9KKInYRzF0GXBzgUn4J+FyLsR3nz5P3v0wgndivB5t8
	 ppu/m5/OHim1clsnQRV7JqsNUXZN61vCxRAAp6Wa+FwjMHfBwKViInNTOxCDpPVJSD9S9
	 9w+jQDddYu791UMWjouVWE7oKBtP+p/UzvG78QcXGYMrw5ymIzTc4X9Y172VK4qIrXJuO
	 +Ie2OUkJIRy/CtNeenYeZKWbAtlS63cEBwQfSmq9K8TSLd0VjQhdS8fKyvY2Bap9uZga1
	 AsKqOsu2MDhy1DK33fyet+mledSOIqQZ4D0gzqKR4gQxUH64QR45eeNXksntlF4ld4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793019871;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8PFNYnCxnHTobdyAueoMuuMaIHtGouA4zstwhQSWAG4=;
	b=HCBoJSN2XV+8gVEidK9iSEZ+J2lpXQvXRmQTs8yTHIsFTUdGlPBNf2Nrh2CGYdPuqHxg
	 koE6n8LzThF/GAtfW30ByMpl/wJP0iPqEuTkZOHQsn1UY1CFcitQ3wE6KG0+uHgZLFeFl
	 h2FeUSwx2/rEreS8bFaSH/E6mzn43iBnWnlrGp+CEUIOG8m24lwqtrZdnxzaIg/Pw2xYq
	 4q2Mm/w7twO5c45azrgUXfsmQ/0YKaLNXROfxrCeepzqTa9sKmwhyi+cNxKNzqYwHp5Eg
	 VEFOnGW/35epLyunXh3bWQr3JWFEyAng7WXVsRBjTXMwGVo7jr94offk6fMtJGfe2Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpad4MCH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE579606A31A;
	Mon, 26 Oct 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpad4MCH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6D81F01825;
	Mon, 26 Oct 2026 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793019870;
	bh=8PFNYnCxnHTobdyAueoMuuMaIHtGouA4zstwhQSWAG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpad4MCHUggRDX3VpO2fmwKUF9KmDRBQsvFf7QM4i7wiVRkkgCGMmJeyPvNbK9+ww
	 msXGNrXaI8bkS6+fmt3BKrDJ+HqeZNPKVxIwCAgH3LqA7UF/iv2lu8rZh3Fne1jka8
	 M9LviUKvYuG8g9VqgXchHIZoYRWr+KVPkREQ13OPO7R993f+bj9R5WH+moDK4eZBYw
	 hxb0cCVQk5NS1mLNeHDL4Niy9ufBv5FBqmdumrntuo/NZZCZ6T5ajJQYJ+41xFN+VC
	 GNkzZs0Dv7rc/CU1qefnLzrueG+4xN2l7kLK1BKhP/p474Bh8SSkx4/BNq7C6sZcBj
	 W4X2pdfc5stPw==
Date: Mon, 26 Oct 2026 14:04:26 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: cdc: add Texas Instruments
 FDC1004
Message-ID: <20261026-excellent-invaluable-tamarin-cfca98@quoll>
References: <SN1PR12MB2528DD1E6067CC4C0B76746FA5622@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB2528E69DFEDBE002A60CBA82A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528E69DFEDBE002A60CBA82A5622@SN1PR12MB2528.namprd12.prod.outlook.com>

On Sun, Oct 25, 2026 at 12:48:05AM -0500, Victor Chernyakin wrote:
> Add device tree bindings for the Texas Instruments FDC1004
> capacitive sensor.
> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
> ---
>  .../bindings/iio/cdc/ti,fdc1004.yaml          | 46 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/cdc/ti,fdc1004.yaml
>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

