Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794228894;
	b=n4pYAn1AMluOqWPyvAVleLAg8bwmPtA/oqIU4xI40xptqhsKh6TIC241c0l1It6sJ4vx
	 zjf8jFXCT/KKyoaVseXEDOpJUF3K0z/T3XklSPe6X/bScuMrUadFgX2lPSnPRvm5fo/IQ
	 aqLy+/yV5DQ0GUp/UecA7T6DKeAJ17Wus23p44RX348oKr3digV4Vn/1S2btdiG6dlH0r
	 c1fiKuOJVBdjI+EQR+13oZSL6cL5K+lj4EwJXgqatiM5XDVgyTo7YMZ810GSSf4wGsc2s
	 DKFpfs+hr+xbggoGKxdTWOjfLRVtAJGyDRx9fr9PJKWuZrqba+62AovaXsmSmmD6Zhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794228894;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Vk/7PyValeiiNusSs4XmjhTye34OGHG6ZZR0Tgh70bk=;
	b=Ol28oe0WWPAxshIUuI1I6ue2k4W6fSC4doyIcje/DkLHQp9kSAntoHXlJABJcm7jg3/w
	 U7yB8hvOf9Ta3v/JGf2tBg7q5eAWDLU04mXJE5Y28Z48ilH72tUlfEcMAh20fj53pkU7h
	 LXHH6b/zUjd7LiOQnZ5wQcfMMekXEysFbRof6SP512rtycyJY5jfh9gYS7ZZouOTRD/iL
	 J+xhgDRZJojPaHr8ZrBV3mcYx7p7kV0mi1zYsrUY9udS8mOEpgGb8X5ZNhLJM5Cx4ThSX
	 uJpArw7ABDfuUdtjseVClwRZwXw90lq9c1UkwnRAwfgoQIP5n3nXKQwXS+x980XGZqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8g9hprj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4476C606A322;
	Mon,  9 Nov 2026 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8g9hprj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB161F0089F;
	Mon,  9 Nov 2026 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794228893;
	bh=Vk/7PyValeiiNusSs4XmjhTye34OGHG6ZZR0Tgh70bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8g9hprjf0A+Wa2Phzannf5tkUlsjI6sWYuEqhQhqqsua1dCClBEh2k3SFcLRMKbj
	 EG2Qo7/CUGtnl2URNwGVJ/tsUaSpzLSecZUeeT2g3PxaSvhbqvZpXdRhDJKfVOB8cu
	 0E+6FkMRvWcsqvSobS9hbnhvB6FlfbQdHymJJLt0VAUepLne29uXXj+lNhs5ZA4HDi
	 PxhcE3m7CeDZFeOov4z4Swqwd5qT9MrdDrlNjSuW5oQL6B/TIBeAcIGI2/8roJth7P
	 QHu25vCLUgCrUd7BQZIfxN79rWcgoNdAzkotg1+Rkw4RsFZqjOrYYyyP5aUpfSsE1S
	 fMGdHRnYotP5Q==
Date: Mon, 9 Nov 2026 13:54:50 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kyungmin Park <kyungmin.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: iio: light: sharp,gp2ap020a00f: Add
 GP2AP030A00F
Message-ID: <20261109-loud-shiny-hippogriff-2fbca7@quoll>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
 <20261108-gp2ap030-v2-2-24eaa1b9fe59@kernel.org>
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
In-Reply-To: <20261108-gp2ap030-v2-2-24eaa1b9fe59@kernel.org>

On Sun, Nov 08, 2026 at 10:44:00PM +0100, Linus Walleij wrote:
> The GP2AP030A00F uses the same register address layout and interrupt
> interface as the GP2AP020A00F, but returns raw clear and infrared counts
> instead of providing automatic illuminance calculation. Describe it in
> the existing binding with its own compatible.
> 
> Datasheet: https://global.sharp/products/device/lineup/data/pdf/datasheet/gp2ap030a00f_e.pdf
> Datasheet: https://jp.sharp/products/device/doc/opto/gp2ap030a00f_appl_e.pdf
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  .../devicetree/bindings/iio/light/sharp,gp2ap020a00f.yaml     | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

