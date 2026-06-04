Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48603401480;
	Thu,  4 Jun 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569474; cv=none; b=TlkR9JGXdBWMFLZ2SECqL3o+oRpIP/IYiLvQ+c5nUqHtIHMUQHLQ9PrrrE5L4ECXITXhc+C3eLupzfgTux4aJ7J5mPXReaP2jCnrg7R+HWKul8pIBYUMVAfnVZWAYkZwe/uLgEfjJurcJN+/E+CgV1QSE53Tw+t0ehVI7wD5POs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569474; c=relaxed/simple;
	bh=c5RpBLqWlICFbIobg9nqlCNhrruLQfpGcYrA/xs7Zbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MkHPQoWtsfWcyyzg7+5GsltsyyVDvR0t6d6Hzbu1LePiil4xHWTjYz+WHx7O7CMmYPewuJV90wI83yBhXXg9xNc6QNrVroPFzmFDcdInCXb2h0Z+cJFyT1ESblOYYHUnGdeOp5iu86wEnEoocaaJxs8WgB7deyqJ0TqvciN4gOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eF2hDYEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eF2hDYEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B64F1F00893;
	Thu,  4 Jun 2026 10:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780569471;
	bh=ZcBh0Lca+Z3zK3SpF1noQ+gU9c/xq6vt/xeZ0e0WeM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eF2hDYEMQZSmCJiQWOL2xR8t+NE3zncfpe5Vnlu6e5UNYEwtg9NtE4WDwyoZeDsif
	 dr4cr3q/7P9gJYlfyXdSU78UOi3WdsiDI+/TQUTNglTWxIovgTYnRQ3wlbPecGRQWc
	 jZO7pBuoM/dQ23z3Y62R/EIyu2vd/HHGR/imVLC0PW2aB4P5WrApP+olGE2bEgwoEm
	 hlZWKGrY3F3QpI9iBbUdhEgfYe06cPW/PACOGEhXAOK5suSRinUn2hRBXpi65a6dOa
	 1GYmJEtXQKtQTcBttKTE/zmS8BX0CmToC/unP0E0yqwWJ1kUqqBC+ZMkgYMzVAt4Oi
	 M/Vge0Bnekyyg==
Date: Thu, 4 Jun 2026 11:37:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Aldo Conte
 <aldocontelk@gmail.com>, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v3 4/8] iio: tcs3472: use ! instead of explicit NULL
 check
Message-ID: <20260604113743.1231ccfe@jic23-huawei>
In-Reply-To: <CALoEA-zCeWEAOAQGi8pQ_R7Sqify6Z=BegMuV1nx5fKH7OUvtw@mail.gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
	<20260522123420.45495-5-aldocontelk@gmail.com>
	<aiE36_SrwCvwLYTu@ashevche-desk.local>
	<CALoEA-zCeWEAOAQGi8pQ_R7Sqify6Z=BegMuV1nx5fKH7OUvtw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 10:38:18 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Thu, 4 Jun 2026 at 10:31, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Fri, May 22, 2026 at 02:34:15PM +0200, Aldo Conte wrote:  
> > > Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in
> > > tcs3472_probe() to follow the preferred kernel style.  
> >  
> > > Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>  
> >
> > Joshua, even if it's not written in the documentation (or unclear) the idea is
> > that whoever formally suggested the change has to acknowledge it (Acked-by is
> > enough, but full review is superior, of course).  
> 
> I see, thanks for the heads up. Not sure if Jonathan will add my tag
> at this point,
> nevertheless
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> 

This is burried under a merge so indeed unlikely I'll add tags.
Still good to have a record on the list for anyone who looks back.

I rushed things a bit because today is more or less the cut off for
anything making this cycle.

Thanks,

Jonathan
