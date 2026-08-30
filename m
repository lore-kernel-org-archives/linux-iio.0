Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA9DA10F2;
	Sun, 30 Aug 2026 01:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052593; cv=none; b=KXUH/DU05pYDQqyUaIhfemNWS2M7jDGpiiS9iNNzfYQj6J/JtW8+ewWYl/vOXg3djruxvmhfmW8APW29SyEPwWciULvGXniur8ypm6UCP9D6c0aCkubhEChnky3fDTYUjWlyCfOfxhSFFXYowlKz0eVEzwPpBmMWi0Jj2HblFNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052593; c=relaxed/simple;
	bh=5RlZI6+QEepnWNo3dFMwyfSA3eI7a674J0DkJIGGgHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUYPtWs6xHQai1W6IhMSYDXKbsKbK9BPdV1okjErV6AwlOn5Vhj4uCf/MWYwUT9LsvSNlhnyw/A3hI+bytLt40HcIKiFJGGg4wXNM5sIbkSurKrnPHneTrprxbYYhm7xfwDk1XpuSmXfUX1uZZZwWBUE66UrvIvYhvzJ5lFeJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5NPw434; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5NPw434"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1FC1F000E9;
	Sun, 30 Aug 2026 01:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788052592;
	bh=lrPVjDXCCv9tzn8QEgFO8MeONbW011V/HHJip8f+1RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=I5NPw434W5lrfILWonrM0VVDGZQ+5YyHloilHSb+UIhKAk3C06F69Sxjhk0NtY5U7
	 QWyuvJHNKe1M1XTYDOgyle47c55U8wRdtgO3k4WAIZuMsmN+wecqgwVcv4dIu1nuya
	 vlJZgFalPqUC6+kfKteKdEHVJVvrunAFrX3gMn8FzsvD7LtLWEm+oXoGcJPvp5oMq5
	 7A0Dcs1C9dKgNqfn394dfituYUdRbWF4sr8nXfKDX8p7IIJgl3UMTpO5MlpIUJShxW
	 JS1PnoE1WqW7qmKnaQIanGxrvkZJ0VVmDJu3PgwDkdffQwuY39Q9O5dLgdROGXoSne
	 F5HrU9rJ9vJ4A==
Date: Sun, 30 Aug 2026 02:16:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on
 error
Message-ID: <20260830021626.025397c8@jic23-huawei>
In-Reply-To: <apFqmjGZKQ-qW7L7@ashevche-desk.local>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
	<7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
	<apE-gauHWlJO8-5X@ashevche-desk.local>
	<5d274bfb-2570-4336-af16-60640550e6c9@gmail.com>
	<apFqmjGZKQ-qW7L7@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 14:01:46 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 28, 2026 at 12:46:24PM +0300, Matti Vaittinen wrote:
> > On 28/08/2026 10:53, Andy Shevchenko wrote:  
> > > On Fri, Aug 28, 2026 at 10:40:36AM +0300, Matti Vaittinen wrote:  
> 
> 
> ...
> 
> > > >   	wait_ms = bu27034_get_int_time(data);
> > > > +
> > > > +	/*
> > > > +	 * If reading the integration time fails, default to the minimum so we
> > > > +	 * don't lose samples. This may waste CPU cycles, but as a hardening
> > > > +	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
> > > > +	 */
> > > > +	if (wait_ms < 0)
> > > > +		wait_ms = BU27034_INT_TIME_US_MIN;
> > > > +
> > > >   	wait_ms /= 1000;  
> > > 
> > > With the above being open coded the _ms feels not right.
> > > I would expect the TIME_MIN to be in MS from the start
> > > (and for the consistency's sake with the below) and having
> > > all this to be written like
> > > 
> > > 	ret = bu27034_get_int_time(data);
> > > 	if (ret < 0)
> > > 		wait_ms = _MS_MIN;
> > > 	else
> > > 		wait_ms = ret / USEC_PER_MSEC;
> > >   
> > > >   	wait_ms -= BU27034_MEAS_WAIT_PREMATURE_MS;  
> > 
> > I don't like using 'ret' there.
> > 
> > At first glance, the
> > ret = bu27034_get_int_time(data);
> > 
> > looks like ret is containing just the success status. Furthermore,  
> > > 		wait_ms = ret / USEC_PER_MSEC;  
> > 
> > forces one to go back and see WTF the 'ret' is (even if just couple of lines
> > - but this is not an improvement, using ret is obfuscation).
> > 
> > I could change this to:  
> 
> I suggested without knowing the possible ranges of the returned value.
> 
> > wait_ms = bu27034_get_int_time(data) / USEC_PER_MSEC;
> > if (wait_ms < BU27034_INT_TIME_MIN_MS)
> >                 wait_ms = BU27034_INT_TIME_MIN_MS;  
> 
> This looks sane to me and  removes the confusion I was talking about.

Except that wait_ms can be negative due to a read error and that is obscure
by what now looks like 
	wait_ms = max(wait_ms, BU27034_INT_TIME_MIN_MS);
so ensuring we clamp an out of range value.

I'd just go a touch further and split return value and parameter
+ provide a default.

wait_us = BU27034_INT_TIME_US;
ret = bu27034_get_int_time(data, &wait_us);
if (ret)
	dev_warn(dev, "Failed to read int time, muddling on\n");






> 
> > (but for me this feels like unnecessary bikeshedding than anything else.)
> > 
> > Well, I'll change this if I respin.  
> 

