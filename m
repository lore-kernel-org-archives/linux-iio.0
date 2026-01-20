Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C3F3D3CE2
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768946196; cv=none; b=QLNj5kT4kPmEc3ZFajrtN3Xr/JSssABmgsy27Y1jtPmXcvHSAaGeXLs7xaK1DI5Z8AqGJUCA22jnK3G3Z0afXuYh63Q5oQrRRBq6fPkgJknEivQqDefzbYQ8k8QE+bpp60MegZnhfvruy5+nvGnxnSgUPAyD4/5XJHkjgbRCePk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768946196; c=relaxed/simple;
	bh=1M2xurEvwTbZHBnoC9TgToUdzKSqPns6FiyF+//wBOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ys9cRRo5VGQkvvnLx6U9VPdcxm1dGp7fUlTuR0drw/d6HHrli5iUgpqG0K3PySfsUv5k4HIGL+9zf7Nrxk7wa8p6jltYw337NLt+nk2BXvVFn85UF4mIEn/c6Sw4k3o191dk4Tq4413gKcbWCfhHKN/bM52qyo5hYvpR+NYAGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/HcmQ+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/HcmQ+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AEEC16AAE;
	Tue, 20 Jan 2026 21:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768946195;
	bh=1M2xurEvwTbZHBnoC9TgToUdzKSqPns6FiyF+//wBOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/HcmQ+J9ty9JcJ6+EVCF9s6oHzvTsPH+db0oraH3JatDAxPfygmvEoY2VWoPR5Qq
	 YMi3plJcwvsskRuJ7sge/5G0TQOkAS/oxNSH3WLNQXH1OmfRvQRLuF+IMm+eBz5cJo
	 0AC4aFeBZ/alm/GcFAPtC3XksFZHSQZeyeQYxMRGWtq6Cdeb4fqIpzkzD2PPjaSqXT
	 N4t75t0WYr015cMRNos1EX5rp/k4m4DO4u6XG/EoOqMQoMSzemfkCBgtePrXW2cyBq
	 p7isXWUyKcWFkZBFP9F5Jy4XwooT7fe4/2EOLJO1FrT38wCSFnXEjlqwTqey7KBGpX
	 4tRwIlv1HAvtA==
Date: Tue, 20 Jan 2026 21:56:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Frank Li <Frank.Li@nxp.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] iio: magn: mmc5633: Add some ifdef / __maybe_unused
 until stubs available
Message-ID: <20260120215627.371741a7@jic23-huawei>
In-Reply-To: <aW8tWECNSvLTTKU8@smile.fi.intel.com>
References: <20260119221736.804825-1-jic23@kernel.org>
	<20260119221736.804825-3-jic23@kernel.org>
	<aW8tWECNSvLTTKU8@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 09:23:04 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Jan 19, 2026 at 10:17:36PM +0000, Jonathan Cameron wrote:
> 
> > The I3C tree has Frank Li's fix for the case of I3C not being built  
> 
> > https://lore.kernel.org/all/20251230145718.4088694-1-Frank.Li@nxp.com/  
> 
> Make it a Link tag
> 
> > Given those will only be available upstream at the next merge window
> > and the ordering of merge of I3C vs IIO is uncertain, apply some temporary
> > stubs in the driver to avoid build issues.
> > 
> > This can be reverted next cycle.  
> 
> Link: ... [1]
> 
> > Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202512280443.lOhY75Df-lkp@intel.com/
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> ...
> 
> >  static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
> >  {
> >  	struct device *dev = regmap_get_device(data->regmap);
> >  	u8 data_cmd[2], status[2];
> > -	unsigned int val, ready;
> > +	unsigned int val;
> > +	unsigned int ready __maybe_unused;
> >  	int ret;  
> 
> Reversed xmas tree ordering?

I'm reverting this in a couple of weeks and want to keep things
as tightly organized as possible.  I swapped val and ready but
no more than that.

> 
> ...
> 
> > +#ifdef CONFIG_I3C
> >  		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
> >  					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
> > +#else  
> 
> > +		return -EOPNOTSUPP;  
> 
> I would do one point of return, id est
> 
> 		ret = -EOPNOTSUPP;
> 
> > +#endif
> >  		if (ret < 0)
> >  			return ret;  
Ok for this one.
> 
> ...
> 
> > +#ifdef CONFIG_I3C
> >  		ret = read_poll_timeout(i3c_device_do_xfers, val,
> >  					val || (status[0] & ready),
> >  					10 * USEC_PER_MSEC,
> >  					100 * 10 * USEC_PER_MSEC, 0,
> >  					data->i3cdev, xfers_rd_sta_cmd,
> >  					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
> > +#else
> > +		ret = -EOPNOTSUPP;
> > +#endif
> >  		if (ret) {
> >  			dev_err(dev, "data not ready\n");
> >  			return ret;
> >  		}  
> 
> Ditto.
I'm confused this one already does one point of return.

The final one (which was in the cropped bit) I'm leaving alone as
it would be more churn.

J
> 

