Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8030E0F1
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651351; cv=none; b=KaZJhnhOJLIeceNzz1R3v5Hyc+/VlRIG5g1Kx983ZIFJHAUfMMwpUzqVjarpA5qI2BTB5qlDHEXlefN8MVu9/ycXoBzikQOu9XSCS57HMcp33BsKNbK7lhMvEJG6rFK0ippi2Ew90r/PkjHQ/nWjt+wsxSt7NCKEhmFFR7ZH6eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651351; c=relaxed/simple;
	bh=KAPFGa8apvmZnWXaA7VcM3+x2PjRGFMC18ZP4qMJdzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUVKPOwEwC2i4sNtqjXGnrANn4Lec7WaVaYLE2y+44w4WEKPQkscMZdS5CzIF72D66zE7X3AMHmuJ+B1aGXf7y/o/FpY8/zcSWzCCufK+ytRBYmwbNLepF0AV91PRqCEXl5hS1s05edlA8npfZpq1Aq8Zhr0i7wRFWfJ7bG83ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+VPgirn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+VPgirn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso77094025e9.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651348; x=1780256148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MA5zBTVqqPAZ1JUYUScqIpW2iGsfMAiQgXisbURssgs=;
        b=J+VPgirnzu9o2DwsDtdsjK65F1vP4ps2od7SX0VQLOgW1fkh8Mi1b/llHrsTTFqdAp
         GP2yr83mlweNeQNEvntbvZqlMYujD+vXE6Id5tG7FbovpUjxG0kdepwnepZYLxyq0YgU
         FDmBsqY8zIre0LNMDp0ZTLZWsZiVtGwlVrCnaH2hqZM5j2P/0d07ZOPnP1DzL6ybxqIo
         SKvLBD8vB2qhuAyIUgN3eZIE5YjRM2A0ThU7HeqTut9YKqd0lwREr+wJ347gZ5pjLIHN
         TvAXokg1QWy8Gw9qM+1iBepz5weKOb8HGmmdZcU9xxs4/tBYL0Vo7Xtc96Un3kL5A629
         FXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651348; x=1780256148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA5zBTVqqPAZ1JUYUScqIpW2iGsfMAiQgXisbURssgs=;
        b=H0dl0LXi1WFLXOblSHQl7O49s4XN6w0GC9R4FIGTPs9mI2/g57ELErid8EAjJ2waHW
         vFB79TNBTZqyibCAz7SXZchNqgmbe4wBe+PSQ5Wryt3F4Fj6lyWTlDHUzCD16CSNC784
         3hp5DogX2wLaY8w6Xp3uAlKV4Ce+fTUL2oH01iTCDEOZKoaFBZuQwfg4CDW6xnAORk0H
         g7svfvYUCHiZA/GKVwdLiYpsKrby1HBqnwHyUE/aXkg0Yqjd9G0IvPnr76mKnB7WOQ76
         XWyZSZWtwsHVPvTSl56SJ3wDzoPZVZ/wH3ju/oaGJK/3Qvd1rLWj5gPlRpQ/RmhOdyZ3
         1GmA==
X-Forwarded-Encrypted: i=1; AFNElJ/UEyTHXfXkUFx2bNUI+XP81oT+lHKEoXB0pGZNGNyvg+5IbfZXc745EJDljDQVdPomOrdq0BS0/xA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz16jYUoIc/Wr9lCMJq+ZySEHR/v1UkbtE5h4vSO1oJ4DKL6DvV
	P8XKy3kAH2BcJvJTIZp/o+s9Pw5axKclLM23C7OiEkM0NK2o3uE9eU85
X-Gm-Gg: Acq92OEl5M4AYLP4vijiAwXs000dwsF70Bh+8fni+i4Cwbj3qcX24Pdq+itAX+Czv8a
	iZvQHR0A28lJmzCXqUBavEQ7EMwyrko4OmLoBL9nBmNzX+JxiBQCqeQAVU/4cs9rM+zq4R63hIU
	oBN1sTYRtkbuUn9af828sAD5DTmDP/bzO1jFlIGE5TfGXRxfbSxoWZhkLGX/4S4/efGcHh5MxZc
	RZh+mgGVUInLCXWhhU3GIsK7p+RBNwfiCfPGgxnSxviqfywFD/6SZVWC01GvqPn6pX0+RHLE7y+
	H2OjjOQt2Ip3s7Tu3GJwGq510Yw0/JG8Ih5I29v6sR9Q6KgI3ZJfGn0w94g1NB00StNuD/91K4v
	4xpqKcJG+C8ojPUvapfjhwj+0wq6RvuPfQenreR38qTq5g04zoMmEU3E4u3Hii8CTtoJmTTm2Uf
	ioDkAqmKy/AbThwHw=
X-Received: by 2002:a05:600c:4ecc:b0:48f:e249:4094 with SMTP id 5b1f17b1804b1-490426d4bf0mr192598335e9.18.1779651348168;
        Sun, 24 May 2026 12:35:48 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454b7d57sm193410105e9.15.2026.05.24.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:35:47 -0700 (PDT)
Date: Sun, 24 May 2026 21:35:45 +0200
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] counter: add GPIO-based quadrature encoder driver
Message-ID: <2u2lqetlfph2leoggp6d7sxqv4toxpnsts2f2zgq3pwt7ae4ol@ploty2jwm3t3>
References: <20260520044525.128529-1-wbg@kernel.org>
 <20260521002627.172691-1-wbg@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521002627.172691-1-wbg@kernel.org>

On 2026-05-21 09:26, William Breathitt Gray wrote:
> From: Wadim Mueller <wafgo01@gmail.com>
> 
> On Wed, May 20, 2026 at 01:45:20PM +0900, William Breathitt Gray wrote:
> > On Fri, May 15, 2026 at 05:36:15PM +0200, Wadim Mueller wrote:
> > > +static int gpio_qenc_a_delta(struct gpio_qenc_priv *priv, int a, int b,
> > > +			     int prev_a, int prev_b)
> > > +{
> > > +	int state = CREATE_QE_STATE(prev_a, prev_b, a, b);
> > > +
> > > +	switch (priv->function) {
> > > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > > +		return gpio_qenc_quad_x4_table[state];
> > > +
> > > +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> > > +		/* Both edges of A; sign comes from current A vs B. */
> > > +		return (a == b) ? -1 : 1;
> > > +
> > > +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> > > +		/* Rising edge of A only. */
> > > +		if (!prev_a && a)
> > > +			return b ? -1 : 1;
> > > +		return 0;
> > 
> > Quadrature X1 count modes trigger on the falling edge when the direction
> > is backward. This isn't simply a requirement by definition, but
> > necessary for the proper interpretation of the quadrature encoding.
> > 
> > Let's evaluate an incremental encoder used in a positioning application
> > as typical use case.[^1] These are commonly implemented using a rotating
> > shaft with a quadrature-offset pattern; aligned sensors detect the
> > physical A/B pattern as the shaft rotates.[^2] As the shaft rotates a
> > quadrature encoding emerges whose A-B phase difference allows us to
> > determine direction: forward when rising edge of signal A leads B, and
> > backward when it trails.[^3]
> > 
> > Now consider what happens to the signals when the rotation changes
> > direction: there is a phase change between Signals A and B.[^4] The A/B
> > pattern on the shaft is physically present so it has not changed; rather
> > the pattern is now fed backwards to the sensors due to the direction
> > reversal. The key point is the physical boundaries of the pattern are
> > located in the same shaft positions they have always been, yet the
> > signal edges representing those boundaries have flipped as a result of
> > the direction change: positions marked by rising edges now appear as
> > falling edges.
> > 
> > In Quadrature X4 and X2, the pattern reversal doesn't affect positioning
> > because we count on both edges, so swapping rising and falling edges
> > nets the same position count. Quadrature X1 presents a problem because
> > we count on a single edge type, so a phase-difference in the encoding
> > results in a physical shift in real-life position. The way to account
> > for that phase shift is to swap counting to the other edge type when the
> > direction changes. That's how dedicated quadrature encoder devices solve
> > this problem.
> > 
> > I'm not sure of the best way to solve the Quadrature X1 problem in this
> > driver. Right now we fire off interrupts on both edges, so perhaps
> > there's a way for us to determine whether we're firing on a rising edge
> > or falling edge and evaluate accordingly. Does the GPIO subsystem
> > provide an indication for which edge triggered the interrupt? Or would
> > it make sense to provide two interrupt service routines (one on rising
> > edge and one on falling edge) and handle it that way?
> 
> The simplest method might be to evaluate the current GPIO level to
> determine the edge polarity. Because we trigger on both edges, we can
> assume a high level means a low-high transition (rising edge) and a low
> level means a high-low transition (falling edge).
> 
> Using that assumption, we can implement the Quadrature X1 case by
> checking the current state and direction, and adjusting the counting
> accordingly when applicable: count up if rising edge and forward
> direction, and count down if falling edge and backward direction.
>

Implemented in following v5 as suggested in both signal-A and signal-B ISRs.  One
caveat I called out in the source: in pure X1 mode the driver never
sees both edges of both signals, so direction is whatever the last
X4/X2 sample produced (or whatever userspace set via sysfs).  In
practice X1 fits applications that already know the direction or
that have just calibrated in X4.

> Quadrature X1 A is handled by the signal A interrupt service routine:
> 
> 	/* COUNTER_FUNCTION_QUADRATURE_X1_A */
> 	if (ca)
> 		if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> 			count++;
> 	else
> 		if (direction == COUNTER_COUNT_DIRECTION_BACKWARD)
> 			count--;
> 
> Quadrature X1 B is handled by the signal B interrupt service routine:
> 
> 	/* COUNTER_FUNCTION_QUADRATURE_X1_B */
> 	if (cb)
> 		if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
> 			count++;
> 	else
> 		if (direction == COUNTER_COUNT_DIRECTION_BACKWARD)
> 			count--;
> 
> There's an obvious caveat that this method only works if we're able to
> check the GPIO level before the next edge arrives (we're limited to low
> frequencies), but that's a caveat present regardless for our software
> counter so I believe this is an acceptable solution.
> 
> William Breathitt Gray
