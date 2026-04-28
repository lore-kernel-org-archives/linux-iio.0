Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97B26F2B0
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388742; cv=none; b=JT4d5XQIQfKODGmOzeersfdQUIElaQ2kRiWhd4h3stqX2388NkAGVyzk/vP6sdj6rFfAR986sRI0Vuudy3Dswvi8M87nn7Cn2hdjNuw+St5BYG0bQyHRnRhgeErQZvBS0jEaxJWHOdpgajJzuNRbyr0bTInXQBstr1hA8wqpr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388742; c=relaxed/simple;
	bh=KBEmWhjBbToX1uFnmo0bt+OcXIRsovCuSf3JUa9I+dA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FUnfqO3xjVgP75DzHsF6qWYdp+RUf9RktL7mwzshfQTWVeylPXMxu4RscC65WRCkh+Mv4i22ZiwuLQpWYeXtxVDVjv7vZX+5Ea3JlcMroqQlzNZ0D7AlzsP77SNmtMqQgD0cKZwdEYTPoSfW1IdLgAy+XIS/diS9KUIz43GQAKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig6uGCQi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig6uGCQi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA305C2BCAF;
	Tue, 28 Apr 2026 15:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777388741;
	bh=KBEmWhjBbToX1uFnmo0bt+OcXIRsovCuSf3JUa9I+dA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ig6uGCQiqoseJ4h/5pD3OOHEHLltdr+Rus4nSw4w13u6EZfSpMWZDD2nzc5fckzBE
	 kkfVH1g1mF3qkSZSH8Z0sniVVClIK73DQZ04Hbt2Dt4lWLsNOVgLzWupOA6SBSx+TD
	 ebNH/+f6TPkavvaDNINvuBbphwuZqv5FMGA812u/Kb/k6SKPKP5vpDbnAO5Sya8YPr
	 w0V2vA3c/I5P2b5m69oRuewiPboQ92b+Io+SF6ViPCJB02b556Dl3KbiFIobDwkybc
	 x0rU1JMFgAEXuRtvaCf6GGqwmE8S9DshUtiOYvFjZmCaP2mMXxxgFM/d/NSJqNNKF8
	 CClgzZNBwqYcA==
Date: Tue, 28 Apr 2026 16:05:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, Felipe Khoury Dayoub
 <felipedayoub@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: stk3310: update includes to match IWYU
Message-ID: <20260428160533.47e4e820@jic23-huawei>
In-Reply-To: <CALoEA-wd9jo_bPCGF0GqLH9SX7vWsCN7oyvkN3Q86R0F=WTjog@mail.gmail.com>
References: <20260428134205.1137419-1-rafael.guimaraes.dias@usp.br>
	<CALoEA-wd9jo_bPCGF0GqLH9SX7vWsCN7oyvkN3Q86R0F=WTjog@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 16:33:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 28 Apr 2026 at 16:13, Rafael G. Dias
> <rafael.guimaraes.dias@usp.br> wrote:
> >
Reviewing on top to avoid repeating the stuff Joshua has
already pointed out (thanks Joshua!)

> > +#include <linux/array_size.h>
> > +#include <linux/bits.h>
> > +#include <linux/device.h>
This is a bit like kernel.h in that it's mostly a catch all header
that we are trying stop including directly.  However, it does still
contain some stuff. I'm not immediately seeing why need it here?
struct device * is used a lot but a forward definition will do for that
(put any of those needed after the headers0

> > +#include <linux/dev_printk.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> >  #include <linux/i2c.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/kernel.h>
> > -#include <linux/module.h>
> > -#include <linux/mod_devicetable.h>
> > -#include <linux/regmap.h>
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/types.h>  
> 
> It's better to group the <linux/iio/*> headers separately from
> the generic <linux/*> headers, usually below them.
> 
> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
> > +#include <linux/kconfig.h>  
> 
> I don't think you need this.
> 
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/pm.h>
> > +#include <linux/property.h>
> > +#include <linux/regmap.h>
> > +#include <linux/sprintf.h>
> > +#include <linux/stddef.h>  
> 
> You don't need to include this.
> 
> > +#include <linux/sysfs.h>  
> 
> Remove this too, the driver already uses the linux/iio/sysfs.h
> variant.
> 
> > +#include <linux/types.h>  
> 
> It would be better if you split this change into two patches,
> first the ordering, then the removal/addition of headers. It
> improves the reviewing process.
Agreed!
> 
> Although IWYU is a pretty good tool, it generates a lot of
> noise, some of it not really valid.
> 
Absolutely - I've had a few goes at putting together a 'standard'
config file for it, but never managed to make it do things correctly
for some corner cases.

Jonathan


