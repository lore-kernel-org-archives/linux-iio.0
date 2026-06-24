Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AD3D9696;
	Wed, 24 Jun 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322655; cv=none; b=oDfjK3FE4Bht7vqILWZiY6mDz/cPUT+h9uYby9d28I9cmV0MOdkJR7mrXBPZOnpz6k0nJ49NzR7aYSFIadrEVZDBif3NxpaDDXhk2TFqLWPsvNT5Y93xBsxFNC5Av+w9ZpoEQShub/63r8cYLgNvBMH+mFxIaIUp4NTsYLyOLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322655; c=relaxed/simple;
	bh=CtQtJTvg17r8J6ahtm92eNVpEDSa0nzxF+sphPOIquM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fgd5+zjBTVk392AXdbjd88QYRvDZz+CiaEOkN/EBBxXM2XgRyZaeKnpzpa0MVjD6LHt0KGFPwCd9NikW9TVEfDZ5uX2uiBOxNWut9Zhf2pFtMXxLLWvk0p7dscoQekoWO+movcGSKdEvCG+CCvR3Cm2Psve0DrJJVOG8nP/7ThI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUbFxchi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUbFxchi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121DD1F000E9;
	Wed, 24 Jun 2026 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322654;
	bh=CtQtJTvg17r8J6ahtm92eNVpEDSa0nzxF+sphPOIquM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iUbFxchigggu3ON59p2aGmdmy8jnoWSgmE9vhS6inENEw6dwzce2h39TTye78QeT6
	 7BawhAFSwUa6z7i9AKmtRryx8S7I8Ps54mVYFq8JpekBg1RWQobDth7A1rG99oheAQ
	 /0FrT3Oq4ymQxKRb2AjGzOgGULvA9NfGKXCjRl8aB0fzxJgi2JTGcbX32rYn09obI0
	 7Dodqo9+0oqlpx6biZaCv5sc7tAy+CY81uJvVl4uSckfu9Pkzaktg5DC+PP+7fPQxn
	 FxDCaP5uohwDu2Q+YTYmvXtzAXfoe0JEaFD38bY+t0lkiMY7VxhvKyP4dj9ANH7WLE
	 XU5HNI6nNZUNA==
Date: Wed, 24 Jun 2026 18:37:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 04/13] iio: adc: max1241: Simplify device abstraction
Message-ID: <20260624183727.758614c7@jic23-huawei>
In-Reply-To: <3e03bd522955c265e88f61d9b3d3e5f018762ce0.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<3e03bd522955c265e88f61d9b3d3e5f018762ce0.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:32 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver was introduced in 2020 and since then only supports a single
> chip variant and .driver_data was unused from the start.
>=20
> Drop the assignment for .driver_data and hardcode the device name
> instead of doing a lookup in a table with only one entry. While touching
> that array, make use of a named initializer.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied this one.

Thanks,

Jonathan
