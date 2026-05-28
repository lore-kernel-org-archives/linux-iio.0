Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66D83C5526;
	Thu, 28 May 2026 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969515; cv=none; b=aBwzBLhJfKeQVuJpdJ2oc+nQr32QropWpq/E93kM/LLUD7GjSlCpWqM20lbqbJAlV8E0c+WiGvTVrmjcnnMaSPTVrq2AaAhTQvv0FdsPJU7c9WUEZunkZAZFld72WgsuFSOumwAvb21UhrwppSXkbNNKuQdTlwRQ9xkyLuB4qB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969515; c=relaxed/simple;
	bh=wBckan28ReRm+vHjeqo9hDBptTm2ZDo75/qWYq2cqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pkn+PvgYJZLvt3j+5vqM69VmwOMzf4iWb0IbP5itbvNPTAGXLP7H/Q+0r/XgKYF3IUqwCrwTTSipLYuU3fUA+bT0XMK3B6GYWOg2SNYoU8q31JVHm+e6eep19nlXFdZMKYuib5XFBrZBE8DlOmTYWFshJEt3weH+VCrmvJ9Q7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIdxE/z/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIdxE/z/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FDB1F00A3C;
	Thu, 28 May 2026 11:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779969514;
	bh=wBckan28ReRm+vHjeqo9hDBptTm2ZDo75/qWYq2cqUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CIdxE/z/EY39UPxYgK/2ngScCHwb8bDMkCmmvEsxaLRWICgYUHP27cih64JbHi//6
	 /yHoigsrygZVx8ntlZOuaimw3A37Cz2I1U9KcU9uIL0mB0Ib+cL0MfgS3Xsdm6n0r8
	 cwcLnkb8Jv/gCjvJicwkZOjdOqULQN6gM7eEV5hW8aEwVytQb26y27gHGFeRfF07/w
	 lfD47iGqcs+RcmMiMRvQPWMrvFHSmJPuebkFiVmhNWvy3iESQPeR2arST8bbl2P7EQ
	 qOOq6XKizP1RJh3ezHacKO4UzRAZgt3wgoav8TEDkwTaGYEuOXSY04H90Aub5+rMs7
	 jsACbW+IrDuvg==
Date: Thu, 28 May 2026 12:58:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Chen-Yu Tsai <wens@kernel.org>, Duje =?UTF-8?B?TWloYW5vdmnEhw==?=
 <duje@dujemihanovic.xyz>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v1] iio: Use named initializers for platform_device_id
 arrays
Message-ID: <20260528125824.0f5f9853@jic23-huawei>
In-Reply-To: <1a45a4aade700448d7b1c702210ff147aaf21f90.1779962510.git.u.kleine-koenig@baylibre.com>
References: <1a45a4aade700448d7b1c702210ff147aaf21f90.1779962510.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 12:16:49 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> Named initializers are better readable and more robust to changes of the
> struct definition. This robustness is relevant for a planned change to
> struct platform_device_id replacing .driver_data by an anonymous union.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied.

thanks,
Jonathan
