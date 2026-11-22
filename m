Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795306887;
	b=fto0dgWy0YFfjXI0MVsKftUYc5gUogvH0E4ALMeIty/phV83XL2KoExrewhraIGPzfcT
	 zdLS39nSKWUJu3ya/awRu4hwSPhD6KhrA3cwm/6v3jGzREonMXKWc0nuIelm0OBlYE1vQ
	 JMYlwYWTClQ3+TlPf+yFYiK5u2SqMxKjIaPCi5PUiMtTahXLFCfFyYiI1qKh2zH7s0PP/
	 eP9r5GrJe42qTMIJIK1O2qvhNRXysaUHBVrk72393/n3KaH1wjSvkvNdfLOEskmmWvOJL
	 m3WvHyToJgqxi6+Ffq/i4wbMVj2449CIFh+pyDEdQWbRGv37iyF23GCDSzqLTkF0cRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795306887;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mdyQFBr0cd8KrOt79LiqhxwKESg2tS5qwCo7QjFMXeQ=;
	b=W9QxVqNBQ3pHzft4QO13MMeaUU7QaNo+GsNWszF4SKFnTj8qDc0ldtl+vahn8DjNVprP
	 NL2Teu+EjsDPtTzlOhtHymfsETw2/Kfon1DH0J5bcKLwzb1gV5DROE6Fgrkt5axICuSG4
	 mSKc05ssBcZXy64Kd93BXzl+2lOZCm/58eGtXZSlxHL/yz07BcDFwFs9n+0knR3ZMmZuo
	 cf080ro5fFliL8RDQoR1pkPpOIHMycT1+GkdZr5jXeKzWF58oDKU0qGWQWlxyKv0MezG4
	 7T/Wb70xZbEZ9PDMCCUaquepULo00XDgvc3ZedulS4Vvz4giXm+F0g8fyfGBWOTzdtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuxB9wGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C97606A320;
	Sun, 22 Nov 2026 00:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YuxB9wGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9072F1F000C0;
	Sun, 22 Nov 2026 00:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795306886;
	bh=mdyQFBr0cd8KrOt79LiqhxwKESg2tS5qwCo7QjFMXeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YuxB9wGCYlvNqFqXvYcai1G16+UyNN000DwiwUV1nFMyD+GwHsbx5MWtDSXqYgvdS
	 1a5tvcuDRyQ1YaCWOpaWiCG6mt7/XchZocFKG+5yFFIcwNnyJFddghGeSrhOIsTlsY
	 Y1/CyaPhtm+RHNMEJsBG5M3Dhb7Ts/F1fcifas++koidg6NCS9J9UUXQ21jK9hv3p7
	 Dqa2R2MP4t9WeANcjq6K2joumBnmXJ72Ign2bzL3EjfxpHG2qaS3Z0IdS7huzuX0PR
	 RuJg3nIxf0CzQ0TF5CqPuKVxosq21WGtZyYxvZXRfXSIpDw1cixbQjZNyBwrTuUBmH
	 5bwZGNnPQOwcw==
Date: Sun, 22 Nov 2026 00:21:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
 linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
 antoniu.miclaus@analog.com, gregkh@linuxfoundation.org, mripard@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: at91_adc: fix NULL pointer dereference
 on trigger remove
Message-ID: <20261122002118.723b23b3@jic23-hlaptop>
In-Reply-To: <avyEqQEL3A_YNcgg@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
	<20261117140510.391907-2-abdelnasserhussein11@gmail.com>
	<avyEb9La1tqS90Cp@ashevche-desk.local>
	<avyEqQEL3A_YNcgg@ashevche-desk.local>
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

On Tue, 17 Nov 2026 18:45:29 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Nov 17, 2026 at 06:44:37PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 17, 2026 at 04:05:08PM +0200, Abdelnasser Hussein wrote:  
> 
> ...
> 
> > >  	for (i = 0; i < st->caps->trigger_number; i++) {
> > > +		if (!st->trig[i])
> > > +			continue;
> > >  		iio_trigger_unregister(st->trig[i]);
> > >  		iio_trigger_free(st->trig[i]);
> > >  	}  
> > 
> > Yes, but no. Please, rather fix the above mentioned IIO trigger APIs to be
> > NULL-aware.  
> 
> Actually the iio_trigger_free() is already NULL-aware, so make it only for
> iio_trigger_unregister().

I'd rather we didn't.  Any code that is unregistering a trigger
that it didn't register is probably really very very buggy.
I'd like them to crash or at least guarantee that sashiko
flags it.  We could add a warn if it is called on NULL I suppose
but that is ugly.

I'd rather deal with this by fixing at source. That doesn't mean
papering over it except as a potential easy to backport change
which is the intent of this one.  It think the description should
call that out though. Something like

"Make a minimal fix to simplify backporting.  Moving over to
 device managed cleanup will shortly remove this code."

Jonathan

> 
> 

