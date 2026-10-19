Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A684299920;
	Mon, 19 Oct 2026 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792373445; cv=none; b=crjMuMXxpDJL631h7p24JwF+BPMg8NMfDr4RNxPCIdtbPBNlpCmLrc7PecVm7spo5ofIpyiXjmI1g0t5LK0d4A1lI6QejL7B7NrihBRR7FSqphBg6I/Fw1+8L6pFhp47Hvna6Et1HHClM4CHNoTclAiglu+muxTsJUzTXfz+4pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792373445; c=relaxed/simple;
	bh=CByFKcTpSkcKeCpYf8z2Fog2OgYYxsOADDwcBLA1TP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dMSVx6A08iZMBxJAmd0PQabJAcczafjMeHGRvh6f3hisjv06txBG7UovS1U+WruAzrZjHexrk1XlxRjRv0u1YkGfcviJZ3Pyin494w/IGeG+XY0eNa13XjTjU32hFkedunUVWym7xsWC+gjhUxt70HficRA4FvhWLLtMcXp621w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/5zxDYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/5zxDYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676A01F000C5;
	Mon, 19 Oct 2026 01:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792373444;
	bh=6DONImIz/tkgXGbPeG/+xyhn67lNnTYwz6Ur02o9Rbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k/5zxDYrul7wnzk83Zs7UkC45Ngg/EhOg9f+2lTDsHpF5vGfMAB5FYGmV00CUnq/r
	 epwQ+84Xk+oZA4MmWAYg+oThiO3NjxdgFJ4CXZegMW7r3rgGP7yhXMPolX2yr8U5DO
	 G7QbkrwBiXH82/E/6NJpsO/rB+UxK+LSKwIAzClfgUUqG4ko1mI2zOzr3J16Rbr1RP
	 un16+BFw8TRDlhZMTCvc496xRxHt+Pzxsl4uzWMWeWwP18QJIc+2S2mYHv655Hp25Z
	 C2ndyv+O+XvqRK9uKXvWQ7g8Fw04oAvlP/hrsPmzw8AvotcpXnFHNcKXA7MBh5UKcQ
	 FZcIhkJJn8f0Q==
Date: Mon, 19 Oct 2026 02:30:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261019023037.24674f30@jic23-hlaptop>
In-Reply-To: <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
	<20261001145702.2628429-2-olivier.moysan@foss.st.com>
	<20261001-tribesman-gauze-862e1ef0cdd8@spud>
	<bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
	<20261008-9e2a48675c1a4c28f2dfa73b@squawk>
	<950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
	<20261009-8db882a9fa159f8759aa7327@squawk>
	<2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >> Yes, we can have two clocks gated independently but sharing the same rate.
> >>
> >> Using the clock framework apis seemed to me the right way to manage cck1 and
> >> cck0 gating and divider computing. I think I would have to introduce
> >> proprietary properties and have to implement code in the driver, that would
> >> be handled natively by the framework otherwise.  
> > 
> > The CCF is still the right way to do it, especially since CCK0/1 can be
> > exported to other devices. I don't believe you need to actually have a
> > reference in DT to do this though, plenty of "real" clock controllers
> > have only one input clock and hang a whole tree with multiple layers off
> > that.
> > Down below I mentioned this under "ouroboros devices", I think this kind
> > of ability to chose which clock a channel uses is a fairly normal thing
> > to do in IIO land, I just dunno what the preferred mechanism is - I just
> > know that it is not referencing yourself (probably it's some sort of
> > property that you put in a channel node that says 'blah-clock = "cck0"',
> > but better that the IIO folks answer.
> >   
> 
> The adc.yaml binding do not expose clock properties. But maybe IIO 
> experts can answer about this.

Hmm.. For an 'conventional' ADC channel a clock is a novel thing to have
on a per channel basis. What does it mean for an analog signal?
I think these are signals between the front end (which here typically
has one channel only) and the backend. They are useful because they
end up indicating (I think) whether we want to interleave or not?

Anyhow, right now I don't have this clear enough in my head to
give a firm answer.

Jonathan
