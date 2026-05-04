Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058C83D3305
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923468; cv=none; b=clUA46jczXp3qVmMXiknIt1LIvMkYAkHMK9SeEHjxsw2TVx1xibWfQDzowumteW5Xl3RzZJz3cn6mTs7/9H9Cz5Yp/sear95i5YRHA31P0scMYd/1uZg34f42A4vdtwWNvHPMHJ63+xXsCKkRYj1rGgQmhAt76Zlbr8MOAvyA4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923468; c=relaxed/simple;
	bh=NCAV152kmL1c0/WTvQgyU0xiEjdTe/n/Tpg7/KyXu5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUmSxO6iu81iDXMe04JUMQWwpyp48eOMnU0ZaJXXsOTR/DJraThC7YzyY+kub7G3sq6lWod76DPee+PsvCPu4VVO0lQp6IwNiplJK8IJhuW8qzw3Gw5V/mfg+Stq5MGvphs1WhKlH4TvP586dbLqKx7XFVHMHag+81WbGZaB5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnDGH58t; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnDGH58t"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso54247055e9.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777923465; x=1778528265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PTVTMnyXMhr6MOBQkrI7V5/oME2+FKO+b2H2y/lgEJM=;
        b=HnDGH58txQtZOLr06SuigkTLignyXdAuL9l4JAgScspsaG3Z8gun0achpQftaUtPGF
         e9Uwhp//XKTDzjdPoqzESDjzvBedRBAliIp0bbMaWXGOx+E6VWIz3qDdVAReY+mHq0Hy
         +vle3zJ1kPX30fmSnbKQU227JaOQbdMBYBIMvTgBF3jtFQX6BYoh+/APJjDomMzmtNEk
         8ahj4HL1/lXA1w08fnMp1Uk66AsEmB/1+4SHgX7RhHSZQDYNhLTngLtcCNEKQrJ0ExWv
         2IgSwrilpdS1slX+natFVoFvZM2ZQydX5O7dAxWAVA+juKnJuBZRm4hBv6AVEhZ8LuX5
         ZuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923465; x=1778528265;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTVTMnyXMhr6MOBQkrI7V5/oME2+FKO+b2H2y/lgEJM=;
        b=pz6jt2bvq9Ep+Nf8i2yQGfLsOiFyKjRj+kYBrY48QvA/JAl98MOphAtWbtLRRceMAT
         HFslsFwe1oa1SiPliBQ1Yep+L2OGSkF5WMiHfVr5/N3tryNd6H3ZQXfN+xS2WZ/lrX8M
         RLvLFcJWEvCtpqjqyQYFXpAksZb11X6CdX+8i/BtTU7pFJ7nvM08GvrNpjQ0uKvhoQie
         Rk/wNLi0Lc/x0NZLM5wmyPbg67/YgCm3xf8vR37asmSj3qB2T9jqd/ipjLrh8f2f1E7l
         e6jz+gGYbkhpIbQFY8IzBDId+ynYCM2kJB/Aw8aUsR/xmuAu3waB4jbHcoBNUxDKC3fn
         0dSw==
X-Forwarded-Encrypted: i=1; AFNElJ++Z4DvUuIW/4idGWtvWRQ+jPxVgeWZl594deD1pSTdevCEHraf/YE6gLJAyYHJfTvIdxzZk+AGroQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGXqIS035M9RrOqdITo3YvrwqIbevWTLc17lImzju376mnciB
	omiR4M303AKMi0wJxtzypmhazEddxsb3nThbxUWU0vVRHVBp83YvHTvk
X-Gm-Gg: AeBDieti9nGdr3AEwQXAiW0mHMvYxjT5gceMneUKdOYljCJr8qx6xw8t6KoMgWONp3d
	b0z2OcRvOF63IZz90CWDUiRb4BUaEznRUSCasZVu5b7bWKd6m8K+Of8eCJzIe1SPMB/gmzcC6sU
	pTAiNiNW3IZakIDKQd0TIy7Yitx4YeQQL+2QlMUpVajcnXv+y37aM2DOcnnpWWDzGwFxXltWKjR
	jLyhEO7/gkDAtiWvyeVv+mENbUqHC75nvL0j0IkukEc5ofUPZJgy/tv0lA4mqh0Cg448CWaFhtm
	HqoLdntfXzip9LvNVxtn5X7q992dinR5/Wf9eDLOqSSoy1fVRZfiMknCgJIaJzsvaAqpF7JfuAp
	tdBf4T/V9auq0A/eWayJJw85Vcxz7r8qvjgzf2gU4Mnw0pmJXquH8ks/u54xE9Eu9Mvvba/23U7
	mK3QDC6Qfo
X-Received: by 2002:a05:600c:e41a:b0:48a:592c:e642 with SMTP id 5b1f17b1804b1-48a9865f799mr149293125e9.18.1777923465214;
        Mon, 04 May 2026 12:37:45 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::3323])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fc1sm305550825e9.7.2026.05.04.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:37:44 -0700 (PDT)
Date: Mon, 4 May 2026 21:37:42 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linusw@kernel.org, brgl@kernel.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, conor.dooley@microchip.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] counter: add GPIO-based quadrature encoder driver
Message-ID: <45kxuyadtuvc4g2dsxcsvrsaw5agpq6zaesmc47x23vg5c3zsy@oke7vjaf7jqb>
References: <20260501200749.20029-1-wafgo01@gmail.com>
 <20260504093648.530308-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260504093648.530308-1-wbg@kernel.org>

On 2026-05-04 18:36, William Breathitt Gray wrote:
> On Fri, May 01, 2026 at 10:07:46PM +0200, Wadim Mueller wrote:
> > This series adds a new counter subsystem driver that implements
> > quadrature encoder position tracking using plain GPIO pins with
> > edge-triggered interrupts.
> > 
> > The driver is intended for low to medium speed rotary encoders where
> > hardware counter peripherals (eQEP, FTM, etc.) are unavailable or
> > already in use. It targets the same use-cases as interrupt-cnt.c but
> > provides full quadrature decoding instead of simple pulse counting.
> > 
> > Features:
> >   - X1, X2, X4 quadrature decoding and pulse-direction mode
> >   - Optional index signal for zero-reset
> >   - Configurable ceiling (position clamping)
> >   - Standard counter subsystem sysfs + chrdev interface
> >   - Enable/disable via sysfs with IRQ gating
> > 
> > Tested on TI AM64x (Cortex-A53) with a motor-driven rotary encoder
> > at up to 2 kHz quadrature edge rate.
> 
> Hello Wadim,
> 
> This is certainly a neat idea! :-) Several times I have wished for a
> convenient way to just plug in a quadrature encoder to the GPIO lines of
> my system and immediately start reading position data. However, I want
> to be sure this makes sense as a Counter subsystem driver before I
> proceed with a full review.
> 
> If I understand correctly from my brief overview, the core approach in
> the gpio-quadrature-encoder module is to take two GPIO lines (A and B),
> setup interrupt service routines for them, compare their GPIO values on
> each interrupt, and respectively update a persistent count based on the
> quadrature relationship.
> 
> From that description, I don't immediately see a need for this to occur
> in kernelspace. Couldn't the same design be accomplished effectively in
> userspace via the libgpiod API[^1]? I believe that library allows you
> to watch for GPIO edge events and request GPIO line values. (I'm CCing
> the GPIO subsystem maintainers in case I'm missing something obvious
> here.)
> 
> Although the Counter subsystem does provide an established user
> interface for counter devices, I'm not sure that alone justifies a
> kernel driver when the same can be achieved by an equivalent userspace
> application. If you can argue for why this should exist in the kernel,
> I'll feel more comfortable with accepting the Counter subsystem as the
> right home for the gpio-quadrature-encoder module.
>

Hello William,

thanks for the look -- fair question. Let me try.

Even with A and B in a single line request (so one event fd, no extra
get_value() between edges) the libgpiod path is:

  edge IRQ -> kernel edge event -> chardev fifo -> scheduler wakeup
    -> read() -> decode -> update count

The wake-to-update delay is bounded by the scheduler, not by the IRQ.
At 2 kHz X4 the inter-edge spacing is ~125 us, which is firmly inside
scheduler-jitter territory on a stock kernel under load -- and a single
missed edge is a permanent position error rather than a transient
glitch. In the kernel the same work is essentially
spin_lock_irqsave / gpiod_get_value / count update / unlock in
interrupt context, which is what gives quadrature decoding the
atomicity it needs.

To be honest I haven't put real numbers on this yet -- the argument
above is from experience, not measurement. I'm going to set up a
proper back-to-back test (libgpiod v2 decoder vs the in-kernel driver,
same hardware, deterministic edge source via eHRPWM so the generator
side doesn't pollute the result) and follow up on this thread with
the results once they're in. If userspace turns out to hold up under
load on this SoC I'll happily drop the series.

The other angle: interrupt-cnt.c is the same shape of driver -- one
GPIO IRQ feeding a Counter -- and quadrature off two GPIOs feels more
like a sibling of that than something to push out to userspace.
Keeping both behind the Counter ABI also means downstream tooling
doesn't need a parallel libgpiod path next to the existing Counter one.

> > Changes in v3:
> >   - Pick up Acked-by: Conor Dooley on the DT binding patch.
> >   - No code changes.
> 
> As an aside, you don't need to resend the patchset if there are no code
> changes, I'll make sure to pick up the tags in the mail threads when the
> patches are accepted. This helps reduce the amount the messages we need
> to parse on the mailing list.

Got it on the resend, thanks. I'll just collect tags in-thread next time.
Thanks,

Wadim

> 
> Thanks,
> 
> William Breathitt Gray
> 
> [^1] https://libgpiod.readthedocs.io/
