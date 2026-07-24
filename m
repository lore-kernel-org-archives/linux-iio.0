Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2C637DEBE;
	Fri, 24 Jul 2026 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784928861; cv=none; b=pulEfBZ/2iCBxHdKZQGiDBc2jSTkGNKYNEYgf4AsbIX0FFqQcyNamJHpZaFpWxii3qqr5ShSmLIgucsyZWnN/3dc4uaJ6j/DrqXFiiLXOulIR9rHUhD/HPP2Mj39AjN48t4kDfDTOAB6afkU28664QXOAUzQ3YRRNZgQJNq2ok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784928861; c=relaxed/simple;
	bh=nvaNCIQkRv5qvJm19UduDDybD+inaZ2H7dRZRa93/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZjyN5Sm3JhQu/DyqhpKvfkbcJHU625CXOU+sGwZE3w8amIHcPkWADP5X+9kap1x4eEmAOt9SrunN8Y1DHgwLGdABtfEhPLBeNAKjfdgZHcZk3i9zaRR2x+hstaVdupO4OTvcvFKAElRR0bMalhTDBFbL4oH86fnRvvSFNloDY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/cR5vcU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/cR5vcU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159931F000E9;
	Fri, 24 Jul 2026 21:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784928860;
	bh=m5L73AIz+nPHeGqR51ERCxEaDfShHT2wFBezXg+vhLc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H/cR5vcUpQpfhPokZSNv/TtGQOZ3rH8VlDWLhzg1+XnAX87KMadkRyim2V5VDGzWN
	 EdVyr3TFFP95pNF0AWhHYHcI2b8Gvyd0HM9yZPh2LXeQGlcxyVHQhm0DcIAg7G/AwI
	 h5D85BqSftYXnhkA7x9A09qnLmeWmcSQ6uEo9TWKvnNoBT1rhZo8XJ40yPTcnANhL0
	 LswGs8Y/EAZRWO5B50cfrwER87t2uSU/HSKdn2xHm5wBbV7jWrC/FJl050LcNHKOub
	 htjhID+vn7SjWsbtwIxVkHCvVIR+7h+eqtSjqbsfeOSaChe42yfkOPQ6UAH5fvaUki
	 akbBhKO5she6g==
Date: Fri, 24 Jul 2026 22:34:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered
 read
Message-ID: <20260724223415.5620190d@jic23-huawei>
In-Reply-To: <d8d69bf3-8fd7-41ed-8fd4-8b42e9165ac9@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
	<20260720015527.0ccc543d@jic23-huawei>
	<7a600363-ae61-48db-a0a2-34b9a4919b6d@baylibre.com>
	<20260724002508.7e176510@jic23-huawei>
	<d8d69bf3-8fd7-41ed-8fd4-8b42e9165ac9@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 09:47:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/23/26 6:25 PM, Jonathan Cameron wrote:
> > On Tue, 21 Jul 2026 18:23:58 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 7/19/26 7:55 PM, Jonathan Cameron wrote:  
> >>> On Tue, 14 Jul 2026 19:19:32 -0500
> >>> "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >>>     
> >>>> Add support for buffered reads using a triggered buffer.
> >>>>
> >>>> The device has a continuous conversion mode, but that can only be used
> >>>> with one channel at a time since there is nothing like a sequencer to
> >>>> support that in hardware. Instead, we use single-shot reads like we do
> >>>> for direct reads to be able to read multiple channels.
> >>>>
> >>>> Support for continuous conversion mode could be added in the future if
> >>>> needed via a 2nd buffer.    
> >>>
> >>> How about enabling that if only one channel is requested?  I vaguely recall
> >>> us doing that for another driver (though I might be dreaming :)  I did
> >>> see your comment in the cover letter about it affecting timing and that
> >>> making life complex.  Fine to leave considering this for another day
> >>> but maybe don't suggest a particular solution here.
> >>>     
> >> Actually, my latest thought it to do it by trigger type. This chip has
> >> a DRDY interrupt that can be used as the trigger for the continuous
> >> conversion mode but we need some software trigger to the single-shot
> >> mode. It think this would take care of the timing issues as well.
> >>
> >> The logic would be that if the self trigger (DRDY) is selected in
> >> the trigger/current_trigger attribute, then buffered read will use
> >> continuous mode and fail if more than one channel is enabled. If
> >> another (software) trigger is enabled, then use single-shot mode
> >> and allow multiple channels.  
> > 
> > Hmm. Bit unintuitive but can't really be helped.
> >   
> >>
> >> The timing issue is that (or will be since I haven't sent the relevant
> >> patches yet) there is a settling delay before the first sample. For
> >> single-shot mode, every sample is considered the first sample (because
> >> it is "single"), so the chip applies this settling time on every sample.
> >> So it might be good enough to just document that as a quirk of software
> >> triggers for this particular chip since they would be using single-shot
> >> mode?
> >>  
> > This is where it gets messy if settling time is reported. I guess acceptable
> > given it doesn't make that much sense for an external trigger anyway.
> > In theory if the settling time has to happen each single shot, we could
> > just merge it into sampling frequency (as no longer depends on whether
> > channel changes or not) but then we have to make that dependent on whether
> > it is the devices own trigger or not. Messy. I guess one to paper over
> > as a quirk / corner case and document as you say.  
> Yes, this is the direction I am leaning as well. The input chopping feature
> that we have been talking about has a similar issue. In addition to doubling
> the sample period, it also includes the settling time (2x as well) minus a
> few clock cycles. Even messier.
> 
For that one I think we need at least a readonly sysfs attribute to indicate
chopping is going on.  Then we tweak the settling time docs to include
a reference to chopping.

Jonathan

> 

