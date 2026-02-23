Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949925393B;
	Mon, 23 Feb 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771881685; cv=none; b=km2guzq1Hc8yzeYzkCS7gI0raW7Cm8rIwnZvDmYFwvA92h9p74fjomeZDBuXEMmxits5wLwfrzZntovFgdi2I3pP8crfYsFaSeAEHLQL5SelbuNanT6kLAelZ/n4BDbWTj7phm/kPmfqOwWAA/+1USdj0wnOpLZBZF16r66bTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771881685; c=relaxed/simple;
	bh=j6kYNMWpQpeeeC7D6u7GaL4PlVDNob1jSMhAKPnJ+Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1p0iPVJrKL3tT9DZXboWCUrU5HF4FdcWKRaAK4UzxvQWf9BMaSJxrib3kebJwgXICCAUCldvVY4yX8R1SIUjyGd5O3dqFzAeHLiH7D/A51PXvLrRGY+CySuPYh0kpFehfZAlk3qL7qsFP2YgRB8bwViVvsIl/jfyXpC2wDK6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oARCLiyw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oARCLiyw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C20C116C6;
	Mon, 23 Feb 2026 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771881685;
	bh=j6kYNMWpQpeeeC7D6u7GaL4PlVDNob1jSMhAKPnJ+Yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oARCLiywCOoembq/P64iOJw7FVNwdX9cy9meZu8VKWWWr0C610vZ5aSG55f/V5m0L
	 J5a1RhfCUi/M9wQYiNo25cnbhWxj1hn3D6bAXYvJsLHFxlJw/ngvg3LbHVP8xOLeG0
	 MayHpg51w4ZIWiUmidxhfCCJ4cf6ryX1QLB6XzPyGRkOJ/9nfeDKGEf6be4XcnQs9m
	 up/qdNktKGVRpSnjoYnVnEIAxBD59/SSPMZ5gU3tq/yA/z/HkaIsizanRnmLmGzoli
	 aZHAVmB8/KdJA6/zEdAi6c6Hvfawd60uTKo3LMibSqTvQXRYdm3QD7lxIYLaIren5i
	 2PVpGBmzocDdg==
Date: Mon, 23 Feb 2026 21:21:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: move opening brace to a separate line
Message-ID: <20260223212116.32bd2486@jic23-huawei>
In-Reply-To: <aZwVEd9LUt4Nsooa@smile.fi.intel.com>
References: <20260223082359.46403-2-giorgitchankvetadze1997@gmail.com>
	<aZwQszq2o4MlXpOS@smile.fi.intel.com>
	<CAE7dp2oVSDKM2FArSfLtjjUTBm1RPWQNXrsvOgDNvg9G+URogQ@mail.gmail.com>
	<aZwVEd9LUt4Nsooa@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 10:51:29 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Feb 23, 2026 at 12:40:10PM +0400, Giorgi Tchankvetadze wrote:
> > On Mon, Feb 23, 2026 at 12:32=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote: =20
> > >
> > > On Mon, Feb 23, 2026 at 12:24:00PM +0400, Giorgi Tchankvetadze wrote:=
 =20
> > > > Place the opening brace of ad7173_calc_openwire_thrsh_raw() on its =
own
> > > > line to comply with the kernel coding style for function definition=
s.
> > > > Issue found by checkpatch. =20
> > >
> > > Is it the only problem like this in the entire driver?
> > > If so, feel free to add
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com> =20
> >=20
> > Thanks for the review, Andy. Yes, it is the only instance of this
> > issue in the driver. I verified with checkpatch and a manual grep for
> > function definitions with opening braces on the same line. =20
>=20
> Thanks for confirming, no need to resend with my tag, the tooling
> Jonathan uses picks this up.
>=20
Applied to the testing branch of iio.git.  I have a bunch of other
stuff I applied tonight that I want the autobuilders to play with
before I push this out as something linux-next will pick up

Thanks,

Jonathan

