Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1E34216C;
	Sun, 11 Oct 2026 11:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791717837; cv=none; b=iVG8jMgCJ/HHZ61cY8vZ9Bfovb142UKJYNa7enCst7xeAQpOgfWl1kuHGHC0u6hSjeOORIDTakqBTPlO8kQT0s8OAkPwdyAZso9l5bW9BuEzcCxk4XDkxdl96KPa5qfx7wVBWFllLlSTc+GOMldMCF5JnVG2x+KlN/hHFkmEqA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791717837; c=relaxed/simple;
	bh=CCferC2my1KTfiRlvoMZHvwLRRPxthwclodKSDzPpAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDtp4wOfEku1dCgwbZES4m6tOaCiDGZzDug4i1JKI2yJsIi9HjhjtELmvXwl3GqYhcBB73JaUwH19ZePG3/29RC98XfKzKEWVvBsG3dX53X6cukk7Uz5II0eV6PypkIN2rpnbqztHVb2lC8JOxrP7T3zHhIQiXheGdEjwofbxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJNe293a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJNe293a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE501F0089B;
	Sun, 11 Oct 2026 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791717836;
	bh=B+sTImV2OzP8xPaKYq6APrxAM++DsSPbzV5A+zRS8LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SJNe293aduo2+L1Mk5AtkOLI/nly1/xtEXT5TJzcVm4ZKK53bk/QdPzSXAQIB2/xT
	 WlCLamXGF7Q58nK9UxPnz3wXU8f56eXM+Yhpev+JVmNw4wSDfIZKAccjO1GPcSOZa3
	 v2Ikz5wTGi3UTdyS/pMgxgGeQy9kR9Zqb9xtpe0wAnlZAa5QiO1mEzbToda7XPbeWc
	 9yt+hSFBPrvrMwQX/8A4biO8vWdPFSRg/95BrT/QMAc1ZiibsDHjsDuf7P582PfEs+
	 vXrNARNRHy8IhTE6CIdtsCAtbVNUiJ8BSkZwJE2GIYaEowSuREaBtSxqiNY1jy31E5
	 ip9cGduAiErxg==
Date: Sun, 11 Oct 2026 12:23:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Stepan Ionichev" <sozdayvek@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: reject duplicate event disable
Message-ID: <20261011121422.5c7078ff@jic23-hlaptop>
In-Reply-To: <5d8fc46a.89bc.1a0e7525da7.Coremail.19888972804@163.com>
References: <20260925140956.2254877-1-yaojiale02@163.com>
	<araCndRmAqnX1K9k@ashevche-desk.local>
	<6b2f4eef.1cf6.1a0d8fc9ac6.Coremail.19888972804@163.com>
	<20260926020133.3699a786@jic23-hlaptop>
	<20260927181632.76bc1eda@jic23-hlaptop>
	<5d8fc46a.89bc.1a0e7525da7.Coremail.19888972804@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 17:22:09 +0800 (CST)
"jiale yao" <19888972804@163.com> wrote:

> At 2026-09-28 01:16:32, "Jonathan Cameron" <jic23@kernel.org> wrote:
> >On Sat, 26 Sep 2026 02:01:33 +0100
> >Jonathan Cameron <jic23@kernel.org> wrote:
> >  
> >> On Fri, 25 Sep 2026 22:33:48 +0800 (CST)
> >> "jiale yao" <19888972804@163.com> wrote:
> >>   
> >> > At 2026-09-25 22:18:05, "Andy Shevchenko" <andriy.shevchenko@intel.com> wrote:    
> >> > >On Fri, Sep 25, 2026 at 10:09:54PM +0800, Jiale Yao wrote:      
> >> > >> The IIO core does not filter duplicate writes to the event enable
> >> > >> attribute.      
> >> > >
> >> > >Can it be done there once for all?      
> >> > 
> >> > I don't think the core can safely do this generically, since it doesn't own
> >> > the per-event state and read_event_config() may reflect shared hardware state.
> >> > 
> >> > The runtime PM accounting is driver-specific, so handling duplicate writes in
> >> > the driver seems safer. gp2ap002 does the same in commit 579c049b4cb6,
> >> > refer https://lore.kernel.org/all/20260720193911.74919-2-nikhilgtr@gmail.com/    
> >> 
> >> Exactly right.
> >> 
> >> Event handling in the core would indeed require complex mapping of
> >> what can actually be enabled on a given device. Some of those we might
> >> be able to represent with simple approaches similar to what we do
> >> for avail_scan_masks for buffered channels but it is hard to generalize
> >> and FWIW that concept still misses some corner cases of channel enabling
> >> where drivers have to apply constraints in the actual buffer enable.
> >> Those are rare enough that it isn't too much of a problem in practice.
> >> Probably fine on 99% of drivers.
> >> 
> >> Events have simplre cases like:
> >> - 1 enable bit turns a whole load of events on (we don't filter in
> >>   the kernel - so userspace has to cope with surprise events).
> >> - Always on event signals.
> >> - Limited numbers of general purpose event engines (the ADI IMUs do
> >>   this as they tend to have 2 instances). Each engine can do anything
> >>   but there are only two of them.
> >> 
> >> We also have more complex ones like mode bits that flip a subset
> >> of events from one enable state to another.  There are some really
> >> odd rules in some devices because some upstream filter that is needed
> >> for 5 seemingly unrelated events has to be in a particular state for
> >> subsets of them.
> >> 
> >> Anyhow, all in all event control is a mess of 'original solutions'
> >> from vendors and relies on the (naughty) get out of IIO ABI that
> >> just occasionally any write to any userspace ABI element can
> >> change what is read back from any other.
> >> 
> >> Not great, but I've never come up with a better solution for events.
> >> If anyone wants to have a go at architecting a filtering solution
> >> a bit like the IIO buffer demux maybe we can opt in to it from
> >> some drivers.
> >> 
> >> I am wondering if it is worth registering a driver specific tidy
> >> up events call though that would disable everything a bit like
> >> we disable buffers as part of the userspace tear down.  That would
> >> close out some races sashiko has reported.  That project would
> >> I think be a lot simpler to implement.
> >>   
> >This one needs a fixes tag, as do the other similar ones.
> >Fine to just reply to each thread with the appropriate tag.  
> 
> Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
> 
Applied to the fixes-togreg branch of iio.git and marked for stable.
Note that I'll be rebasing that on rc1 (once available) before sending
out a pull request.

Thanks,

Jonathan

> >
> >Thanks,
> >
> >Jonathan
> >  
> >> Jonathan
> >>   
> >> >     
> >> > >      
> >> > >> bmg160_write_event_config() already ignores repeated enable
> >> > >> requests, but a repeated disable request still calls
> >> > >> bmg160_set_power_state(data, false), dropping a runtime PM reference
> >> > >> that was not acquired for this request. This can underflow the runtime
> >> > >> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> >> > >> 
> >> > >> Return early when the requested state already matches ev_enable_state.      
> >> > >
> >> > >-- 
> >> > >With Best Regards,
> >> > >Andy Shevchenko
> >> > >      
> >> 
> >>   

