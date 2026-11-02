Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578092;
	b=nJ1jYHigaU4c++U5Afgp/6wZq6K3a+nun4gyzzPO9zKJdj8YkouFiDepkQBEfke9YJKg
	 gSKEF9CNgoYTPn/Ij4/E8gODUK0PqWu2qXLhDrLmijBn53+VRGjVolCwqr4JvBWcQ1Qb4
	 Tc/NfyF1kpKEZWplOMqV0CfJwaDQIh3wnPKBgpCASomRK/X9m1+qr2NbBNfHBnel6Zpwt
	 zGKSdJx176/ym6xn24hKGWrT7aowAdIPU0yeaWP/zuIG9l0NFIh+2SLgOwtqJaCrONdK4
	 +eclqhvKNiUFZcKfekg/kBUmcwBDVPN/YE0Qz2vD9CBcYxAWXo9dH/suzP42ostfVPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578092;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=To2uuGbxbCF9OFD4rYrbZQc498MOdFtRXrJ5fR1WVTU=;
	b=JcBQHCsb6BVoeSHMFMszAtcoIhD8uRLVh1mUcKzN1pp1xBxK0CLFsrOZFRO0sgtY5glY
	 vzcz71Xu6cs1VyeT3xFDCUINxvu7BjPgKO6iJXEh2vJ/9PNB9Lc8QdCuBt+Cp1Wizc4xc
	 wo4EMLp97vwJOntan839zgEnqz9SMY+rFhdBkSYnNIMbHPiC1u9K4NOibu6Gvzu3jp2LK
	 LlYw2Z/wjoUg25OMDoCuOhSQ0Aswe+nnmYjyRVM41iIOcgMYpFS4Y+Bvtc5Z2YJ0jWbyf
	 jzG9r/1svCjM3F4Gcu1f1xrBbLVhKCyiUf7oDYgPWFsKKQmzCVTs1PbqWLXPSPnMlEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsFR662W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF60606A324;
	Mon,  2 Nov 2026 00:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsFR662W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8521F000C1;
	Mon,  2 Nov 2026 00:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578092;
	bh=To2uuGbxbCF9OFD4rYrbZQc498MOdFtRXrJ5fR1WVTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VsFR662WK1EvXzuwd0r/uOXZxWykjrSBpVH7zElBWp1mwIMIMzKyMMuDDAAWuQGCw
	 TYA9lDewlAC1l7pyJ//BZYFazk2a2jZBzFDG4UKncYFBvQ7pSTps1HvyRc0oBs5bJJ
	 SnvYjnf9W7JN1gWXrk7BcCCBr+jQRujDwcZ94Q9bp6OuVGbgQesRk3BwwrpMlOGry1
	 322Tycd37S8FiVicn+2PNUEr9bMB4Rvxi6Ggs5rIlvurRz33zc2B2ERe37FUYz5Hg2
	 pekT1qbV5Y3oJrbwP6Z6n11cxpNT/nT+qv8Y9j+i9q0POW4B/7dZjDx0Gk15nCHEva
	 LA9S+Ulz2nCYA==
Date: Mon, 2 Nov 2026 00:08:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: adc: ti-ads1298: fix the data read path
Message-ID: <20261102000802.646dfd86@jic23-hlaptop>
In-Reply-To: <20261028021946.29877-1-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-2-stephanbrrs8@gmail.com>
	<20261025230601.6a2eae34@jic23-hlaptop>
	<20261028021946.29877-1-stephanbrrs8@gmail.com>
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

On Tue, 27 Oct 2026 23:19:45 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> On Sun, 25 Oct 2026 23:06:01 +0000, Jonathan Cameron wrote:
> > This is a lot in one patch.  Can we break some of this
> > up into smaller changes?  The whole thing is probably
> > to complex for a stable tag, so focus on the most broken
> > aspects.  
> 
> Will do: one patch per fix in v3, the most broken first.
> 
> > This I'd like in a patch that does just this and allows the commit
> > message to say why simply using a single lock for the data buffers
> > would not be cleaner.  
> 
> OK. To check the argument before I write it: a driver mutex around
> write_cmd() and the regmap accessors would also stop a register access
> from rewriting a command. It does not help with rx_buffer, which an
> spi_async() started from the hard IRQ writes, so it cannot be under a
> sleeping lock and still needs its own cacheline. Separate buffers fix
> both without a new lock. If you would still rather have the mutex for
> the command path, I'll do that.

I'm fine with the approach you have here. I just want some more reasoning
in the description as cachelines can be quite large and so we need
to have a clear justification for people thinking of backporting the
change.

> > > After STOP, the conversion in progress still raises DRDY, so an RDATA
> > > transfer can be in flight when the core frees the active scan mask.
> > > Track in the driver whether samples go to the buffer, wait in
> > > predisable for the last DRDY and its transfer, and push the sample
> > > before marking the transfer done. update_scan_mode reset the transfer
> > > counter, which let a new transfer be queued over one in flight; wait
> > > for it instead.  

Too much cropping.  I had to go find what I replied to in order to
following the discussion! Put back above, indented as if you'd left
it there

> > Complicated sounding solution. Can we claim buffered mode instead?
> > That would ensure the update_scan_mode and this don't race and mostly
> > would be taking an uncontended lock.  

> 
> I don't see how to do it where the race is. The sample is pushed from
> ads1298_rdata_complete(), the completion of that spi_async(), which the
> SPI core "invokes in a context which can't sleep".

Ah.  I'd missed that complexity and was assuming this was a normal
threaded interrupt handler.  One simplification here would be to stop using
async spi and instead just use synchronous spi in an interrupt thread which
is how most drivers handle similar flows.

> iio_device_try_claim_buffer_mode() takes mlock, and the core holds mlock
> while it calls predisable, so the completion would also wait on the
> teardown it races with.

yeah. I got this wrong in another reply I sent today. Indeed, the lock
is not conditional even though it acts like a conditional lock in the
outer call.  We need to be able to queue up multiple users of that
state on the lock so it can't be conditional wrt to mlock.

Added checking the existing places we grab the buffer claim to my todo
list for likely bugs :(


Jonathan


