Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA75431A34
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 07:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789112485; cv=none; b=K+KY04vikVR5U3YWwavuVKAweUYCSyHBb3Uw70Sl8cKTswIeuvh+QoO3LfAguU273je05kKqcebCXwl8vGdT9Ijk5BpyiVVZ9asqGqiCmCJI+3woDeIzwBArapVN6BEsOBrUGoKVC0dzcDaMRr3dxn0UnjwTjnZyLAHGWC6tcGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789112485; c=relaxed/simple;
	bh=NO/OF5kdS6j1QF4/t6fTKO7uogCt4Zulz2Ll0FAdBeA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NO051i9VqPImuBHAD68AgVg/OU0ZXKDdfOnZm/wiq9P8WCDnJulHAI2B2vD0m3bQXGxNwQ6Cpc4HAPa83A4QTEh5oJV/8loLVbyjrnFlHZEX3jmbJDIAm/+RdW94U8okK8KoByZoVerDnbTYl9JX2NVuEKRJ7KXL7EA+ZznG1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5yIk1ZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5yIk1ZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512CD1F000FF
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 07:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789112484;
	bh=NO/OF5kdS6j1QF4/t6fTKO7uogCt4Zulz2Ll0FAdBeA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=c5yIk1ZKQWrpT7q3tlD/FHemkJLrK2xQ6VBo/ec4kFurOeSlrzrTxfPO9eqAuR+Hl
	 qK2A3lc5zvC/nELRwZQcTHViahP4SPrAd6jIsZOWamLOVQnit8A0TCiujvmEWRlgEw
	 bi7UHpBk5QzSxUmZKfKdpQ/ivmaMi3ZM1elnqQPNoFSbOjkEMpxh4az/JVv5J9okjs
	 ziPVt5QiBzjT9EdjLvKOl9+IzhkL4yzdF/eA/FSxxvQQcmyTDOqSPtgIDl7spjDnnm
	 y01QdJ1ZQK+q+0gHE63FaXd16MAPmlFTQYv2UZisMsPW/owRW4sxdg5aDqutEQjetk
	 uh2kpWsJt4Zyg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a354118856so4970921fa.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 00:41:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwLZd0Q8TJCGBIcXSxKbT1c4aORV8Zu91a+LmLOWmteER7fOq1gLTAr2m3qkOlBs6ooo8h9zCxnV6s=@vger.kernel.org
X-Gm-Message-State: AFuF++n45NIeF7Em4ue2HrEFXlua1b2U1l0NgsLs7QtDt9uI2g8EPjD+
	TXAwnsViUl7eEvUwyBIljYZ2WeGUD8N8/LjEfeuznAx2/9o5bXtAImE8hxUpVSmfFGMHsH/g2T4
	1RXAJRkbfyhBVZ6A7TG69c1VE8szs93mkcYFzNGJ5DA==
X-Received: by 2002:a05:651c:31c6:b0:3a4:8913:a259 with SMTP id
 38308e7fff4ca-3a5a52919e6mr2819641fa.29.1789112482986; Fri, 11 Sep 2026
 00:41:22 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:41:20 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 11 Sep 2026 00:41:20 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260910-ad7768-driver-v7-16-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com> <20260910-ad7768-driver-v7-16-7f70b07627e1@analog.com>
Date: Fri, 11 Sep 2026 00:41:20 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mei5ZrOcW3B0mGw1woX3ws+q6t1jzR+Pv6_dKKRo7ZOvA@mail.gmail.com>
X-Gm-Features: AcwNN1W5R2PpX2POIWzVZ_dgShbvNnsPO4gL5fI0M7B8ZSyCOdNjEzti7afKFRU
Message-ID: <CAMRc=Mei5ZrOcW3B0mGw1woX3ws+q6t1jzR+Pv6_dKKRo7ZOvA@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] iio: adc: ad7768: Register GPIO auxiliary device
To: Janani Sunil <janani.sunil@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Jonathan Cameron <jic23@kernel.org>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Sep 2026 19:36:34 +0200, Janani Sunil <janani.sunil@analog.com> said:
> Register an auxiliary device when the AD7768 is described as a GPIO
> controller. This allows the GPIO driver to share the parent regmap and
> runtime power-management state.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
