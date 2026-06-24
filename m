Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E530100E;
	Wed, 24 Jun 2026 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323305; cv=none; b=VMrmyvbjkIbgFEf4ha1xAoLvyZgLUOE0z53iJi/Pd6Vl8UgEZLaS2yzUtxYD/C96LcFh5zcRBuuCDMGoL/L2DoPyrbMFF7FxANoPjmoopPgqzHG4BwzACPTd94ymRgEDE2ehBjm6Hu2G8/VoikJSCB3OMnK8VQs31dKqgoernOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323305; c=relaxed/simple;
	bh=jS4xKXj32iGjtDpyjpTzyrkRls/75g04CP5EFBo8heg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3Xx3LsL5llWyNq5NZHfjkIgjBp/wolom93Vag7QCBy2pZcyQ/W4ByK+iwoID1ybvu8Ty4WkwJQ/hsPqXWN9ek1mDmt08ISl2bgl7ETQKs+oa0mmKhQbFqGH2J5xiE8frmWOHZqDFIU3UCGVhuJite77QzcfH/S7Fy+AEZl5rAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oh/1u4HH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oh/1u4HH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F4A1F000E9;
	Wed, 24 Jun 2026 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323304;
	bh=jS4xKXj32iGjtDpyjpTzyrkRls/75g04CP5EFBo8heg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oh/1u4HHLuRE++kMKdWlA1XIVTrt2rf6yqGnRqPPq/B/TqkZhfpBIzHx+cCZb21UH
	 Jximy6xcySdMgcgcjIS3pM8es06MZVEfIxPwXvmLC7rvgTnjCx5ZQZSjB954wd9WHh
	 mBjvaU+/bGX3r5e4fQwcJuGGgTk+sPFeOgIcsqNjjOG+lcd5gN7t7duqDAMN+D7e/3
	 gkn6k7m+GJ6l2yompF6WkEBsD/J5gLwOdOWKLJrtB8mRJEipU5O79noqpVEqBq7bwa
	 fi7HhbcTMErwpRTgM3B1ifZgKzjarW01dwV0qb1GmJk6+Ebdm4YDrJP6vhVUTp0L+Z
	 w1gxGt6XkK2sA==
Date: Wed, 24 Jun 2026 18:48:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/13] iio: magnetometer: hmc5843: Simplify device
 abstraction
Message-ID: <20260624184817.3aa1783b@jic23-huawei>
In-Reply-To: <e5cf8297220b8d560854f6c64e80f00c4d093593.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<e5cf8297220b8d560854f6c64e80f00c4d093593.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:36 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver supports a single chip variant only. Simplify the driver by
> hard-coding the device properties instead of using the id_table's
> abstraction for a single chip type and a lookup in a table with only one
> entry.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Applied this one.

Thanks,

J
