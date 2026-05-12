Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0B244685;
	Tue, 12 May 2026 14:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778597749; cv=none; b=iLldxHBhz4F/yE/gj6Gg+0LiArUSz0a3YHbexbzYqitxJhIlMVDeePUHNk2q61oHfKLP9OjG0s8U8hrN064bQ5ivV2hyq+Ml+LYJ9Dn15CCyAhe4eCD9un4uv89IzH5g4xDq5PCPyh1lAx8ps9qkhqADd+tUhs0v3JLr2VsJZCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778597749; c=relaxed/simple;
	bh=SmZPZPaW8Z15inC8PCsVHmZ/aVUuRGzdF8rt6LJYSJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EMC5Xi/7ciRexK9mxJZfDo0FpRngpxRP0DLXa5nC7/rXGr8ITwdFl9JDFJHQkKCexWwwlba9w/QLQZtUl17ddyPm6oITZoql24/aGGfsPUO6JOm5MpezMCc45eiFQU+8Ge0myUIJCg62kxeecNAqJe/OvN/gnJ5PiMbCCiuywps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaAxZHZH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaAxZHZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299ADC2BCB0;
	Tue, 12 May 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778597749;
	bh=SmZPZPaW8Z15inC8PCsVHmZ/aVUuRGzdF8rt6LJYSJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jaAxZHZH2/YatMOr61xnUs7uiL3K0RnH90uG7nH9JMIp0YnH4xxGJ6dWTAse8R74e
	 UktpgdfVMmUHvS3Ab/6DiSvO7I35TF/Aw944opgtFzUiQpuGTJML4EZoMw6qMKkhv2
	 m+VlvAv61WDi4IH8VhLkMSmo2+/dxo+nbiTjSZ9AyD07EJ3JtauHOtHJm7E59Q2FxV
	 abUIvzo3zehDf4p1Gop2+L1Hxef6JZV6ZonH0g1vXwYy9RkzKdzGQzIS93wVjFzqji
	 DujssGmTBZx08Xqikck5aXqAkK59+Z4JqtaNKPmaquGdntF9ORA1fFsJkySE2qrSdz
	 Uquoxmh9dvj4g==
Date: Tue, 12 May 2026 15:55:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <20260512155541.1da40c49@jic23-huawei>
In-Reply-To: <CALoEA-y-bLur7tBnj61hXSnOdbJkco3zyAH8v_-y8+VFfVyEgw@mail.gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
	<agLu6wF3JhF9zZDN@ashevche-desk.local>
	<CALoEA-y-bLur7tBnj61hXSnOdbJkco3zyAH8v_-y8+VFfVyEgw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 May 2026 11:16:17 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Tue, 12 May 2026 at 11:12, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, May 11, 2026 at 01:26:09PM +0200, Joshua Crofts via B4 Relay wrote:  
> > > This series is a continuation of the previous ak8975 driver cleanup
> > > effort, as most of the patches were picked.
> > >
> > > Changes include:
> > > - using BIT() and GENMASK() macros
> > > - moving to devm_* resource management
> > > - adding a scan index enum
> > > - moving from using wait loops to iopoll functions
> > > - various code style changes  
> >
> > Thanks for doing this!
> >
> > Jonathan, the same Q I had in previous version round, can we get some patches
> > applied to reduce the burden of the series? (I think of 1, 2, 7, 8 and might be
> > more.) As for the series, I think if this version is still not good enough
> > (patch 3) we need to rearrange it so that patch is going to the end (as much as
> > possible) of the series, so we want delay the 'good' ones to be applied.  
> 
> IMO all patches excluding the shared resource management patch are good
> to go. I can send a new version reordered to reduce the headache.
> 
I'll see what picks up easily then you can reorder the rest.

Sashiko indeed not happy with patch 3 and the issues around runtime pm.

Jonathan
