Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0D2FD1AA;
	Sun,  2 Aug 2026 17:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785692491; cv=none; b=nq1ggMFqdL6aWbvT1QsQfhf/88kGvDNj8zEbeu6EHeNWnDu8IENTRXsOPz8ak7E+b+B7sXPOngc5vonDzUSLFw5Jmo+MyVpH70I8rxU5BgK+C1aev08jGvCzhN5DD9XGydVuZDEXhtsnGz58Ny6JAyEay54XzbJnki5XT39OH0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785692491; c=relaxed/simple;
	bh=5RhO7fUTrEZJSfFlaOj44UmPUJzdtfLPZdLFbvvKAjI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XgEjYVrEKL1s+dLPCdHuQrKu7kmFA4wjW+9lQbbfSkE52gWZzi1lbJ7nMXrTV9XfYnXGMyx0LZ76dNcLNUw8kuVCCODEOr4tTsuc3RimyjxG9YjgvID1rAJlEfIfz7cbpInOaXKupXlPY0yN6IFnA4PHiQHYSSlkxQRrbR6Yi0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZknBiis+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZknBiis+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233781F000E9;
	Sun,  2 Aug 2026 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785692489;
	bh=hZ5tSTSVoAp7eTECma3oVw1RATF48bqHwGIbQY6nUBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZknBiis+N3vfcU7uVAn2fIUtGuJfUGlGCfPLTNl1ep7Ql/ySMVQuSAYm/j8OkPWh0
	 i+OROZfAHbAifIYyPmTnxxRTw1mhf1QwI4MRhTuWh/BNxKM8Ub8sVpAFyIOzer8/Xy
	 DvmwocBAS37n1EX2U3WWfmfTOiFslClEWwMPVbsqav77fp0YseNzu3IAvIURt5W+b3
	 ZUP+16Cl2u1B62/PeEjs1b39S0HejDhqxcmP/mKm36rPm3TYiFo7dArzUpaZo28E+t
	 f+Bxv92WaPWkZuhF7OekWEs18K55n31zfA7djNB23hFwWVRcuMEhDY8WoiqzRLGghl
	 1sPf0kr6XA6bw==
Date: Sun, 2 Aug 2026 18:41:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marco Chen <marcochen.dev@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, pmeerw@pmeerw.net, matt@ranostay.sg,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260802184126.04738251@jic23-huawei>
In-Reply-To: <89176b25-bcf6-4d44-94b3-7a29abec7b10@baylibre.com>
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
	<aca9bdb5-f068-491f-a651-d24a80a2786e@baylibre.com>
	<20260802031035.6eb2be14@jic23-huawei>
	<89176b25-bcf6-4d44-94b3-7a29abec7b10@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 2 Aug 2026 10:21:41 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 8/1/26 9:10 PM, Jonathan Cameron wrote:
> > On Sat, 1 Aug 2026 10:18:42 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >   
> >> On 7/31/26 1:41 PM, Marco Chen wrote:  
> >>> The interrupt is requested in max30102_probe() and stays enabled    
> >>
> >> I've always wondered why most IIO drivers seem to do this. It seems to
> >> me that requesting the irq with IRQF_NO_AUTOEN and only enabling it
> >> when everything is set up for reading data would avoid spurious interrupts
> >> like this.  
> > 
> > It teaches discipline.  More serious from what I recall the no autoen thing
> > used to be done via a racey bit of trying to turn it off as fast as you can.
> > 
> > Most of the time we should be able to write drivers that don't need to
> > use that flag and don't touch enable_irq() at all.
> > 
> > Obviously that's not always true.
> >   
> 
> Hmm... so I should go back and change [1] since it isn't strictly
> required there?
> 
> [1]: https://lore.kernel.org/linux-iio/20260731-iio-adc-ti-ads112c14-continuous-mode-v2-1-eb13da38e8fc@baylibre.com/
> 
> 

Ah. I was assuming that was spurious irq territory or a device
where we couldn't disable it device end.

I remember a discussion a long time back with the irq maintainers
(probably tglx) about the fact that they really advise drivers not
to turn interrupts on or off because it can be a very expensive
operation on some systems and such control belongs at the device
end when possible. What a host does with a disabled irq is just
too variable. The only guarantee is it won't immediately report it.

Maybe that has changed over time - I have no idea!

Anyhow, yes - I would drop that enable / disable dance if it
was about spurious prevention.  If we want to prevent spurious then
better thing to do is to check the software interrupt status register.
Looks like for that part there is a drdy status bit.   Bit annoying that you'd
have to drop to a thread to read it but we probably should do that
before the complete.  Maybe we could speculatively complete and
check it in the main thread.  

I note you do use that for polling.  I'd treat the irq as a way
to ensure you only need to read it once rather than not read it at all.

Jonathan
