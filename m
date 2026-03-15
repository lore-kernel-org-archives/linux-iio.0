Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262D1F471F;
	Sun, 15 Mar 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577699; cv=none; b=ITgFnCr0/VKL4tRQs8luwpwW8GtnpHkjDvCCB12JlvYF/Oht5fTTteuvGMWyqyE1WVCJC24vsrvOQqHEKTjQfKsJL4q8m400He06yWI3hUwOm2bjwtEvIi86lgJu8PHw5Hm5Gh3N9R4XJlL3GI0GMD3vicDlI2/vfTx6Ux6fLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577699; c=relaxed/simple;
	bh=cSzP2VJFOljB54zSkqCtt5lyvO7J28V4tDVEu7c0oDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Af4P+IvF+Dq0uUOXMkpH2TMr1vRH8lfndwxL0QkOlwG5/kZA+rEAqxsX1uQUOgOmgQGa4bJRrl025pVMs4w+pSfqGW+o3LSfXBol/j8s4NtEyZ1Ymq5D5zImcacR1tc+555fYYH9t2GwNIEyd3oO0b/bF2wqpX6DhMNBXJR0AZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFlw+Zhn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFlw+Zhn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F29DC4CEF7;
	Sun, 15 Mar 2026 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773577698;
	bh=cSzP2VJFOljB54zSkqCtt5lyvO7J28V4tDVEu7c0oDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IFlw+ZhnGkOxL7SUqdPlmmk9/dmr396+jnAt7+Cha3kCEUSFWMCZ2dZLi5UaFPATE
	 W67Ul9pJGzabR6PGVzG7D5U0NLEbE+aUmvZ9P/MhOtq3mp7lLKTIgsrkLd8aXCdl+W
	 mL2aMKGHXve3dPu3MvloRp81ZDl2T6PJK0uuLNToZTuZVs86VSE4sgcEVe+i2zKzQ7
	 AdBhyNWkKlD44l2ORbo2LT6y2VsAC7RJ+eQOdEzKSFQWJGeZeGAznyT8orkflOaJ94
	 6Jz5BNWqsKysRDQRAvrA4gJoFsQtVzb/psO+XrREoNNNP/z7oXPrxC9xvUiJTeHvJv
	 L8qJ+AtvBB2bg==
Date: Sun, 15 Mar 2026 12:28:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: dac: mcp47feb02: Fix Vref validation [1-999]
 case
Message-ID: <20260315122804.228961f6@jic23-huawei>
In-Reply-To: <abAMvPm0G5jK_GZh@ashevche-desk.local>
References: <20260310-mcp47feb02-fix1-v3-1-d46a830055f3@microchip.com>
	<abAMvPm0G5jK_GZh@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 14:21:16 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Mar 10, 2026 at 01:56:44PM +0200, Ariana Lazar wrote:
> > Store reference voltages in uV instead of mV to avoid invalid error code
> > in dev_err_probe() call. Vref variables store the actual value returned by
> > devm_regulator_get_enable_read_voltage() function instead of the results of
> > dividing it by MILLI. The corner case [1-999] divided by MILLI of the
> > voltage reference variable value would become 0 is covered too.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
> >  	struct device *dev = &client->dev;
> >  	struct mcp47feb02_data *data;
> >  	struct iio_dev *indio_dev;
> > -	int vref1_mV = 0;
> > -	int vref_mV = 0;
> > -	int vdd_mV;
> > -	int ret;
> > +	int vref1_uV, vref_uV, vdd_uV, ret;  
> 
> Hmm... Semantically ret != vrefXX_uV and putting on one line is questionable.
> But I leave it to Jonathan and others.
I would have left it on a separate line, but I don't care enough to
tweak it whilst applying.

So applied as is to the fixes-togreg branch of iio.git.
Thanks,

Jonathan

> 
> ...
> 
> >  	if (ret > 0) {
> > -		vref_mV = ret / MILLI;
> > +		vref_uV = ret;
> >  		data->use_vref = true;
> >  	} else {
> > +		vref_uV = 0;
> >  		dev_dbg(dev, "using internal band gap as voltage reference.\n");
> >  		dev_dbg(dev, "Vref is unavailable.\n");
> >  	}  
> 
> Now a question here, why do we need use_vrefXX if we may deduct it
> from vrefXX_uV?  Perhaps it deserves a separate change.
> 
> 

