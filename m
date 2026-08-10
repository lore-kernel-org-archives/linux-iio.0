Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD2742FCB6;
	Mon, 10 Aug 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390717; cv=none; b=TMESiuwUZ9onQI0qH2mHEYB3B9D9yxPc2MTmHpq9+e5IEVHpqdg81LSMzM40w9AlTs7l+TsZ/FN5Z0wXuk+AyYij6BKZiQVOCcuXh2WpqrvhGJI+QPF5aks76PpQi6iNGVgnWZxlKgHwaMtGlJBp6VsneonTORm9J81YkpqqDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390717; c=relaxed/simple;
	bh=pAudGTE5Y4iGeMkxbz2qBuaD6Bx18W40S4c97rL6+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V84irkeesolODKxpp55ntLO3Kcm0fojb5AA7HBKBz0+ulXCu3GaHe+BCb1mI4z/zs4tg8UYk/RoZ6UtGrrXDZZ31NuTCk7ywO8dqNMqWQ44L9r1QACbja1fOOzIho+93dzYxelGpr3Gchhcd62yrECZr9nOitETVYB8Qkq9ZOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOcuKPrq; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOcuKPrq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786390715; x=1817926715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pAudGTE5Y4iGeMkxbz2qBuaD6Bx18W40S4c97rL6+Nw=;
  b=XOcuKPrqPIUPxafzpPVl6I0+1skif7+HD/NS9oUKeBbb9a8YVs3jUtoD
   ZHqw9myLPqKsr+SYy5dc779dRQ+mAkwyhV2EpmiiSvEb7ZLyOoJOKiG6M
   vAmBpou9wXpWnh/ZD0m6ur2bdEnKNB3i9IpfJ4kHSsVSjVKJJ8c0ldN0w
   Y4RbYIp1vQWQKcMsgg+yjyIvPsGSL+cNFotBuhQbif3Gh2Hx18oJkmg+y
   sfUV+WlsdQ0Od3dhrScT5FbDaStac1kAQEMuW23699X1oPv2aCaO2t7mM
   3YvLsY44zSQiDXJjONFZXzxuzq1Vcqk/P86HAjR6edUVrw53hT350KWCw
   w==;
X-CSE-ConnectionGUID: zYP7XxedTDa0TbAKgbdwzw==
X-CSE-MsgGUID: 6Se2o24TSuicZ80uLJkzrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="97266652"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="97266652"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:38:34 -0700
X-CSE-ConnectionGUID: JilQjMveTrmPbtZSG1O20Q==
X-CSE-MsgGUID: +HrrmamfT12citG3PkT3QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="256899237"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:38:32 -0700
Date: Mon, 10 Aug 2026 22:38:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH togreg 2/2] iio: imu: inv_icm42607: restore runtime PM on
 system resume errors
Message-ID: <anootUNH8xa_PRDe@ashevche-desk.local>
References: <20260805035451.487465-1-lilinmao@kylinos.cn>
 <20260805035451.487465-3-lilinmao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805035451.487465-3-lilinmao@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 11:54:51AM +0800, Linmao Li wrote:
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

>  static int inv_icm42607_resume(struct device *dev)
>  {
>  	struct inv_icm42607_state *st = dev_get_drvdata(dev);
> +	int resume_ret;
>  	int ret;
>  
>  	ret = inv_icm42607_enable_vddio_reg(st);
> -	if (ret)
> -		return ret;
> +	if (!ret) {

This usually hints that the function needs to be refactored by splitting out
the wrapper that does PM and the core (current function).

> +		/* Sync the regcache again after regulator shutdown. */
> +		regcache_mark_dirty(st->map);
> +		ret = regcache_sync(st->map);
> +	}
> +
> +	resume_ret = pm_runtime_force_resume(dev);
> +	if (ret) {
> +		if (resume_ret)
> +			dev_warn(dev, "Failed to restore runtime PM state: %d\n",
> +				 resume_ret);
>  
> -	/* Sync the regcache again after regulator shutdown. */
> -	regcache_mark_dirty(st->map);
> -	ret = regcache_sync(st->map);
> -	if (ret)
>  		return ret;
> +	}
>  
> -	return pm_runtime_force_resume(dev);
> +	return resume_ret;
>  }

-- 
With Best Regards,
Andy Shevchenko


