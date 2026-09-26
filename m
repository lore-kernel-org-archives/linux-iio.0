Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A8A30E858;
	Sat, 26 Sep 2026 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790384501; cv=none; b=EEaa/rmMOQ6jeQak34o1+ozU4+71ILI9hW/TPr+VOuLvICDRnm33lUuD3Dpu/O6S3cl3Rg+bVo7+LVhu0OoUufEe1jhTua0DLTKiSybegZBrn2Id/elu9U6ZPKlHoIGiaQpBMpPxemsACDdBT+QVqwX+Mo0ekY0ySQNTmL/3ZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790384501; c=relaxed/simple;
	bh=WCM/Z7enFyM5Bk18cIfAZtmGL+pbvuTN+IBrXFve4rQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gir3evkNsrJaliWBwui2F7tUYGR3SG2NnVgcy77eM9pb0HT3Tlsnxy9Gnsj+JfnGpFeiQZjHX341SwCShsuPTC/gnEHJAp4Jh4b5RDo34JAhZAbMFuZ/uzMKfpq/mT6+OdEN4sOup9fSKJnz+eOY5y9ds5WZF7zSMcH8S/9+8BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5sNKMx7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5sNKMx7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA7B1F000FF;
	Sat, 26 Sep 2026 01:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790384500;
	bh=o3jc6OMeXfvVnh0p34oh6Oi7jzZHTaQhPi/PXeh+Xq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a5sNKMx7Btm/I872/rcSO2PRGlZqmcYPg/fe414ff1Fi0DVrlTrXBzANbfcEC/rVf
	 gCm3sfW0fMZ0cXDDcthb1jyW8RUnE3C/mlBCsZMgBuWhUAOk7shTK7KeCRLMnVeNV6
	 40qnsguCovSqdcz35Hk2IRTDmVFRLq3U148IEwtjlcoMpWSrK9QXp+LS/RIPJox5UG
	 SzVdhDJkhPGJTj3lKfkz5DrCrDZs85BuCJVWKQliOO7A/hVu/g1l/eRjNcP1WyHio2
	 z4vbuk+1Gvfi+Yu2THJeqRXZzCEfKgo9wAl0g8EKjD+/K2BDTLqzp74VLTJdcK+Efw
	 dQ/YOxW9yXn4Q==
Date: Sat, 26 Sep 2026 02:01:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Stepan Ionichev" <sozdayvek@gmail.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: bmg160: reject duplicate event disable
Message-ID: <20260926020133.3699a786@jic23-hlaptop>
In-Reply-To: <6b2f4eef.1cf6.1a0d8fc9ac6.Coremail.19888972804@163.com>
References: <20260925140956.2254877-1-yaojiale02@163.com>
	<araCndRmAqnX1K9k@ashevche-desk.local>
	<6b2f4eef.1cf6.1a0d8fc9ac6.Coremail.19888972804@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Sep 2026 22:33:48 +0800 (CST)
"jiale yao" <19888972804@163.com> wrote:

> At 2026-09-25 22:18:05, "Andy Shevchenko" <andriy.shevchenko@intel.com> wrote:
> >On Fri, Sep 25, 2026 at 10:09:54PM +0800, Jiale Yao wrote:  
> >> The IIO core does not filter duplicate writes to the event enable
> >> attribute.  
> >
> >Can it be done there once for all?  
> 
> I don't think the core can safely do this generically, since it doesn't own
> the per-event state and read_event_config() may reflect shared hardware state.
> 
> The runtime PM accounting is driver-specific, so handling duplicate writes in
> the driver seems safer. gp2ap002 does the same in commit 579c049b4cb6,
> refer https://lore.kernel.org/all/20260720193911.74919-2-nikhilgtr@gmail.com/

Exactly right.

Event handling in the core would indeed require complex mapping of
what can actually be enabled on a given device. Some of those we might
be able to represent with simple approaches similar to what we do
for avail_scan_masks for buffered channels but it is hard to generalize
and FWIW that concept still misses some corner cases of channel enabling
where drivers have to apply constraints in the actual buffer enable.
Those are rare enough that it isn't too much of a problem in practice.
Probably fine on 99% of drivers.

Events have simplre cases like:
- 1 enable bit turns a whole load of events on (we don't filter in
  the kernel - so userspace has to cope with surprise events).
- Always on event signals.
- Limited numbers of general purpose event engines (the ADI IMUs do
  this as they tend to have 2 instances). Each engine can do anything
  but there are only two of them.

We also have more complex ones like mode bits that flip a subset
of events from one enable state to another.  There are some really
odd rules in some devices because some upstream filter that is needed
for 5 seemingly unrelated events has to be in a particular state for
subsets of them.

Anyhow, all in all event control is a mess of 'original solutions'
from vendors and relies on the (naughty) get out of IIO ABI that
just occasionally any write to any userspace ABI element can
change what is read back from any other.

Not great, but I've never come up with a better solution for events.
If anyone wants to have a go at architecting a filtering solution
a bit like the IIO buffer demux maybe we can opt in to it from
some drivers.

I am wondering if it is worth registering a driver specific tidy
up events call though that would disable everything a bit like
we disable buffers as part of the userspace tear down.  That would
close out some races sashiko has reported.  That project would
I think be a lot simpler to implement.

Jonathan

> 
> >  
> >> bmg160_write_event_config() already ignores repeated enable
> >> requests, but a repeated disable request still calls
> >> bmg160_set_power_state(data, false), dropping a runtime PM reference
> >> that was not acquired for this request. This can underflow the runtime
> >> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> >> 
> >> Return early when the requested state already matches ev_enable_state.  
> >
> >-- 
> >With Best Regards,
> >Andy Shevchenko
> >  

