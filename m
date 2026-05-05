Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F8948C3F5
	for <linux-iio@vger.kernel.org>; Tue,  5 May 2026 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998336; cv=none; b=IrysmzUYKGZSPOPcMS5+Rvh8V69sQqSi+A8Wv+1et/DqjBljpfdK0j+vRW8+0TrGzY6ojSUcVzvFY+3sFFd1NsKi3o9ihiphYGfML1MbKv9jArw9Oxrcy0rKU4m3c36XnmWFXfeUezFdwTM0GRstc5gZQJEs2OUwpy4Zz6cpOuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998336; c=relaxed/simple;
	bh=K2LtgJDVsguzgjiT2kFNX2eeRHqF7yA+YVuRHONuSJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jtn74qPyKllecn7cuEOPSZNbc0dFoMWdgUOKZfr0eXac4uXjANsq5BmP5Wecrav6zJ7FvxWs0JdKioV0HZpgbBUxZeDZFdh71Gn2MMh1ew+xEpFlfXDrmE3/J8mfRxVeK0oHxoGJHQtbZWyMeA3dQp2CtTNmoY5yK1WibZxpCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvKc2QjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvKc2QjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB6DC2BCB4;
	Tue,  5 May 2026 16:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998335;
	bh=K2LtgJDVsguzgjiT2kFNX2eeRHqF7yA+YVuRHONuSJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvKc2QjYb06/8YIJIRGDHq78LGtPsZqTxJFFEzSwGjdByVx6oAne10WSm5jPZp9AN
	 NEAQRaI9+5aMtouiE8VL0qtLBYdjGuDztn8ieoMvu6g4hbIfj5vBu3ejzD9hlR4cOz
	 34FAzgTsnJj7O9ZzVX2+JCS9W5HOjjvPADigLgHA/pKflRkHHyY237Gr5UVjpW1Q02
	 bL5Cpb036ZSh5O3JC8gjOJ7plSgiaECGQlcv/T03dUC3q6YFW1RWT3DQTnKC6VamWm
	 fzXAsBq4GMitMhyadjEalDBOYQLr3lgkXZxAalnppWJ6nx8a6x/mSIViqcSXVuKWLS
	 eGmavX7Fm8wIg==
Date: Tue, 5 May 2026 17:25:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Educg550 <educg550@usp.br>, lars@metafoo.de,
 Michael.Hennerich@analog.com, antoniu.miclaus@analog.com,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Lucca Ciriac
 <luccaciriac@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adf4377: replace mutex_lock/unlock with
 guard and scoped_guard
Message-ID: <20260505172526.087ad783@jic23-huawei>
In-Reply-To: <afLwqYt_XUjeroGJ@ashevche-desk.local>
References: <20260429202304.25308-1-educg550@usp.br>
	<afLwqYt_XUjeroGJ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 09:03:21 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Apr 29, 2026 at 05:23:04PM -0300, Educg550 wrote:
> 
> > Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex) and
> > scoped_guard(mutex) from cleanup.h.  
> 
> ...
> 
> >  static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
> >  {
> >  	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
> > -	int ret;
> >  
> >  	if (action == POST_RATE_CHANGE) {
> > -		mutex_lock(&st->lock);
> > -		ret = notifier_from_errno(adf4377_init(st));
> > -		mutex_unlock(&st->lock);
> > -		return ret;
> > +		scoped_guard(mutex, &st->lock)
> > +			return notifier_from_errno(adf4377_init(st));  
> 
> The scoped_guard() makes more sense when we have some code in between before
> returning, here the guard()() fits much better.

FWIW I prefer this option.


> 
> Alternatively:
> 
> 		scoped_guard(mutex, &st->lock)
> 			ret = adf4377_init(st);
> 		return notifier_from_errno(ret);
> 
> >  	}
> >  
> >  	return NOTIFY_OK;  
> 

