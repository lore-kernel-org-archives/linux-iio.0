Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794083715;
	b=3Xpo9nExBUfSszmX7p8nziH/f7y9GWJOWRNmzrJq82MRE00sNp7/EY5h9hkevKjGqdT6
	 g67g9XD2CLT0HYk5BPPMN3cSIkft5wuPBLCQ0+ifljH4rppfXGps4LYSk+9eu01wh3amn
	 +FwbdXZesC5qCXuoCpMcXe9B5M0jO1ypvAr6Fp07OnLQtVU67jRzIWzup5x9hWoVB7B2i
	 vOAMbSkqqWmmpUaRXJJaVuGcsFERfzxBWWsNqUK7yCGhBpJ4Lr7KwqsMqG1QiEn49GqFI
	 eXHP6+lt6udS2Fm3NE2r2AAZoi4upbhcDk+Dlfhq0awUxaRbb275FYV7S2VYnH77OYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794083715;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=V3vJ3uaWbWIy6syguh59DzpN87g8/aV6pxxV7a2FucQ=;
	b=eTlsvlbmldXg/dez9NBp8IH2i0oq4AbdsjpLLU2vj/WaIbnqE5IhXS9xrLNQzjZBo3jz
	 ZWWuORSfZpR6hpbFsWMuZPvb2jzFhg9PV0Ye7m158zHQSP1XjHkXwYiyA5xZMPWKJqLfE
	 YFTswOW0xV0QwpbcO2w7NXQk6OQltX4uUgoLKka/TS+nX1dFqqw+MFf0wZIRQyAowFizx
	 BmbUZ9miyh6f8rVbuzpmVYe+jnTg6ru6mJDCN23V0yTKi4GpLcYy86LmEcAxIBzYkeMx4
	 bs3PfEBv/iO5yVDGvq106egKuM4HFx2+MgBmtiUcVRdSSPXStHUk3/T8qujBNX6x3Qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfGlXISU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C249606A326;
	Sat,  7 Nov 2026 20:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FfGlXISU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4211F0089F;
	Sat,  7 Nov 2026 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794083715;
	bh=V3vJ3uaWbWIy6syguh59DzpN87g8/aV6pxxV7a2FucQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfGlXISUpolnFb+UOCuJm3J+pkmbuwQBoEV91cdNO08QRbcZovt0TljBJWCGXjzid
	 y/8V9e0jGIH7lw4je3kC1VOTk3nOVO92YZJocNLkrEgWZPxz7YxGy4a5yK2xOhtLvV
	 dHEZQ/+woXlO9eikD2riiaDv4GXYUxQe0ldommuJx9WDTC05EugMGIWT6iXJ4nI3sP
	 //tFPASO+R6QBpDMhL+NEZrXS0jethFg4lJ6SS+GzdC6uRr/+BENd2uPnTmx/vnt9g
	 r8Ky/gN7tC8Le5v1Q5lMJ9zAQDrj009423i4Tz2d+FS2LzQLGLil/0yks3F4WJlpBI
	 7Z/EnkIMGGd0g==
Date: Sat, 7 Nov 2026 20:35:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <crofts@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Gwendal Grignou <gwendal@chromium.org>,
 Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9324: reject reserved gain values on
 read
Message-ID: <20261107203508.30be5cf2@jic23-hlaptop>
In-Reply-To: <20261105141504.000009b8@kernel.org>
References: <20261104175920.207384-1-kapoorarnav43@gmail.com>
	<20261105141504.000009b8@kernel.org>
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

On Thu, 5 Nov 2026 14:15:04 +0100
Joshua Crofts <crofts@kernel.org> wrote:

> On Wed,  4 Nov 2026 23:29:18 +0530
> Arnav Kapoor <kapoorarnav43@gmail.com> wrote:
> 
> > sx9324_read_gain() is meant to return -EINVAL for the reserved
> > PROX_CTRL0 gain codes, 0 and 5 to 7. But the range check sits in the
> > else branch of "if (regval)", where regval is always 0, so codes 5 to 7
> > are never caught and are reported as gains of 16, 32 and 64, which the
> > sensor doesn't support and which write_raw() rejects.
> > 
> > Check both reserved ranges before converting the code to a gain.
> > 
> > Fixes: 108e4d4de2b5 ("iio:proximity:sx9324: Fix hardware gain read/write")
> > Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> > ---  
> 
> Makes sense. A stable tag is probably needed.
> 
> Reviewed-by: Joshua Crofts <crofts@kernel.org>
> 
Seems correct and I can add the stable tag.  I'll leave this on list
for now so that perhaps Stephen has time to take a look.

Thanks,

Jonathan

