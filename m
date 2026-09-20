Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628EA250BF2;
	Sun, 20 Sep 2026 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789946495; cv=none; b=DEpevLQrNry0OaceVT+WAEeK7qWWVIn9cpom6qhVCMIORz+VqIFHwscinLB7UyYw+VGCABt+68IwlBTl4UvFkpAmUYkGFmdiv8k4yfnE7BT9DNmOO4gcEZVzTgd+wwSJU6WsgVuZtN5AJy7C+8j4tQUQs2F682gaqD7X9FMyQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789946495; c=relaxed/simple;
	bh=BgjG4UQmuZ01U2fbhTWZuTJ5M6kXJtR2+InDzfRPOTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIB6rtsP/Azzqno0PtzJnFHpGamOEVGqUDvN66bWYxPzIuueLerj6fslyLD8dU6RWx8fAmyxYT0WmgElrPddtYBees0dD7Pu68c/9xvr0P1NaGSMLHhBLb/xLtTR9/5EC11pbbSHt1iSbAHuHWuqgdSxBysUth12Xcg9wOLHrig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsFRndnA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsFRndnA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897591F000FF;
	Sun, 20 Sep 2026 23:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789946494;
	bh=DjtRYmWoSOKCMGiU7DO4kPq/9RweD5LvSP1ZunQKMrM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PsFRndnAbd3t9IoplNpYygVTfi8/er2/8YKmPzM+DJStiRyDT2tyTb71RHjXxPedl
	 lH8Sjfh5qINd9tNVJzZk19tCVUmAJbaCCw9fQjGZ1eMNvz90Yjs4/RgSVQ5wS7zYjs
	 7yFl0oHUY7wqnPx7U3t6h4kPlxPHhDhxzkNEZh9RGEEVtW/vWf8b+7TIjbYgFXGICr
	 3ChT/WuJhDMsRG4zes1TiksEsKVbTmGuMpnBmrjRyBuLeWAyo/wAvI8vi0YIEbCh9h
	 EEyOPY0B17KjZlrMFj6QBvlECc7ZGymMi+4kfs8107OoGIyoW2gkfuzWWlrfNSdoFO
	 YP8p0vm1Ni4KA==
Date: Mon, 21 Sep 2026 00:21:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Kees Cook <kees+treewide@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Remove const from chan_arr allocation
 type
Message-ID: <20260921002128.46dc36db@jic23-hlaptop>
In-Reply-To: <aqzfhNmU3sazdCTQ@ashevche-desk.local>
References: <20260917211436.i.689-kees@kernel.org>
	<aqzfhNmU3sazdCTQ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 09:51:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Sep 17, 2026 at 02:14:37PM -0700, Kees Cook wrote:
> 
> > In preparation for making the devm_kmalloc family of allocators type
> > aware, we need to make sure that the returned type from the allocation
> > matches the type of the variable being assigned. (Before, the allocator
> > would always return "void *", which can be implicitly cast to any
> > pointer type.)
> > 
> > The assigned type is "struct iio_chan_spec *", but the converted
> > allocation type would be "const struct iio_chan_spec *", as the size was
> > taken from "*indio_dev->channels", and "indio_dev->channels" points to
> > const. As there is no general way to remove const qualifiers, take the
> > size from the assignment target instead. No change in allocation size
> > results.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> > -	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
> > +	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr),
> >  				st->num_channels, GFP_KERNEL);  
> 
> I would even dare to put it on a single line now (yes, 86 characters long).
> (No need to resend, Jonathan I hope can tweak if he agrees with this.)
Done, though I would assume Kees is going to send a mega series
that rewrites this line anyway and might well make it even shorter.

Applied to the testing branch of iio.git (queued for next merge window
subject to tests etc)

Thanks,

Jonathan

> 

