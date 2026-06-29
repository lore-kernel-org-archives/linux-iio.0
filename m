Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFB314D37;
	Mon, 29 Jun 2026 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774721; cv=none; b=lLjTb/gZrAqe4eIYiOPRaxCqzpMF55iNLB81XF/eVVz8h6S+dhYg2ZZB0G3F3fgJXnV3ABFhzUEW4s1QGu0YFCebH7EQ09j4/F9lYDlb5UZw21Oi5ObAWcTCAWfOVQZ9A+lde1s7mKD76yoyqQ40L9/MBmKrpp+lT3+3aM9DINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774721; c=relaxed/simple;
	bh=5eSPS1L8BQmjbMwDIPV3kjJcdPDyqUm0+JGZ8TQxENs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m3he4n58v6eDR/ayD2T4WClP7skWi+31KaSYv/i+TzuZfq7Y2zetngxckHaxdcOTCyONvjNhZvpr3qXoLlGl4wAic4jBbAe4QcIPWusmEhpOIIsJ0NsnCPOJapjUIbqBDOw5rYqUaLv4OIEKoOzUk/IyLNZTo12kZ+1VnSrfaWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWvo4US0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWvo4US0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723A11F000E9;
	Mon, 29 Jun 2026 23:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782774720;
	bh=WMvLBwoHlJ8NL9XrKxSe027I0Kj6Px2d9IlDXe9ctYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZWvo4US0fagZQG+Wpn5FdH/K84caxgp+Gi4UGjKhs2NYWSLDHlk3bJACpqmmIhozQ
	 HTrMTp5uB7sHbQS2Tsv11XMCVJ0Z7wm2DyCAnvkbUhDlwPEcuaJMKYEaHItEx5RUYc
	 kCU52xeMRxnwz9RRx15xD/B3Lzcp1yqLENlsbvzNSLbfRLdrVNjKVZoo3jQN2+y3E3
	 RwEdpqlhPPxGKSwz39yVqmxiI8i7n8MT4/NkNbPPAGKA0VKdknE/rgSXoFwjD3n5+r
	 azOJhVcgQYul3nsapk7esJaLmDl5K7lHDhK5FnlUvNovyvRbFFtFrpH2dR0hjRhyn0
	 mQ1A/aAoK7B+w==
Date: Tue, 30 Jun 2026 00:11:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Moksh Panicker <mokshpanicker.7@gmail.com>, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
Subject: Re: [PATCH v2 0/2] iio: adc: ad7779: Remove dead code and redundant
 error message
Message-ID: <20260630001156.61ef50d9@jic23-huawei>
In-Reply-To: <20260628191350.583470a7@systembl0wer>
References: <20260628145734.77191-1-mokshpanicker.7@gmail.com>
	<20260628191350.583470a7@systembl0wer>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jun 2026 19:13:50 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> On Sun, 28 Jun 2026 14:57:32 +0000
> Moksh Panicker <mokshpanicker.7@gmail.com> wrote:
> 
> > These two patches address review feedback from Joshua Crofts on the
> > ad7779 driver:
> > 
> > 1. Remove an unused completion field that was initialized but never 
> > waited on or signaled anywhere in the driver.
> > 
> > 2. Remove a redundant dev_err_probe() wrapper around devm_request_irq(), 
> > which already calls dev_err_probe() internally.
> > 
> > Moksh Panicker (2):
> >   iio: adc: ad7779: Remove unused completion field
> >   iio: adc: ad7779: Remove redundant dev_err_probe() after
> >     devm_request_irq()
> > 
> >  drivers/iio/adc/ad7779.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >   
> 
> You forgot to pull my Reviewed-by tags, no need to resend:
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

Hi Moksh,

Generally slow down a little.  You may well have gotten
additional review on v1 if you'd waited longer and
save both a little of your time and that of reviewers.

For even a simple series like this I'd wait a few days,
or better still 1 week between early versions.  It gets
more relaxed if the code is already well reviewed and
we are just dealing with final tweaks.

Thanks,

Jonathan


