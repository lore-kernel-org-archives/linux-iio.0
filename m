Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D68383305;
	Thu, 10 Sep 2026 03:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011958; cv=none; b=MSJTpy2mf/NaO3w2SLAxxwMQGVWUgeZoqCaBlsDzppBPKsL2MArZhb5HjX5bb6dsnZT1H4h5XuECtDTVStY0RyB7sHEqsLqYvX8dvWts+UWyY3PKSEidsWi41ipBTtVH/enKCxn4qWZw5jIV6jrnk6762J/aAAU5UQwW5OIo4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011958; c=relaxed/simple;
	bh=pS8e2j4HOahUdcPV8ba72XPZyvYGzUGcrWKB5XBMJzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4kmnViSfernOG1xsAYi1QRL6IqRd1ytRhVBxGpaIKdSRjUnQw4ZL561bxZXuIEkV26TSQ2gvg/GyQVMclKBu5ipZgEkt4RxXDL1xRsw2PLub4XfWgDeTQU/8lIslW4sOihZtL05786QUbrOEGBDJDS8TlBzerZscBn9/nLJV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OC28JCDB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OC28JCDB"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 47FCF40E0320;
	Thu, 10 Sep 2026 03:45:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PUFBndoUYOrF; Thu, 10 Sep 2026 03:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789011944; bh=dGMsuLF+fQsklJw684lX5zh9Sk/KJNJzz3GASuAfcIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OC28JCDBltf+WoY6eBtGlRT+HH1KAO2XEw3Kh/e+u96pVU2HaMIaYPyh/Kj0jUv7m
	 1s7ssND78ocn0QMsYzqn2K7lStLXMjFS9+97C00ZYGM1HJxAKKu4K9suhJ8gjX2EZQ
	 ZlNdT/+3/Z4dcy0l+NO+m5BCAl2/23iu4YpVHhhKSAfJj65GX1iH2Dy2Lj+buOjRx4
	 KsVqPYorGzWuC9ZEJeTHhYLSncwAJk7Otq6Ov9CrutGIIhjGx4ZSeYbFD1F+ImKlJN
	 dWhUV1yf2669Fxpban97o6y0P2NiCM7/J0pGBJI4B2GMHJBje/7lfDFCUNr35BLOSZ
	 7KAkWpPq60z/GJfPNPZnLn+avxRcAFi/peNCjYWLYtJqL2d0UcTgi1pkZP5KBJNKqk
	 nrxun9EGr0cegPIAhnBomCKWObyVks51jkC7gPwnT3hFwd8t/SKUVCgCxLlv4Qyqy1
	 rh8OfVCnEgnSMjKU2udZY4xHXkCN1O1XrKJzkn+IJf3Id3GRT1wA/BF38D/b1gDKKP
	 3s3GuursSyRCzsP3c3u/rfoE/pLEp36pXn+8qSxIILZlY2q0vYZ6ZrfljU3G92PnCl
	 BWN98YUpjNazlIM46XDZlqk0vWbrcDyOwXDzbxhg4M/FuKfJUBiXAu9ndwUA2nDZYD
	 fDVh/lz+UiLE9J9EGerD/Igs=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC97340E01DD;
	Thu, 10 Sep 2026 03:45:29 +0000 (UTC)
Date: Wed, 9 Sep 2026 20:45:27 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	David Laight <david.laight.linux@gmail.com>,
	linux-iio@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleinxer <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>, rodrigo.alencar@analog.com
Subject: Re: [PATCH 0/2] x86: Use "er" asm constriant for add/sub
Message-ID: <20260910034527.GBaqIn13O6zSuD4vak@fat_crate.local>
References: <20260803163955.627bdd3f@pumpkin>
 <20260823233536.30b984ed@jic23-huawei>
 <20260901175101.1e059ac8@jic23-huawei>
 <20260907231444.7fa2d116@jic23-huawei>
 <20260908033216.GAap-BwAmBqoVDUbMK@fat_crate.local>
 <ap_cLN807bC56OBU@monoceros>
 <20260908152127.GCaqAn9zI09T7qvMhH@fat_crate.local>
 <aqAtRgouK7DyDlpJ@monoceros>
 <20260908165501.GDaqA95YQKx_IL416d@fat_crate.local>
 <20260910042029.7c78f6dd@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260910042029.7c78f6dd@jic23-hlaptop>

On Thu, Sep 10, 2026 at 04:20:29AM +0100, Jonathan Cameron wrote:
> I've dropped the branch from IIO. That's fine because it was still being
> tested and hasn't gone out as non-rebasing yet.

Ack, will do first thing tomorrow.

> Next time I'll maybe find an IRC gateway and ping you on that.  I can't
> find any reference to that being your preference in the kernel docs.
> Given you have a helpful page on tip, might be worth adding a note.
> I might of course be missing it.

I'll send you a private note after this.

> If it goes into a reasonably early rc, I'll just merge the relevant rc
> rather than needing an immutable. If next cycle, immutable please.

First one can go to Linus now, second one would go next cycle. Do you want to
base ontop of both?

> I started out a bit grumpy that I had to hold a non trivial series for
> a cycle because of an x86 bug (having been very happy when David
> fixed it incredibly quickly!), that got reviewed then disappeared
> down a hole and didn't look like it would ever be seen again.
> Meh, got me on a belligerent day.

No worries, happens to all of us.

Thanks!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
