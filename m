Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D40418B0A;
	Sun, 16 Aug 2026 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786917271; cv=none; b=e8YUehYWC8qyDXZBAIW+iriXdVxfe/RNgYAiYJb8MWWR8E3k97VVtHdiFSbSQtvoea6+ztj8sM3PkSndctFmAUCFu6SbT+WhzkOyhN4cI62VWl45UxyEdWybYKemABLOfYFz8EWFRxPRY4BTu4I954MJzSrQOWNBwSGMvGLhuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786917271; c=relaxed/simple;
	bh=hREXI4wwOw1LBmsGhZlQp8QFxWSTkTI4eWSOcR4ufzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFxpEZwezS0Fzg0WfSPxsAq6GIBhEpsGbEu/N9fJN5RaBSkDmEx/jiKdmXss8WGTSiLRgOCTaVCFT1o61I05Dc1e78IFHK3j/HbG2DBI48Y1ipYI6JZ8BMWTv2Rs+LWzGuD4/oObCHRd04G5Ut30nvWEHt6R7R5OKmcymQL8j9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYpB9koP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYpB9koP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC451F000E9;
	Sun, 16 Aug 2026 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786917270;
	bh=EDNSLLXUevqjoErRmT2EvxJMbxIRW7OLOhVI3JXFcpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SYpB9koPM32FHtyIEi+5EwIW+137Lr/eWMdsGDTsFD+IsINZWgUoivoWOqGKGXiIH
	 cdhDmjqrSB0ppA34A3TqtmRZuAa3F9u0SO8u7PskoO8W0SWoeAFBA6WqaswbTxA5mc
	 C+DpOqgkVL/fwu+7GcfX411uMP3EYeNZXBqiG91YtnOl5CthY3OrypdvTWAUfuvXSw
	 SEOCaYApmqFAbCMOLJHOhLn6YKwwOStAuj/ISP9VIrwyX8DTpa7CR/8C2//HTEk5U0
	 MRG9YtjXCyQk30xlm91zN7SHSYPIJHBwLz/ATD81u738mKKaQZAB2ez/b2ziNtKamW
	 2D7DAZZP8yhiQ==
Date: Sun, 16 Aug 2026 22:54:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Kurt Borja" <kuurtb@gmail.com>
Cc: "David Lechner" <dlechner@baylibre.com>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <brgl@kernel.org>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
Message-ID: <20260816225424.27c9d223@jic23-huawei>
In-Reply-To: <DKME9LSBXSXA.28PS1V6ZAH79O@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-7-f89925d72792@gmail.com>
	<1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
	<DKK9S36LB543.2T124NE3TNETN@gmail.com>
	<f3ea3859-aff1-4c15-9302-095119faec78@baylibre.com>
	<DKME9LSBXSXA.28PS1V6ZAH79O@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Aug 2026 15:24:46 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Mon Aug 10, 2026 at 11:31 AM -05, David Lechner wrote:
> > On 8/9/26 3:28 AM, Kurt Borja wrote:  
> >> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:  
> >>> On 8/7/26 10:58 PM, Kurt Borja wrote:  
> >>>> Add triggered buffer support and a data-ready (DRDY) hardware trigger.
> >>>>  
> >
> > ...
> >  
> >>>  
> >>>> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
> >>>> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN);  
> >>>
> >>> don't need second one to be aligned, they aren't independent.  
> >> 
> >> Ah, I forgot this observation in the last version. These are used in a
> >> full-duplex transfer, wouldn't that require for both to be on its own
> >> cache line? I just started learning about DMA.  
> >
> > No. In this case, it works roughly like this...
> >
> > - We fill the TX buffer before the transfer. (CPU access to memory may
> >   just live in the cache at this point and not actually be sent to RAM)
> > - We request to start the SPI transfer.
> > - The core SPI code flushes (or maybe I should say invalidates) the cache
> >   on the TX buffer. This ensures that what we wrote with the CPU available
> >   to DMA.

Extra fun - it has to flush the rx buffer too.  Because...
> > - The actual SPI transfer happens that uses DMA to access both TX and
> >   RX buffers. (Again, could just live in a cache and not be sent to RAM)
> > - The SPI core code flushes the cache on the RX buffer. This ensures
> >   that when the CPU reads the memory, it will see what the DMA just
> >   wrote.  
If the RX buffer had old dirty lines (could have been used for something
completely different) in it, that is modified data that hadn't
been written back to RAM, then this flush would wipe out the hardwork of
the DMA by writing those CPU cache held rx bytes over the top.

(Next bit is just to scare anyone who thinks they know how this all works -
completely irrelevant here :)
Don't get me started on architectures that do clean write back (occasionally).
Thankfully I don't believe any of them also have non coherent DMA as to
be able to do that nasty hack you have to know no one can see it.
For more fun, one large CPU vendor thought that was the case and there is
a spec out there that has a magic flag to let the OS know it does this
because there are cases where you care.
</rant>

> 
> Oh, this makes a lot of sense.
> 
> >
> > Since there isn't a time when CPU and DMA both write to the cache line
> > at the same time before a flush, there is never a time we could have
> > an issue with stale data replacing data that had not been flushed.
> >
> > It does mean that we can't update the tx buffer for the next message
> > until after this message is done, but we have to do that anyway.
> >
> > What does cause problems is if we just had a regular unrelated variable
> > after this in the cache line and the driver updated it during a SPI
> > transfer. If this new value was just living in the CPU cache, then
> > when the RX flush happened, it would write over that new value with
> > stale data from the DMA's version of the cache.  
> 
> Thanks! I'll look deeper into DMA, it's very interesting.
> 
Wolfram Sang did a nice ELCE talk on the more normal flows for this a
few years back when he was working on reducing copies in the i2c subsystem.
https://www.youtube.com/watch?v=JDwaMClvV-s&pp=ygUQd29sZnJhbSBzYW5nIGRtYQ%3D%3D
Is the one I think.



