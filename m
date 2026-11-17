Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885772;
	b=JL2PcFat69hj5mY6NO2jIeIYLcKw1maqAlSEar/vLOjOjiOF4XmJcUXorg3TIuB2kb+O
	 e/fkhtKZ8zacObOck+OntgaFbpkCjZV5wqjCQck+YheDTKcN7PW6ZJM+ZPJf5FiUqklhj
	 WOFITX/E4I3STDQAic7w61yrJL0RwyUvNl7A/XldEtKhgVKG8jdnjcAm4u5lWYbdggFCC
	 OQouW+tOkH0qGDOusrW6I1czvJ88y44Im4NevqVN3oBXHq22mmJRiPttozuIfj2zelO3b
	 rw8syv4xJwcy6c25vv8S9GQT2wj97U4ojZV5mEn88C/qdqIaE7E2Of+eR5gUW+chpsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885772;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=t/AjsBL1snAP5gb7R7uBEjYqzWe1X/S9wVxVGayJ7D8=;
	b=aqEdxOBEcdhYUsUUTX2OPe+MhrjIRU5cc73Zimvf45U/ihYENHW8IviWPMWKrugYTu0u
	 /alxlttZN1AlNSo7EifgG8Zc5Ti3n4cUDo/X42dL1grl7MLFSA2g/eCKLxjwtWT2Y6SOz
	 bBQ3AO7Nt3VyqO8XOMBBJYhoRowy61q1IuipvOySZHakxaXGZ2uEJzzLwcNYOkiNmUl32
	 SEou5Hy2tPWVSfB5/e1bxk+nt3iDns501ltOrdSHynyLZvBLffIUJsaPlKONysSAxoOry
	 mLDeC7y7iyhBE9DKrSMm+1z0YBy+csXpQ9XUljQ8fuXdNgvAfNufdld5kR7jcDy7flA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc1znfIV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC1F606A331;
	Tue, 17 Nov 2026 03:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bc1znfIV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA431F000C4;
	Tue, 17 Nov 2026 03:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885771;
	bh=t/AjsBL1snAP5gb7R7uBEjYqzWe1X/S9wVxVGayJ7D8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bc1znfIVMQznccauN9jlONfAol9goaOWdCPJSxbEMPFcHLv5l/6mKan1FcrVgCpt2
	 YKJbJfLnuE4yb1TM/kjUhpfU7AYj5/2hspGPzWQdbOeFhPAxd9gbLAARFWygz1ErWO
	 YKeDKCmsaSlKizBVBO08qRf2M4UqBMM5ZCexFYWXu55Mmq+DVYKTXSnTdr3kk2fSb6
	 kqNpFREm4furlJVfyEjkWb0RFcKk1WYngCYWOlNAuqWXSCjPl9Fdh3KqaCeBwC5Eg5
	 WZAmobKCtJjyMYWTXZmSx1PuBCnrX4atuZkWCBhoeHrvvoXjbvXTx9qmT55AFZ9aoQ
	 ZQw+5S/TmBbag==
Date: Tue, 17 Nov 2026 03:22:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux@analog.com, Conor Dooley <conor.dooley@microchip.com>, Marius Cristea
 <marius.cristea@microchip.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 0/3] iio: adc: add support for the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261117032240.487a2b1b@jic23-hlaptop>
In-Reply-To: <6cc41f58-970a-4a18-8a8d-dc6e7b42fe1e@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
	<20261104021700.14e69abb@jic23-hlaptop>
	<01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
	<20261107230925.5e66b234@jic23-hlaptop>
	<51eaa37a-9634-42cb-9aac-4c842ab2af07@linaro.org>
	<20261114184622.5d47903f@jic23-hlaptop>
	<6cc41f58-970a-4a18-8a8d-dc6e7b42fe1e@linaro.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 10:34:30 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 11/14/26 19:46, Jonathan Cameron wrote:
> > On Mon, 9 Nov 2026 10:52:22 +0100
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >   
> >> On 11/8/26 00:09, Jonathan Cameron wrote:  
> >>> On Wed, 4 Nov 2026 09:45:02 +0100
> >>> Neil Armstrong <neil.armstrong@linaro.org> wrote:  
> >>
> >> <snip>
> >>  
> >>>> But for the other reports:
> >>>> - [Medium] iio: adc: max34417: shared accumulators clobbered on CAM power/energy read
> >>>>
> >>>> This is a tough one, today if either we read power or energy, we erase the accumulated
> >>>> power+count in the context, the context accumulator is only here to make sure we don't
> >>>> loose data from other channels, like if we had a single HW channel.
> >>>> This simulates this, if we had a single HW channel, at each UPDATE we would get back
> >>>> to 0 in hardware anyway if we did read the power or energy.  
> >>>
> >>>
> >>> I'm only half understanding this.  Let me see...
> >>>
> >>> I'd expect userspace to see accumulated values since we enabled the channel
> >>> rather than since last read.  I think that's the final suggestion from
> >>> sashiko.  
> >>
> >> Oh this changes quite a lot of things.
> >> How do we handle overflow in this case ? we disable the channel and enable again to reset the state ?  
> > 
> > Is it possible to accumulate into a sufficiently large type that overflow won't happen in a feasible
> > timescale?  Anything else is going to be a but unpredictable for userspace if it
> > is expecting an accumulated number.   The other things that accumulate in IIO tend to be
> > moderately small so it's never been an issue (things like step counters).  
> 
> The hardware can store up to 4.55h of data with it's 56bit with the default rate,
> we store in 64bit in software, so we can store up to 256 times so up to 48.53 days.
> 
> It's possible to lower the SPS to 8, in this mode we can store up to 6211 days of data.
> I plan to add this mode afterwards.
> 
> I'll switch to this and clear the overflow only if we disable the POWER channel.

Hmm. Could use dual 64 bits values and a retry loop for theoretical tearing.
Would then need custom code to report though which isn't ideal and
it might rather surprise userspace.


> 
> Neil
> 
> > 
> > Jonathan  
> 

