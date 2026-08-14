Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF4542AFAF;
	Fri, 14 Aug 2026 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698434; cv=none; b=e78mJ+YonH4ioShlZLgfXmNLF0v0O/1rArT9lCStGaMBAUSo2xIhcxKHirwyiEnXM5U0uc7qchYbserzBFYgwpmjVqPfY5HzH47NRu5Pn9akpo4PFQbXczifpgPca5geSsG2XJ18D5vpqbGcZaAsOIiWzfQW6Pw3n9aN1/TqNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698434; c=relaxed/simple;
	bh=/tDtFX3EjQsn+3Z8JEA1ppYnqFQ/G/7gBPpEhs+uTQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8bsXX5DvPy2RkdPjllxRgNumbyIGTDpjoC4hWXQDfysZPKh7bTFeA+wiWhkJNHSbq4a0zfZ62DA/3gGelZ1BEhw0V2lGcad+AN8n4Zu4FD/oLb1pY7UiODOoC8T+Ht8Hp+ScTrNm+9UnC4EsokBhdEwJ+7AuzUU+7DwfGw12DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZI+M8Gi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZI+M8Gi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786698433; x=1818234433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/tDtFX3EjQsn+3Z8JEA1ppYnqFQ/G/7gBPpEhs+uTQc=;
  b=jZI+M8GidHxFF2Q1SylSC9CEU5/PyqhqS4oIBHvGDfQ3ZY8RzLJ0ZMa3
   HfRmttbxjeMGWRLZ+JQYHxW6Wk1aEkxJuX5xG2c79Rj9H3IeqovA16nyH
   MsJVCplPHL9mpDy5bWtLIc3Uyx7M/6kRpujwLYMcBazB60lUQzNPviFWr
   4A91c9kxLPmS0CAEkYXnOZa2mu4oYrFctkL/R57L2rKolq7O49jxjzpyW
   ynYHQgL7Obt9E1WCvcV63lQu65pTRUFXOvdswcjnA05pZn96SN6vTKoYe
   yXz6SWqzdIpMkm7B8zARixCUV1TzPDbH9j5UvA2Wn43rw5ok2srA5odY7
   w==;
X-CSE-ConnectionGUID: z6IGDYBVS2Wwa7tedaJAzg==
X-CSE-MsgGUID: FsfdBfiiRZW7TiJn5Je7jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="90952611"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="90952611"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:07:09 -0700
X-CSE-ConnectionGUID: BnpMgjOLSt2rDG9cVx6nNA==
X-CSE-MsgGUID: b57VzxImRLaVlyUydjW5IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="257955540"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 02:07:06 -0700
Date: Fri, 14 Aug 2026 12:07:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <an7atynATsJHlt7_@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
 <an1rR07iJd_XLSPr@ashevche-desk.local>
 <DKNPY12RSCH4.2KQCX98171G2H@gmail.com>
 <an7IpvdXnxzzDknS@ashevche-desk.local>
 <DKOJJJSXCZ8Y.KCR5NRYX7PVL@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKOJJJSXCZ8Y.KCR5NRYX7PVL@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 10:58:10AM +0200, Javier Carrasco wrote:
> On Fri Aug 14, 2026 at 9:49 AM CEST, Andy Shevchenko wrote:
> > On Thu, Aug 13, 2026 at 11:46:32AM +0200, Javier Carrasco wrote:
> >> Hello Andy, thank you again for your thorough review.
> >> On Thu Aug 13, 2026 at 8:59 AM CEST, Andy Shevchenko wrote:
> >> > On Wed, Aug 12, 2026 at 10:27:41PM +0200, Javier Carrasco wrote:

...

> >> >> +	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> >> >> +	if (IS_ERR(data->regmap))
> >> >> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> >> >> +				     "Failed to set regmap\n");
> >> >
> >> > Is debugfs access already enabled for regmap after this call? Perhaps you want
> >> > mutex to be initialised before that?
> >>
> >> Could you please explain what you are trying to avoid? Even if the
> >> debugfs is already enabled for regmap at this point, what is the
> >> possible race condition?
> >
> > That's my question to you. If you think there is none, then we are all good.
> > Basically the Q is if that mutex (that is initialised later in the probe) is
> > required for the device IO which might be possible immediately when regmap
> > is registered.
> >
> >> The IIO device is still not registered at this
> >> point, and the registers are set to their right values in _hw_init()
> >> after the mutexes were initialized. Moving the mutex initialization a
> >> couple of lines towards the top is not an issue, but I would like to
> >> understand the reasoning behind.
> >
> > User may read (and depending on the driver case writing) the register map.
> > Would it be a problem?
> 
> That is not a problem, as no assumptions about the original values are
> made.

It's not about the values, it's about the *access* HW during that time when
there is no mutex available yet.

> >> >> +	ret = devm_mutex_init(dev, &data->scale_lock);
> >> >> +	if (ret)
> >> >> +		return ret;

...

> >> >> +err_pm_put:
> >> >> +	pm_runtime_put_noidle(dev);
> >> >
> >> > Hmm... This is usually a red flag to see a goto after devm_*() calls.
> >>
> >> Could you please elaborate on this? I am aware of the dangers of a goto
> >> after the cleanup attribute, but devm_*() calls work on a different
> >> scope, not local to the function. What could go wrong? This goto is just
> >> a way not to repeat pm_runtime_put_noidle(); return ret; and I am not
> >> strongly against repeating these two lines wherever there is a goto, but
> >> I am not sure what we are avoiding in this case.
> >
> > No, the goto here may (or may not) lead to the wrong ordering on the cleanup
> > and/or error paths. It's usually recommended to avoid such a style even if
> > it works without races in that case. That's why when switching to managed
> > resources it's highly recommended to wrap everything to be managed (in case
> > there is no native APIs available) and avoid any flow disruption (goto:s).
> 
> In this case I can't see any issue with the goto. It only leads to a
> call to pm_runtime_put_noidle(), and after returning 'ret', the
> device-managed resources are released. If the goto is removed and a
> call to pm_runtime_put_noidle() is carried out in every error path, the
> result is exactly the same as there are no operations within the probe
> execution path that affect their behavior.

Right, but again "It's usually recommended to avoid such a style...".

> I can imagine that it might be problematic in some special cases, but
> the use of devm_*() and goto jumps within a function is allowed and used
> in the official documentation [1], and in several upstream drivers in IIO
> [2][3] and other subsystems [4]. Of course, all those examples might be bad
> examples, but I could not find any reference discouraging the use of
> goto with devm_*().

> [1] https://docs.kernel.org/driver-api/usb/writing_musb_glue_layer.html

It's not kernel-wide documentation. At a brief glance it has more issues than
just that one. I would not recommend to refer and use that piece of the
documentation without fixing it first.

> [2] drivers/iio/accel/kxcjk-1013.c
> [3] drivers/iio/pressure/hid-sensor-press.c
> [4] drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c

-- 
With Best Regards,
Andy Shevchenko


