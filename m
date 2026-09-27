Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B18A3B961F;
	Sun, 27 Sep 2026 19:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790536828; cv=none; b=OpMVQADirkgplTMOkWasUDHDv6aPaP7Scadove166iqOejRi8hum9e9KRQ7oBMehZ+6eraheW5t5jje1Bw0D4pgp4VfUv7VFDQlhNs39A0oZiMVJCUkOBldBWiDSaHCucfVK3cbAbNzuPfNf96J/TyGl+dJeMdT96l3FGObndNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790536828; c=relaxed/simple;
	bh=oiCTL8EpT0ZRStGZFP34WodlD/ufVXWiGnOSZ+U04WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KbW6LZYId3P/6sbQhBqZ9p0h262X3nFWurbehkYiWqU6G7D8fv1OpkpPqvP1Tg8ZLmlveA9G/xnx+noWJ09tECTOpAWs/FejCr8Vj60SmJH6KmIExwAdd5Rs5cmoNdTBdo1VZM0ZAt02cqskRSKDGtREfI5+Sy5ZnIR4P23BW1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRk4BjLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRk4BjLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094381F000FF;
	Sun, 27 Sep 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790536825;
	bh=w1Mt3mxIwkZ6STlK6MldHGLAuseHKDidYUPG0X552Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LRk4BjLPkwusaTTrwwdj6kzOE0J9hbIESOQBLcl1iUf1psD+sCWmLY/5VTDgSlAsu
	 HJVZxiQPmOqYTGenFQAyT2SK5CMx6s8+yFY+HOcAZVypv9GaiL+o+7onkS1ZIsqp32
	 QndLFSb4tKytiI8WT136yyEk8i5Cfluk0xpXlk2RWmTgenI/P7134b1pRswsxLSrwt
	 WfeVEUNAYe6/du4kR69AR5aKWeYWatnJQ5e63uUkINylvVkL+oeBzNG+7jkbcRVy8e
	 kKX/ZZYDWPhoy9A3/6yXOs2LkqfkPL6gj74P8OV3kU7uZIibouUpcDNGsjsEz2afwP
	 547a5KP1rjH5g==
Date: Sun, 27 Sep 2026 20:19:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
 David Lechner <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>,
 Joel Stanley <joel@jms.id.au>, Justin Stitt <justinstitt@google.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v8 04/10] iio: pressure: dps310: take the lock once per
 raw read
Message-ID: <20260927201917.2e8412b7@jic23-hlaptop>
In-Reply-To: <20260921183132.233136-5-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
	<20260921183132.233136-5-zoone.rupert@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 21:31:26 +0300
Rupesh Majhi <zoone.rupert@gmail.com> wrote:

> A processed pressure read takes the lock twice: once in the raw read,
> then again when dps310_calculate_pressure() trylocks to refresh the
> temperature. The refresh is skipped whenever the lock is busy.
> 
> Split the raw reads into variants that expect the lock held and give each
> channel a helper that takes it once for the whole sequence, so the
> temperature refresh is unconditional. Buffered capture later in this
> series needs the same shape.
> 
> Mark the functions that need the lock with __must_hold() rather than a
> comment, and include cleanup.h, which ACQUIRE() needs and was coming in
> transitively.
> 
> Assisted-by: LLM
> Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Applied.
