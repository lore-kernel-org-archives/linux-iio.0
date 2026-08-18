Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987613AAF42;
	Tue, 18 Aug 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018619; cv=none; b=kl1QAOxcCY9uu2XlgW/BSFrqFnrcyiQZi+SXwsKLRWcRmIMDkCw/n9AFPGfwUgr2c9QattqblZk0bqFW3lJ9aVjJktDO52Ag7O2/E0ye9rYWV4kjwHxnRDy7TNupA3ARPmq5CW82cDXKUMxv8x6ct6+iX2UyMayel7kc257DNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018619; c=relaxed/simple;
	bh=90lMGZXyvcIhgMn1UFFjyqKpo08ba7VLxaEcBIGCskM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLGG00RajzTzCFNdfm2LxNePD29gCJKHg5Ti8JnDR945UPtF68rvWTLi0Jn1NUeXim4JSab6j7sMdAj+QybGilkYkzcyWSdeot8z2JD1/C/2n/k8g7M9t1jPpYUy5ypvxj6GiEKd9EggwRopQJOtI87NcxFsg/rv03iF3Us0GtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=El+VWeaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="El+VWeaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62041F000E9;
	Tue, 18 Aug 2026 02:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787018616;
	bh=SBhkfAAthfbaHIZydma87FUH4CZZVfaJC3R7WBc9SJE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=El+VWeazO6JGicCrX89GDXP4r22xutsmLwgn4Szi+iKa5PhcwrELYOIrdDACHnlcl
	 rF3HNCTiKdm9pQ2EO89E/lhOVgC8FCjRhb5xNFGV/8B5X3tj/aeo7MiGT2HXOJZa7u
	 qez7qMZxh9Hp6l7lg6Wa0bBu4iaHndHwfOMmVGlD17qmy1SPXzepKAD+KyqerH9cSV
	 mvQNC43qmLPAJEshTecGoBov/8RrVtoopuKwZe1R4mfdImwxzNTi3K+3B3TpVYeEpQ
	 tFK/RRuJvxIemwM3B3lCbLx/czIi4oeJ2hCWQP/seJGa29RDV6AOCbySRr3wpkrsCa
	 0knFAlnTqVZXg==
Date: Tue, 18 Aug 2026 03:03:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@linux.dev>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>,
 0012-iio-accel-kx022a-Fix-IPOL-macro-name.patch@mva-rohm, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Mehdi Djait <mehdi.djait.k@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kalle Niemi
 <kaleposti@gmail.com>, Topi =?UTF-8?B?U29ua2Fqw6Rydmk=?=
 <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 12/12] iio: accel: kionix-kx022a: Fix IPOL macro name
Message-ID: <20260818030330.62158406@jic23-huawei>
In-Reply-To: <0498393a-1313-4781-8afc-6dab918233b6@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<c26c2741ca11adf7a089c094d8648f4ec6cbab54.1786347811.git.mazziesaccount@gmail.com>
	<20260817025351.5d3baf14@jic23-huawei>
	<0498393a-1313-4781-8afc-6dab918233b6@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 14:43:18 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 17/08/2026 04:54, Jonathan Cameron wrote:
> > On Mon, 10 Aug 2026 10:55:25 +0300
> > Matti Vaittinen <matti.vaittinen@linux.dev> wrote:
> >   
> >> From: Matti Vaittinen <mazziesaccount@gmail.com>
> >>
> >> The "interrupt polarity high" -macro for KX022A variant is defined as:
> >> However, the KX022A_MASK_IPOL1 is not defined anywhere, so actually
> >> using the KX022A_IPOL_HIGH would produce a compile error.
> >>
> >> Fix the define by using correct mask.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Fixes: 7c1d1677b322 ("iio: accel: Support Kionix/ROHM KX022A accelerometer")
> >>
> >> ---
> >> It appears the KX022A_IPOL_HIGH is unused as the IRQ is currently,
> >> unconditionally set level low in kx022a_prepare_irq_pin(). The KX022A
> >> hardware would support other configurations though. So, another
> >> potential fix would be removing the define altogether. I decided to
> >> leave the define there, as having it will allow users who need different
> >> configuration to simply change the KX022A_IPOL_LOW to KX022A_IPOL_HIGH,
> >> which is kind of a "easy to try" thing.  
> > 
> > Handling interrupt polarity options at the device end is typically a
> > 'feature' rather than a must have given in most cases we don't have sharing
> > going on and these days interrupt controllers can cope with most types
> > of input.  If anyone needs it they can propose support.  
> 
> I take this as a "please, drop the unused define rather than fix it".

Nope. I'm fine with fixing the define being there (fixed).
This was more of a comment on whether we should 'fix' whether we 
ignored the flag from firmware or not.

> 
> > Note I've never been happy with how we do this when we do support it
> > because the argument for letting DT set the polarity is there may be
> > not gates or similar in the path so the driver can't know, yet if we
> > read the type to set the polarity at the driver end we are saying we
> > do know there aren't any such not gate (trick for level shifting on
> > the cheap). I haven't figured out a better binding.  
> 
> I was more thinking of people who do downstream projects than a proper 
> upstream support including nice mechanism to select appropriate 
> polarity. It's quite easy to experiment (and carry a downstream patch) 
> with one-line define change. Especially so when defines are already there.

I'd rather we support them properly if they actually need it.
Ideal case they'd ask even for a downstream project and at that time
we can add support - via the ugly path or maybe something better.

Jonathan
> 
> Yours,
> 	-- Matti
> 

