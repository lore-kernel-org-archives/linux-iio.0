Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AADB1DF736;
	Sun, 27 Sep 2026 17:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529401; cv=none; b=LobZaGPEXSgODreoso0pT+3zrHrvpTFKGcgYu0i9C+SnCmZx3Bsu27FaWJc89ER+GoYLt2lCJoGmtXYsH6m29cSMYnUGSbktL+jhYaMYnK2eOFOUmQan0qzyUm1f/JgBZyZBl16NuIPV4ZWglQWrPJ8XWP4KvKYvNySQwlDKRbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529401; c=relaxed/simple;
	bh=Gdai30PjBzWLZGdj5WZEr/OfE0c3yijYtn+GBcIo4no=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JXOhdOSw19tmoCnPoBhsD8SScBTm1GsX8x+K84s9ETZeNiUybshMw1Z6UIsC7JhRCdxJBw6/tLKMG8+D4PdItUKMLhg6WwxYS9onT7IwoKD8SRliuEQ7xYv12AmmnJ6izcxBTSofpqp3kJ2SQRcJ94xWGpPy2957iK4W4cepCUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt8xGnhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt8xGnhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785631F000FF;
	Sun, 27 Sep 2026 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529399;
	bh=bpOBFqR9/CyIrsFJP/ZVh16uI2vmK0AckLze3Xfu3G4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zt8xGnhj6PGRayAa7247FB50WWcuXXlRWwB07g/ILU7h6IK5649f4+arMDCQ5xqmS
	 gZI3s8OjsuKf2UZuntzekLsv/+3sTyqhJIGZnvskSKB4sByjxvb7SEcTvO4qHyrYQL
	 mbILA40ronAvUVAjDLee3A774M45G6zCv7EzFJN1hDqAWYJYB+7ImPk2HnILcvuLwt
	 SuXX4s7mK3C2UOmbFQSvRfDCSjBCiOWqBmfdRsfUYGaym9i9bXzEFccfANUbW58KVD
	 x/9zOUuCHZjRi3xUhNTrceYX3LZ+Aat2GENvttG830SRXZnCcvdyMrkBuXkRIJQv3n
	 8bw/hYDzNB2UA==
Date: Sun, 27 Sep 2026 18:16:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Stepan Ionichev" <sozdayvek@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: reject duplicate event disable
Message-ID: <20260927181632.76bc1eda@jic23-hlaptop>
In-Reply-To: <20260926020133.3699a786@jic23-hlaptop>
References: <20260925140956.2254877-1-yaojiale02@163.com>
	<araCndRmAqnX1K9k@ashevche-desk.local>
	<6b2f4eef.1cf6.1a0d8fc9ac6.Coremail.19888972804@163.com>
	<20260926020133.3699a786@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 02:01:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Fri, 25 Sep 2026 22:33:48 +0800 (CST)
> "jiale yao" <19888972804@163.com> wrote:
> 
> > At 2026-09-25 22:18:05, "Andy Shevchenko" <andriy.shevchenko@intel.com> wrote:  
> > >On Fri, Sep 25, 2026 at 10:09:54PM +0800, Jiale Yao wrote:    
> > >> The IIO core does not filter duplicate writes to the event enable
> > >> attribute.    
> > >
> > >Can it be done there once for all?    
> > 
> > I don't think the core can safely do this generically, since it doesn't own
> > the per-event state and read_event_config() may reflect shared hardware state.
> > 
> > The runtime PM accounting is driver-specific, so handling duplicate writes in
> > the driver seems safer. gp2ap002 does the same in commit 579c049b4cb6,
> > refer https://lore.kernel.org/all/20260720193911.74919-2-nikhilgtr@gmail.com/  
> 
> Exactly right.
> 
> Event handling in the core would indeed require complex mapping of
> what can actually be enabled on a given device. Some of those we might
> be able to represent with simple approaches similar to what we do
> for avail_scan_masks for buffered channels but it is hard to generalize
> and FWIW that concept still misses some corner cases of channel enabling
> where drivers have to apply constraints in the actual buffer enable.
> Those are rare enough that it isn't too much of a problem in practice.
> Probably fine on 99% of drivers.
> 
> Events have simplre cases like:
> - 1 enable bit turns a whole load of events on (we don't filter in
>   the kernel - so userspace has to cope with surprise events).
> - Always on event signals.
> - Limited numbers of general purpose event engines (the ADI IMUs do
>   this as they tend to have 2 instances). Each engine can do anything
>   but there are only two of them.
> 
> We also have more complex ones like mode bits that flip a subset
> of events from one enable state to another.  There are some really
> odd rules in some devices because some upstream filter that is needed
> for 5 seemingly unrelated events has to be in a particular state for
> subsets of them.
> 
> Anyhow, all in all event control is a mess of 'original solutions'
> from vendors and relies on the (naughty) get out of IIO ABI that
> just occasionally any write to any userspace ABI element can
> change what is read back from any other.
> 
> Not great, but I've never come up with a better solution for events.
> If anyone wants to have a go at architecting a filtering solution
> a bit like the IIO buffer demux maybe we can opt in to it from
> some drivers.
> 
> I am wondering if it is worth registering a driver specific tidy
> up events call though that would disable everything a bit like
> we disable buffers as part of the userspace tear down.  That would
> close out some races sashiko has reported.  That project would
> I think be a lot simpler to implement.
> 
This one needs a fixes tag, as do the other similar ones.
Fine to just reply to each thread with the appropriate tag.

Thanks,

Jonathan

> Jonathan
> 
> >   
> > >    
> > >> bmg160_write_event_config() already ignores repeated enable
> > >> requests, but a repeated disable request still calls
> > >> bmg160_set_power_state(data, false), dropping a runtime PM reference
> > >> that was not acquired for this request. This can underflow the runtime
> > >> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> > >> 
> > >> Return early when the requested state already matches ev_enable_state.    
> > >
> > >-- 
> > >With Best Regards,
> > >Andy Shevchenko
> > >    
> 
> 

