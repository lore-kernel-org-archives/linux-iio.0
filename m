Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739FC175A5;
	Mon, 17 Aug 2026 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786934077; cv=none; b=gzpyf6LAdsw+5bSaTx7SuXajVdaZM83ykEWWkoF7W7aTcTBRSpNjxVrCN6adTqsn/P6sflF4Qv8+tU58EAL5UXNai+CmBXvYhJBuXkIfFE9sW7hMOOQGGz1kfq5jUsomLuRj0jcWlOtk1Q2Um3IfAKFSgVnAv5wLMsC6c0DUCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786934077; c=relaxed/simple;
	bh=JO00TPKkaUK+Ytiq7fXhxprwM9VRYgOPt5IvRkeUMIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImtSH0NlGxLDrkEAoqOkFrkg6CQyEdZ2J+dEyWSItgUG1tL2gZC0PH6MmFcoAzpAb+ueG/R7S8Yz1KJi3vowaETy5lNI7SlCV0DPEoq33zJjIKoGmW3HAWDbyeHlWseoZBrgzk2BH1aCXFBUoGyMnOYq/cFAWKmXzngaQUk/5R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQdMumUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQdMumUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5601F000E9;
	Mon, 17 Aug 2026 02:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786934076;
	bh=ToAYu+1DBSdPrmc7a4Xhzc4N11Q4e5o0WUPPZH5M3ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dQdMumUKAjHmHVLOeJFtIf8WTPfGqaWA5OX3Xhz+mOU0DnY8K3/+ZXoVJieBRpZAc
	 2sO+ndIMLwOUfxv9p1BRDhwZETAuhfDeGbtf0RqyN4CJR3IFvvCsdwPXNdLxEvREhB
	 HNzlS1hfn2pOF1YH+mYDNx34LUsbXxNhjFwtk+/8TE3qEJY7Kvw9UsVZVtbfoFp4wx
	 4Dh2EWS1kjGQux+pr7sppTFK55iwV0POZTGOJc4AI3EtWhZWXobgnSoTRBBvfm98U0
	 E9vv2Yy4LCCJhN6myAXsYhMnyPJ2mTer2W6waoWjLu3RXTkHNhexmepcQvFpt5GZOw
	 eh1Wb6Xh1f5gQ==
Date: Mon, 17 Aug 2026 03:34:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260817033431.4ae11665@jic23-huawei>
In-Reply-To: <an7atynATsJHlt7_@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
	<an1rR07iJd_XLSPr@ashevche-desk.local>
	<DKNPY12RSCH4.2KQCX98171G2H@gmail.com>
	<an7IpvdXnxzzDknS@ashevche-desk.local>
	<DKOJJJSXCZ8Y.KCR5NRYX7PVL@gmail.com>
	<an7atynATsJHlt7_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Aug 2026 12:07:03 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, Aug 14, 2026 at 10:58:10AM +0200, Javier Carrasco wrote:
> > On Fri Aug 14, 2026 at 9:49 AM CEST, Andy Shevchenko wrote:  
> > > On Thu, Aug 13, 2026 at 11:46:32AM +0200, Javier Carrasco wrote:  
> > >> Hello Andy, thank you again for your thorough review.
> > >> On Thu Aug 13, 2026 at 8:59 AM CEST, Andy Shevchenko wrote:  
> > >> > On Wed, Aug 12, 2026 at 10:27:41PM +0200, Javier Carrasco wrote:  
> 
> ...
> 
> > >> >> +	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> > >> >> +	if (IS_ERR(data->regmap))
> > >> >> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> > >> >> +				     "Failed to set regmap\n");  
> > >> >
> > >> > Is debugfs access already enabled for regmap after this call? Perhaps you want
> > >> > mutex to be initialised before that?  
> > >>
> > >> Could you please explain what you are trying to avoid? Even if the
> > >> debugfs is already enabled for regmap at this point, what is the
> > >> possible race condition?  
> > >
> > > That's my question to you. If you think there is none, then we are all good.
> > > Basically the Q is if that mutex (that is initialised later in the probe) is
> > > required for the device IO which might be possible immediately when regmap
> > > is registered.
> > >  
> > >> The IIO device is still not registered at this
> > >> point, and the registers are set to their right values in _hw_init()
> > >> after the mutexes were initialized. Moving the mutex initialization a
> > >> couple of lines towards the top is not an issue, but I would like to
> > >> understand the reasoning behind.  
> > >
> > > User may read (and depending on the driver case writing) the register map.
> > > Would it be a problem?  
> > 
> > That is not a problem, as no assumptions about the original values are
> > made.  
> 
> It's not about the values, it's about the *access* HW during that time when
> there is no mutex available yet.
> 
> > >> >> +	ret = devm_mutex_init(dev, &data->scale_lock);
> > >> >> +	if (ret)
> > >> >> +		return ret;  
> 
> ...
> 
> > >> >> +err_pm_put:
> > >> >> +	pm_runtime_put_noidle(dev);  
> > >> >
> > >> > Hmm... This is usually a red flag to see a goto after devm_*() calls.  
> > >>
> > >> Could you please elaborate on this? I am aware of the dangers of a goto
> > >> after the cleanup attribute, but devm_*() calls work on a different
> > >> scope, not local to the function. What could go wrong? This goto is just
> > >> a way not to repeat pm_runtime_put_noidle(); return ret; and I am not
> > >> strongly against repeating these two lines wherever there is a goto, but
> > >> I am not sure what we are avoiding in this case.  
> > >
> > > No, the goto here may (or may not) lead to the wrong ordering on the cleanup
> > > and/or error paths. It's usually recommended to avoid such a style even if
> > > it works without races in that case. That's why when switching to managed
> > > resources it's highly recommended to wrap everything to be managed (in case
> > > there is no native APIs available) and avoid any flow disruption (goto:s).  
> > 
> > In this case I can't see any issue with the goto. It only leads to a
> > call to pm_runtime_put_noidle(), and after returning 'ret', the
> > device-managed resources are released. If the goto is removed and a
> > call to pm_runtime_put_noidle() is carried out in every error path, the
> > result is exactly the same as there are no operations within the probe
> > execution path that affect their behavior.  
> 
> Right, but again "It's usually recommended to avoid such a style...".
> 
> > I can imagine that it might be problematic in some special cases, but
> > the use of devm_*() and goto jumps within a function is allowed and used
> > in the official documentation [1], and in several upstream drivers in IIO
> > [2][3] and other subsystems [4]. Of course, all those examples might be bad
> > examples, but I could not find any reference discouraging the use of
> > goto with devm_*().  
> 
> > [1] https://docs.kernel.org/driver-api/usb/writing_musb_glue_layer.html  
> 
> It's not kernel-wide documentation. At a brief glance it has more issues than
> just that one. I would not recommend to refer and use that piece of the
> documentation without fixing it first.
FWIW I think the runtime pm handling under the goto is unnecessary
anyway (as we don't need to grab a reference anyway) - so with that
gone this whole debate becomes moot. (Yes I did put moot in for my own amusement)


J
> 
> > [2] drivers/iio/accel/kxcjk-1013.c
> > [3] drivers/iio/pressure/hid-sensor-press.c
> > [4] drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  
> 

