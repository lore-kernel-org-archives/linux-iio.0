Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1082E1EF4
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776619563; cv=none; b=NaKiH/0j7sGkKwwzaGhBX+b9M7Yi/Gqa5ERgqXIZvY8/Vwj5gMlZY3u72+XyjrHOmLlUdFR+Ec2cV4s+Oc87iBR6BVTIElIv17Xhyd/ou89si8gIPcyABlfrUbWbwD+NT7pnrwuoMYdT8U3cF6cyNVAakZW6rybQkPTdkhUvHAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776619563; c=relaxed/simple;
	bh=RoiSc+wjeEjjlczCgd7q/xW+tked8K2n1tMDycqP2Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgFF6pXC7BL+y+6gjjR1i1ESz1o6IwHd0mDWqZOE+dyAlnYdRLBlCKgwH4IONRFlVLIXTYeJumVg1RqAfUhODYkmn26LPHM/V1wMPGkFiSKyRbK+ZF3/HI5U0B05+GKUwDtcfmOgkn8gP2s1tKft6sdkGEPXtnwLDPkBPNsWms0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKDFuwye; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKDFuwye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18CD8C2BCAF;
	Sun, 19 Apr 2026 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776619562;
	bh=RoiSc+wjeEjjlczCgd7q/xW+tked8K2n1tMDycqP2Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKDFuwyet6wT3FFLMnH2bVKg5vQKNIHYBL8JbX6nkE/bXrSSYW5MNlg55+HPltLXy
	 sDMWsrrSNkQUTvpRClUOXFICPxG0xeo9m3KYP6h9PS9PannTC/uuYHKdgBheXWAQgu
	 TOsGUZSrvcmvMI2zMqaCuJuoPCJo/9U9JKmd8qi2kvBwsP3AJ8wNDUkkI24L4fZI36
	 CY5TXlGxj6rAT088p0nTNgyCoE/SiaL+o1le9WEjszUUoa5g2N3XTT+kpe+6A2SZeD
	 R2RGG5c6J/sYvgweXojFstX9c5XJKFlPKjHvbb5vzybbqDmNA2lnVHRBSRru+ji7ed
	 JvFuK3GBdQH6g==
Date: Sun, 19 Apr 2026 18:25:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, Felipe Ribeiro de Souza <felipers@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7280a: use cleanup helpers guard() and
 scoped_guard() for mutex locking
Message-ID: <20260419182555.44eb4e28@jic23-huawei>
In-Reply-To: <aeHpz7Ny2hP6Xj0U@ashevche-desk.local>
References: <20260415160856.22231-1-lucas@ciziks.com>
	<aeHpz7Ny2hP6Xj0U@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 11:05:35 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 15, 2026 at 01:08:38PM -0300, Lucas Ivars Cadima Ciziks wrote:
> > Replace open-coded mutex_lock/unlock pairs with the cleanup-based
> > guard() and scoped_guard() helpers in ad7280a_write_thresh(),
> > ad7280_show_balance_timer(), ad7280_store_balance_sw(),
> > ad7280_store_balance_timer() and ad7280_read_raw().
> > 
> > This removes the need for the err_unlock label and explicit
> > mutex_unlock() calls, as the lock is now automatically released
> > when the function returns or the guarded scope exits, regardless
> > of the exit path.  
> 
> ...
> 
> > static ssize_t ad7280_show_balance_timer(struct iio_dev *indio_dev,  
> 
> >  	unsigned int msecs;
> >  	int ret;
> >  
> > -	mutex_lock(&st->lock);
> > +	guard(mutex)(&st->lock);  
> 
> This will add some rather heavy operation into the critical section.
> Why do we need that? Please, use scoped_guard() in such cases.
> 

Even better. Look at how ad7280_read_reg() is used and consider should the lock
actually be external to that?

There might be a strong enough consistency argument for scoped guard out here.
I haven't really looked at it closely.
> >  	ret = ad7280_read_reg(st, chan->address >> 8,
> >  			      (chan->address & 0xFF) + AD7280A_CB1_TIMER_REG);
> > -	mutex_unlock(&st->lock);
> >  
> >  	if (ret < 0)
> >  		return ret;  
> 

