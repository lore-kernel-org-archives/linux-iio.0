Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0141C314;
	Tue, 16 Jun 2026 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781605864; cv=none; b=oIONir3XbwsvNXNFl7p8dhI2q2gpQ3njJJUNQghlgyK3rrdvwLLQp9FUrGTW3lHNeZvjcJqph3F87g4sJDVdfxvuucy0R/SF/aBYJteth+xNpnoC2ZdoHXfExNp9tAFoYfCVJzzY6NGqMExxI0lSp5edwj3HAZz+3QaHGGH22zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781605864; c=relaxed/simple;
	bh=s0gpugqWybDqM3We3liL08vuqMKjFZd5Dgf7wGPFwC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOVwzojhfGmZYbZupCdf5vqB0ODmAp25P2PJjLEmWliM0j9+y6Le9LpUCBfU4Nbfa03gHVSxJPNEsAblFpnD2a00swkFjmARD61VGIO5bPFLRYaUhDgsLNq0FH+ok16ouk7sl1FgWBd7PtPYlFNYkGVFo8zHFmum+eCyD+dDjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvsQNyUZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvsQNyUZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CF51F000E9;
	Tue, 16 Jun 2026 10:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781605862;
	bh=n+GS7Vbtz2X+9so1+tuWUQjePRyW9hO0IBeWljZH954=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvsQNyUZajukbHE8+EKIIw/J3dB2sV9okDB5nWSa9RRUEjE9f878oTj1XJlpgfyRQ
	 8VjuXz4uY+Lscu2YYfwCAGhVbAvH0XwS0XOQOOiJkPvkYQ0ZUssGhvD2JruxuvONyI
	 9FCJBWBVQru3n1FGKbDQQT/r8zQmez1X4O9CJ7rMDTLUn2TKx3F2ITuzTw8cnLQuFn
	 vNvVfSYSCvRVlRVvGU+RxYw7wMwge/NeGfREh8+KPoht7YOB8WX0ANbDwo9/Svk+TH
	 Bw0TiSudkCg0xBh0DzWimPoKcC5uuHzTAGtBJAAhbBwKPR15VMPxJkGstnOohfFQ8s
	 3Vsj8A0Gr62rw==
From: William Breathitt Gray <wbg@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] counter: add GPIO-based quadrature encoder driver
Date: Tue, 16 Jun 2026 19:30:51 +0900
Message-ID: <20260616103055.253139-1-wbg@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2u2lqetlfph2leoggp6d7sxqv4toxpnsts2f2zgq3pwt7ae4ol@ploty2jwm3t3>
References: <2u2lqetlfph2leoggp6d7sxqv4toxpnsts2f2zgq3pwt7ae4ol@ploty2jwm3t3>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5138; i=wbg@kernel.org; h=from:subject; bh=s0gpugqWybDqM3We3liL08vuqMKjFZd5Dgf7wGPFwC4=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDFmGqktzJbYXci17wRSlayGbeslEPvuD6bktt8sn3PGtm rZz8+lpHaUsDGJcDLJiiiy95mfvPrikqvHjxfxtMHNYmUCGMHBxCsBESiUYGQ5wXr1mtdtUcpOc QJphI2d8jNPHu149OiL1H+++LnKfP5Hhn1qV/ooH6e4RBh6c6z95Caee072tyznxXrjVu39CfI0 tbAA=
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit

On Sun, May 24, 2026 at 09:35:45PM +0200, Wadim Mueller wrote:
> On 2026-05-21 09:26, William Breathitt Gray wrote:
> > From: Wadim Mueller <wafgo01@gmail.com>
> >
> > On Wed, May 20, 2026 at 01:45:20PM +0900, William Breathitt Gray wrote:
> > > On Fri, May 15, 2026 at 05:36:15PM +0200, Wadim Mueller wrote:
> > > > +static int gpio_qenc_a_delta(struct gpio_qenc_priv *priv, int a, int b,
> > > > +			     int prev_a, int prev_b)
> > > > +{
> > > > +	int state = CREATE_QE_STATE(prev_a, prev_b, a, b);
> > > > +
> > > > +	switch (priv->function) {
> > > > +	case COUNTER_FUNCTION_QUADRATURE_X4:
> > > > +		return gpio_qenc_quad_x4_table[state];
> > > > +
> > > > +	case COUNTER_FUNCTION_QUADRATURE_X2_A:
> > > > +		/* Both edges of A; sign comes from current A vs B. */
> > > > +		return (a == b) ? -1 : 1;
> > > > +
> > > > +	case COUNTER_FUNCTION_QUADRATURE_X1_A:
> > > > +		/* Rising edge of A only. */
> > > > +		if (!prev_a && a)
> > > > +			return b ? -1 : 1;
> > > > +		return 0;
> > >
> > > Quadrature X1 count modes trigger on the falling edge when the direction
> > > is backward. This isn't simply a requirement by definition, but
> > > necessary for the proper interpretation of the quadrature encoding.
> > >
> > > Let's evaluate an incremental encoder used in a positioning application
> > > as typical use case.[^1] These are commonly implemented using a rotating
> > > shaft with a quadrature-offset pattern; aligned sensors detect the
> > > physical A/B pattern as the shaft rotates.[^2] As the shaft rotates a
> > > quadrature encoding emerges whose A-B phase difference allows us to
> > > determine direction: forward when rising edge of signal A leads B, and
> > > backward when it trails.[^3]
> > >
> > > Now consider what happens to the signals when the rotation changes
> > > direction: there is a phase change between Signals A and B.[^4] The A/B
> > > pattern on the shaft is physically present so it has not changed; rather
> > > the pattern is now fed backwards to the sensors due to the direction
> > > reversal. The key point is the physical boundaries of the pattern are
> > > located in the same shaft positions they have always been, yet the
> > > signal edges representing those boundaries have flipped as a result of
> > > the direction change: positions marked by rising edges now appear as
> > > falling edges.
> > >
> > > In Quadrature X4 and X2, the pattern reversal doesn't affect positioning
> > > because we count on both edges, so swapping rising and falling edges
> > > nets the same position count. Quadrature X1 presents a problem because
> > > we count on a single edge type, so a phase-difference in the encoding
> > > results in a physical shift in real-life position. The way to account
> > > for that phase shift is to swap counting to the other edge type when the
> > > direction changes. That's how dedicated quadrature encoder devices solve
> > > this problem.
> > >
> > > I'm not sure of the best way to solve the Quadrature X1 problem in this
> > > driver. Right now we fire off interrupts on both edges, so perhaps
> > > there's a way for us to determine whether we're firing on a rising edge
> > > or falling edge and evaluate accordingly. Does the GPIO subsystem
> > > provide an indication for which edge triggered the interrupt? Or would
> > > it make sense to provide two interrupt service routines (one on rising
> > > edge and one on falling edge) and handle it that way?
> >
> > The simplest method might be to evaluate the current GPIO level to
> > determine the edge polarity. Because we trigger on both edges, we can
> > assume a high level means a low-high transition (rising edge) and a low
> > level means a high-low transition (falling edge).
> >
> > Using that assumption, we can implement the Quadrature X1 case by
> > checking the current state and direction, and adjusting the counting
> > accordingly when applicable: count up if rising edge and forward
> > direction, and count down if falling edge and backward direction.
> >
> 
> Implemented in following v5 as suggested in both signal-A and signal-B ISRs.

Hello Wadim,

I apologize again for the delays in my responses. I'm currently
reviewing your v5 submission, but I do have a question below.

> One
> caveat I called out in the source: in pure X1 mode the driver never
> sees both edges of both signals, so direction is whatever the last
> X4/X2 sample produced (or whatever userspace set via sysfs).  In
> practice X1 fits applications that already know the direction or
> that have just calibrated in X4.

Wouldn't the driver see both edges of both signals in X1 mode? The
ISR callbacks (gpio_counter_a_isr and gpio_counter_b_isr) execute on
both edges of their respective Signals (A and B). The driver can use
GPIO_COUNTER_GET_DIRECTION() to get the current quadrature direction and
update priv->direction accordingly during each ISR.

In that way, any quadrature mode selected will always be capable of
knowing its current direction regardless of whether it's X4, X2, or X1.

William Breathitt Gray
