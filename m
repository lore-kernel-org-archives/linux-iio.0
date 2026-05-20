Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386C3D8117;
	Wed, 20 May 2026 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779273374; cv=none; b=LkrcRJ06KbJodLEzZUPZYpy7Xqn5wpDvROaVYfJrflDog/m6/Gx9QEZIh/0Qqq6Z+8UjKjmJCjBUY70vIKT8yYZZZP2Om8SoBFK/vHuzTF4Npi3bNAcIBtRkdcLRG8NNdFc852aOd6IQqZuSGcOaXb9RVQy7H9+hs6A7upsac98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779273374; c=relaxed/simple;
	bh=8viWbM/+q7G0mIAPIT9mn7NLFoOSKm33yF/EUNfuFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eE4Q0Ul5SG4ZZHruQb0EhGdX61xBUQ7G9qw+ON2Kud8W5CjXdrA8MXR1lXcaheIt1vEY8S3xBRMnx+w3R8I6TXnpYYzBZSotqbQgdHPMM+m8Zw6TuUR09KYnwopiwWTNK9j3VcXhGS6YZ2FDK6J/6Br9OHLDZdZ9JMxI5hwikEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJeUv62n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJeUv62n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C221F000E9;
	Wed, 20 May 2026 10:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779273370;
	bh=ioZrtEEYg4k635wsb1/rh/i6x2bVFgbtMj1PfCjU82Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jJeUv62nYDVmjvlRxUP14odgLoWGsQxAPjPvKPQqaVplMoMjmhG/YaRILrWJU0e4t
	 I/zYoj38Tw5LMYHKUjhry7A1emyd565JTWq4ATAFtyfB/f8ZpSchUkpd1NbTo8B9W/
	 AS9l3HOHZXRyi3oxORKwnT22PlhshGaEwFgZ7rsdL8k2SFD84cKDP/mGkPLSDfTet2
	 uGmNG7tfb3Z2+Omid3NzjeiGmaO/K0lI9klay5uljq+FUAGw5ck6SA8sqWoi1mDBCV
	 GP9I7PdqcAKig5spLWOoFTVsq5OmwF/e8D5liw7rvhF467XuBGPn9LWZdCHNaJ4oFM
	 1pWI9giTLl+jg==
Date: Wed, 20 May 2026 11:36:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, "Sabau, Radu bogdan"
 <Radu.Sabau@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, "Hennerich,
 Michael" <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
 <linux-pwm@vger.kernel.org>, "linux-gpio@vger.kernel.org"
 <linux-gpio@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v11 4/6] iio: adc: ad4691: add SPI offload support
Message-ID: <20260520113601.2f13b9f0@jic23-huawei>
In-Reply-To: <agtZwbeVeZdnlXTI@ashevche-desk.local>
References: <20260515-ad4692-multichannel-sar-adc-driver-v11-0-eab27d852ac2@analog.com>
	<20260515-ad4692-multichannel-sar-adc-driver-v11-4-eab27d852ac2@analog.com>
	<80f61c0b-1f36-4fee-9f76-b93f63b87abe@baylibre.com>
	<LV9PR03MB841418AEF0059E802F7A69B2F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
	<60d66897-41cc-4f3f-afd2-64e49f0bb55e@baylibre.com>
	<agtZwbeVeZdnlXTI@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 21:26:09 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 18, 2026 at 10:16:38AM -0500, David Lechner wrote:
> > On 5/18/26 10:14 AM, Sabau, Radu bogdan wrote:  
> > >> -----Original Message-----
> > >> From: David Lechner <dlechner@baylibre.com>
> > >> Sent: Saturday, May 16, 2026 8:53 PM  
> 
> ...
> 
> > >>> +	if (st->manual_mode && st->offload)
> > >>> +		return sysfs_emit(buf, "%llu\n", READ_ONCE(st->offload-
> > >>> trigger_hz));  
> > >>
> > >> Why do we need READ_ONCE?  
> > > 
> > > trigger_hz is u64 and if the target is 32-bit, a 64-bit access compiles to two 32-bit
> > > instructions, so show() reading it without a lock and store() writing it concurrently
> > > can produce a torn value at the compiler level. READ_ONCE/WRITE_ONCE suppress
> > > the compiler transformations that would allow that splitting or caching. We could
> > > have st->lock in show() instead, but that felt heavier than necessary for a single
> > > scalar where a transiently stale-but-whole read is fine.  
> > 
> > I would go with the mutex. It will be easier for people to understand.  
> 
> But why? READ_ONCE() here is exactly enough. We do not care about
> serialisation, we care only about integrity. With mutex it will confuse
> (some) people more, e.g., me. Because in that case I would think about
> some specific access to it that may happen. Yes, I saw many times the show
> functions that do mutex and then print the result when mutex is not held
> anymore, but for simple cases like here, mutex is overkill. Interestingly
> that using guard()() inside show makes the mentioned functions to print
> (almost) latest value of the variable in question. It narrows window down
> as printing will go inside critical section.
> 

I think it's worth noting that we are very lax in IIO wrt to READ_ONCE()
usage.  It might be worth starting to tighten that up for state variable reads
etc whether they are 64 bit or not (that just increases the chances).
In theory compilers can do far too many evil things.  I've been scared
of pushing this because of the massive number of incorrect instances
(and the bad example I set with early drivers :(), but it would be good
to have a few examples in tree so we can start to encourage people to
do that stuff right.

Jonathan
