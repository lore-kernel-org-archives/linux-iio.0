Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA533D4133
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 22:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946616; cv=none; b=Gl2xHdX1cE764gICavMeF6n5ofAS/rtDwKOIVwa3rVyJe6p09xydAP4qtDAmNCDNArU/Jm3QeoYtTJ+90scOSa/zrZYFQeP917edeCXBAJ+vwx8A2oWQq5S/Noo5VWHMqK4g0NROwunEOsdDQmlxFevFj0Y/Rg7pmomHsJvb6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946616; c=relaxed/simple;
	bh=lwX2bPaiwNqCk7neAqL3vIPX5ERgjq8HxNiBECCpRW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcR22Eiqpez/htSfGW6X4bomb2roO5KbsLR9wHyf5xQPeezrgLJ8TuTnyCNj65AkY/oJEbm+29w8UY+RRHtHK89OIcaQfJEWjf7x8aH5kftMW4n9XXFHbgoMIM9qp47/VIUQs3bR4bTv5hLkLuYZi88/DjuWTQIc9u8E3L9zSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTjnCHKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTjnCHKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10586C19421;
	Tue, 20 Jan 2026 22:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768946616;
	bh=lwX2bPaiwNqCk7neAqL3vIPX5ERgjq8HxNiBECCpRW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZTjnCHKo3DmFpuFjfdxA5/GBwA+fpAHrAWRDiQu4H7j+Tg6ZQ7yL8B9iIzpGDhLqv
	 ixBpryQ9nIlsSTdvAsC73WoONf6B5U4xehnsPgCYK+/sJIutqcNXiG9Kx58XBcH+R6
	 nxh1/6DGI8pX5eOtfaBdTRUdosWJtW3JY7S6M4hRym237qjVqEyU5aKNYFn6sqjrRc
	 PwaoqPd/cGB7y337x3qFsY5Ws1GeNoep6LwveD7h30DGoHArCSsWLpgSVI0GqQO1RC
	 5fLbvzTk3uOhwP6Nd5vVO+/vv25fh5Q6tsUjXWNIJ//FhahoYds/HPySF309FLj10K
	 Z7oadkZx9HW/g==
Date: Tue, 20 Jan 2026 22:03:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] iio: magn: mmc5633: Add some ifdef / __maybe_unused
 until stubs available
Message-ID: <20260120220328.771b2589@jic23-huawei>
In-Reply-To: <20260120215627.371741a7@jic23-huawei>
References: <20260119221736.804825-1-jic23@kernel.org>
	<20260119221736.804825-3-jic23@kernel.org>
	<aW8tWECNSvLTTKU8@smile.fi.intel.com>
	<20260120215627.371741a7@jic23-huawei>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 21:56:27 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 20 Jan 2026 09:23:04 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Mon, Jan 19, 2026 at 10:17:36PM +0000, Jonathan Cameron wrote:
> >   
> > > The I3C tree has Frank Li's fix for the case of I3C not being built    
> >   
> > > https://lore.kernel.org/all/20251230145718.4088694-1-Frank.Li@nxp.com/    
> > 
> > Make it a Link tag
> >   
> > > Given those will only be available upstream at the next merge window
> > > and the ordering of merge of I3C vs IIO is uncertain, apply some temporary
> > > stubs in the driver to avoid build issues.
> > > 
> > > This can be reverted next cycle.    
> > 
> > Link: ... [1]
> >   
> > > Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202512280443.lOhY75Df-lkp@intel.com/
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>    
> > 
> > ...
> >   
> > >  static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
> > >  {
> > >  	struct device *dev = regmap_get_device(data->regmap);
> > >  	u8 data_cmd[2], status[2];
> > > -	unsigned int val, ready;
> > > +	unsigned int val;
> > > +	unsigned int ready __maybe_unused;
> > >  	int ret;    
> > 
> > Reversed xmas tree ordering?  
> 
> I'm reverting this in a couple of weeks and want to keep things
> as tightly organized as possible.  I swapped val and ready but
> no more than that.
> 
> > 
> > ...
> >   
> > > +#ifdef CONFIG_I3C
> > >  		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
> > >  					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
> > > +#else    
> >   
> > > +		return -EOPNOTSUPP;    
> > 
> > I would do one point of return, id est
> > 
> > 		ret = -EOPNOTSUPP;
> >   
> > > +#endif
> > >  		if (ret < 0)
> > >  			return ret;    
> Ok for this one.
Or not.  Amazingly enough if I touch this the compiler suddenly decides
val is not initialised.

drivers/iio/magnetometer/mmc5633.c:260:7: warning: variable 'val' is uninitialized when used here [-Wuninitialized]
  260 |                 if (val) {
      |                     ^~~
drivers/iio/magnetometer/mmc5633.c:205:18: note: initialize the variable 'val' to silence this warning
  205 |         unsigned int val;
      |                         ^
      |             

 Why does that happen?  Answers on a post card, but I need 'a fix' in place
for this. Given I plan to revert it shortly anyway, I'll play a little fast
and lose this time!

> > 
> > ...
> >   
> > > +#ifdef CONFIG_I3C
> > >  		ret = read_poll_timeout(i3c_device_do_xfers, val,
> > >  					val || (status[0] & ready),
> > >  					10 * USEC_PER_MSEC,
> > >  					100 * 10 * USEC_PER_MSEC, 0,
> > >  					data->i3cdev, xfers_rd_sta_cmd,
> > >  					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
> > > +#else
> > > +		ret = -EOPNOTSUPP;
> > > +#endif
> > >  		if (ret) {
> > >  			dev_err(dev, "data not ready\n");
> > >  			return ret;
> > >  		}    
> > 
> > Ditto.  
> I'm confused this one already does one point of return.
> 
> The final one (which was in the cropped bit) I'm leaving alone as
> it would be more churn.
> 
> J
> >   
> 

