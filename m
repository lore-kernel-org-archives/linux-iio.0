Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C7E13D503;
	Fri, 24 Jul 2026 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784852534; cv=none; b=f8caLummmAsc8VQ4dEbcFKX2K9Y9ZglE5dZ5KYzvI2KfeYrVnYx1kPBKTbldiDC1wqKXVWGzD5nkhv6ZVJfZdI18mDjbBCLhQiAcJJMH7rvNeJLr5A4Gq9gpIBagtGuAtRFy92B9DdT1CpNd8YSKCGiYDrOFUi2fGUOgGn2UxUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784852534; c=relaxed/simple;
	bh=NsI7D64Zwp1jqAPistajs58rxIDyOBjPR7pAEq9eDz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ms0YJkiTrNFBVUs0au+R/WwsUi/ZDK00pK6Ej/glVQ9W+lp8v2TIwWZQId+YkvboQa0NBZgtGaVmaABZiGhdvMyMJYOfzurH3OOTwtgpF+mdXOsd27Mj8A/Gm14W5GPsORMN9UUeSRs+nfQZD4+J7pJ+sQPCa1sYF8zfsUIdKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maLUvQ80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maLUvQ80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4271F000E9;
	Fri, 24 Jul 2026 00:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784852532;
	bh=RQzMlb3RzDDwVpamN+WjGOZ3rR0CHVnsub3C8HVDb8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=maLUvQ805Rp0u12xlVeGtQDhVkRB/zqRLpnLg+BSJNxnhziFVkRmSh1g9wPlyM5l9
	 cTIBRlwRnp2asrRaR95znQkHcHKf1DUkJQ97PN7XLuUv4aqWZQd1nqSlucvUs5EdUw
	 cKyk3Mb8sPJOAsyZS7o2+Lb5tgGlepFR+JuAugHIp2QKOIy7XULqzHPaHpyPM/edGt
	 ySp/9kaCWyqDJNu8AjRFeXZWeGogfjtfAwfHNN9rjktsPwhmIe6JWVUEacO6GfrMl5
	 njtYW7WtLE3u2+lsh49f+5IRXNyE2apbXsArZLP5rKx2AIdUxXwRg2/RRb5zH2v/jv
	 ojVdQXdKLWznA==
Date: Fri, 24 Jul 2026 01:22:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>, Jean-Baptiste
 Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chris
 Morgan <macromorgan@hotmail.com>, Luca Weiss <luca.weiss@fairphone.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: imu: icm42600: add icm42630
Message-ID: <20260724012207.56d737bc@jic23-huawei>
In-Reply-To: <20260722-creature-volley-0f083b904c1d@spud>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
	<20260720173411.82979-2-jorijnvdgraaf@catcrafts.net>
	<20260721-lethargic-purge-e3cfb3c50677@spud>
	<20260721171647.26128-1-jorijnvdgraaf@catcrafts.net>
	<20260722-creature-volley-0f083b904c1d@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Jul 2026 17:59:42 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jul 21, 2026 at 07:16:47PM +0200, Jorijn van der Graaf wrote:
> > On Tue, Jul 21, 2026 at 05:01:26PM +0100, Conor Dooley wrote:  
> > > On Mon, Jul 20, 2026 at 07:34:10PM +0200, Jorijn van der Graaf wrote:  
> > > > The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> > > > found e.g. in the Fairphone 6. Document its compatible.
> > > >
> > > > A fallback compatible to a sibling is not usable: the part reports its
> > > > own WHOAMI register value, which software validates against the
> > > > compatible.  
> > >
> > > Why does software do this? If the whoami is the only difference, the
> > > software should stop checking it.  
> > 
> > Whether the whoami is the only difference is exactly what I cannot
> > establish: the part has no public datasheet. What I can establish is
> > driver-visible: the unmodified driver has been tested to drive it
> > correctly, and Jean-Baptiste confirmed the chip is "similar" to the
> > ICM-42631 and "can be supported by inv_icm42600 driver without any
> > modification". That is short of knowing the parts are identical (the
> > family has precedent for real differences behind the same register
> > layout: ICM-42686, different full-scale ranges), so I did not want
> > to claim full compatibility with a sibling.
> > 
> > As for the check: it is not mine - inv_icm42600 has returned -ENODEV
> > on a whoami mismatch since its 2020 introduction (and per-part config
> > does differ within the family, see above). Since every released
> > kernel enforces it, a fallback would not probe on any kernel already
> > out there regardless of what we change now; and even if the check
> > were relaxed, a fallback-matched part would bind with icm42631 as
> > its ABI-visible name - so the dedicated compatible is needed either  
> 
> Is that really problematic? It's not problematic for any of the dozens
> of other IIO devices that use fallbacks, is there something that would
> make this one different?
> 
> > way. Whether the check should become a warning is
> > Jean-Baptiste's call, as a behavior change for all parts the driver
> > supports; I did not want to gate a trivial ID addition on it, but am
> > happy to send that as a follow-up if wanted.  
> 
> The check should be deleted since it prevent using fallbacks.
> IMO, delete the check and add the fallback rather than retain it and
> propagate the issue. Even if you think having a fallback is a bad idea
> because you cannot be 101% sure that there are no programming model
> differences, delete the check. Personally I think that given the
> testing, patches and quote from JeanBaptiste, a fallback is suitable
> here.
> 
> I think Jonathan has sorta changed his stance "recently" on the
> correctness of checking whoami values versus the compatible, so what was
> done in 2020 doesn't represent what's the current guidance and I am
> always a proponent of removing these checks whenever I become aware of
> one preventing use of fallbacks.

Yup.  I was convinced (probably by you ;) that whoami hard checks should
go.  There are quite a lot left from before that time and this probably
one of those.

If it does turn out there is a difference then that is what the specific
compatible allows us to handle

So dt-binding wise, please go with the fallback route for this new part.
For old kernels that just means backporting relaxing that constraint and given
a backport is required either way it doesn't matter.

At least a first glance all that is needed is to drop the error return?

Thanks,

Jonathan

> 
> Cheers,
> Conor.
> 
> > The commit message led with the driver check where the real reason
> > is the identity uncertainty above; I will reword that in a v2 if one
> > is needed.
> > 
> > Thanks,
> > Jorijn  

