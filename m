Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794622563;
	b=nKo9ExdarRvN6EdXv06TY82Rec278W+7P692NGYj5rCW2EDLEPMNLiJ/1jLt7WGE9/Kn
	 jjtUAXZUDYHP8PAb193JU4hmDw0OhTpJiN5gvtxsNk2YMPRVajapZwPcR53h3X2x8RR+b
	 G7YLNokNCe2OjezrBshpTcFRQJve2YSpTPGIPzjBnixwtcLCi0V7yvvdsgaiFEJJRAzbo
	 pXdDSGoNYFYgQ0KYBVX1aA/HppZJk989cAqDsoyjH0WVxVtzeaPpC1AoJJaUkcHsJ3BRs
	 KgB6LErw+Fnv0RN3WE3gfJtuMorERxhU9STZVUXmIIr2xM1zWceeS3Uly+qHSU9P3nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794622563;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Roggx5/wkV3KhVWt1yynfm1Kzg49sxJrPoIQ3oBO9m8=;
	b=AYnBi5C+vBvY0kcQ+X2JW8sTHL4KMeDsCpjlayUWffKupMlO8eQEyF5hxJ2TBXUPk1hK
	 nw2eFN51JNIeObHW2YT0Bvxwcca1fGKCQQQB+56+gNebY3Z5+JZaFCI1WKph8Al5zzcsb
	 u2OaSAs2ut1jahbvE1+Y5HfkQTRYxtQiGN1FuXChw+C0NRiJNVHLCnfFBKP8/tAcno148
	 WJge8y3Ae3F0YlB9RLb37Y2KsV6dFVB34apyk9ml7koVvqym38UYPo2EwSOaK/hQq9lHt
	 GGh00XvWNgr5farmuIkNXQYELpL4KTwCBEIMyOmgH25caXRmyzorVPtLDTQ2eYPdxvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsfTA3oB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451A7606A327;
	Sat, 14 Nov 2026 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UsfTA3oB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA43A1F000C7;
	Sat, 14 Nov 2026 02:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794622563;
	bh=Roggx5/wkV3KhVWt1yynfm1Kzg49sxJrPoIQ3oBO9m8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UsfTA3oBI9zmZPuhfAO275YEO5Fc4IZbie/mxutRpY5aIKga/xk2aSXHOiKLiCDjq
	 egH90qo6xXyAyPvXuWzNGYnBfheL4ZW8oWWccd6AZWrbxONaVpac3fVVS+FmnMsu8t
	 8J6zPL49FoPsCTd1R8JJWAymrVOxKZR9O4gVxNHbQhCw3ShswD5+DZxzJU0oJ3PEzf
	 hDuZ65m21mAgPoCXaSAHy25+Ah8y6wGkZ31CrJbP6FddrDC1+qI+oU3ycaj4Y06Owe
	 RN2qeG+9Z/DMXih5VdeP+x++K6fGQ7sYpzqjx+LiCE9RM4ZmvdcJxZfYwJGxAm2EqF
	 3RToxtXb55x/g==
Date: Sat, 14 Nov 2026 02:15:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Di Wu <diwux@google.com>,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
 linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: use sysfs_emit() in show callbacks
Message-ID: <20261114021554.2165a2bf@jic23-hlaptop>
In-Reply-To: <20261113092305.00ec8be5@pumpkin>
References: <20261111072608.3490763-1-diwux@google.com>
	<avR-KT-6e77EexZn@ashevche-desk.local>
	<20261112020439.37b0da70@jic23-hlaptop>
	<20261112220218.1adae5e5@pumpkin>
	<20261113013646.4c2f8456@jic23-hlaptop>
	<20261113092305.00ec8be5@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Nov 2026 09:23:05 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Fri, 13 Nov 2026 01:36:46 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Thu, 12 Nov 2026 22:02:18 +0000
> > David Laight <david.laight.linux@gmail.com> wrote:
> >   
> > > On Thu, 12 Nov 2026 02:04:39 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >     
> > > > On Wed, 11 Nov 2026 16:39:37 +0200
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > >       
> > > > > On Wed, Nov 11, 2026 at 07:26:08AM +0000, Di Wu wrote:        
> > > > > > Replace sprintf() and snprintf() with sysfs_emit() in the sysfs show
> > > > > > and ext_info read callbacks. sysfs_emit() is aware of the sysfs buffer
> > > > > > PAGE_SIZE limit and is the preferred helper for show callbacks.          
> > > > > 
> > > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > > > 
> > > > > ...
> > > > >         
> > > > > > -	return sprintf(buf, "%d.%06u\n",
> > > > > > -		       latency / 1000,
> > > > > > -		       (latency % 1000) * 1000);
> > > > > > +	return sysfs_emit(buf, "%d.%06u\n",
> > > > > > +			  latency / 1000,
> > > > > > +			  (latency % 1000) * 1000);          
> > > > > 
> > > > > As David said, since you touched these lines, make the less amount of them
> > > > > while at it.
> > > > > 
> > > > > (But no need to resend, usually Jonathan is kind to tweak this small thing.)
> > > > >         
> > > > Done and applied.
> > > > 
> > > >       
> > > 
> > > I just looked at that line again.
> > > Why is it multiplying the remainder by 1000?
> > > It could be:
> > > 	return sysfs_emit(buf, "%d.%03u000\n", latency / 1000, latency % 1000);
> > > if the 6 digits after the decimal point are required.    
> > 
> > Good point, I guess unrelated change that we could have on top.  
> 
> Indeed.
> 
> > Those trailing zeros shouldn't matter.  
> 
> There is a matching oddity in the set function (just above).
> It calls iio_str_to_fixpoint(buf, 1000000, &integer, &fract)
> then does latency = integer * 1000 + fract/1000.
> Just replace the 100000 by 1000 and you don't need the divide.
> 
> iio_str_to_fixpoint() will ignore are extra fractional digits.
> 
> Although I'm not at all sure its handling of negative value is correct.
> It converts -1.5 to -1/5 and -0.5 to 0/-5.
> I can't see how that is useful since i*10+f for both gives -5.
> 
> I'd have though that either the fractional part should always be positive
> so -1.4 would need converting to -2/6 or it would have the same sign as
> the integer part and -1.4 would be converted to -1/-4.

That is rather odd use of the output of iio_str_to_fixpoint()
which admittedly is a bit unusual because of the need to handle there
being no where to put that negative when the integer is 0.

Can get away with it here though as latencies aren't negative so.
The code doesn't seem to actually check that though which might
be a nice useability improvement rather than setting it to something odd.

Jonathan





> 
> David
> 
> >   
> > > 
> > > David    
> >   
> 

