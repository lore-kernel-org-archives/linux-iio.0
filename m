Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263A3B0ACA;
	Mon, 27 Apr 2026 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283690; cv=none; b=uKUyMTUj+wCyqNEhNSh0yXf4xYAPLyPohSrkq2uaQP5UAIrTEFlVrEKdZsBlwss6LIDqljjuCvSb3NXrTZmVa4RrjrpE7YwnsDtYywUrfYf/1ei5nhtGBK9DyxhaYPLVAblerk1+LahsV7DsKBbm9u4t6YLc6RkQ/4oxjlF9ErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283690; c=relaxed/simple;
	bh=3GJbd01BMV46KOqmSsQTOMiZH5IiF+nQeyc2rgr2Oy0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1aAu5CFJKCEKAgPruW3WhEwQf8bgRhmV3jmZz/Lqj2z+npcGBjSZqKqVHxrsZ4IqI2xaAPpfLtumyIp6ING36F3scw1I15knetM6uV5kJN8wvds4SIDGDkwk+5esR/+VnLDmhyKuaMKMYT/VhMuTG60DmL+zLFFKpjPPmh+PAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0e1xCma; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0e1xCma"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD6DC19425;
	Mon, 27 Apr 2026 09:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283689;
	bh=3GJbd01BMV46KOqmSsQTOMiZH5IiF+nQeyc2rgr2Oy0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N0e1xCma1Yv/JFQEVHz6rAqbo4SzecdgubW5eAeuFBxPfZLFcSpHZifv3smJyUZL4
	 wLX+78hNXVoT6Us5dXRipin+RcIYZEnW0Nc87BCRW7eJGKnV+3E46tVwFrj672qevA
	 cBfkymnQOHyjd7cH5I+NxJHloek91K2y156YPIVQ9g07CgGrd/RBlJS5tVYNmVJBwH
	 0LL49GtkSA7wTOsuTxWqeCgpW6da9FIc3lwpnrt7SSpHsDlUEvdjULzHYeX7safi59
	 T4hMOD87cDj4NWOjQ0hA6Xxs5AmhqbAaDaxj3AvBdtKD7jE11dz222IpZr0ITdM/6I
	 XD1R17oZGM81g==
Date: Mon, 27 Apr 2026 10:54:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Rosen Penev <rosenp@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
 <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: meson-saradc: fix calibration buffer leak on
 error
Message-ID: <20260427105438.2a9541f6@jic23-huawei>
In-Reply-To: <CAN4SLj1_45OG+1AdzCfNiV7T3VX9tpQTcX8krsTDruhtYLzEGw@mail.gmail.com>
References: <20260426-meson_saradc-v1-1-6e96b2982c43@gmail.com>
	<CAKxU2N9_Nmk_apUZLSCGssXpwxYOz9k99ggRcUM3EPGUzaVi7w@mail.gmail.com>
	<20260426114118.7ad8b130@jic23-huawei>
	<CAN4SLj1_45OG+1AdzCfNiV7T3VX9tpQTcX8krsTDruhtYLzEGw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 26 Apr 2026 23:26:33 +0800
Felix Gu <ustc.gu@gmail.com> wrote:

> On Sun, Apr 26, 2026 at 6:41=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > That is the minimal fix, so we should probably do that first
> > even if we then circle back to consider if __free() magic is worth usin=
g here.
> >
> > J =20
>=20
> Hi Jonathan,
> You prefer a minimal fix here?
Yes please.  Then if you like we can carry on discussion about whether
__free() is a good change here as a follow up.

That can include the fact that it would have avoided this bug ever being
introduced.

Thanks,

Jonathan

>=20
> Best regards,
> Felix

