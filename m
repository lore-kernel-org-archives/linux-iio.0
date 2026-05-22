Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678A3A7F52;
	Fri, 22 May 2026 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779451196; cv=none; b=ss5vtg9Xp6m5nH2EzWy0p4KSpSS1l+DvSUJXxhq8fzULOOdMG/Mf3FFMIXoTsM3CQQbetEiE4GY3lNxKpJYrbBxXy4VEk/KKsW21UFoMrbHsEcD9T7TnzpG+eeQRRRpFlooFeYTmMysgl7D+Yc3TGkLtZGkwtwlCNFqZDl8PyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779451196; c=relaxed/simple;
	bh=aTlPKGXr7rf3v6LYPdGJYuY/JBNTTriHpOO4+jM2JbA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3lz+utGTYuSBOKEqoiQdda0ND6EJzJvIUum6KKSaDzwBw1ELfETvSb54LMoqDBep59H3C71QIIhZV/KvBm4W68PO8UMdZpVqCXmrC6Awf19o/1HHCBl77vVqMkUV9JKUYVMskv1Uc33P9k35OLQKE8BK8ahMILR8KZA/UzzXmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyK1pxya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyK1pxya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415811F00A3D;
	Fri, 22 May 2026 11:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779451195;
	bh=aTlPKGXr7rf3v6LYPdGJYuY/JBNTTriHpOO4+jM2JbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UyK1pxya0U9zLZXtVwJ5LDjlpVKmjNskudjTctROAZ/f/SmdKTkQDESVV8gpCZAHB
	 GdWvr+9Yx1i4bW/hSaD2/+dHUFgQkr6NIYSODZaDuK77goB7ZDWHqThX9Hs6wRXiQW
	 55jSepDbwGYzk5vxvxYxL/7Cf3R8YedPBfym9E7QW3DmgbVxs1kVOBNQDwHQ5Ct1ds
	 97uq+Cq/R/FhEnVYiWmTlWacfHDEGLAkoB6cRbgR17B8n4Pfq0j83tyWIMRuyelb27
	 2jk+iuVkSsIIYKBPdgc2+Z76NfXsrrOFxmlcKQmz3mWVXBIeuGJFn2YndOPSsTS42y
	 kVwU8PXpGW0mQ==
Date: Fri, 22 May 2026 12:59:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] iio: adc: ad7091r5: Simplify driver_data
 handling
Message-ID: <20260522125946.564bef15@jic23-huawei>
In-Reply-To: <ag89vYd0qFhOq6Oi@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
	<2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>
	<ag89vYd0qFhOq6Oi@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2026 14:15:41 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 05/19, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> > The driver only supports a single device type. So the return value of
> > i2c_get_match_data() is already known and can just be hardcoded without
> > type casting. While at it also remove the unused .data of the
> > single of_device_id entry.
> >=20
> > Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig=
@baylibre.com> =20
>=20
> Not sure still on time to offer tags. If so,
>=20
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>=20
Added.

> Thanks,
> Marcelo

