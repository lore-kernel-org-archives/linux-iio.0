Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC1255F5E;
	Mon, 26 Jan 2026 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422239; cv=none; b=I5z/XoKThni7lhlxYrqr3yMs2KQjwRrWCgzvIR16ZeyW4KjvZnbLhWlwC2QFU+YusGYTCIHIeWPOkdX4p9/yzZD5ZzvftHOK/CsNPl0MlMvtPK409IPYaWlYf/PFECLiXUOHbKfL00uUYRLeE79quuVQiUtKizcFv4matRENfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422239; c=relaxed/simple;
	bh=xRVCDR5hiiDmGZtULdlXQZLT/t68n7I3mBxKRnxkDjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaOgurZWafdE3F8+YtBtKVslzfGB8cNRQzyQuPOjMksMSOTWZY2r0XPFbwKoH+Jp+JEBparRuBWsnfx4xRtCk7OrcjU3ULtnjeVlWb0jVhH0dDvi+rZ+X/X4ETZXgBRRPbYNRTMNf+XXwQUPnmrnhwUM813ZuYScKKyZUM5Qjz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+KrxCKt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zyyUu95S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+KrxCKt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zyyUu95S"
Date: Mon, 26 Jan 2026 11:10:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769422235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCvmrrHYwe06OKQ96thqOovpL6Xr/sVW3H5W1NA7lc=;
	b=0+KrxCKt9+O9O6oLKiRjtd74lhdWUD6wkk3QQo0XIHELJbf/WG/nQYEh4BDog55CA5SeAq
	Xj2uUuYMth89IMHNIAVWxDYBQncsGJBl49880bLY1j+1KH/ND+4eKmWhasWsJMTK12g2Ze
	ZAmneodcYIIQONypCNiDSthuYxCN73oQ4n6H5Wedf74sxj/Abr2xbJZWd9vCN+Xq6mkw8R
	VOUarBH6JLmecPFn3e9VsZDPJwjZH/lS5cFdqD7MMC9i/AKGo5doLisqex+gYL1uINU9dn
	KQtFA7EhNO83ypx3IzgUeh2+Ra0mU39+JGvxW3+s9jM9USUH5M9tdjc1Ey4n/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769422235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDCvmrrHYwe06OKQ96thqOovpL6Xr/sVW3H5W1NA7lc=;
	b=zyyUu95SpRMrlHpcdEh8rOdGnyBdxwJe64Hmu6ruEYJQuDwXPLqZ/rcoTszLpvByHgiYU+
	ig9KhvUYpxq+R1DA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260126101034.lnGGQmUD@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aXc5Efu-PlLNCxkk@smile.fi.intel.com>

On 2026-01-26 11:51:13 [+0200], Andy Shevchenko wrote:
> > > > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > > > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > > > Cc: Puranjay Mohan <puranjay@kernel.org>
> > > > Cc: Jonathan Cameron <jic23@kernel.org>
> > > > Cc: David Lechner <dlechner@baylibre.com>
> > > > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > > > Cc: Andy Shevchenko <andy@kernel.org>
> > > > Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > > Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> > > > Cc: Kent Gustavsson <kent@minoris.se>
> > > > Cc: Gustavo Silva <gustavograzs@gmail.com>
> > > > Cc: Nishant Malpani <nish.malpani25@gmail.com>
> > > > Cc: linux-iio@vger.kernel.org
> > >=20
=E2=80=A6
> I didn't follow. How? What tools do you use?

b4/ git.

> > So I have to move them for each submission. Or is there something I am =
not
> > aware of?
>=20
> Make them in the tail of commit messages locally with a delimiter, they w=
ill
> always be present as long as they are in your tree.
>=20
> I dunno if `b4` manages the Cc lists separately. At least I see no-one us=
ing
> `b4` *and* putting the Cc noise into the commit messages, so I assume it
> behaves nicely.

I point is if I move them for one submission, I lose it on the next if I
update patches in tree and re-export them.=20

> > > > +		ret =3D devm_request_irq(dev, st->irq,
> > > > +				       iio_trigger_generic_data_rdy_poll,
> > > > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > > > +				       indio_dev->name, st->dready_trig);
> > > >  		if (ret < 0)
> > > >  			return ret;
> > >=20
> > > Interestingly that this driver ignores the flags from firmware... See=
ms to me
> > > like a bug (not in your patch, obviously). Ditto for other drivers do=
ing similar
> > > things.
> >=20
> > If the irq-chip is level or unknown mode on boot up/ default and the
> > device can only operate as an edge-rising then I don't see why this
> > should be a bug.
>=20
> But if FW says use "level", wouldn't this setting override it?

Yes, it will. It was common to use it pre-device-tree time where this
information was not configured automatically before ->probe. Now it
might be missing/wrong in the dt for some of the old devices.
It might be a left-over which continued to grow and spread.

Sebastian
