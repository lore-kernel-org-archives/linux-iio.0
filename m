Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51213D5C05;
	Wed, 24 Jun 2026 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312867; cv=none; b=kLweUAd7wxMtuGIVMrCgoe4+xTJI7of/oeM/DRV9CmC445lVgAMIVyIWaJb1Dypz1VmSsePn92jMELkqr3LUlcW7WMxChnumpwRHeq+pnzq4E33movd3YKBuRyAXTcigZbBrNA9ZDUMovJxZEjuPJ9A8acddLn+3uJ8KNqLlfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312867; c=relaxed/simple;
	bh=RJN3BHqTjhShdhoyOpmqSe9zWevWxparSWkFsvw36NU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pzdb+KTMTdIebOdu8v+UFz4bi6pbDaZ/BA5o5b3qOsTpmgADiTfsPlJh12wrEwlBiRDQBA5ZJBZt1k2Enx74sw0hZKVC3yFJqJVgu9LPWK++GWu5OsIDT2NxoJZhJEeumJxHeJhgpsH8DtYK7zGklrLF5Du/Si/GG+A+No/TGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egCNRDZ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egCNRDZ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2490A1F000E9;
	Wed, 24 Jun 2026 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782312866;
	bh=y0UN3Un8oyUHkOFXuNz8lBuRk80Y1mfTFcU46CtjQos=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=egCNRDZ5stEnp6shriAeg7z7NOHq3CugHqinmq2CT0Lq+44uoLB6MgUhjdEfvTDtX
	 tETOvfzui1EUiQXdPYBlfX9EqdQqiVbblg9w3OTmbpQT57Wp9/1WStk0jxB0U++EkN
	 25ax4hSy8mTWU7L4SJEENDT1Cf+QE7i4saDNn9msNfHT5GeS8cVx95+6TW6GJnKGF9
	 MTrW8nHv32FIlFLVVAespJgfQN0VBeaxnHXTCflyOJXykmjilwa47eJBrv5qzeM/A9
	 ID7e6d+IwrvJYj5V5kMLjicMZl/YCG+LS0UlW6t/ZOogZcKXcZFK0IU9FkWHKK2G7N
	 iZsj3KM3cn5nQ==
Date: Wed, 24 Jun 2026 15:54:14 +0100
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
Message-ID: <20260624155414.61755e9a@jic23-huawei>
In-Reply-To: <20260614210044.19dfc8df@jic23-huawei>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
	<20260604-adf41513-iio-driver-v16-4-1a7d09143bc2@analog.com>
	<rvx36i2ydmwhbbkdgbvh26uqchyoptzuu7tleuyarqn2skzkxz@owzwp62mzkdo>
	<20260614210044.19dfc8df@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Jun 2026 21:00:44 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 4 Jun 2026 11:09:33 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/06/04 10:58AM, Rodrigo Alencar via B4 Relay wrote:  
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add init parameter to _parse_integer_limit() that defines an initial
> > > value for the accumulated result when parsing an 64-bit integer. The
> > > new function prototype is adjusted so that the _parse_integer() macros
> > > stay consistent allowing for one more argument, which defaults to 0.    
> > 
> > ...
> >   
> > >  noinline
> > >  unsigned int _parse_integer_limit(const char *s, unsigned int base, unsigned long long *p,
> > > -				  size_t max_chars)
> > > +				  size_t max_chars, unsigned long long init)
> > >  {
> > >  	unsigned long long res;
> > >  	unsigned int rv;
> > >  
> > > -	res = 0;
> > > +	res = init;    
> > 
> > This might generate conflict, as the code around have changed in linux-next.
> > It is an easy fix though.
> >   
> Thanks for the heads up. Hopefully that will all fall out when I rebase testing
> on rc1 once that is out.
I've done a mid merge cycle rebase as the char-misc branches have merged.
So this should be resolve on my testing branch now.

Thanks
Jonathan

> 
> Jonathan
> 
> > >  	rv = 0;
> > >  	while (max_chars--) {
> > >  		unsigned int c = *s;    
> >   
> 
> 

