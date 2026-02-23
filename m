Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67134AB16;
	Mon, 23 Feb 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881750; cv=none; b=rt+hGEIOR+iBroP9lJ1Pu2LxXGOBPS/sVpsXmYXZpF+gd/pA1srxDLd+8c3+/gOrNGe/1xvj1M5TVdunfoz3k/Ivj5J/aaeygvrA8qjJMTKBS5eyvY4R03zv9ZEmQf9NTyFR8S55NyDK2aRs9BjqhxxNTRaDE3UfT6XMXfHQBUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881750; c=relaxed/simple;
	bh=iHgra+uFkEbnwBpp0WYF10LCEYcCHaeuGWxtQbCqpag=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YU4xk39ub6rykvI4dzdFB7JwYPl4PhZaKiGPuRP3X2i3aj8/JaRk6SRAbhq2g3JVChMfxgCmZXafY172lTDMXVIxpQsg+0RcH3dDg+nvvxOdJOb54GdgFr29Dsjd6C2KsGX4qeWckslHcwxDGu0JE2pcW11vnBHshKxgBw6JM+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRKBUKsV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRKBUKsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7D3C116C6;
	Mon, 23 Feb 2026 21:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771881750;
	bh=iHgra+uFkEbnwBpp0WYF10LCEYcCHaeuGWxtQbCqpag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRKBUKsVbAswUe/SU5430cfMAsR91NR2VCdVSkWgVhl1+D21E2GAGEZJKB/YeH23Q
	 WdRyfsNeM8cEWu+zCnXb+bTfisobW+0LCNhCGK5i6xy4GKBYI5uxT96G2/4zQVz98i
	 KFIEHXQ/HJ31NPN7dNGMASk0Ib1nVZ3x1Neo42l0v58e2Iq6vtM7dGu6h4cMjv0H0D
	 OW8rF0rA11YzEomTQKAE+g0+bZnYm3Ho2UpgkXzxIDW4tTlWJCbMRPdcdP1ZUMupR5
	 o6ymNubTotVPuCmRIHEI2q7UJ7oN1S81FFLPi8/znMrYJTSHoW695wK/Go8o4n0oku
	 ZCCRG/f62flgA==
Date: Mon, 23 Feb 2026 21:22:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: addac: ad74413r: simplify timeout return
Message-ID: <20260223212221.4e43b0ca@jic23-huawei>
In-Reply-To: <CAHp75Vci3N+2iH1UZwnWb-pe9EYGq=Q0NA-fTuAf4sOMv6db9A@mail.gmail.com>
References: <20260223101440.4872-1-antoniu.miclaus@analog.com>
	<CAHp75Vci3N+2iH1UZwnWb-pe9EYGq=Q0NA-fTuAf4sOMv6db9A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 12:34:08 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Feb 23, 2026 at 12:15=E2=80=AFPM Antoniu Miclaus
> <antoniu.miclaus@analog.com> wrote:
> >
> > Return -ETIMEDOUT directly instead of assigning it to an intermediate
> > variable first. =20
>=20
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
>=20
Applied.

Ta

J

