Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4F3644CE;
	Wed, 25 Mar 2026 20:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471154; cv=none; b=pjEWG7zaq5VKgqzkfCcg28b3SaaEJDKQu7hmp/KIYkf+HkmYkBsTW1ypgPQy6AvQfyoYWZcN0MdxP5i3ixrzZ7VrLYtPA43RJ4nU8izXuJGHVL3Of3DRw/dB6PDQfW4Ond5gQI9SwV+G6f76o2jFnjo/WsTFMf1Yn5WEurkdMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471154; c=relaxed/simple;
	bh=zi5Z2s/k9jiTHswH61QNETmaHq+2KETeNaUnEXw8byU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otxUeGfTvO3xfZkGMEUXc+E4FGyEVPEhr0O3gtNaO75eWZ/O0LqrXdPdQh6yeYnUWHxsMRG4YTdSz/vrBOOQZW73XXFe8dT8+kdAepyIetcxeAOfqAVqpdaED4wIahKmRyqEjqx7ud64k4gtWZor6be1mfkhofen+i6Ms0j0AJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lj+E8u0W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lj+E8u0W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4372FC4CEF7;
	Wed, 25 Mar 2026 20:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774471154;
	bh=zi5Z2s/k9jiTHswH61QNETmaHq+2KETeNaUnEXw8byU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lj+E8u0WUnpIziLM2wNXjk8xzjZbThQ3WLRG7f0B9nflhQSv/T1s+d0FUIs4vLYtm
	 +xXH+6nL9IWIWW7ZPMIMydBwiIPAa2VtaK6Uh5fCGA8m/WKWuSWMqwtWKKqmpzHw6d
	 BrnIqQbX/deWeeEC8XMb/xaLtdxk0dvtWzXegCICEBeQoY42w7JmjYmoyOVF4ygx8Y
	 4FHevfErqrsQLxsUlpQacVA/MZ9RWTgNDJHhYlhEZYnGPlMjdXaU/Rn/mDrrt0ID/h
	 vodGR9oNqbvJCSb5FGLYm7QiQ25LF2Loo1Pv5JiASxEuMM3RcjQpH/frEncrA9wJ1A
	 JTJhICva4+4Kg==
Date: Wed, 25 Mar 2026 20:39:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <20260325203907.6cdca48d@jic23-huawei>
In-Reply-To: <acP3aiLCZkYEXhqc@google.com>
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
	<20260321210539.2de04bc0@jic23-huawei>
	<acBtUzrkMGK2Wd19@google.com>
	<acP3aiLCZkYEXhqc@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 07:56:31 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Sun, Mar 22, 2026 at 03:30:21PM -0700, Dmitry Torokhov wrote:
> > On Sat, Mar 21, 2026 at 09:05:39PM +0000, Jonathan Cameron wrote:  
> > > On Sat, 14 Mar 2026 16:12:24 -0500
> > > David Lechner <dlechner@baylibre.com> wrote:
> > >   
> > > > Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> > > > when writing the timestamp in the rx_buf.
> > > > 
> > > > The previous implementation would have been fine on architectures that
> > > > support 4-byte alignment of 64-bit integers but could cause issues on
> > > > architectures that require 8-byte alignment.
> > > > 
> > > > Fixes: 902c4b2446d4 ("iio: adc: New driver for TI ADS7950 chips")
> > > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > > ---
> > > > Since we were looking at this driver, I was going to convert this to use
> > > > IIO_DECLARE_DMA_BUFFER_WITH_TS() but then I noticed that we actually
> > > > have an unaligned access problem with the timestamp since we are
> > > > ignoring the first two elements in the rx_buf when pushing the data to
> > > > the buffer.
> > > > 
> > > > Unfortunately, this will cause a merge conflict with the series Dmitry
> > > > is working on. I don't think there is any rush to get this backported
> > > > since no one has reported a crash from unaligned access. Since fixes
> > > > should go before improvements, we could apply this to iio/togreg then
> > > > Dmitry can rebase his series on top of it.  
> > > I've done that. Applied to the togreg branch of iio.git pushed out as
> > > testing etc. I've also marked it for stable so it gets picked up in the long
> > > run.  
> > 
> > Cool, I'll rebase and send out my patches as soon as this hits
> > linux-next.  
> 
> Hm, I only see it in "testing", not in "togreg"...
> 
Should be there now.  I was waiting for build bots to take a first look.
They were clean so now pushed out for picking up by linux-next.

J

