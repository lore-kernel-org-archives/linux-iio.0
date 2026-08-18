Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB62626AE5;
	Tue, 18 Aug 2026 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036877; cv=none; b=FfrMWyaq0T2FV8iNDTPy3l8DNZFpv8vBFsfdBNtm9agMRwv1WHMI0JcTe1iXuleqEYsdyMRq00K7j5N9Hw+i8SdIRJ2sw0Fj06+Ou0VP6i1wemKCW1s05p6IJrQhRg4vgGTF2LsyTR6nDFmMiLDmbpIdYqrPNIujoEKAeyJv7cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036877; c=relaxed/simple;
	bh=VWQ5f74u8mziLiEFPHUai/p+QI3soWxGbSFYBD5q6W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ji/87tA8KYc3XeiyH/tVMibBwQnfrhybqelzI72VI/jkgL1U9Vye4/RjLtiGBziFkh24Dn3FYzFjNBOMWAXTUgqzGdErYnJ1mg3VqZVs933b6YrhWnNPKZQx8SnAN2ika18SOh2cFb4vRi3BxkCauGrUnkK5xCfa64+3fAt8o28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gziy0j6X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gziy0j6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BDD61F00A3A;
	Tue, 18 Aug 2026 07:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787036876;
	bh=P2Y5pegapTsdtHvkjg1UBQ3syPjrq3TeS14D+GzcXhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gziy0j6XuhLLpxPfS/XQDs3mYyUHlAC68W6RSKfQxSVHJRLFsbFVfej4n2BnqD3wB
	 5dBQIej3cxDTmBuOIYUjoZKtIsYJJ++uP+Uk5WMb0HLBtZ4851ZAJIh2z8VTEkIWxb
	 dF3URPnbkreyPislZpYxNpt8X6kHb492jk0frqMJekwtZTjhmJjNMXhgIHc7CIyhTH
	 C1dALmceCqgDS1B4B0mUk/fV6HK1jmHqGYysCPjekYQPu8AGobbSEnDCBeig+3GkNs
	 OqwsUPhZ7AQZnIjeY/+R0D10PmXjTaCfILdEQ4GC2GN31cICqTm2/HGb+HFsBN9774
	 cEPJ1Xa0TheBg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wwDvN-00000000m2f-2Efw;
	Tue, 18 Aug 2026 09:07:53 +0200
Date: Tue, 18 Aug 2026 09:07:53 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend cleanup
Message-ID: <aoQEyeHUiTwWenBL@hovoldconsulting.com>
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
 <CALoEA-xEgXWaGxQwfh6HsrOMkjjCeOf5RtO1GuF7=rvN6ff5JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xEgXWaGxQwfh6HsrOMkjjCeOf5RtO1GuF7=rvN6ff5JA@mail.gmail.com>

On Fri, Aug 07, 2026 at 05:02:32PM +0200, Joshua Crofts wrote:
> On Fri, 7 Aug 2026 at 16:46, Guangshuo Li <lgs201920130244@gmail.com> wrote:
> >
> > srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> > power GPIO is present, but srf04_remove() does not call the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > The runtime PM documentation requires pm_runtime_use_autosuspend() to
> > be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> > removed. Failing to do so can leave the autosuspend usage state
> > unbalanced and may result in a usage_count leak when the autosuspend
> > delay is negative.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call in the remove
> > path before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 2251157b335b4 ("iio: srf04: add power management feature")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> 
> Since this has a Fixes: tag it should also be marked for stable.

I stumbled over this comment when looking into why these were marked for
backporting (which I don't think they should be).

And no, having a Fixes tag does not imply that you should CC stable.

A Fixes tag indicates which commit introduced a bug, but that in itself
does not imply that the fix meets the stable backport criteria.

Johan
