Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C425B093;
	Mon, 31 Aug 2026 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788142265; cv=none; b=QPdc9w/IOVj8BiDLtdqKxwqcoHgIQ8wOpi400n6mfF2KDMlkMk6Evp3tUoEELLEeG+4FaoJK3ztOWP1w/lL8F5GeSEM7BrCuj7lGZCa8JI8t+JEKuoFDG2UL8de6nyj2JZkUm9Z9EyRHJo1wuGjDBdtMuCcqbSzjVpGL1nD1Qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788142265; c=relaxed/simple;
	bh=YaOoMf94FzD0v7rOS2FNsADL67IVHeiA9cSabYztE8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcsCvDbm/oOIIa/U1FFvF/62x4+E4Kub1726D+ZSGR/erpfXR7aOmyRMQqZlrTnZKonNIV9KzUVnNVaapXOea2uNOdHQ+spRoqHaQvY66eS5XBnoIjiM+BtvaYqTCcS31ysvGsQQqFN3SwTE9Tj7YktywptQr3/YSC6skREZ0U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8fYOfok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8fYOfok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7311F000E9;
	Mon, 31 Aug 2026 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788142263;
	bh=vkyZ1f8b6Irt1T+MHj5caDYZ3HGOvaiJXa0mBGRsmjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=h8fYOfokplJSjYnTXG+ZnJ/P4ulaGGi/qVH8fODr/X/XKwBobAiB6ujQfI70WLQfO
	 E3VfpAVMmd0ktrx/ktTXj6HeGlO8xwm84/LFkVn3rYmqojwXnh1eUKmnafsOP5DPNz
	 Q9Lb2LeLBJloxfg69vgbLi+gQIQ1gui1hoOO9DHlGOPl9tedzrgHj/zI+OK8TtKt5h
	 DFOueOafQ813Yfgr2PVQXkX/D16VSxEERC02/sr3da9AQf78gsZv+4Kq7l0JJqfhtD
	 9GP7i213DbtXsTYaVutvEfr2sIJh9i+3oFzM4wI+GaEeiHGd0SWUHfk7/kBq7y8Y7+
	 Xitboc/BbAJKQ==
Date: Mon, 31 Aug 2026 03:10:57 +0100
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
Message-ID: <20260831031057.0e44cf67@jic23-huawei>
In-Reply-To: <DKZY65U6LPP1.AIH4CZKUGVWJ@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
	<20260807-ads126x-v3-7-f89925d72792@gmail.com>
	<1b6b6981-1a08-42a2-a03a-4366b980da13@baylibre.com>
	<DKK9S36LB543.2T124NE3TNETN@gmail.com>
	<f3ea3859-aff1-4c15-9302-095119faec78@baylibre.com>
	<DKME9LSBXSXA.28PS1V6ZAH79O@gmail.com>
	<20260816225424.27c9d223@jic23-huawei>
	<DKZY65U6LPP1.AIH4CZKUGVWJ@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Aug 2026 13:45:17 -0500
"Kurt Borja" <kuurtb@gmail.com> wrote:

> On Sun Aug 16, 2026 at 4:54 PM -05, Jonathan Cameron wrote:
> > On Tue, 11 Aug 2026 15:24:46 -0500
> > "Kurt Borja" <kuurtb@gmail.com> wrote:
> >  
> >> On Mon Aug 10, 2026 at 11:31 AM -05, David Lechner wrote:  
> >> > On 8/9/26 3:28 AM, Kurt Borja wrote:    
> >> >> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:    
> >> >>> On 8/7/26 10:58 PM, Kurt Borja wrote:    
> >> >>>> Add triggered buffer support and a data-ready (DRDY) hardware trigger.
> >> >>>>    
> >> >
> >> > ...
> >> >    
> >> >>>    
> >> >>>> +	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
> >> >>>> +	u8 rx[11] __aligned(IIO_DMA_MINALIGN);    
> >> >>>
> >> >>> don't need second one to be aligned, they aren't independent.    
> >> >> 
> >> >> Ah, I forgot this observation in the last version. These are used in a
> >> >> full-duplex transfer, wouldn't that require for both to be on its own
> >> >> cache line? I just started learning about DMA.    
> >> >
> >> > No. In this case, it works roughly like this...
> >> >
> >> > - We fill the TX buffer before the transfer. (CPU access to memory may
> >> >   just live in the cache at this point and not actually be sent to RAM)
> >> > - We request to start the SPI transfer.
> >> > - The core SPI code flushes (or maybe I should say invalidates) the cache
> >> >   on the TX buffer. This ensures that what we wrote with the CPU available
> >> >   to DMA.  
> >
> > Extra fun - it has to flush the rx buffer too.  Because...  
> >> > - The actual SPI transfer happens that uses DMA to access both TX and
> >> >   RX buffers. (Again, could just live in a cache and not be sent to RAM)
> >> > - The SPI core code flushes the cache on the RX buffer. This ensures
> >> >   that when the CPU reads the memory, it will see what the DMA just
> >> >   wrote.    
> > If the RX buffer had old dirty lines (could have been used for something
> > completely different) in it, that is modified data that hadn't
> > been written back to RAM, then this flush would wipe out the hardwork of
> > the DMA by writing those CPU cache held rx bytes over the top.  
> 
> Makes sense too. In this case, if both buffers share the same cache
> line, I *guess* that would just be a redundant flush.

In some paths maybe. I'd need to draw it out and it's Sunday evening
so not today! :)

> 
> >
> > (Next bit is just to scare anyone who thinks they know how this all works -
> > completely irrelevant here :)
> > Don't get me started on architectures that do clean write back (occasionally).
> > Thankfully I don't believe any of them also have non coherent DMA as to
> > be able to do that nasty hack you have to know no one can see it.  
> 
> With "clean write back" are you referring to a write back without
> invalidating the line?

No.  Writing back a line that was known to be be clean - neither CPU
nor devices ever wrote it.  The problem lies that it could have been
fetched in by a prefetcher at any random time. Then written back at
another random time - potentially on top of what ever DMA occurred
in the meantime.  It's completely broken but only if there is a way
to see it.  On that platform one was introduced much later than the
original design on basis everyone pretty much assumes cache coherency
protocols never do clean write backs.

Anyhow, tales that should be accompanied by strong spirits.  Not even
beer is enough for this one (and I was only on the side lines!)

> 
> > For more fun, one large CPU vendor thought that was the case and there is
> > a spec out there that has a magic flag to let the OS know it does this
> > because there are cases where you care.
> > </rant>
> >  
> >> 
> >> Oh, this makes a lot of sense.
> >>   
> >> >
> >> > Since there isn't a time when CPU and DMA both write to the cache line
> >> > at the same time before a flush, there is never a time we could have
> >> > an issue with stale data replacing data that had not been flushed.
> >> >
> >> > It does mean that we can't update the tx buffer for the next message
> >> > until after this message is done, but we have to do that anyway.
> >> >
> >> > What does cause problems is if we just had a regular unrelated variable
> >> > after this in the cache line and the driver updated it during a SPI
> >> > transfer. If this new value was just living in the CPU cache, then
> >> > when the RX flush happened, it would write over that new value with
> >> > stale data from the DMA's version of the cache.    
> >> 
> >> Thanks! I'll look deeper into DMA, it's very interesting.
> >>   
> > Wolfram Sang did a nice ELCE talk on the more normal flows for this a
> > few years back when he was working on reducing copies in the i2c subsystem.
> > https://www.youtube.com/watch?v=JDwaMClvV-s&pp=ygUQd29sZnJhbSBzYW5nIGRtYQ%3D%3D
> > Is the one I think.  
> 
> Very interesting talk, DMA is way messier than I thought. I guess it's
> the price of supporting so many different architectures.
> 
> I recently got my hands on an FPGA board so I'm gonna be playing with
> it, although it seems DMA is still way out of my reach :p.
> 
> ...
> 
> Thanks for your review! I already finished v4 and I should be able to
> submit it tonight.
> 

