Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2EF1FC8
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600107; cv=none; b=JUFASvf6m9N8nA5Zb+XAb8d7V3kGmJGD+06ZGkDiHTY830syhzPs5wb8P0vy6AFvD7wsXA+bdhrxq9V3yWRi0qj2N7eKYRmIOG2ZRbQw6lyXFH83qI2PjrOk8usYA6/S0pAZqPY/wRfYCrjmL5+uM01m/Cwsf2nZ+3su3vLkdH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600107; c=relaxed/simple;
	bh=SGcNK1yoxvTUP7CPCuhD9SHwUADasESSEURxD+/7YAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnrmqiYijXvu6YZPKdee4shqvGiKieNAEn7fqquoOA1/G7hS4VxTABPeaOCgDKzm0PCKpYvAeJptqhpcHb1lshdW/sum+14ChFuNB6sKiNmXMAJu9a5wyhNbat+/zYZBdNbF4kyDV92r8UHwEDRnuYEHqn7MA9fP+T/OfcEYHQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsPlm2sc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsPlm2sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48664C4CEF7;
	Sun, 15 Mar 2026 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600107;
	bh=SGcNK1yoxvTUP7CPCuhD9SHwUADasESSEURxD+/7YAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lsPlm2sc5i49q6Kj8UNmYKtW3SJJDjSs6ApTit9k2E4CpQi94t3zeqBbUksfKK186
	 U7mzt8Kc6WU7hRmLGNDr4RwhM2gB1GOlQW1e9MoZH/yQgExAiiR/BtmDS6Al1GoST9
	 iSGa3VCTLrj5IptAr/oklUj/QynDX1TzpArcL99EkCqutaaKRD6jJKduHQ+8QzVd9/
	 ww7l+O2tZX+SvIymyna9iLN5aLFv4Ki62pHPMnuJSnYzySWNk8vBBCco0mtMZjNaUV
	 rLShrVAK7t8WGu94uYQDFAtWP4KcC5C9tuN67PNR+qBtbGJJRx4XEbq8ugzVfZNEH6
	 m8tvNwWpgKSkQ==
Date: Sun, 15 Mar 2026 18:41:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>
Cc: "Andy Shevchenko" <andy.shevchenko@gmail.com>, <andy@kernel.org>,
 <linux-iio@vger.kernel.org>
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
Message-ID: <20260315184140.6f34f76a@jic23-huawei>
In-Reply-To: <DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
	<CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
	<20260314110758.2fc20704@jic23-huawei>
	<DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Mar 2026 13:08:04 -0500
"Ethan Tidmore" <ethantidmore06@gmail.com> wrote:

> On Sat Mar 14, 2026 at 6:07 AM CDT, Jonathan Cameron wrote:
> > On Wed, 11 Mar 2026 22:18:07 +0200  
> 
> ...
> 
> >
> > Hi Ethan
> >
> > I'm not keen on a mass cleanup like this without taking a closer look at
> > the drivers. I would say (based on gut feeling rather than actually
> > having checked the stats) that perhaps 25% of these patches result in
> > feedback on the surrounding code or follow on improvements that are
> > enabled.   
> 
> That makes sense. That would be a ton of time spent on reviewing this.
> 
> ...
> 
> > As to the your question on how this 'might' be done, it would need to be
> > 1 patch per driver because this will cause chaos for backports of later
> > fixes due to significant churn.  
> 
> Yeah, that kills the idea entirely. I was hoping it could be done per
> vendor per dir but, I understand why that wouldn't work.
> 
> >
> > There are ABI changes that we want to push through the tree such
> > as iio_push_to_buffers_with_ts() but that's because the new ABI
> > is inherently safer and I want to get rid of the old one.
> > Some of those cases are easy, others much less so.  
> 
> If a tree wide conversion to iio_push_to_buffers_with_ts() would be
> wanted I'd be glad to do that. There is much less volume for this
> project and if completed then a deprecated function could be removed.
> 
> $ grep -rn "iio_push_to_buffers_with_timestamp" drivers/iio/ | wc -l
> 73

It's definitely wanted.

> 
> And this would be much more manageable to review. Would this be a viable
> proposal for GsoC?

Perhaps not on it's own - I'm not sure as I've never been actively involved
in GSOC.  One to discuss with the folk running the kernel projects.
I don't know how open they are to this sort of (mostly) mechanical
cleanup.

There are a bunch of other bits of historical stuff we'd like to get rid of.
Converting drivers to read_avail() to cut down on hand crafting attr or
using the macros in iio/sysfs.h that mostly should go away.

I also have been thinking it would be nice to figure out a cleaner
solution for hardware fifo related attributes which are a case the core doesn't handle
at all today. That was fine when those drivers were rare, but they are getting
more and more common and that stuff certainly looks ugly.

Jonathan

> 
> Thanks,
> 
> ET

