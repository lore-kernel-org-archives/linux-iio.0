Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE260266EE9;
	Thu,  2 Jul 2026 23:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783035126; cv=none; b=Nu0eA+OwcHUA5qXAqptl6zi0H0HInukviS566/Bm0g9kQTatjx+CvJq3n+7j+d8tyG4ga0bV9mLh7mQdjJ2ImJUilUljZy4ZZDmSSvP4vKiT4cWbHTCCO5YGOWHDpSICuyNGyPxh88+UFlPCGhZ3QjwPzH8+36NS8HqtUA+JdP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783035126; c=relaxed/simple;
	bh=SQIxg6UHwUhuHyaLPPNaTBhZmvDPnCpYBab88JikSMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXaeTc9oF32/QR7glo+dHnIOUMldYN7R3Erl0ioBVQBbwRwDbVjUAmScreMdtCc18BYqs+qLyjfHRrrmnRQU4s5w2QJy1BXdbqn2ZMo1m4SJ1IH6DrIX7zPTFx0nt9JXPPrbZVvozHSAjofYPz4oaPyjnA68zJYpVmve+1MXggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW+O/krY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW+O/krY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77691F000E9;
	Thu,  2 Jul 2026 23:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783035125;
	bh=jrn0WT9n7PVBuyEgF+S+cvtSAtmFgbkZf3nN1Vx0Z4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YW+O/krYAr7iBLXP0CV9jV6LsI4h/CtLH9ri1UtO0MUofM84iX8CxbEwKXopfGb+F
	 DkKmGo09+kzQnXsbbs6vv0Vg7VXMqrNQ3YDeBvEvqFho3fxrQLuHvn07auVvtP+GGZ
	 5zgmzRIFEv29fAy9qjkch0I623+O7FJHrGNMgqCukx07QZM3AorE6UE3IOFoo5drkC
	 UxmkMNvqdMetxVa+uuQrZ9lYgETte/Dx8nK+AXNp3Ft+ibHgGxIy8glKyDxvgzNXnS
	 39mvjD7fMBu9pSZR6DWbsQU0ZUH+f8ld4jqamlYm4tsBT8GgY6bGt9/BNsVHNeZWzA
	 Hc84N9H3kbCCQ==
Date: Fri, 3 Jul 2026 00:31:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "open
 list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, "open
 list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: temperature: Add STS30 temperature sensor
 driver
Message-ID: <20260703003159.44850872@jic23-huawei>
In-Reply-To: <CAKqfh0G1dcn4MLQ5jxjM8aDHVu=z-NEAR-y=xMjfOiW7M_HF-Q@mail.gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
	<20260621004626.66629-3-m32285159@gmail.com>
	<20260621203303.0f8c5d08@systembl0wer>
	<CAKqfh0HUih0q9PEh+5pwwMuBBkm6nsaZP9e2yPjHO3+Yccuvgw@mail.gmail.com>
	<CAKqfh0G1dcn4MLQ5jxjM8aDHVu=z-NEAR-y=xMjfOiW7M_HF-Q@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 21 Jun 2026 19:09:11 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Sun, Jun 21, 2026 at 7:05=E2=80=AFPM Maxwell Doose <m32285159@gmail.co=
m> wrote:
> >
> > On Sun, Jun 21, 2026 at 1:33=E2=80=AFPM Joshua Crofts <joshua.crofts1@g=
mail.com> wrote: =20
> > >
> > > On Sat, 20 Jun 2026 19:46:24 -0500
> > > Maxwell Doose <m32285159@gmail.com> wrote: =20
> > > > +#include <linux/array_size.h>
> > > > +#include <linux/bits.h>
> > > > +#include <linux/cleanup.h>
> > > > +#include <linux/crc8.h>
> > > > +#include <linux/delay.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/errno.h>
> > > > +#include <linux/export.h>
> > > > +#include <linux/i2c.h> =20
> > >
> > > I am a numpty as I also forgot to mention a missing
> > > mod_devicetable.h header.
> > > =20
> >
> > D'oh, I ought to look at my includes a lot more closely as well. =20
>=20
> Forgot to mention, I'll be away for 2 weeks starting tomorrow so it'll
> have to wait :(

Don't add mod_devicetable.h.  There is a series from Uwe that splits that h=
eader
up and puts the tables different headers. i2c.h is now enough.
(It's causing merge conflicts)

Jonathan

