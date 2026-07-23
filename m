Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E7840B0ED;
	Thu, 23 Jul 2026 23:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849114; cv=none; b=F/Fdibg7itPT0QyNXzAm7B01Gx6S441Hydb+K2CDtJR0T5XX27+9V43gxtevazrDSp7Zf03c5iZPCFtnUlJkGd4XgW5+8FV1J2UaJjBAh+VEc+T8/vjLqRrzdb+G3ByWeuWIq2Fqzk2zoynUhoeosvIKTmpC7BAXG4Th20PsuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849114; c=relaxed/simple;
	bh=RvFzBzYzArkmBLsuamj0bKNRYY1+HoTS9pYGfhO6joI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z13IfRYiuQNhvzujvh4M7DRnppBsMPbPRC1Zc4cK5wu3LzwmiPnHjqGVy4w2XdexDQzicN+fmYpOEjsIm5U81QAsGsKQyigNunDnwxamYaBtKTH96exG9Ik9Y3sPUhQmqSJGilBrXLXunDhzlIUTa+vArqI/L8Q5vrOCiykYWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHZamSOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHZamSOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBB81F000E9;
	Thu, 23 Jul 2026 23:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784849112;
	bh=JBe4NscLq/hf7ZGAdF/CUOznX7tcAvEtK6uzgB8k7wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LHZamSOaTuCcmkunlmSVS/lr0WLxHn5EAKl6o8tNj/q9dHIYudQOpljto5AJSEtdL
	 tkw97G3aZgGkMaEzwO6Flp/DQJYK5hIFu8OsAtXAER26Ou7b7BGe7CZ+bYb5ycHGgl
	 5mZKkrFfLU8nhF6gOD0sigqbVIJ31F688UTJ8TwSvJr2Hlf7DZ22L0d/6qlD0NNsQc
	 kQegTvZEGdiEUwCFKbdnm+sbKo9t6Q/ooK2QAzlH7lVvY4TRvhFKj71f6VJM/3gH32
	 bUM78HoV6MWa6WSXD9ZbIgQl9nJ2v9DlSiv/Tld1P3XULiD1ORYHeFy6yElNcE/CFJ
	 +/gwkWs+jbkkw==
Date: Fri, 24 Jul 2026 00:25:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chris Hall <c-hall@ti.com>, Patrick Edwards
 <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien
 <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ti-ads112c14: add support for buffered
 read
Message-ID: <20260724002508.7e176510@jic23-huawei>
In-Reply-To: <7a600363-ae61-48db-a0a2-34b9a4919b6d@baylibre.com>
References: <20260714-iio-adc-ti-ads112c14-buffered-read-v1-0-fe6e1c971288@baylibre.com>
	<20260714-iio-adc-ti-ads112c14-buffered-read-v1-3-fe6e1c971288@baylibre.com>
	<20260720015527.0ccc543d@jic23-huawei>
	<7a600363-ae61-48db-a0a2-34b9a4919b6d@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Jul 2026 18:23:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/19/26 7:55 PM, Jonathan Cameron wrote:
> > On Tue, 14 Jul 2026 19:19:32 -0500
> > "David Lechner (TI)" <dlechner@baylibre.com> wrote:
> >   
> >> Add support for buffered reads using a triggered buffer.
> >>
> >> The device has a continuous conversion mode, but that can only be used
> >> with one channel at a time since there is nothing like a sequencer to
> >> support that in hardware. Instead, we use single-shot reads like we do
> >> for direct reads to be able to read multiple channels.
> >>
> >> Support for continuous conversion mode could be added in the future if
> >> needed via a 2nd buffer.  
> > 
> > How about enabling that if only one channel is requested?  I vaguely recall
> > us doing that for another driver (though I might be dreaming :)  I did
> > see your comment in the cover letter about it affecting timing and that
> > making life complex.  Fine to leave considering this for another day
> > but maybe don't suggest a particular solution here.
> >   
> Actually, my latest thought it to do it by trigger type. This chip has
> a DRDY interrupt that can be used as the trigger for the continuous
> conversion mode but we need some software trigger to the single-shot
> mode. It think this would take care of the timing issues as well.
> 
> The logic would be that if the self trigger (DRDY) is selected in
> the trigger/current_trigger attribute, then buffered read will use
> continuous mode and fail if more than one channel is enabled. If
> another (software) trigger is enabled, then use single-shot mode
> and allow multiple channels.

Hmm. Bit unintuitive but can't really be helped.

> 
> The timing issue is that (or will be since I haven't sent the relevant
> patches yet) there is a settling delay before the first sample. For
> single-shot mode, every sample is considered the first sample (because
> it is "single"), so the chip applies this settling time on every sample.
> So it might be good enough to just document that as a quirk of software
> triggers for this particular chip since they would be using single-shot
> mode?
> 
This is where it gets messy if settling time is reported. I guess acceptable
given it doesn't make that much sense for an external trigger anyway.
In theory if the settling time has to happen each single shot, we could
just merge it into sampling frequency (as no longer depends on whether
channel changes or not) but then we have to make that dependent on whether
it is the devices own trigger or not. Messy. I guess one to paper over
as a quirk / corner case and document as you say.

> 

