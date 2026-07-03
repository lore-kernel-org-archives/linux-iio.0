Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D01A6807;
	Fri,  3 Jul 2026 00:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039154; cv=none; b=uFtvrajvf1IP0s0X7+Sg2b4f0nzs5iogdz8HXb/ztB1SafH5UeE0t0ZrM5FzM376K4bqZwYgMLTSVP0AULPOU1vujvkZfu89c2uvPQ2GXF5zbBUv2I9baBEO8qQ7+UHaGbJQdnM8tNgzLjYqpVxpoFm1sJQ7XnMnu08ibvpep7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039154; c=relaxed/simple;
	bh=XnyG9aNXGx+VVoy8huNzYy/PQ6PFlcs8I0OV8agwavs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAMOEHi/XZ5x85ANkKpqroC0kCLA89f6zi1/9f+m8x+xX5EjcFp2yzcsf0lamPfTXILeOBJDR49mZaghiLoRUqxUYgkfLrygWWqM0c9ZDQ3pKyy/Rp0AoDZ62oXR2EmP7B4L/LmcSdhqpovUeI/oQOv/OjHU5Iq0JIrJmkhxxQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGfknRQv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGfknRQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971731F000E9;
	Fri,  3 Jul 2026 00:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783039153;
	bh=jeqIsV18NBIsSoSTbipGvzeOWaFcehtDih+38yxnWP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BGfknRQvp2mCv128GoipyO1zkHhBecFshBXjxsrQsssdr5N/PCQJr6K3SyXj6EXNJ
	 9rNG/Ij2O6+hTto8Fohrjcf5Pp5IVoAaI3lQgMBjxH2XUn8pHvXKuLi4LFxg3zYf+i
	 P3IzOY1U9FTMav4tsFFd5a3CVMO9lxBIu/PrtdJN/DVExySkgw3kAzN0WrA8oT/8eo
	 CE4wI2EvOL5pMj+SDO8/4AaO8Cq/Rp9ZUdDivChSzcHqN7eJnzC53yEXg9dPjUGYTP
	 sUSTe4qa7N+4jBGliHgUaDcqkr1AlZKTnLJJZreC1n72s3FnDC76/sSDuyKToRDXto
	 Gv9JEsrSQyILg==
Date: Fri, 3 Jul 2026 01:39:07 +0100
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
Message-ID: <20260703013907.57b0f114@jic23-huawei>
In-Reply-To: <aj01H48IHTyhn4ZR@ashevche-desk.local>
References: <20260620174708.111470-1-prashantrahul23@gmail.com>
	<20260620174708.111470-5-prashantrahul23@gmail.com>
	<20260623203636.69a7429a@jic23-huawei>
	<DJH77MBX1U37.1JJ1Z6UGLF0LT@gmail.com>
	<aju-_HSz6jNkR_NM@ashevche-desk.local>
	<20260625120952.471ec21a@jic23-huawei>
	<aj01H48IHTyhn4ZR@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 17:03:11 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 25, 2026 at 12:09:52PM +0100, Jonathan Cameron wrote:
> > On Wed, 24 Jun 2026 14:26:52 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > On Wed, Jun 24, 2026 at 03:43:44PM +0530, Prashant Rahul wrote:  
> > > > On Wed Jun 24, 2026 at 1:06 AM IST, Jonathan Cameron wrote:    
> 
> ...
> 
> > > > > Why this particular one but not the devm_iio_device_register() below it?
> > > > > Both pretty much only fail on driver bugs.  Or out of memory for
> > > > > which dev_err_probe() doesn't print anything anyway (on basis that
> > > > > is normally pretty noisy).    
> > > > 
> > > > My apologies, I wasnt aware that dev_err_probe simply ignores `-ENOMEM`.
> > > > Looking at drivers/base/core.c:5096, it is pretty evident that it does.
> > > > 
> > > > My goal with the patch series was to change dev_err into dev_err_probe,
> > > > as my understanding of dev_err_probe was that it's a specialization of
> > > > dev_err for probe contexts.    
> > > 
> > > Jonathan, actually the triggered buffer setup might return not -ENOMEM error
> > > code for the surprise. After all this series does add not a dead code, but
> > > a quite rare to be used one.
> > > 
> > > https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/buffer/industrialio-triggered-buffer.c#L57  
> > 
> > Agreed and I'm not even sure why that is there (lost to the mists of time
> > / my failing memory ;)  However I think it's an obvious driver bug case
> > that should be trivial to see in basic tests so to me it's marginal on
> > whether a print on these is useful.
> > 
> > Maybe given that one is so rare we should just add a print in the core?
> > I'm not particularly keen on mass patches to print errors from the core
> > code but this one is perhaps a reasonable trade off vs series like this
> > one adding prints to drivers for something we don't think realistically
> > ever happens.  
> 
> While the series ends up not adding a dead code, the rareness of the case
> doesn't justify it, so I am still on the side of _not_ applying this series.
> 
> For the core printing, I think for devm_*() or other managed resource APIs
> it makes a lot of sense (in general). Not sure about plain calls, though.
> 
For now I've picked up the two straight conversions to dev_err_probe()
because I'm keen to (slowly) stop using dev_err() in probe functions
but lets leave the rest for now at least.  If I get some time (you never
know) I might throw together an RFC that prints appropriate messages from
these IIO registration calls so we can have a debate about whether they
belong in the core or the drivers (or not at all).

Thanks,

Jonathan


