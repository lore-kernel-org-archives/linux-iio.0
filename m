Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0688A3382DA;
	Sun, 22 Feb 2026 16:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777838; cv=none; b=KNQ73xTpgrRLcgJJoOuOo7n2ylV16lbAnttqmN3nK1di2ZiTuxKoED7LU9ItCPm32or/hRYF1y3/Gn/9v9E+P/cRAaqixINN8NnwaEdhQvy7BmWpF//ZIW8PbQr97Q3SuW7uf5JDexgzkFztWd6IkvHWxPgKetb12lxH4WQOGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777838; c=relaxed/simple;
	bh=epgHuHy7E0CiRMYQ+neWx39ZTaJyFvqk7comDdQTyKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YggmQYutc9JnkNnRrvdS5VjoLz78kV/1gV8+1nT9OITZEPu76HHDBomsYDOQKbunYX4Mk1DwgoCKAvfhpg7qJPpHwj6vDZP66l/3vBGc2ctPueQHoKFyfWpF9aAtYV5MjsojDiqVISNMpVHj6YbDse3CHniXVi6K40w1f9LgzkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqzFENj+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqzFENj+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75E44C116D0;
	Sun, 22 Feb 2026 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771777837;
	bh=epgHuHy7E0CiRMYQ+neWx39ZTaJyFvqk7comDdQTyKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EqzFENj+7GwtPLewjbv/BJc7wmtxbIy2cATzd+vnFj2VXp/KHCI2GTcnpt9QTyNuG
	 F397QG2o9q3mXJMVhHH3bVxfPQbo7BsPCVgf+1AYWDsw2kTODPjskaeLz9GUnVnqg8
	 1RpSIo97cXypQe6zOtc85J6PFnWTjxXJWyBueiPN9ByIEUFee0yfXER1d/vAA8H5G5
	 F1nq7evprXD6bje+03R1q3NBCqso5TjcUaxcioG5f5jfcA5zDT2/eAw1wDzlR1czFB
	 F9gYybhjVnAqKgOR2FDViUaiJ+/H/BN9cHofQjD+yDCmNTWFK3SAspxStJzZu6RQOi
	 2TJn5dr03kwIQ==
Date: Sun, 22 Feb 2026 16:30:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Ethan Tidmore <ethantidmore06@gmail.com>, linusw@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix resource leak
Message-ID: <20260222163029.14c3f8b3@jic23-huawei>
In-Reply-To: <aZrjbmU8Vt98Sjwr@smile.fi.intel.com>
References: <20260220200522.19967-1-ethantidmore06@gmail.com>
	<aZrjbmU8Vt98Sjwr@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 22 Feb 2026 13:07:26 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Feb 20, 2026 at 02:05:22PM -0600, Ethan Tidmore wrote:
> > The interrupt handler is setup but only a few lines down if
> > iio_trigger_register() fails the function returns without properly
> > releasing the handler:
> > 
> > 	ret = request_threaded_irq(irq,
> > 				   mpu3050_irq_handler,
> > 				   mpu3050_irq_thread,
> > 				   irq_trig,
> > 				   mpu3050->trig->name,
> > 				   mpu3050->trig);
> > 
> > ...
> > 
> > 	ret = iio_trigger_register(mpu3050->trig);
> > 	if (ret)
> > 		return ret;
> > 
> > 	indio_dev->trig = iio_trigger_get(mpu3050->trig);
> > 
> > 	return 0;
> > }
> > 
> > Change request_threaded_irq() to devm_request_threaded_irq() to resolve
> > resource leak and use current API.
> > 
> > Detected by Smatch:
> > drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
> > 'irq' from request_threaded_irq() not released on lines: 1124.  
> 
> ...
> 
> > +	ret = devm_request_threaded_irq(dev,
> > +					irq,
> > +					mpu3050_irq_handler,
> > +					mpu3050_irq_thread,
> > +					irq_trig,
> > +					mpu3050->trig->name,
> > +					mpu3050->trig);
> >  	if (ret) {
> >  		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
> >  		return ret;  
> 
> Now this prints two messages on the error path...
> 

This driver is a bit of a mess wrt to devm already and the change here makes
things worse.  Rule for devm (to make it easy to reason about) is you use it
on everything until a particular point in probe when you switch to not using
it for anything.   Mix and match leads to subtle race conditions.

Now, today the mix and match is there but on memory allocations which tend
to be safe to release late (though not recommended to do so!) this adds
irqs to that mix.

So your patch is fixing a real issue, but I think we should be looking to
clean up the other related issues around it.

As a side note, the indio_dev->trig should not be set after iio_device_register()
That's one reason almost all drivers register triggers before the device.

Also the free_irq() you are dropping is out of sequence wrt to
iio_triggered_buffer_cleanup()

If you want to take this driver on I'd suggest it needs a more complex and general
conversion to devm.

Alternative is just fix the problem you've identified but not using devm_
but instead use goto and a manual free_irq() call in the error path.


Thanks,

Jonathan

 
