Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E75405F7;
	Sun, 14 Jun 2026 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781467255; cv=none; b=i3x7FcqJDtxpYVlbkSdUe8Z3+9MuNVDWTExmcfRM3nDjHI5KYNV0DT6gGJHOuUlNR1g3BEyW9WkOnUPveERdZyJT7JB914Ft4Q4CaFsO71Li4C0u161Yv7r3XA9kxWcdR6K7Z3TAyFDwm2iPwfYN8Wzm4HJzRfwE3FrF57E6VwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781467255; c=relaxed/simple;
	bh=ZlFkjiPTFHROITNzEQrq0nMZvYwPSznwPaV+MsmGQck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzvXbHzkF26ixTB/Zq7toJ4SfbWMdb85tfeGmdygwf7uiYmPj/sNYLHdns+XBAuA86bUslz8lFlkf6u/wGSfCVnZJfYmk1RLHEVqDlga+xpDUH7fn+5tSuoD2oDCGyOQc1dy+ejxYfrU8Kv97rymsMDXKPzbfXo7UZLhbVKspdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6zTjiQd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6zTjiQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D62B1F00A3A;
	Sun, 14 Jun 2026 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781467254;
	bh=+h7boi57YK10q0T8Pl0hYb/PxEKKjfbVZBiNgQmKZao=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C6zTjiQdMhb9g5sKlncT5mTDLMZJ2V0hkgQB87KUuflsGEV2A8Ia8xXvhQzvX4/uc
	 Lr1469Y07mDFPU7eJCfyY41Dnk5/1Va/pa7UzJ/l1JaVLtSgwqCvHSiPm/wnGwKN4h
	 8vbZHM498VXUsjpBZNJpXnj3bVcUL/Pf/SMn5gM5b7WlGG+UfbAXl7HRed2ANABPuF
	 793bJHx68/5+Lv2X4lN1kG6NGESGCvyEw/WPftFgCt7te74sX21PIz9m4iN/wG5Sfw
	 DpLZuYmr/4LPaHKdkZwEP1tu+gipdXzNl3EXcHeqoyy9VnfYLUjLtm09uiNNyhlplD
	 Fn3Jt1D8AALHw==
Date: Sun, 14 Jun 2026 21:00:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux@analog.com, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 04/14] lib: kstrtox: add initial value to
 _parse_integer_limit()
Message-ID: <20260614210044.19dfc8df@jic23-huawei>
In-Reply-To: <rvx36i2ydmwhbbkdgbvh26uqchyoptzuu7tleuyarqn2skzkxz@owzwp62mzkdo>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
	<20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
	<rvx36i2ydmwhbbkdgbvh26uqchyoptzuu7tleuyarqn2skzkxz@owzwp62mzkdo>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 11:09:33 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add init parameter to _parse_integer_limit() that defines an initial
> > value for the accumulated result when parsing an 64-bit integer. The
> > new function prototype is adjusted so that the _parse_integer() macros
> > stay consistent allowing for one more argument, which defaults to 0.  
> 
> ...
> 
> >  noinline
> >  unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> > -				  size_t max_chars)
> > +				  size_t max_chars, unsigned long long init)
> >  {
> >  	unsigned long long res;
> >  	unsigned int rv;
> >  
> > -	res = 0;
> > +	res = init;  
> 
> This might generate conflict, as the code around have changed in linux-next.
> It is an easy fix though.
> 
Thanks for the heads up. Hopefully that will all fall out when I rebase testing
on rc1 once that is out.

Jonathan

> >  	rv = 0;
> >  	while (max_chars--) {
> >  		unsigned int c = *s;  
> 

