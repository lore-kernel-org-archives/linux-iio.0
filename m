Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1AE443302;
	Sun, 11 Oct 2026 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791727286; cv=none; b=oBvNiyi/YjPbBy02d16VgHXskLD5OUZb8rsMgo4V4tBNaVYNpKnZZF86x/1n2/lyGno7Ilwkk3MnJeJsPUYag7mGmzOs+IJxSW6N+Ovzq56CJHno0nm6Im9CAg5bpEfK2LPADALEhjAOkpEZyZuTjIaGG4REJw4gn9CLTMbmwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791727286; c=relaxed/simple;
	bh=Na1EUkt0JJQwOnozdLO0DdKbJ7Wnsm00ry8p7zOjNsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fRdmpEHRsVD17Wbrz5jQdsXnqJjAvL2OmIxOxCR/3Fz6VRG0mHFEUZOD3bE2ZEibDDF4GovAREYf5YoackEe3LqirAqCoMtOdfMauXQUCE0V1Qni611LSqsiXyr7E8NfWN/UtrW6SVmDbe00DAnP3rftMMex7rMXB650D+aO+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O71hz7vR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O71hz7vR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04431F0089B;
	Sun, 11 Oct 2026 14:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791727285;
	bh=fs7ad+dEwnEnvKB6eqmYTdy81PfBs48cMsK++AYh+fg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O71hz7vR7Ey8tNoLL6GVRVX/1/+gCErbCwiJOyYdcBy1gZOc3C5KKCEMtEY6kD0EG
	 6wJoRluV4cR+hzm6+Z9sFKKdb5D0hVQqYWIQz39wxVrzmtG0K1UIQjs7mn+XwhnUnZ
	 J5GlRAVVXRSo0cbkq16yJBVHBcWXF+GbpxKTaj4K3d3ZNRCrOnG1lA/MSzbO+mDOdH
	 hfxAwA/uoqJ0Gxa0GCAG9MoItoB401WS0e+x8tzg/xchkWdDvnogYDBYDvHAswZaeJ
	 SCUVBCRIgChvp7cO88Hb04v7qb6UESUloR/ucsJJ55etASAHjllCJSoR+6cQdQHGQO
	 VhWFZSqJHQ9fg==
Date: Sun, 11 Oct 2026 15:00:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Justin Stitt <justinstitt@google.com>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v12 0/5] iio: pressure: dps310: hardware FIFO support
Message-ID: <20261011145914.05d1c7a6@jic23-hlaptop>
In-Reply-To: <20261003195012.92948-1-zoone.rupert@gmail.com>
References: <20261003195012.92948-1-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Oct 2026 22:50:06 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> Rest of FIFO series, on iio/togreg which has 1-6 and 10 of v8.
> 
> Since v11:
>  - patch 1: blank line, Reviewed-by Andy
>  - patch 2: guard() in postenable, setup moved to a helper that kfree()s
>    on error, scoped_guard() in fifo_work, loop counters in the for,
>    ternary on one line, two comments trimmed. The first loop in
>    fifo_drain keeps cnt outside, it is used after the loop.
>  - patch 3: signature wrapped
>  - patch 4: drain comment and commit message trimmed
>  - patch 5: Suggested-by Andy back, assert in the new helper too, still
>    optional
> 
> Pressure overflow fix is now at v4:
> https://lore.kernel.org/linux-iio/20261003185716.32732-1-zoone.rupert@gmail.com/
> Patches 1 and 5 conflict trivially with it. I can rebase on whichever
> goes in first.
> 
> Retested on DPS310 with BeagleBone Black. Lockdep run under QEMU.
> 
> v11: https://lore.kernel.org/linux-iio/20261002072526.250081-1-zoone.rupert@gmail.com/
> 
Applied patches 1-4.   Not this was messy so there was some hand applying needed.
Please check I didn't mess it up!
Maybe we'll still get some more review on these (which is fine as I'm fine tweaking
or dropping them until I rebase on rc1 in a few weeks time). 

However, too much in flight and I wanted to trim down what I was paying attention
to!

I replied with my view on patch 5 in the earlier thread (just now), but definitely
open to hearing more opinions on how far we want to go with annotations.

Thanks,

Jonathan

> Rupesh Majhi (5):
>   iio: pressure: dps310: use devm_mutex_init()
>   iio: pressure: dps310: read buffered samples from the hardware FIFO
>   iio: pressure: dps310: derive the drain interval from the watermark
>   iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
>   iio: pressure: dps310: assert the lock at runtime too
> 
>  drivers/iio/pressure/dps310.c | 441 +++++++++++++++++++++++++++++++++-
>  1 file changed, 430 insertions(+), 11 deletions(-)
> 
> 
> base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68

