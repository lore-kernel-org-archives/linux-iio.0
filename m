Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28469259C80
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778050241; cv=none; b=NOSUTDQHStvrcJpc8e0CN6FdbwL9bJaeQf6KU/thoV/W8p/7T1IMVvPWPR5HRLk9PldJOh0fFdjHhA/5mRbhj64GuoMXTa3fmPctpEOY7BqIxWVL5MG7iNh205TIdAHnzy/jth8k2VlBWFj1Te4i97mJWx2UQKKz69NP7sb3OK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778050241; c=relaxed/simple;
	bh=uxlX6Gcmsd9bWbw8fKTJPbfRFLUxFx8Sv/6fr1Litv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5JyjDzmWgXBLDFYruVy491mPtHiiFVZ3mplOB/o831VqvsqaPJT5be0z7sDAiD6+RlPS9Lcyx2as9YKL4/jMdxDYtdCEg55U3IMF3ndDO12cIx13CX1AQf5K0rJnVoFZQnI9A9X4BECWD7IIqvCzJNn3xwG+CpwKwcI2H3Dzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZp+d2kR; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZp+d2kR"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-67b7c71c165so7515946a12.0
        for <linux-iio@vger.kernel.org>; Tue, 05 May 2026 23:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778050237; x=1778655037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J7uzaq8Z+Qd3g9gr2RKexUjVoo4DK/9fbKzFG8oa4Gw=;
        b=MZp+d2kRzAGGezO6AnfHTj25fsLtbHOBON+9sMVdSpIlL0EEe5jrdPGFf1ZYdDKrxT
         XRbwHN8jMjhunmEVxbvWmYYXYt8N63s9BC/c20fsaqez/kdJiuitjV30/lXAcGi3K8Pz
         O/L5DmRoAO7B25XcDibsJXFP/bPgwtynsXwhEFK45/hY78nmjbqh8to3ECLd24maIQL7
         4+FIsnfR1LagVuuHilALgTtf7ClqGooqK9CALAbiVvpdFP9vr6OX1ZmKvk6pf4wuL+o0
         2cD8OT/okIN1NnO1fMab13L46B7ENsHgoi2rB2oA59+iGR23Sb+WlX/4lBo2KkZSZl3s
         k3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778050237; x=1778655037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7uzaq8Z+Qd3g9gr2RKexUjVoo4DK/9fbKzFG8oa4Gw=;
        b=l0f+6F0wQMHhc7Foxz3AdWedusBzrW1gV86yoqgw3EQV3YZlXmh/LZejFQB2ambG34
         CYVdRU4u8HZjQegPd3XzQuKvZQwQ4xAaNNQPKBWsZSUOuLnFJ44jGyMD4qMKUTd911HM
         uHiDZ7LfhLg4qXIIZwx+4wic94gKNSfvYnPU5b0UnodcjsCHI3LCb7qzVBazsFRwuTtw
         KaG1Flt/0vHIIpPwpEXAHGhz3Kv8gyCn+ygtFuGA3byYzEN4P9uyJJTjoiZu8DVZpnD5
         ozymxjaj0SBlpMIuK0610cJmKnGKotLYKeIzpN8PTgT5iXw4iCXuWbFWFrRgtMSCGFvQ
         p0jQ==
X-Forwarded-Encrypted: i=1; AFNElJ/zj1kmyQoqx543Enz8NpoPScEoQBsjrP46Mf/c8oeFqiB3s/i/tKv1yyivcSrLwLplyd76ASUbeM4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy856sARnwctnGaaMqG1HPGgMfWmB+tMQQGsORhrTDZb29ZajU4
	YKwDhFbYFIIwRJxokZAs3B0bcF20MmtPiNy1hvBBklwI/RFcGK0J2Yjn
X-Gm-Gg: AeBDiet0EX1b8oz7Ok5s8RFzoN7evd9zYcHCTvhfGXFhugphBsYG3FWepY2o0teXWbH
	XA8kGk9iCRQSg91lcPdUNzzBhsfL/ghMbkXjzjqcsEvfica0EnFIVv/49vrPMFfnrtFAWiaISpe
	21NbPT8WKbKT77etvxp3Ytnz8rjPzZIbK6WLSdHLFzDcWrTd/fcmntN0hURoYN+I9FGrOBj+u9h
	ZVpvGNui/wJT/Ay0D6uj3mNuvx7duwRc5dcxh5oUsXKSpGusKLANICwO/x+r66vXv4R+OgAuH44
	VJX4DTfRIRjqC6vCffudvZ8OjolnpFz4YPP/HBcIbI3eDNrrh3LlM14wVPj+i568ypEVlS50bzJ
	SDgF2xHsuzFAB0pRpjhJHB0+L/RB+IBrEjpCVPXzNRp4Yv3YCchJIw8+iEih8R9Ic2sXM2Qn4yP
	rE7rdw0cE/P16UOJktaeVt09Dh+A==
X-Received: by 2002:a05:6402:5112:b0:66c:304d:bf12 with SMTP id 4fb4d7f45d1cf-67d646af17amr674840a12.19.1778050237128;
        Tue, 05 May 2026 23:50:37 -0700 (PDT)
Received: from fedora ([2a00:20:d22c:fcce:9a0e:db2e:5657:8dc3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67cd91bb82asm979138a12.21.2026.05.05.23.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 23:50:36 -0700 (PDT)
Date: Wed, 6 May 2026 08:50:33 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: linusw@kernel.org, brgl@kernel.org, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, conor.dooley@microchip.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] counter: add GPIO-based quadrature encoder driver
Message-ID: <4mklwzoe3g24rse57hcrztmq3u7lmr3czxs6jha4ltkys57o5z@rlrxjfjbpkeh>
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
> > Changes in v3:
> >   - Pick up Acked-by: Conor Dooley on the DT binding patch.
> >   - No code changes.
> 
> As an aside, you don't need to resend the patchset if there are no code
> changes, I'll make sure to pick up the tags in the mail threads when the
> patches are accepted. This helps reduce the amount the messages we need
> to parse on the mailing list.
> 
> Thanks,
> 
> William Breathitt Gray
> 
> [^1] https://libgpiod.readthedocs.io/

Hi,

to give the discussion "why a kernel driver, gpiomon should be
enough?" some real numbers, i did a small benchmark on the AM64x
board where this driver was developed on. From my side the data
below looks like a kernel side counter is the right tool for this
job, but in the end this is of course your decision as a maintainter.
Please tell me wether i should send a v4 or rather drop the series,
so i know how to continue.

Setup
-----
SoC:     TI AM64x, Cortex-A53 dual core, gpio-davinci
Kernel:  6.6.32, CONFIG_PREEMPT=y, CONFIG_HZ=250, no isolcpus, no RT
Source:  EHRPWM driving one GPIO line (square wave)
Window:  2.0 s per point, 3 runs per point (mean +- stdev in the repo)
A:       counter/gpio-quadrature-encoder, pulse-direction, B held low,
         signal_a_action=rising-edge
B:       gpiomon -c gpiochipN -e rising -F %o (libgpiod v2.1.2 CLI),
         lines counted from the output file afterwards

Both ways are seeing the same physical edge.

Rising edge counts (mean error vs. expected, n=3)
-------------------------------------------------
   f [Hz]   kernel err%   gpiomon err%
     1000        -0.16          -0.13
    10000        -0.42          -0.88
    20000        -0.89          -3.18
    50000        -2.37          -6.77
    75002        -0.29         -10.93
   100000        -0.65         -20.53
   150000          n/a*        -42.46
   200000          n/a*        -60.74

CPU cost at 75 kHz
------------------
                 task CPU      sys irq+softirq (sum of 2 cores)
  kernel:           0 %               ~50 %
  gpiomon:        ~60 %               ~25 %

Some interpretation
-------------------
- Below ~10 kHz: not really distinguishable from quantization
  noise (one rising edge of phase ambiguity per measurement
  window). So no meanigful difference between the two paths here.

- 20 - 100 kHz: gpiomon error grows more or less linear with the
  rate while the kernel counter stays at the noise floor. At
  75 kHz gpiomon is dropping roughly one event out of nine and
  consums 60 % of one core in user/sys time, on top of the IRQ
  work; the kernel counter looses ~0.3 % at zero task CPU.

- *at >= 150 kHz the davinci-gpio bank IRQ saturates at around
  200k irq/s. This is a SoC limit, not a software stack limit, and
  applies to both paths. The bench harness aborts the kernel sweep
  on >30 % apparent loss to stay away from soft-lockups; the
  gpiomon numbers above this point are only listed to show that
  the same hardware ceiling costs the userspace path much more
  useable counts, because of the poll/read latency on top of the
  IRQ.

Honest caveats
--------------
- "gpiomon" here is the libgpiod reference CLI: single threaded,
  writes one text line per event into a file. A hand written uAPI
  v2 consumer with a tight read() loop and a binary buffer would
  most likley be cheaper. The IRQ rate ceiling at ~200k irq/s on
  this SoC is not affected from this. Patches against the bench
  are very welcome.
- The driver is benchmarked in pulse-direction mode with B held
  low, so one IRQ per edge. A real two channel quadrature source
  would double the bank IRQ load accordingly.
- CONFIG_HZ=250, no PREEMPT_RT, no isolcpus. PREEMPT_RT and pinning
  would soften the userspace cliff but does not change the per-edge
  cost of the kernel path.

Reproducer, raw CSVs and plots:
  https://github.com/wafgo/qenc-bench

(README.md has the full sweep and plots; data/aggregate.csv has the
table above with full precision.)

What i would like to know
-------------------------
My reading of the numbers is that on this kind of SoC a kernel side
edge counter is the only way to get correct counts at industrial
encoder rates without burning a whole core on a userspace listener,
and that the proposed driver does exactly fit this role. But like i
said, this is your subsystem and your call. So concretely:

  - if you would like me to send a v4 (with whatever changes from
    this round you want me to fold in) i am happy to do that;
  - if you would rather not take the driver at all, please tell me
    so and i will drop the series. I would just like to know either
    way, so i can stop sitting on the branch.

Thanks for taking the time to look at it.

