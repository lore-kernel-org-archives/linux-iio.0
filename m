Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959BA20ED
	for <linux-iio@vger.kernel.org>; Sun, 15 Mar 2026 19:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773601314; cv=none; b=eobBLvS3Qe9LkfIZjE7LziemIUMNIl7OBQsYw/RSglXLEMnKYL3rDVK61cbCg2NKaelGiZd6tBpChujD8T5AtXMlyNXhQRwyiMcpWUR4J0WAELqj436gAcAyJCVHhG7kZjOPmDwtkFb79TBSXt0uVMyESZaPHjhziyVK6jWLqPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773601314; c=relaxed/simple;
	bh=gJ0VWmu251io7OWYleLM4RZc0SFRaOPnh4gdA5jVNf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pj28M0nkPi7f+oNNPnh4EtDktzLD2POyL3+EMmtFKpdDZruGguFzGO2rvyKrLKzATGF3YOrFZwt9kAyurXOtgKU5gASCGg6xCMwC67hRvrTSZcrxN9Nh0k5J8wkqk7KUW7a+mab0GIF9CFp30l/5jVRFPNknSwmjnOrd2AMjLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrXtxtIc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrXtxtIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6594C4CEF7;
	Sun, 15 Mar 2026 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773601314;
	bh=gJ0VWmu251io7OWYleLM4RZc0SFRaOPnh4gdA5jVNf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hrXtxtIcRH2OwlemvJo66ftBZ1LnT14Kty7dMo14+tL0ZQtlMbRLvmorxHg+yJGK6
	 g0/wnK8kUznN5s1hpBfmTkDpkNhNg1gOPLSECOQqq1AcOkGMXuYW/8fQA/Qded7Jxl
	 p65hLI4y/bu3qsTCWpoDs1fZh9nssQicclnVGUoL6QrWlLfJGNEIbU10qtoNoC5Ait
	 Ur9wyxrJtOg1OV9JF5f1UTuy7FQewMOUfUsqwzMKxj+Fpyn+2VERaUzM6InZD0rfTt
	 CHNybLtjqKWlTzc+4gL+qbSDcQKz59TgLqXLWXgWpBxMQ//0zvCjrFzXY0HdSvS/sI
	 N2Og4Cn+Kb8tA==
Date: Sun, 15 Mar 2026 19:01:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFC] GSoC 2026: Transitioning IIO to guard() and
 scoped_guard()
Message-ID: <20260315190145.4c9a1fb5@jic23-huawei>
In-Reply-To: <05eaccd7-b5b1-470a-abd1-2c2fc4b47e90@baylibre.com>
References: <20260311194624.1521-1-ethantidmore06@gmail.com>
	<CAHp75VeZb0pSiAkHo9QUeS+2L-qP_83-dKKRSp7-1VfZrtr1bw@mail.gmail.com>
	<20260314110758.2fc20704@jic23-huawei>
	<DH2PF86XN60W.2MVDUHLKPR7LH@gmail.com>
	<05eaccd7-b5b1-470a-abd1-2c2fc4b47e90@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 13:34:12 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/14/26 1:08 PM, Ethan Tidmore wrote:
> > On Sat Mar 14, 2026 at 6:07 AM CDT, Jonathan Cameron wrote:  
> >> On Wed, 11 Mar 2026 22:18:07 +0200  
> > 
> > ...
> >   
> >>
> >> Hi Ethan
> >>
> >> I'm not keen on a mass cleanup like this without taking a closer look at
> >> the drivers. I would say (based on gut feeling rather than actually
> >> having checked the stats) that perhaps 25% of these patches result in
> >> feedback on the surrounding code or follow on improvements that are
> >> enabled.   
> > 
> > That makes sense. That would be a ton of time spent on reviewing this.
> > 
> > ...
> >   
> >> As to the your question on how this 'might' be done, it would need to be
> >> 1 patch per driver because this will cause chaos for backports of later
> >> fixes due to significant churn.  
> > 
> > Yeah, that kills the idea entirely. I was hoping it could be done per
> > vendor per dir but, I understand why that wouldn't work.
> >   
> >>
> >> There are ABI changes that we want to push through the tree such
> >> as iio_push_to_buffers_with_ts() but that's because the new ABI
> >> is inherently safer and I want to get rid of the old one.
> >> Some of those cases are easy, others much less so.  
> > 
> > If a tree wide conversion to iio_push_to_buffers_with_ts() would be
> > wanted I'd be glad to do that. There is much less volume for this
> > project and if completed then a deprecated function could be removed.
> > 
> > $ grep -rn "iio_push_to_buffers_with_timestamp" drivers/iio/ | wc -l
> > 73
> > 
> > And this would be much more manageable to review. Would this be a viable
> > proposal for GsoC?
> > 
> > Thanks,
> > 
> > ET
> >   
> 
> I think most of the same advice still applies. It would still take
> significant review time because there are usually other issues lurking
> under the surface. We could probably handle 3 drivers a week or so.
> 
> Getting them all done would be difficult, but not impossible. :-)
This one I see as more worthwhie (and many are really simple like-for-like
with the buffer locally visible) so I'd make time to review
these in say groups of 10 simple ones, or smaller number of the corner
cases. Trick will be get the simple ones out the way first so we can
focus effort on the harder ones which will take real review time.

I don't like have that old interface around and if someone else will
do the work to get rid of it, all the better!

Jonathan

> 
> 
> 
> 

