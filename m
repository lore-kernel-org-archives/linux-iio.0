Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792969567;
	b=PxMdjbXKld2wYcxIU3X6i2sxtLOeEr9OlD12cKWop+rVTPmzjqf0DEX0e5ag0tPPT2du
	 K12W2RiBe4ivtOMRCi8L0kr7Dc0HxtprIKSYukqBbD2osqsuCH94Uu+YctBQ23+zSUI0f
	 Nd6LvwsdNZChfo1xLDWgMgKXbRGv/GAQnZ9SPLEPnzzrVA5TkXVi/3HcUaeM9d1hvPk7W
	 K3X3MCm5pDil8bcrU0ZucidAqk+bqPnrS8IPHXUR/I0GAk+x1+OOPH1BUJmOlGivQehDu
	 erWWxGuNy0EatG6u32e31dqCbA1DXnD+jJFutqsjAyEHoPDkcdNQgPo716vP7XyU6pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792969567;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=9X+eCEJM6Bm0M9jCniiKDdeECCVzDK0ao2lv5p6rrwE=;
	b=Osp80htim5Nlqj+74YItCeGVSu30euFaxv25hAmglVGMUyqAiSzUgFur1mXhwi+h/vQG
	 6FeIdpk8vuKkn3zNGy2phwzxsrw5uVJg58jEJixlRnsyJwxoDxhhVD27bBl7/r5eCsGk+
	 lfSk3Uhlf7Ni3uSNapV0Pv7AB2ZWOzQz8qvMszhTEcmOD7H9HHpwG49YyUgWDSH6b6/gN
	 Hc4QSxNeJse0gBFhIgK5oG06oAuDXkWOhEqpbfB1HSCLoQJ17K3veDZdq1DQEgUlkP+rJ
	 8rIEtkQ8g6JM4Mw/Mkp5InpmliK0p4LhdCgj9h1eX/E0GmsfQZ4CbcEYWMYHKGWwBNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlW34+GY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C951606A31A;
	Sun, 25 Oct 2026 23:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlW34+GY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2941F01825;
	Sun, 25 Oct 2026 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792969567;
	bh=9X+eCEJM6Bm0M9jCniiKDdeECCVzDK0ao2lv5p6rrwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NlW34+GYlgVJnAB/wb+d4MLG6Fr3hcnZcsmjnyJ8AaRC2+NBECKspsmJZK7NL2C+e
	 WQZWVfGLaTqC1lc96TU/pFN8CqfJRCoedg8az/xCQds8ZjJyz1vm1bBrw8p8ILop5p
	 LmijH7W9gESQzqREweGFjE8//yU67L3QfP+5wVTX6gE8mNOZSRBBScL7iWWijcHZHV
	 Iuenv3BNwr4lPdM9Ua3Hq6u28xA98rj8qPV/RhSQ9Sj4TD+QSPBD5GKCqNtysE8yhM
	 Nyg11qfxixFGeF+F7uWb2Yci25xh5CiiYBEup01GpzBQJnFyrd7sQnkaFRE2Qe2NPG
	 whq6maC2/DcYA==
Date: Sun, 25 Oct 2026 23:06:01 +0000
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
Message-ID: <20261025230601.6a2eae34@jic23-hlaptop>
In-Reply-To: <20261024231335.280955-2-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-2-stephanbrrs8@gmail.com>
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

On Sat, 24 Oct 2026 20:13:30 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> Fix five issues in how the driver reads samples:

This is a lot in one patch.  Can we break some of this
up into smaller changes?  The whole thing is probably
to complex for a stable tag, so focus on the most broken
aspects.


> 
> - cmd_buffer serves both the register accessors, under the regmap lock,
>   and the commands, under the IIO device lock, and shares a cacheline
>   with rx_buffer and tx_buffer. A register access can then rewrite a
>   command on the bus, or corrupt an RDATA transfer in flight on a
>   platform without coherent DMA. Give each path its own buffer, each on
>   its own cacheline.

This I'd like in a patch that does just this and allows the commit
message to say why simply using a single lock for the data buffers
would not be cleaner.

> 
> - After STOP, the conversion in progress still raises DRDY, so an RDATA
>   transfer can be in flight when the core frees the active scan mask.
>   Track in the driver whether samples go to the buffer, wait in
>   predisable for the last DRDY and its transfer, and push the sample
>   before marking the transfer done. update_scan_mode reset the transfer
>   counter, which let a new transfer be queued over one in flight; wait
>   for it instead.

Complicated sounding solution. Can we claim buffered mode instead?
That would ensure the update_scan_mode and this don't race and mostly
would be taking an uncontended lock.


> 
> - When a single-shot read times out, its transfer may still be in
>   flight, and the next read then wakes up with the old sample. On
>   unbind, nothing waits for the DRDY interrupt or its transfer. Wait for
>   the transfer before a single-shot read, and on teardown disable the
>   interrupt and wait for the last transfer.

If we get a timeout, we'd not normally worry too much on old data
on the next read. It's an error case that isn't supposed to happen so
if we are talking stale data that is often considered fine. The
second part may make sense - break that out as a separate patch
so we can easily analyse it on its own.


> 
> - The return value of spi_async() and the status of the RDATA message
>   are ignored: a failure leaves the transfer counter stuck, and a failed
>   transfer is reported as a sample. Handle both.

This is fine but not burred in this giant fix patch.

> 
> - read_raw takes the sample out of rx_buffer after releasing direct
>   mode, so a buffer enabled in between can overwrite it. Take it while
>   direct mode is still held.

This one seems valid.

> 
> The first, second and last were found by review and not reproduced.
> The third and fourth were found by review and reproduced on an emulated
> device only.
> 
> Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>

With all the above in mind, I'm not going to spend the time
to unpick the different fixes today but look forward to them
as 5ish individual fix patches.

Thanks,

Jonathan
