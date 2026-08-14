Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FF41D104;
	Fri, 14 Aug 2026 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693809; cv=none; b=aEESNOfBzmeRbvN93AGoYcJRVG5+XFnjcm65NrvK5azBmAhWga0wVkEyXZjRMaf4aLFTIxCXOczMiIr6fMx1AiC9/VHtO9B2CtF5SfG8uaJj3wWw1/b4fjNsxj+359iD7yiPmNmhNUQxAI4qM0ed3ymCHI4SzGhG+jxXeyyxwiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693809; c=relaxed/simple;
	bh=kW/g5y5wQhUxRsqytR7Az0Nb/kG2mfwtVXLKQr0FL4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBn2yxeOeLvwAkY0FKzuwDmYKhPmFYYeY7FTjQ4vHk8ibSUoz6spE0cXeXqAj77cbNkezlhin+bMsrIudbSjSCEC6Nksdb6zGUIVjy4MFI5oKm1Z3qNu/oqrx9x2Y6oUQURhpOHOFrfeiCEKE9O540eg+AluBnLWIE7vBs1PTmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jdtIBEla; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jdtIBEla"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786693806; x=1818229806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kW/g5y5wQhUxRsqytR7Az0Nb/kG2mfwtVXLKQr0FL4c=;
  b=jdtIBElaPQYbpOE+fOT17z19yxFudtwqIhwgIza/93POM0yeoP0KYsqN
   vI+I/Trw3F2bKKk1XK4JEZah2LygO+VR4N1ACLz8BLfdR9/QmGbB8Bvj4
   wluB2MvRNxx/AiU09wkeJS4v4el3Ko1sXfalp4uxOtHVhW3dHQ0tCn1jn
   wtggeHCHhW/ISejYUWXOHi5P7as/CYiXBL0pDpVUdzfFNkneA3enhrqtY
   zT8mYjtiFGtSNWCvwADbjvlzJlaebwGe5DEUi7eKOudHm0Ge8KEF+D1Et
   ZhdVvTKLf4+mZVJAjt8QkULdtnxSlZP2Y8XwsbsrpTRyoJXQc48Kp36so
   g==;
X-CSE-ConnectionGUID: +zsTn1M5Tt+kKk4FCMjwVQ==
X-CSE-MsgGUID: ILC9+WoBQKqtLT1sD2z8cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87490249"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87490249"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 00:50:03 -0700
X-CSE-ConnectionGUID: kUp9qcgHQPW1L70l38yW1g==
X-CSE-MsgGUID: s7mOhmxqQam0auPBFjN25Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="259918686"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 00:50:00 -0700
Date: Fri, 14 Aug 2026 10:49:58 +0300
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
Message-ID: <an7IpvdXnxzzDknS@ashevche-desk.local>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
 <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
 <an1rR07iJd_XLSPr@ashevche-desk.local>
 <DKNPY12RSCH4.2KQCX98171G2H@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKNPY12RSCH4.2KQCX98171G2H@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 11:46:32AM +0200, Javier Carrasco wrote:
> Hello Andy, thank you again for your thorough review.
> On Thu Aug 13, 2026 at 8:59 AM CEST, Andy Shevchenko wrote:
> > On Wed, Aug 12, 2026 at 10:27:41PM +0200, Javier Carrasco wrote:

...

> >> +	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> >> +	if (IS_ERR(data->regmap))
> >> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> >> +				     "Failed to set regmap\n");
> >
> > Is debugfs access already enabled for regmap after this call? Perhaps you want
> > mutex to be initialised before that?
> 
> Could you please explain what you are trying to avoid? Even if the
> debugfs is already enabled for regmap at this point, what is the
> possible race condition?

That's my question to you. If you think there is none, then we are all good.
Basically the Q is if that mutex (that is initialised later in the probe) is
required for the device IO which might be possible immediately when regmap
is registered.

> The IIO device is still not registered at this
> point, and the registers are set to their right values in _hw_init()
> after the mutexes were initialized. Moving the mutex initialization a
> couple of lines towards the top is not an issue, but I would like to
> understand the reasoning behind.

User may read (and depending on the driver case writing) the register map.
Would it be a problem?

> >> +	ret = devm_mutex_init(dev, &data->scale_lock);
> >> +	if (ret)
> >> +		return ret;

...

> >> +err_pm_put:
> >> +	pm_runtime_put_noidle(dev);
> >
> > Hmm... This is usually a red flag to see a goto after devm_*() calls.
> 
> Could you please elaborate on this? I am aware of the dangers of a goto
> after the cleanup attribute, but devm_*() calls work on a different
> scope, not local to the function. What could go wrong? This goto is just
> a way not to repeat pm_runtime_put_noidle(); return ret; and I am not
> strongly against repeating these two lines wherever there is a goto, but
> I am not sure what we are avoiding in this case.

No, the goto here may (or may not) lead to the wrong ordering on the cleanup
and/or error paths. It's usually recommended to avoid such a style even if
it works without races in that case. That's why when switching to managed
resources it's highly recommended to wrap everything to be managed (in case
there is no native APIs available) and avoid any flow disruption (goto:s).

-- 
With Best Regards,
Andy Shevchenko


