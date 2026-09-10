Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D7430F540;
	Thu, 10 Sep 2026 00:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001930; cv=none; b=q0qvRv+HopML2KpaNqxwuftgWY6IDqWLpbBqnd6BgpEC9mnAJ0w1MnvY7C2uFhg/cjKYvp5uq5AZ52FXXuhTgbOHOZsGfUEA6oecOmq2r/eH72+2Y6WKuu9Q/FGNBllXEdfmIqxAGsd7dfmfcf5iLDhSWGHN3zun2eHz8oQDvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001930; c=relaxed/simple;
	bh=5ONOSrZ9PygqHMM1RL9yYpBJaqgRcjqmsxxCPFN53E0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONizGVH/tev2ouLA98shEyV9jwcHm5LC2/6aRdXZvmGZlK2grEh85ec1jq9mwo0/HaFdAnsAyizyTanFbTn8IN/gQ73bZ/JSF9kzGi8GlGON6gpSybbzEIbQ6Xs3oDn+t0EBeh39mKK1t2EP2nd6MAb8O6wACXJnLXMSb8Xaxrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egmu6Wqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egmu6Wqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03211F000FF;
	Thu, 10 Sep 2026 00:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001929;
	bh=5ONOSrZ9PygqHMM1RL9yYpBJaqgRcjqmsxxCPFN53E0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egmu6WqqV0y/LLWZUu7Up4KNG35MfxUO803amkRhryjKrVtraTkflv5KoV+GNZpq8
	 vqXTsO6ZIb5kGXFyN09p5Goy7ez2z9AEVQgM9NGHwVvWW8+5Jchci0AX80H/o2fqYn
	 i3WmShpORh12835KCe44BrFWEYh2Z79Ctn9h3QUw+kE8qxgw3yeno0ZI9b+T64Po2E
	 Wj2JiUdt1t8M+/yFN+FoqCl6Fgw6sNJOC00PMBvW4m4kG8SZcLrnInUZ1a9c5CTi+f
	 7qU4oEgVCxw8hZHqGeWN0jUdgm+RyPHab/muLbDaUCVymrRL6g7RA11NXqssodqb2y
	 LlhY+omNXfA5A==
Date: Thu, 10 Sep 2026 01:58:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jakub =?UTF-8?B?U3pjenVkxYJv?= <jakubszczudlo40@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mike.looijmans@topic.nl,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jorge.marques@analog.com, antoniu.miclaus@analog.com,
 mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
 duje@dujemihanovic.xyz, wens@kernel.org, sakari.ailus@linux.intel.com,
 linusw@kernel.org
Subject: Re: [PATCH v9 0/3] iio: adc: ti-ads1100: Add support for TI ADS1110
 to ti-ads1100 driver
Message-ID: <20260910015840.1f44b20c@jic23-hlaptop>
In-Reply-To: <CA+gq5Jj=bMQBFr+DBZcA5TUPYC5omEh1T-A8MP3VpOJ7XRmf-A@mail.gmail.com>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
	<anocR1F6uCdh4e1V@ashevche-desk.local>
	<CA+gq5JgkegYTNKD1dPcWRp9sYXoMDfa9O4=B2azROy3QuTszpw@mail.gmail.com>
	<CA+gq5Jj=bMQBFr+DBZcA5TUPYC5omEh1T-A8MP3VpOJ7XRmf-A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sep 2026 22:04:38 +0200
Jakub Szczud=C5=82o <jakubszczudlo40@gmail.com> wrote:

> > > LGTM now,
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > >
> > > A few minor comments that Jonathan hopefully may tweak whilst applyin=
g. =20
>=20
> Hi Jonathan,
> can you check this patch version? Should I resend it with fixes?
Seems I messed up and didn't send an email. Been carying these with
tweaks as suggested by Andy.

So better late than never, applied and on the togreg branch of iio.git.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=3Dt=
ogreg&id=3D4c1836bb76d869e13e51c3e60a033af5e46dfe17

Thanks,

Jonathan

>=20
> Best regards,
> Jakub Szczud=C5=82o

