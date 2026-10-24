Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810601;
	b=SGvNKc18oe0SihxiEbLhgp7/ARc50oTb+aQLw+5sDjRkfsMiCkT0vQd5/Rapowttl947
	 QxSzDVPj6W/swvqb+OeD6Pxmmtj//rYyegQ6dGBo2u74WM6ynGDQ29hkXlu3inRBfLvZJ
	 BGoYvxHOpgvOALtPxyyRLwxmdMHoF+6p8cnAdmy3MmCv3ilI1oZoW8M/PCL0G1jAg0QCV
	 J0VcwJc77bz83/fAsR5VtluQVA1kkNoPBBFj1eu/BLh1ZB0As7Yw6G+mARq5J4wSDBNor
	 sn2K4+jq8Qks3Io4/ikGZMuDmTATB9r2622Mo5OU0VUBLMXV7LG8zsNtwt3YM4YojSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810601;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TlMk0OHCWyY7aemC7WNhoEFJiD/shgfDTmWPL30g6hE=;
	b=5Bj6AgKqj37bZIzGLOB99Tc+HqIoFjC+g66hSQNWlJMhkiv7IquCZByh/vZBjlF58wAZ
	 MX5IKw6S16yTqlcMks+ciUoDj4k/9NeutGHX8ZHPL6MDFngXTRwDDsddwgR98WLfKF248
	 RmQwEQspmEHD6Isz57LFeBzO34D9pw9IDw3FnyOPGSf9VjJ2bOOzlCuWiI1qjhUTh3v0W
	 tTPpriCEEBjeLj1l0iHnCfnfkSO5xOnMlmQ5fxdUaqYrnEe44wJTnd0u98+d83rsfolhN
	 AFA2GRBpmfP5dzrO0W+D74Qr5ajEa2c2kAylh2IWo2SnArXTQTVZYXWbyvf2WxUfoZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRezZvsB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C606A31A;
	Sat, 24 Oct 2026 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRezZvsB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1359B1F01825;
	Sat, 24 Oct 2026 02:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810600;
	bh=TlMk0OHCWyY7aemC7WNhoEFJiD/shgfDTmWPL30g6hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NRezZvsB8/P53mapSwSg+QVKw8Aj0hW7pf1exkzBweCT5NmaadPVacDbbwupqbNs5
	 ah5Ro2lf6P0ZPPmNjTv0og/QEZZ9xhReRkV58OMNJFL6bTM9UT1lA3RdK9n2KxTK8J
	 s0bCf4NbQ9Fpsb+zTh40kPl8SGYIuYr3eB0FPRFuDEP1HxFzdeLFFPHk1nQGgp6H3F
	 jmChfXjgWyPAGr0Web7Xxo9/a0JGl0At38hexpHlD+UNwitgCBgTHUvqZk3poNZkqh
	 Iy5ExM7OnjabyqmrhXnRCnJ2OEpljProQhZjOkOAxdiZsi+t0QhYLYPpP/p4SZeiqZ
	 cJAgHJXcja++Q==
Date: Sat, 24 Oct 2026 03:56:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Mike
 Looijmans <mike.looijmans@topic.nl>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Md Shofiqul Islam
 <shofiqtest@gmail.com>
Subject: Re: [PATCH 0/2] iio: adc: add TI ADS1299
Message-ID: <20261024035633.500a1659@jic23-hlaptop>
In-Reply-To: <20261020000031.14522-1-stephanbrrs8@gmail.com>
References: <20261019001247.483005-1-stephanbrrs8@gmail.com>
	<atXuGv3esexdRJ4e@ashevche-desk.local>
	<20261020000031.14522-1-stephanbrrs8@gmail.com>
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

On Mon, 19 Oct 2026 21:00:31 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> On Mon, Oct 19, 2026 at 01:16:58PM +0300, Andy Shevchenko wrote:
> > On Sun, Oct 18, 2026 at 09:12:45PM -0300, Stephan Costa Barros wrote:  
> 
> [...]
> 
> > > A question on structure. The driver started from ti-ads1298.c, and in
> > > this subset the two are close.  
> 
> [...]
> 
> > Okay, I think you can try to rework this as a series on top of the existing
> > code. I can't easily see if the above difference warrants a brand new driver.  
> 
> Thanks, Andy. I'll do that for v2: first prepare ti-ads1298 for more
> than one family (chip info for the gain table, the data rates and the
> reference), then add the ADS1299 to it, with its compatibles in
> ti,ads1298.yaml instead of a new binding.
> 
> Some background: this comes from my undergraduate thesis. The project
> first planned a driver written from scratch; I then found ti-ads1298 and
> built on it instead. Beyond what ti-ads1298 does today, the out-of-tree
> driver that came out of it sets the gain of each channel, timestamps
> each buffered sample, reports lead-off as IIO_EV_TYPE_FAULT /
> IIO_EV_DIR_FAULT_OPENWIRE events, routes the internal test signal and
> shorted inputs, reads the supply monitors and the temperature sensor,
> switches SRB1 and SRB2, and runs a self test at probe; all of that is
> tested on an ADS1299. The bias drive, GPIO1-4 as a gpiochip, the CLK
> output, PWDN and suspend are written but not tested yet.
> 
> For mainline I cut this down to the generic ABI. The rest can follow as
> separate series on top of ti-ads1298, where most of it applies to the
> ADS1298 as well; only SRB1 and SRB2 are ADS1299-specific.
> 
> The automated review of this version also pointed at issues that the
> new driver inherited from ti-ads1298 too.
> 
> I had missed Md Shofiqul Islam's series when I sent this one, and found
> it only now: "[PATCH v2 0/2] iio: adc: ti-ads1298: add ADS1298/ADS1299
> driver", sent on 6 July 2026 and reviewed by Jonathan on 11 July. Md,
> are you still working on it? If not, I would like to take it on,
> following Jonathan's review there (per-chip match data, the reference
> voltage and the ID register), and I can test it on hardware: an ADS1299
> with DRDY as an interrupt.
> 
> Jonathan, if you would rather keep a separate driver, please let me
> know before I start.
> 
Definitely worth having a go to extend the existing driver.
If you run into major problems or unexpected complexity then
possibly come back to the separate one.

Jonathan

> Stephan

