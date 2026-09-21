Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDC0217648;
	Mon, 21 Sep 2026 00:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789950088; cv=none; b=BTDJcxIarER9cvzORUbLNZLtAwx4ci7RQbU7piAsJPSjuLfBQNlhVl+yFU4cniyE0q4YY0XUz5XLDQkZvWP93OiVSEMP2iPGYC08h8BBHvrMxVmMerChIqZj8sdAD1btgYhGmyJL4WdE5j744/XM/NlluCieMamswHvLDqs/oZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789950088; c=relaxed/simple;
	bh=FEwUJtdz5lsOBk+2bdSX7PiRdFundMwe5cceFhOi0Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJY6h4+MuGQRwZHSt+T3erKSkPWsJPkS9DXb1H4Swnr+pzAQEtkOvtRE9GaTok7DoQt3b9ra1qgM84AXwwULoj9MpT+Hf07rGbBjKnDhgJw0X5AgmkYyH0mL/b8drp53sKII4H8Hjj1fXR4G3e2fmEKm8pmuczoL6j+sFEBLdcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8gbed0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8gbed0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A61F000FF;
	Mon, 21 Sep 2026 00:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789950087;
	bh=nwf30iuTuv5VLbNpYFck9XFeHn/Dpbwh6FqWUkooBEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C8gbed0tVCs/tkqu9+wuToN+7202xAx+QM2NyRJy4p+ixQ7rb65LcnrkJi3eCvtwp
	 sU++JbEMgY4pKUqYUt33Bwk/KQMRiLVL+FKpF/bfqM1Hnrslio7QbqfBmrcUIGRuFm
	 ozbjwLTMQA3xE6HKonFzaunnRJEuVJJLvBm5mU04oI49QArf8NgtehLTK33xA/Pu/R
	 6kLvfQo/KlZz2knNZaArriNJFb5ypf8RjDyvUe9CUFr3euljeV6QOTnyJBY7NWosqH
	 ZJV5z5dRTlJIBWdnfpqhkQiVDWt5ZCU0I3vo7fYq+ou1fvOo5scEE1wVqLnRmUSMEJ
	 XSQmLvSnBLejQ==
Date: Mon, 21 Sep 2026 01:21:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Zhiyong Tao
 <zhiyong.tao@mediatek.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: iio: adc: mediatek,mt2701-auxadc: add
 mt6572
Message-ID: <20260921012121.048cef83@jic23-hlaptop>
In-Reply-To: <20260918-boisterous-slim-dolphin-03d5ea@quoll>
References: <20260916-6572-dt-auxadc-v1-1-e8190d614c33@protonmail.com>
	<20260918-boisterous-slim-dolphin-03d5ea@quoll>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 11:50:20 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Wed, Sep 16, 2026 at 02:42:35PM +0300, Roman Vivchar wrote:
> > Add a compatible string for the mt6572 AUXADC, that is compatible with
> > mt8173 IP.
> > 
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/mediatek,mt2701-auxadc.yaml | 1 +
> >  1 file changed, 1 insertion(+)  
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Applied.

Thanks

Jonathan

> 
> Best regards,
> Krzysztof
> 

