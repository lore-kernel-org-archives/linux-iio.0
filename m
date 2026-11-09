Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794216963;
	b=5rpYj2aMAzinyqJ10h6hPvwdm61hpK+QHJvCVpYJZtBs9249I0RiuQ2JpzFTArw8S7Bd
	 ddiBnGF4JsC8pUEP4r7Hk+bS282P13vkqs/qGoOUuPZBI+rNE7MC5BIZIzrszgX/80yYu
	 ff/IVZpX+ceVKrxhMa+8IVzPJ5yJyK0oybxqYoM6BseQffqndsXhWigXBFKwe6xwDdXEo
	 JTUEP2NqhKNGKQwpBUan5XdoO8fDWzJYtdhU5TOBUwDTFEJH2S/am6Fn3r6cCo5SWX3ta
	 TpCXAw8WSfisQGlAiq9CPS8XbnCh06PCUjG0WznuN6G226/zPlmsqjMXWgdzbJiHK/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216963;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NCouDec5+YqiyzwNHWpIXVtwCZttH/a+/7DByyMCImo=;
	b=OggSeK1wNR4nKr0Op4B/OTfaKsWLQxBipCe/4BgLi13GoKBIj3t/2fE0CJOWHmrN7pIv
	 SnF+BrU/OpKhdYZtxT9H4JeE7kq++RIJbh0rxu1ymcW+XXjN7leGfeVlP/ofU1Jw8YZkd
	 UUlxVM7U/QfG91mMigKSF9kCQvgemJA/OaDLcN9aV6YyF18JF35CBH/P9jI+xMVQqMv3a
	 DiosSli5Of11Jbqo+CggeFocG/0glUB5Hz3U5jD5aCXmVnAFfUr+/eCJzTQMGv4vw2TuW
	 6+x8wHMxlb0nLc6sDvXJ8aMABTLOoLk0hjdmiGr9xIPmcFompKJrso/cwjVHs2Q3VJw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc1Sj8iA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC4606A332;
	Mon,  9 Nov 2026 09:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pc1Sj8iA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794216962;
	b=3clxNe75wzrUJfp2EbrXh9rewIAzZKz5AmvCgZdy+BAh1eRlHpawCrlxnYRmm+hceSI+
	 ESgnMKpSI5gc10hp+8otXhj1C62CmAQXUtp/5c+lW8i4VqJqvNPuDzLqLiID4bs6OSHl7
	 rwGYA6aRkwxRb1ZNPfuo7OCnE0oqVEW3QnLSIoH+r4N7HJwKdda6D+gYnlRlrngc2DzoU
	 L99y2eh8rY7ufaHz4WaLImrV424Agfatc+t6/M1zOloC8jBk4oSdzd+WzOeothHl9nd/C
	 yBgKBYSqs1hpPydRJBEuN4cNfUeP/TdH08XYu+77LqSrQCuf86OG72E7KF2gqYq1q8g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794216962;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NCouDec5+YqiyzwNHWpIXVtwCZttH/a+/7DByyMCImo=;
	b=NBZAOKJ0EQ6bVJlT+6LXqPDX+150a3F/muvcmQCclJhlDO4XUHqN2BDiloec4NFYoRox
	 Fcp8YeSU5H/69ZlASu3ovOEcSygo5bHkK6GIaE62Op8iarrV38xsCH+4A5ZdbS68EPbLl
	 aH0OnaPtmMu1bFuPWkPmbodoWFJw/VyawL5fQiFCwjLBIrMTNCCq0V3m0yYJ1ab6vIJ/R
	 J54QhhWgDzWLtpTdHKyTdx8BVNPVRdcDjm101ffyrUXaMw6sK0NEUxXq5RuTArlz3MvOi
	 cy1+aXbTf/n8rJnBl71851HMUjwEwN1FgXtlJa5fy3b/3XxQJlgaXK9vIsfYz9yxRYw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 047481F008AB;
	Mon,  9 Nov 2026 09:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794216962;
	bh=NCouDec5+YqiyzwNHWpIXVtwCZttH/a+/7DByyMCImo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pc1Sj8iAl2h6QAjo89WiAVUKdD/GfKoWXfACXCB61I1w7vatLCoJmVwjABbWEWloG
	 IFN70Y8ADkNt5BHKmQ4scQ3Qy9xJbxYL4d+4iwFnEghWtCySjo1WDplAucSoRnbCNe
	 i7YM3+yGRjx+FEuhwNmWr/MKnnRpU7KIihN3PlS1MTf+5JyKVuDVJ58VmwQTopvLQE
	 lQBpOtFlXkgs0uMIlzzU3Gfl7EYuYFOGiDBO4/R1Yx0aMlRg7XOPkyRNC5V/+BlJPt
	 nmDCBGfBdKdQrqrkmVZMnyF8wv0Hhpymbk5aMboDz0vsvJey4Rau5qD8fjPr4+rpjP
	 CZv+No/V4P+mg==
Date: Mon, 9 Nov 2026 10:35:53 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: adc: ti-ads1262: use umin() for excitation array
 lengths
Message-ID: <20261109103553.00004a85@kernel.org>
In-Reply-To: <20261108-ti-ads1262-excitation-umin-v1-1-65929a66394d@gmail.com>
References: <20261108-ti-ads1262-excitation-umin-v1-1-65929a66394d@gmail.com>
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

On Sun, 08 Nov 2026 19:55:51 -0300
Kurt Borja <kuurtb@gmail.com> wrote:

> min() rejects mixing the signed count with the unsigned ARRAY_SIZE()
> unless the compiler can prove count is non-negative, which fails on
> some configs and breaks the build. count is already checked to be
> non-negative, so use umin().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202610241549.J9R32Wf7-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202611080814.7RmHoQ6e-lkp@intel.com/
> Fixes: b0b43a26dfc9 ("iio: adc: ti-ads1262: support excitation currents")
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
