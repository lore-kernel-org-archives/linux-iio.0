Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5443B47CD;
	Sat, 29 Aug 2026 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788027604; cv=none; b=CsPbLBegdZM32Wr2X1syxIjUBLUrkeR6INFdWDJ5soGrryndpx5UcdNZRBf0A0PRhoduFErv1Gs2hPxopk6oQUZw0BLeaGHhs2yB5XDXDkXt28usIo3qqZ5E+wL3G9tAMyOLp7qF8GKaHFHxltBNErm7aFPQV89y4XdSDM5D74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788027604; c=relaxed/simple;
	bh=aDthw+klUlFrAHBVWpJb63/nRyWnWEz+h4Ug65DBDTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzrHx3T7QdyVzMF5XFSCZKmY2gd8hYGCzI854K8l9CsxZl2QeYSeN7w25ltnFbX9M3D6+YJ/sLMHhLD7PtKuy+8sFolMCammZIieaeQ3vol3y7DCr29SoN5uG2/rkGEyutdA0aarsvbAZj19a4vfJQhTwb6CRAh6L7+UivZ5jVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ji+okeIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ji+okeIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAEC1F000E9;
	Sat, 29 Aug 2026 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788027600;
	bh=2m+w6kX81ZJlZopXoWgvGQ7ixn52IRcN/jOsMcSny2o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ji+okeIaCJvrDWsEXiKFyJ/uei71ioQ1XKD6OTbxFcv0dNo2ad4PTMLnndFaaCNeE
	 N3upzQaiF2GOPujY+MgSAbyOCWVOHY0D99c9R64tw0+rACETL8aP9LfB2oMrWz92Qk
	 YhCcjeZY4TPhr+JC3y9MwSTREERISIKfKAlYpzsCSVIFMbxLnLXfVWN/7kD3aPszjV
	 MUV2ydg3qI/mR3wVTG+Q58T84ZMYWl+P6UiKiSm18qA8VqKxF+jKzBmtL1F27hQ0ap
	 Li9sC34f5lhq8HPSGdIJdjg+jA1NydbnPTQcp76qXS3THMbd96FRgfW651VSx3B7EN
	 5m76x0jjTGijg==
Date: Sat, 29 Aug 2026 19:19:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, Bartosz
 Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <jananisunil.dev@gmail.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, "Andy Shevchenko"
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 00/20] iio: adc: Add AD7768/AD7768-4 ADC driver
 support
Message-ID: <20260829191954.7a5f1875@jic23-huawei>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

> ---
> base-commit: b75697ef53e435d894833dad2a8c2fa882cb9b19

Where is this commit?  I tried the various IIO trees, GPIO and linux-next.
None of them seem to have it.  That means automated tooling is failing
to apply this including sashiko (and I'm starting to use b4 review which
has similar problems)  Please fix up and send a v6.

Choices for base - and say in text which it is as well as the
commit id.

Latest mainline release
rc1 of the new release - occasionally rcX but then you must call that out
with reasons

These first two are the strong preference.

An immutable branch that others have created to allow some cross subsystem
work in a single cycle.

togreg branch of iio.git - but call that out and say why.

Anyhow, given I have a long queue today and this base commit thing has
been going on for a few cycles (as seen by sashiko not reviewing it)
I'm going to give v5 a skip and wait for v6.

Jonathan

> change-id: 20260708-ad7768-driver-10cd15296c20
> 
> Best regards,

