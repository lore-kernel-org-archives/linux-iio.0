Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D930DEA6;
	Mon, 21 Sep 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979656; cv=none; b=kdgVxiotdamlEBVdi9XIqVbI2OyeHdYOjOv89JQ8GD4cpVQy3l7WUeffTvCW9MVhiDQIXtwZXtWdqPPUCEE3Q4ojb01AK6TXsJsvfF2iZy+E6FxefRJBPQjI0TpsBdVA9+IAlroKlplG4GxId7miwfjH/8UMffpRxhCbw4TEcvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979656; c=relaxed/simple;
	bh=LKQBA+epEihVp/53sMaunef0vZqLpiZm8EEONl8LDls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/CxlHQ42EHvxDyOBVQqvVMQapnqfqKlaf2XJOCrFUDFDuzBN+smUhNPBaLdkGoMHnC+0mSRHcgnjNPQKSVohMfrO4K/EMUjFw2Md4vI9SYLl32Y9EevOmXXbD0Stf90Iw/QRWOSUc7PxuzfE1pP1MVbcOSQxSTXCMerjgbdgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP3nWF7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP3nWF7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5741F000FF;
	Mon, 21 Sep 2026 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789979655;
	bh=8gbl7Xm+wSfCvDbbc3qvZFGs24Sa3c8Li3JzmJET1KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mP3nWF7gGESdM2fA9CMjpIcdOIQbsFwFIUK+oQtYtVi0L8AORfOrkM/amIbo3cP9Q
	 hHgvUapxO/ZL65CqoVmV7I8tVJrNI67pJqMr7lzly8tDbpcZTAy0dlZjix+U6/0S0M
	 AfJWOBYCcIUSKvILtwULBkbfgJyIeIT9PUwgZpMtDLcNWgGoYS+RykMJSqf6Aw1vp/
	 06IDQWzunYXkyj2/L7kWDuSfIYq5+zRt0odBfXT6cPrkA53am5SQ4H9HyJCtKhiX8d
	 VM1hEYw0eO7WtEqQjaGf61b0SquKks2QdNFea/yuiMdPjZy5C/Eqbimcg/QHJbea/H
	 u7XNeMACJxK7A==
Date: Mon, 21 Sep 2026 01:34:14 -0700
From: Kees Cook <kees@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Remove const from chan_arr allocation
 type
Message-ID: <202609210131.8441BD398B@keescook>
References: <20260917211436.i.689-kees@kernel.org>
 <aqzfhNmU3sazdCTQ@ashevche-desk.local>
 <20260921002128.46dc36db@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921002128.46dc36db@jic23-hlaptop>

On Mon, Sep 21, 2026 at 12:21:28AM +0100, Jonathan Cameron wrote:
> On Fri, 18 Sep 2026 09:51:48 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Thu, Sep 17, 2026 at 02:14:37PM -0700, Kees Cook wrote:
> > 
> > > In preparation for making the devm_kmalloc family of allocators type
> > > aware, we need to make sure that the returned type from the allocation
> > > matches the type of the variable being assigned. (Before, the allocator
> > > would always return "void *", which can be implicitly cast to any
> > > pointer type.)
> > > 
> > > The assigned type is "struct iio_chan_spec *", but the converted
> > > allocation type would be "const struct iio_chan_spec *", as the size was
> > > taken from "*indio_dev->channels", and "indio_dev->channels" points to
> > > const. As there is no general way to remove const qualifiers, take the
> > > size from the assignment target instead. No change in allocation size
> > > results.  
> > 
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> > ...
> > 
> > > -	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
> > > +	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr),
> > >  				st->num_channels, GFP_KERNEL);  
> > 
> > I would even dare to put it on a single line now (yes, 86 characters long).
> > (No need to resend, Jonathan I hope can tweak if he agrees with this.)
> Done, though I would assume Kees is going to send a mega series
> that rewrites this line anyway and might well make it even shorter.

I will indeed. :) But Coccinelle will be happy with whatever shape it
has. (It'll swap "devm_kcalloc" for "devm_kmalloc" and then gain "_objs"
and lose ", GFP_KERNEL".)

> Applied to the testing branch of iio.git (queued for next merge window
> subject to tests etc)

Thanks!

-- 
Kees Cook
