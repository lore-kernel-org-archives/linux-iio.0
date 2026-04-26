Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAB8357A40;
	Sun, 26 Apr 2026 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777200015; cv=none; b=TIKJI6Pje80JfcXNTtnd9WL2LQZn2xzuCpwWmzGSjgtt6qDzFZhZW/zye8OfBmINcbVehtqt4AyNLZCXcgX37YLwSH/FYPi2CgenCNJnuHDsQ/yzvwrppaGapMkj5DHRuaXWlygkqQihh/Q0eTOx2Ca5tyHrF49eZdrR76+TjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777200015; c=relaxed/simple;
	bh=Hpm/RHjdQVWHP69xS9eePzzNeO07/UiUtBrVtlV/V5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GvvZd09/ASVgjsUiHiz4fzWR39DdfVZ1VqiunO7auVuqtVpeIjSq5WczT4uCBZR3RF1wae5RYYmlJ0CvfoVHlULSww6FhiNgR974xP26erm5+zEJRbVecE2brM4WYHEnjqcZfAA1v+vD5NB4xhDxoUl+RWvUeHc0kX9xyVzbZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfMTQ6Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfMTQ6Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A8C2BCAF;
	Sun, 26 Apr 2026 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777200014;
	bh=Hpm/RHjdQVWHP69xS9eePzzNeO07/UiUtBrVtlV/V5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LfMTQ6VjKOLIduL9F9kUqMzrEhMqpJrqNy21O/BU8cJbFXiP0KJl3Tq057NxPRxba
	 jFYy7x3IRQk5sWfBrmtD0jfO1wkZdUF9ig83iR8pE49NhPF98GSxqCjbILsea1rEX7
	 PEU+VdL0euAY2xQjCeGOGUyOQKwF8v2tZTChNMOM7aR3t6Ndita8cZ1fBbtCz/ttZH
	 OwydDmDJZcGMMXPId0T+WtdUBnRAD7P9Sy1Vzd+4xihzIpyOmOfBUoPEoYMDkKortz
	 etxi6Qe7gW1DktXjDp9KsPgK9pv8h2G8d5NhZqTNb8QPGN4J+X8DeUAo2GPK0fmf6B
	 digQyHqCw1Lww==
Date: Sun, 26 Apr 2026 11:40:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Rosen Penev <rosenp@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Message-ID: <20260426114005.72fdbc49@jic23-huawei>
In-Reply-To: <CAN4SLj0hp4N_WXPxxQcLjY+espY96LfizsNEqJ3L2UF4_GoCHg@mail.gmail.com>
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
	<84cae83c-2d67-4927-aa40-6c416d4f862d@baylibre.com>
	<20260425194412.1872eff8@jic23-huawei>
	<754b6044-2285-4694-99d4-18d4fd5d8f6d@baylibre.com>
	<CAN4SLj0hp4N_WXPxxQcLjY+espY96LfizsNEqJ3L2UF4_GoCHg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 11:54:47 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> On Sun, Apr 26, 2026 at 7:16=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> > I just updated iio/testing today and I see return without kfree().
> >
> >         priv->tsc_regmap =3D syscon_regmap_lookup_by_phandle(dev->of_no=
de, "amlogic,hhi-sysctrl");
> >         if (IS_ERR(priv->tsc_regmap))
> >                 return dev_err_probe(dev, PTR_ERR(priv->tsc_regmap),
> >                                      "failed to get amlogic,hhi-sysctrl=
 regmap\n"); =20
> > >> Should `#include <linux/cleanup.h>` though rather that relying on it=
 being
> > >> included through another header.
> > >>
> > >> With that fixed...
> > >>
> > >> Reviewed-by: David Lechner <dlechner@baylibre.com>
> > >> =20
> > > =20
> > =20
> Hi Jonathan,
> This code was merged into linux/master yesterday, perhaps you haven't
> updated the code base.
Ah.  My bad.  I tend to be lazy and use elixir to check stuff like this
and had completely forgotten I merged the patch that broke this :(

J
>=20
> Best regards,
> Felix
>=20

