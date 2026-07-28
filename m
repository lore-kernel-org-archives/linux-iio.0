Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317BC3ACA77;
	Tue, 28 Jul 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273623; cv=none; b=ZTHeAqsCN+MZixq+wQUikCSz7QZxHUF+L292vnN89FBwAJs/pGjfZznvXZVa+UDMh6tOEEGdwNQKp54wggVcVmny3MWO8Ghjqxa9d8e+QVgkW6SljfLoQjBO53Pta5thOznJz/N55EtAzw0xSVamzd2IvIjO4bjCu+xU2dOQF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273623; c=relaxed/simple;
	bh=cQ/axbG4u2xMhP7KYYBACZecVz24/hpgptT3EV6khcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBKLRZYD6ECliK1xfRmg5UBFAgnxcF9ThNNcC6ZEl43xHS5M+1IVfbkn2oqTRgbq3ywgfgtCdbFoaNTPZp0V6O4h6GnsaOBKzxccfOdGnsTr4/fssGyRH4hBiXO9n4iV0Tr/fI3PR2tjZvikWT7AnQVjZwF+nF7KcWzULl0iUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUb62dVM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUb62dVM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719441F000E9;
	Tue, 28 Jul 2026 21:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785273622;
	bh=iPZA0jMAzfMFPA/GiEBtreKUM+ZSQ2eea/AtUjxGUqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eUb62dVMiJGpG80osjIpauY+bA4lCc/4KA1/mBOTmkpXLeTievq+3xgESSnglGDt2
	 sbrFvesazkkG6kUC1NnAFN/mUwKd4tY3x9wVngofcDCknMhTgdq6eBIObrqYadmxUh
	 BLE3WEuf1eno1sXpWlfIu6QSd0wtT8mRiPoyGQnL0EKOARQL2G2q2AQUpKqbuSaYXm
	 7q0xP18KvPe3OUgCmtenNvAnTDm13+OHmFDxyvdFOddFlSBJM0y0yIiwxhp5lKqXYN
	 HcGXzUQczcY67nAFI3SmfnFuHXstM8ByTVfQRbHWy1f+esTuwRBhpSN5J0B5ey4zyu
	 Omvo1Ct9jhNfA==
Date: Tue, 28 Jul 2026 22:20:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jean-Baptiste
 Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: imu: inv_icm42600: warn on whoami mismatch
 instead of failing probe
Message-ID: <20260728222015.6a62b287@jic23-huawei>
In-Reply-To: <20260728-extradite-yanking-42d918637f61@spud>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
	<20260724202708.128267-3-jorijnvdgraaf@catcrafts.net>
	<20260728-extradite-yanking-42d918637f61@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 17:51:57 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Jul 24, 2026 at 10:27:06PM +0200, Jorijn van der Graaf wrote:
> > A WHOAMI value differing from the one the compatible implies aborts
> > probe with -ENODEV, which prevents a register-compatible part described
> > with a fallback compatible from probing at all.
> > 
> > The devicetree compatible is authoritative for which part is fitted:
> > demote the mismatch to a warning and continue, as st_sensors does since
> > commit a3c2c5c937ed ("iio: st_sensors: relax WhoAmI check in
> > st_sensors_verify_id()"). This changes the probe outcome on mismatch
> > for all parts the driver supports.
> > 
> > Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> > ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> > and matched as icm42631, warns once and probes, and accelerometer,
> > gyroscope and temperature reads work.
> > 
> > Suggested-by: Conor Dooley <conor@kernel.org>  
> 
> I don't want this to warn, I want it gone. Fallback use should not
> produce a warning.

We've had enough problems with 'supposed' like for like replacements
in the past that were anything but that I've been allowing some type of print.

Don't mind it being a dev_info() though if that works for you.
Some have I think gone as far as dev_dbg() which would be fine from my 
point of view as well.

Jonathan

> 
> > Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
> > Assisted-by: Claude:claude-fable-5
> > Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> > ---
> > New in v2.
> >  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > index dc97d8a274e3..f306e3ffca48 100644
> > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> > @@ -509,11 +509,9 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
> >  	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
> >  	if (ret)
> >  		return ret;
> > -	if (val != hw->whoami) {
> > -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> > -			val, hw->whoami, hw->name);
> > -		return -ENODEV;
> > -	}
> > +	if (val != hw->whoami)
> > +		dev_warn(dev, "unexpected whoami %#02x, expected %#02x (%s)\n",
> > +			 val, hw->whoami, hw->name);
> >  	st->name = hw->name;
> >  
> >  	/* reset to make sure previous state are not there */
> > -- 
> > 2.55.0
> >   

