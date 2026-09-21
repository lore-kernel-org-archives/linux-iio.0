Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EED305E28;
	Mon, 21 Sep 2026 03:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960976; cv=none; b=A2zd7vjDGAZkN6PGWgQUmxMLY/x3LIAxUWzNJgvX7WYCZkevOEYjRACvLz4k9JVltTxf7jBstqrL0OYiNjgcdF2N9U7l19Erf/59twyYgS7Lwsoi/CHccXyS9xab4uNH6Ts4MqFhBVNVaUeiBwzmNXVMKk9RkWxEH8/im2knzAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960976; c=relaxed/simple;
	bh=48NZByhf7EcsSgYrdoL1UvWYvmb/JE2gBENG3oSrCd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhTbxmJSbLRlgPOVxij5tHHZ+WZJ6Khthk0/Um6Idgy3ZMXtYUd4sbQ0hTF7HYvy9cvWGOYmUb4vPs5Xw7aQJp1xWzAs917q0bby3a0YcyguKT1peGQC1WsBlSTVGYflhYnM86qPQNY/HTz5haX2I+pv0+JcYj7V+bn+Ntloy+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj5fEFrN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj5fEFrN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A049D1F000FF;
	Mon, 21 Sep 2026 03:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960974;
	bh=ux5z0s1IyADk+kuq3aqQ+l8AgeX+eTxzwLfvEW84JmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fj5fEFrN8ccQGWvt+EF/YNgew6mmxvtJIqe1V5sTRP/e7edvN2wS3ymje4nPnDI26
	 CsPKKgYh2Jg2Heb1i/Ao9azyhR8WJh6afZrsPMVostkc6qsqr7erPMTrusPCyX2g4+
	 paO0AAu1eyvoj2Vn/ULqZIXO6iRVPfjzQ2EzAgWehffWXfBOulU88QO1ukpyaGVse2
	 oJSsiueDFmCHh7sjgoa39hdTL9CHdPLccivayH6EbzmEF5+JE0XwjQJxgmqtFrYB3A
	 yBlcX+ttE/k7KWn2IoPHz6UmftWrBYCJwYz2is/7vz286ojxdwNdoxFL4jFuLF6Ugx
	 Zb/Vq+zYVOiew==
Date: Mon, 21 Sep 2026 04:22:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] dt-bindings: iio: adc: lltc,ltc2497: generalise the
 title
Message-ID: <20260921042253.68cf40c0@jic23-hlaptop>
In-Reply-To: <20260917042612.2175ac4c@jic23-hlaptop>
References: <20260915144624.44841-1-andrei.stancovici@analog.com>
	<20260917042612.2175ac4c@jic23-hlaptop>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 04:26:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 15 Sep 2026 17:46:24 +0300
> Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> 
> > The title names two of the four parts the schema documents: the LTC2305
> > and the LTC2499 are in the compatible enum and in the description, but
> > not in the title. Rather than extend the list each time a part is added,
> > say "LTC2497 and similar ADCs", as bindings covering a large number of
> > parts tend to end up doing. The full list stays in the description.
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>  
> 
> This is one where carrying the ack is not valid (unless I missed
> Rob saying he was fine with it). The whole patch was about the title
> which is now different!  Given the dt maintainers have automation
> around this I'm not sure anyone will take another look. Leave
> it a few days then send a v6 with Rob's Ack dropped.

Not worth poking Rob over, so I've dropped his tag and applied.
Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> > ---
> > Changes in v5:
> > - Only this patch is resent. Patches 2 and 3 of the v4 series ("add
> >   LTC2499 internal temperature channel" and "add 2x conversion speed
> >   mode") are already on the testing branch of iio.git, so v5 is a
> >   single-patch round.
> > - The title is now generalised instead of enumerating one more part.
> >   v4 added the LTC2499 to it; Sashiko then pointed out that the LTC2305
> >   is also supported and also missing, and Jonathan suggested stopping
> >   the enumeration and using "LTC2497 and similar" as bindings with many
> >   supported parts tend to do. The full list is already in the
> >   description and is left alone.
> > - Documentation only; no driver change, so no hardware run for this
> >   patch. The DC1012A-A validation previously reported covers the applied
> >   patches 2 and 3.
> > 
> > v4: https://lore.kernel.org/r/20260909082755.366269-1-andrei.stancovici@analog.com
> > 
> >  Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > index c884b6e03767..67445ad2bb3b 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
> > @@ -4,7 +4,7 @@
> >  $id: http://devicetree.org/schemas/iio/adc/lltc,ltc2497.yaml#
> >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> > -title: Linear Technology / Analog Devices LTC2497 and LTC2309 ADC
> > +title: Linear Technology / Analog Devices LTC2497 and similar ADCs
> >  
> >  maintainers:
> >    - Michael Hennerich <michael.hennerich@analog.com>
> > 
> > base-commit: 36c12dbda81c284d72f3c64689461647497b643b  
> 
> 

