Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925441F349;
	Tue, 11 Aug 2026 08:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438458; cv=none; b=R+b/t+XFE1laaaoHVPKYJLYPkUoqnmBsohStoi5zHB6g7myQaxCm9neU8d07SVsi962V1STRuxV3/NXrrlAo1Z9saNmTKTCCkZSOm7ZiM9WMZDfwetll7dmpxvp0jTNayPsS0Ojh1adoYUg4SvwIWIrlU6zlqkeNt4feXdTn4Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438458; c=relaxed/simple;
	bh=a+W+ZtDffJYfstKZ1kDtLAHQ+J0AAJORuKvSCHXVLTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DriwaTeMUMv5Atm0DKRmObnlRiIHO01ONEzSqvQOjd97URks4yPhutOd2dBL6cEHTCYOOH1pnK/2wraHbPJW6b/H88ND0l8YsKIljdLV8aIAmEGCiER6HlB9cYXOI450rFFU3fyG1RnmYALI0KNH2vOA26WFq5r2owpIojqRHss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWtrNikD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWtrNikD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786438456; x=1817974456;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a+W+ZtDffJYfstKZ1kDtLAHQ+J0AAJORuKvSCHXVLTk=;
  b=QWtrNikDWAjlBCPHZVRjV3cAFYJZXOIlpHe1ESLww/Iw0nxA+z8u7fKi
   X6z2j/+oVt8PRHQm5/RBISOum7Qif7eWdq7hzqBFjYo5euQBvDS46lq+q
   EhBkm45A2RrA3drSO9awHYahyiwNQu3PzfaEsOAHICFyGonDS0W1xnBZl
   B9ohcMNFKROdIq/pVrTeAZ3dvcdOdIbC2M38QiFQqpdyZQuo/iKK8mPq6
   1bspd6NjGfiF47HXtCz6BPVseg+KgfmwnvO79kkztio4twtv+cKaloGPR
   JKV/B9ID5fJD7yUdOkgQg1/Hx/kX5yPsTJUa8t3uOGAyz3q8WnLT+JBGF
   w==;
X-CSE-ConnectionGUID: K0OmoCcDQnOwTrg+0CrKeg==
X-CSE-MsgGUID: GpnuHJaQRnukn5D3321DjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86841503"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86841503"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:54:15 -0700
X-CSE-ConnectionGUID: ozaTbj6VQK+rOeJaDAcs1g==
X-CSE-MsgGUID: 3lTlsErsRH+YL9lPNyA6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="268436973"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 01:54:13 -0700
Date: Tue, 11 Aug 2026 11:54:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg v2 2/2] iio: imu: inv_icm42607: restore runtime PM
 on system resume errors
Message-ID: <anrjMowu4HT1yiW1@ashevche-desk.local>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
 <20260811020345.950137-1-lilinmao@kylinos.cn>
 <20260811020345.950137-3-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811020345.950137-3-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 10:03:45AM +0800, Linmao Li wrote:
> pm_runtime_force_suspend() leaves runtime PM disabled after it succeeds and
> expects pm_runtime_force_resume() to restore runtime PM management during
> system resume.
> 
> The resume callback returns early if enabling the vddio regulator or
> synchronizing the register cache fails, skipping the matching
> pm_runtime_force_resume() call. Runtime PM consequently remains disabled
> after the system has resumed, so runtime autosuspend can no longer turn off
> sensors enabled afterward.
> 
> Call pm_runtime_force_resume() on both error paths. Keep the first error as
> the return value and report a runtime PM restore failure separately.

...

>  	/* Sync the regcache again after regulator shutdown. */
>  	regcache_mark_dirty(st->map);
> -	ret = regcache_sync(st->map);
> -	if (ret)

> +

I wouldn't add this blank line as these two are quite coupled. OTOH it's a
better style, so I leave it to Jonathan and others to decide.

> +	return regcache_sync(st->map);
> +}

...

> +static int inv_icm42607_resume(struct device *dev)
> +{
> +	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int resume_ret;
> +	int ret;
> +
> +	ret = inv_icm42607_resume_core(st);
> +
> +	resume_ret = pm_runtime_force_resume(dev);
> +	if (ret) {

I still don't get the logic here. Shouldn't we rather call the force_suspend()
last in the .suspend() and force_resume() first here?

> +		if (resume_ret)
> +			dev_warn(dev, "Failed to restore runtime PM state: %d\n",
> +				 resume_ret);
> +
>  		return ret;
> +	}
>  
> -	return pm_runtime_force_resume(dev);
> +	return resume_ret;
>  }

Okay, after reading other drivers I think the above can be written in a bit better form.

	struct inv_icm42607_state *st = dev_get_drvdata(dev);
	int ret;

	ret = inv_icm42607_resume_core(st);
	if (ret) {
		int rc;

		rc = pm_runtime_force_resume(dev);
		if (rc)
			dev_warn(dev, "Failed to restore runtime PM state: %d\n", rc);

// and yes, I would go with longer line here (that's why I renamed variable)

		return ret;
	}

	return pm_runtime_force_resume(dev);

It seems that if the above analysis is true (I haven't deeply checked that),
there are many drivers in the kernel suffer from the very same issue (when they
need to do some work before runtime PM resume may be called from inside the
system .resume() callback.

-- 
With Best Regards,
Andy Shevchenko


