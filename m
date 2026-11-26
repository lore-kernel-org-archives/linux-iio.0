Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656425;
	b=GjSv4Wd3wFwcokf2uKJzB2iLpBwfLXCjiOFnKNLxdbHcr2S/391z2n+OcrkSszw8VEUM
	 Pz9GgCCrQBRB/Th8PaN+JbNUzYSLcqPl0VCd/PsMFhfA6+k4ony2/NIuDkCsSF6/XJ3kc
	 67ScBAqyNAFNyHUhYNNx2MtjMD5uuQfmfz7Vwop/Mpt4woo8mil3Q6tAmXkFsJn0IYkSf
	 rHZ314I5HwXOc43h00+kZsXG0ukyZKwr04rBsVRmIyNW8EwZXIlZqlqP9vgybr9WUoaei
	 hxvxVcKESSDZDKgNGU6NtGJ6uW3FYqMnVzG8b1yezM16mWZtzAJ/Wpuf8QIa7+sdq0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656425;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=BthUF0RcsY223BUhCP9WAf9gffY6kCpIAVz/UiN/vMc=;
	b=zSqwuXGa/F7sDrbj5HoPHfmxpeubwCHhzhrFmv/u8valixjllVM68joe2XetF5tpKehx
	 JlRzKg9ztzEik94t9/DXpfcxCWhSCugEV5UBryzIdAVPuRBK+JZVVn1G34gAiIhHMOZhc
	 cPrMMXEDDtISu5OliQZNGpx5rAF6pG61Rxdov67N1EVoKur4z8P1z9yYIo6JY7liENkyw
	 +EHMRczAIp0lvLm0i8m76YGvK0yp3vWrQlxFG+ZIU261NYTfchJFvRxAhGIteFNM2Bp/l
	 BWH8lemjsl7rb8RD9yrjI48h/NQmDxRXX3dQcH8bVXRF4yqVxxPIizsILQ2mgXUjDNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz8FOBOw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F141606A31E;
	Thu, 26 Nov 2026 01:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vz8FOBOw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0051F000C4;
	Thu, 26 Nov 2026 01:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656425;
	bh=BthUF0RcsY223BUhCP9WAf9gffY6kCpIAVz/UiN/vMc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vz8FOBOw/TKLHo5xfCxZ+oSe1R4WTmFkstu0Bj7UwV0kpPnbK7elmIF1Oo11PHgw4
	 0+ae61vTbf7COca8hOSkZzT6if25OgXNT7KTxIypR1JwKt/hB2wQp2+KU4LqYy8QJ8
	 /Lk/iSKzfkViwE1RAj4N//guvNEJ21wqLizOP/LAeo7XUNSwDQuxPH5KU71HBYpywI
	 aMrBnnnQxfMotjgwgk3pI5SADhcpGbGeYngxLXY2Uiwn8BkCO4ljx9W7f82XwlYUn8
	 PIlL+lH6/LZDHrG9E8ZXrvLv1dOfMIyeLHkFLwLhD0fpxIzdBr0ART9VuyjBKhtMGR
	 zuXeVNVVazz/A==
Date: Thu, 26 Nov 2026 01:26:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jan Remes <ciakval@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joe Sandom
 <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v4 4/4] iio: light: tsl2591: improve lux calculation
 precision
Message-ID: <20261126012659.44b7f0d7@jic23-hlaptop>
In-Reply-To: <20261022-first-patch-v4-4-90b2fc6e8e28@mycroftmind.com>
References: <20261022-first-patch-v4-0-90b2fc6e8e28@mycroftmind.com>
	<20261022-first-patch-v4-4-90b2fc6e8e28@mycroftmind.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Thu, 22 Oct 2026 20:56:43 +0200
Jan Remes <ciakval@gmail.com> wrote:

> From: Jan Remes <jan.remes@mycroftmind.com>
> 
> The lux calculation computes the ratio CH1 / CH0 as a truncated integer
> (CH1 * 1000 / CH0) before using it. When CH1 is close to CH0, the
> truncation makes the result off by up to ~35%, e.g. CH0 = 56097,
> CH1 = 55973 at LOW gain and 100ms gives 1.517 lux instead of 1.118 lux.
> 
> The formula (CH0 - CH1) * (1 - CH1 / CH0) / CPL is equal to
> 
>    (CH0 - CH1)^2 * DF / (CH0 * ATIME_ms * AGAIN)
> 
> which needs no intermediate ratio. Compute it like that, with a single
> division at the end.
> 
> Also report the result in micro-lux instead of milli-lux. At MAX gain
> and 600ms one count is well below 1 mlx, so the milli-lux resolution
> throws away information. The numerator still fits into u64.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Jan Remes <jan.remes@mycroftmind.com>

Applied patches 3-4 to the testing branch of iio.git

I just merged in rc4 so for 1 and 2 on which to base this.

Thanks,

Jonathan
