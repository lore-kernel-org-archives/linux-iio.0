Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681994;
	b=JXNkw4xBosAoo/x962wFpDpSPyh/3ZJBucx6THGQ3lXIdYz/rVCQ6YQIbfT6LK0siykz
	 8rxCq5YZRQSxYIlIrYkFksLw2Po14r0S+RSSXs82RDKf8Ima/ep+1Jsq7Tu22YPIxr77+
	 tpX/YJAyYVJTuDqNjtSjVzdlieVm6uSE6ifFtwEd43uhK4mU5kW4fQ+eybFTc30xjuUa0
	 lvmDHNzqwc4+FtuusA9xA5FbAudAs12igfxWUFz9blNxTK6wr30igVwhH9yJMEFLK9ZUG
	 Tk6A+Yd3NadG8xXYT4RBC6PqHSkDybNRSTqCXpQAMdextd/Ck9FAxtSVWcuqBN8VMbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ATBXE6mL2rkywyDuVY/BzHx2Pz3wTKC3ekdScyG0NSg=;
	b=dyYrBuHt2BmP5QCg8ClNqNcj7QF0w0v/sHnh0dkcqLNoNIjbNsV9MnUtrugn07BK/34E
	 oAGoRE81oWsknj83Vfy9yCN588jQvMIoqXuNaPl2jmeNJLdahCuOgHuVnEYwvEZMTBEC5
	 KghK5TaC/U5bkW+gmI2AUyviDdqdCsLErSdnI7RG9Y5nwOY6YUE6SbjgkJ/LQOB4apVQz
	 +EwSF7q0n8a4fleHEZ/KMLW3c5lJcb7MJ1te9q9DzizMuwX8E+GyKnznT+C4FOfJF3KEm
	 U0FdS4yKRNsetvIqDev5ACChxIMWqUk8GPPPaAw7Z1fYsP38ShTXdKyPj3Jt5YnipvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icl4Hk4f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF86606A327;
	Sat, 14 Nov 2026 18:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=icl4Hk4f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B261F000C4;
	Sat, 14 Nov 2026 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681994;
	bh=ATBXE6mL2rkywyDuVY/BzHx2Pz3wTKC3ekdScyG0NSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=icl4Hk4fFpQ+ghPZ30yRMDdKzukd7AH0T121nHHmHmbIczLLoyLoTl9bbGQybuAx6
	 AAp2a5gFrXFqvV2mo0vDmq8ql5PqWxCosQVT/Xw+DCoZKbptmhH04wmS2L2BwfoVo0
	 eAIVqgQm40Saj9AUbXJIvHbEMVpbuG/ainHMWNp1k0ouD6Nf7H7bkOpRC6/8tB1Ixj
	 mjIL6n329UmEeIOS7Eft1olzLZRAjXLSxTTIV4QoHvjVx6psZBVeP2zJaUcurHiagS
	 oUtpBsZINXCBb8AiyelVg4B6US2MrebttfPR5yo8GbUV/+J0iITyX4lcHoW/cfr7l+
	 U3OuvIgSjQNDw==
Date: Sat, 14 Nov 2026 18:46:22 +0000
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
Message-ID: <20261114184622.5d47903f@jic23-hlaptop>
In-Reply-To: <51eaa37a-9634-42cb-9aac-4c842ab2af07@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
	<20261104021700.14e69abb@jic23-hlaptop>
	<01fe2a71-ba6f-470b-b6bf-e536a1013b09@linaro.org>
	<20261107230925.5e66b234@jic23-hlaptop>
	<51eaa37a-9634-42cb-9aac-4c842ab2af07@linaro.org>
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

On Mon, 9 Nov 2026 10:52:22 +0100
Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 11/8/26 00:09, Jonathan Cameron wrote:
> > On Wed, 4 Nov 2026 09:45:02 +0100
> > Neil Armstrong <neil.armstrong@linaro.org> wrote:  
> 
> <snip>
> 
> >> But for the other reports:
> >> - [Medium] iio: adc: max34417: shared accumulators clobbered on CAM power/energy read
> >>
> >> This is a tough one, today if either we read power or energy, we erase the accumulated
> >> power+count in the context, the context accumulator is only here to make sure we don't
> >> loose data from other channels, like if we had a single HW channel.
> >> This simulates this, if we had a single HW channel, at each UPDATE we would get back
> >> to 0 in hardware anyway if we did read the power or energy.  
> > 
> > 
> > I'm only half understanding this.  Let me see...
> > 
> > I'd expect userspace to see accumulated values since we enabled the channel
> > rather than since last read.  I think that's the final suggestion from
> > sashiko.  
> 
> Oh this changes quite a lot of things.
> How do we handle overflow in this case ? we disable the channel and enable again to reset the state ?

Is it possible to accumulate into a sufficiently large type that overflow won't happen in a feasible
timescale?  Anything else is going to be a but unpredictable for userspace if it
is expecting an accumulated number.   The other things that accumulate in IIO tend to be
moderately small so it's never been an issue (things like step counters).

Jonathan



