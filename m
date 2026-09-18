Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B104429000;
	Fri, 18 Sep 2026 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725026; cv=none; b=sDqvQJZ7gKrLw/VROYBYSgFSrCEaWOFzuvfltRKwL1lFMOGzM3tk0E/Be3naeJJIPSP7//4dqRkek5Xn1qbtRKQUFBE7m9HUoJvU+F/dVKDo09PkEfF9VE0+txY/6XIKOgn/nQ4E0S/8u1xXd3wuJLFcHHoXAIXLNlL2WBln65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725026; c=relaxed/simple;
	bh=uq//kFF8kNbWDk3Np2NGyHy10OoX1yx7W6htjhBumik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP511KBFZoW3lt+CtvUcadYLNRCklIjVTO9jvuZapUA0dd0xRRHB1X8D4Dl0cr0sreLHSFBv0FqAYzRR1w34gmo5yJmD5pYJgwMG++5vNJOz87DtRtzYNjU8Okd/cbdYYuVI38oh6+6h2f95zsPUfxwY1jRz514pX4P9R+NW8Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/PkjKma; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/PkjKma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8987A1F000FF;
	Fri, 18 Sep 2026 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789725024;
	bh=Mhe/jArEZiTm/L88sXSRArvdYinXqabgfSoJURVLiaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W/PkjKmakehCuNFmQPTGYUoW/AoczQbueulzxRMo1934P0fpkm4au7oh3k9I4EViE
	 thI3adZQpoqaO8d5dr0QCU9sRhPWfHO+ctemWJOyTK4pu7sbdlM6lIKiWODIlGTqnu
	 5S3Si2eoJWXCRezNHqecncDoY1e8LJ/Pv4CUKANmrf03xR1JxlVlMNlGWvrWcj54JH
	 CpvevOIprCD1LBmp58pdEmNWKVK05mMRpr96t+BuntCYCT8TvV3Mr7kBH27hyBDAEx
	 bN5a/s0yvzBRHM81VxIdqRpo1m5/vmvnCI7zGsyvRnGFpLSYQpAwsu8dBRjuk8cy+U
	 sxxjA62G7Tw9Q==
Date: Fri, 18 Sep 2026 11:50:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Zhiyong Tao <zhiyong.tao@mediatek.com>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: mediatek,mt2701-auxadc: add mt6572
Message-ID: <20260918-boisterous-slim-dolphin-03d5ea@quoll>
References: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>

On Wed, Sep 16, 2026 at 02:42:35PM +0300, Roman Vivchar wrote:
> Add a compatible string for the mt6572 AUXADC, that is compatible with
> mt8173 IP.
> 
> Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

