Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5B53A451D;
	Thu, 25 Jun 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385803; cv=none; b=pXYk88vU0wsMPZ7MbTamOXmwAFfdQdD5Bkx0PvdPYX1UikKVGxdwlEac8WmVk8ygOpKH3zd/8UTTZFqkR0cYsO+pDPnxeJ8jT+VKXXH13JI4ZT2kQHcZrSFkDnDNdo15zjnYjwxxeVWiXc2Wv7TI7Rb3m8/hBOxO4GOgm9L3ObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385803; c=relaxed/simple;
	bh=7yk/zMwkYIpn4qOx+Man2mij4d3tASZDjPoBbd/o1pw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6WRETa9qVB+KEFJJdo6vU+k/ZLeK7PLdBYoRgNcsi4wa0h5JMlmmEVsgoV2o23LlD6nNhYTJMDWzXs+L7W0QcxrOPKZnA2hfwLANoqQBdYBVZs0M6m8dhVONnDrmyyBM5nwqTQXgwOOBrRH6r6YIJYoufvAXF1ne4PBIRISB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeZg17v2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeZg17v2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1045F1F000E9;
	Thu, 25 Jun 2026 11:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782385802;
	bh=LZk2KQ+j1eUTuYUyR/4jVJ89umJAueRnZrCK2gYXKoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XeZg17v2Naq0/KqQZZGmJ3Wdii2T9DOa7qLnee8OBIRa3glMtas9EjRAgpITowObV
	 jGTvx9Ten6hppN8GyLZnOr4e3/omX/89N7gi9fOJwMUU+JLln4T7NV1gqh5G0yz6Nh
	 TbQW5qYw+FpKf0qw/WzcxoAYaccLUYfJiJP4RjT/A/byxZhudPFkvnGErOBb9s5iLY
	 yXNNjwvy9Lhe+wSqLO9g2Xc+yYOlgYEe5QwKnkxtyVw/5l4I2avrZUsZZRAvAee56w
	 tODrfks9esJ0UWZdIYWan3WHoAadiwf/D78oIhvtnJ/oFGgI0xGbDBwONTfFDIV/Bi
	 /4r180K3aK6yA==
Date: Thu, 25 Jun 2026 12:09:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Prashant Rahul <prashantrahul23@gmail.com>, linux-iio@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Petr Mladek
 <pmladek@suse.com>, Oleg Nesterov <oleg@redhat.com>, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: adc: ti-adc161s626: log buffer setup
 failure in probe
Message-ID: <20260625120952.471ec21a@jic23-huawei>
In-Reply-To: <aju-_HSz6jNkR_NM@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
	<20260620174708.111470-5-prashantrahul23@gmail.com>
	<20260623203636.69a7429a@jic23-huawei>
	<DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
	<aju-_HSz6jNkR_NM@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 14:26:52 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, Jun 24, 2026 at 03:43:44PM +0530, Prashant Rahul wrote:
> > On Wed Jun 24, 2026 at 1:06 AM IST, Jonathan Cameron wrote:  
> > > Why this particular one but not the devm_iio_device_register() below it?
> > > Both pretty much only fail on driver bugs.  Or out of memory for
> > > which dev_err_probe() doesn't print anything anyway (on basis that
> > > is normally pretty noisy).  
> > 
> > My apologies, I wasnt aware that dev_err_probe simply ignores `-ENOMEM`.
> > Looking at drivers/base/core.c:5096, it is pretty evident that it does.
> > 
> > My goal with the patch series was to change dev_err into dev_err_probe,
> > as my understanding of dev_err_probe was that it's a specialization of
> > dev_err for probe contexts.  
> 
> Jonathan, actually the triggered buffer setup might return not -ENOMEM error
> code for the surprise. After all this series does add not a dead code, but
> a quite rare to be used one.
> 
> https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57
> 
> 

Agreed and I'm not even sure why that is there (lost to the mists of time
/ my failing memory ;)  However I think it's an obvious driver bug case
that should be trivial to see in basic tests so to me it's marginal on
whether a print on these is useful.

Maybe given that one is so rare we should just add a print in the core?
I'm not particularly keen on mass patches to print errors from the core
code but this one is perhaps a reasonable trade off vs series like this
one adding prints to drivers for something we don't think realistically
ever happens.

Jonathan
 
