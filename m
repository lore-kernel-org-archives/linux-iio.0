Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F843BF692;
	Sun, 11 Oct 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726151; cv=none; b=FULHfgPZ/oBbyw/60nSU7J8u3Ft23sPrUeJYpEklHoleJTlxEPW1/u5qwFUYJghrMdoph8RQzhnRn/pSVD5F18TAQ6DTum2sATgnAqkfn1IHifoUmgZXjJWHm6y/qJA2BtXJkkpp0YmmwnCGPs7GTgtuBeQ+dMwXL7dU2yNzlJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726151; c=relaxed/simple;
	bh=pBPW8NxHxkUpuhvdwXJMOPtgMJkmZmNxUYbQENSz5CY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+0oV4ud0ZA77wcp6DXNceQOqVEYgzxz/uDz3WWh2j2ukCAJu4GTNsDmmj/fKySU1rJZplMEgAi0ETKDUdiJY/Il8b/fBGR7x2X5m+ALC/VJzDsuCiwV7BI3Vi6N4gGRZBLWyjdKlpSnjm4Fw4wNz0eAE30ITdVqtrsMumYBi5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km2oUwm4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km2oUwm4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25091F0089B;
	Sun, 11 Oct 2026 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791726150;
	bh=0+h+o6j5t/yhCInvxQOJv2vhBRN98tA/HItmTw/lDDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=km2oUwm4t1pOTSuQQ147Lx531eLKqYsSG1KIRrkJBnI2HJDpO+mwxfWZNN5bAjvyA
	 gDBdsuvbqOqjGKZv2o7Lx7lg6KcxawAR+O4yywkCR/C/XgYTwSlTLKN2asDXD7qkLC
	 tagGbYDUWppikRiPEYJNZCtGPHcztaZTGA9DP5gHwjxhugv/esHQFs0l/2VHLs3Ui/
	 o5b0MYpjt6GbsFrIMRFTXGFaKhs/3nzBgiQaHgu9ZdaLLs++hXWaVrrJT/96Wx/15H
	 4l2oOympumBdUl17F+zrPwThyQ3Bc6CoscbKyS8gpKurZeTEiA/SoYec1kFzRETVM9
	 +YPC/MpmtfI6w==
Date: Sun, 11 Oct 2026 14:42:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko
 <andy@kernel.org>, Bill Wendling <morbo@google.com>, David Lechner
 <dlechner@baylibre.com>, Eddie James <eajames@linux.ibm.com>, Justin Stitt
 <justinstitt@google.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v11 5/5] iio: pressure: dps310: assert the lock at
 runtime too
Message-ID: <20261011144202.204fd8c3@jic23-hlaptop>
In-Reply-To: <asFXwlAOVq1klYL8@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
	<20261002072526.250081-6-zoone.rupert@gmail.com>
	<ar9j0O7DdJ7O1DVk@ashevche-desk.local>
	<20261003191058.35287-1-zoone.rupert@gmail.com>
	<asFXwlAOVq1klYL8@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Oct 2026 22:30:10 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Oct 03, 2026 at 10:09:26PM +0300, Rupesh Majhi wrote:
> > On Fri, Oct 02, 2026 at 10:57:04AM +0300, Andy Shevchenko wrote:  
> > > On Fri, Oct 02, 2026 at 10:25:26AM +0300, Rupesh Majhi wrote:  
> > > > __must_hold() is clang only and does nothing in GCC builds. Add
> > > > lockdep_assert_held() next to each, so lockdep catches a missing lock
> > > > too.  
> > >
> > > Suggested-by?  
> > 
> > On v10 you said it wasn't really your suggestion, so I dropped it.
> > Happy to add it back if you prefer.  
> 
> Ah, yeah, I assumed that this will be folded in the original patch that adds
> __must_hold(). In such a case the Suggested-by would be confusing. Since it's
> a separate change (and we have no response from Jonathan on this) the Suggested-by
> is fine. Hope that this clarifies why opposite signals were given. But this is
> not really anyhow critical. Feel free not to add it at all.

Generally I'm in favour of annotations rather than just replying on comments
or similar for when a driver is expected to be holding a lock.
However, here things are simple enough that there were no such comments
- it was just assumed that the lock was going to be held at this 'layer'
and it does end up rather noisy..

So this one, to me, is more doubtful.

Jonathan

> 
> > > But we need to hear from Jonathan and others if they like these annotations in
> > > a mere IIO driver.  
> > 
> > Agreed. It stays the last patch in v12, so it can be dropped on its own.  
> 
> Yep.
> 

