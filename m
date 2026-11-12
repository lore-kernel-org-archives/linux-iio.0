Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499421;
	b=frz3Jrkf76YWezs3adiMe5xIlhne6RTpXtzkk0oAh/ZAoKUJQPhPGJfxG2TnOfex2YL0
	 W2UuTzdTq+AfVLLihPbyno4jfyiNnZJai6IL69FI6lcEPFSwopQHlwfST9tHCYYHiqbN/
	 GULOUi8DusQ5QO2n/LZR5rQSsjCh84owg+EESJm0LhbrA/vfR8LphSw+MkK5Z+EVVKJJN
	 KE+2+eRpugrMQatkVAfisY04nw1KLMHdBAOseCknpzxt32yjg1f6Gi0ZlMCzJR/IMcjgG
	 PmMeFt/pff5ZXsEz+itSu7YfT/m0O+XhXYKh9wTVRAK6Fg6V0QzxG7NAYpVV/IWneWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499421;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=OyE71Zkb3/iNBTw7B3Y5CiHqSYL/RCxpNgb4AnO35ec=;
	b=Nn3XXjk8euIt49oPiB2KE0yRDiERwC599NYHcPvDC51vccxFKYxEDUbrYr7nSeKT7wtd
	 mY0O9p9/txbokmI31TT1MojOmdK4XGkFj80vUVf7ljpGIl4WWIoPj+AQOlJDJl4LOvriP
	 8qECSnyQ8SmekPU5TjF2ugRCHBjT8E4Qj+HZ7kvvEdSUhqGGLbKARqBmhcLAcdEU02sNJ
	 u0CkNHE6LrFtuoZyFAwmJs3kzEpsw6opwnSf32P5CfJnmjAsppftpN77ZZImMaZAERnnM
	 TiZG6JUZESakB52nYwvDFXuNqx6DWvtdb1WnBqZ5NkWHcQqyetka0MxbJ1SzFJQyW9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKFzgVtc;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DDF606A327;
	Thu, 12 Nov 2026 16:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6DDF606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SKFzgVtc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794499421; x=1826035421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vgX+TuR+T/y+mCUnRazPzYVyOyYgWRIMq0F8DIw16KI=;
  b=SKFzgVtcUjg9sLRbtg8w+UbkNPyZG6zxMBhR63u0ghkn1yLtvN9f74/Z
   08YL5zMrHKQYhGv67GHTzUqoKJU5ixnkJOqtRdZsAFpvTkRVr2VnKP0AE
   DS8e65+/kn2XIVlBRMJ+vppUlh1ewAl/3e8KSjIzQfeJNWdH5mrQ9vJrE
   cndl4q2pyZ98I76mxTm8ZX8NeixgF6emnFjeVoL0sF2t+e+doAKCcd8PL
   WEM/KhMTtoqtXmE2QsyPSvtg0ymPJjyPdMINVEBC1w5DnCKaJq/N0BNva
   xLvDEkkr/T39L0XSFXVwLRVENxuzZahEwvexymMl7/qWwcsh65qFhV1Xu
   w==;
X-CSE-ConnectionGUID: aVBcHn2fQSabovI4jpXDTQ==
X-CSE-MsgGUID: EblE1RFQTc+g951iBmgp8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3373954"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3373954"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:03:40 -0800
X-CSE-ConnectionGUID: s55KVvyZSauzH6MOMc2QLw==
X-CSE-MsgGUID: MsNmaZNaRfmMDF4K0cEDIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8865964"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:03:38 -0800
Date: Thu, 12 Nov 2026 18:03:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiostat: lmp91000: Handle configuration write
 errors
Message-ID: <avXjWG56o9_O7x9o@ashevche-desk.local>
References: <20261112071747.154626-1-zhujun2@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112071747.154626-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 12, 2026 at 03:17:47PM +0800, Zhu Jun wrote:
> lmp91000_read_config() ignores errors when unlocking and programming
> the TIA and reference registers. Probe can then succeed even though
> the hardware configuration does not match the parameters used to
> interpret measurements.
> 
> Check the configuration writes and return the first error. After a
> successful unlock, attempt to restore write protection even if a
> configuration write fails, and report a relock failure as well.

...

> static int lmp91000_read_config(struct lmp91000_data *data)
>  {
>  	struct device *dev = data->dev;
>  	unsigned int reg, val;
> -	int i, ret;
> +	int i, ret, lock_ret;

While at it, it's better to split semantically different variables:

	int ret, lock_ret;
	int i;

> +	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> +	if (!ret)
> +		ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
> +				   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);
> +
> +	/* Restore write protection even if programming the registers failed. */
> +	lock_ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> +
> +	return ret ? ret : lock_ret;

It doesn't use any guard()() or so, hence just make a goto instead
(and use Elvis):

	ret = regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
	if (ret)
		goto restore_lock;

	ret = regmap_write(data->regmap, LMP91000_REG_REFCN,
			   LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_50_ZERO);

restore_lock:

	/* Restore write protection even if programming the registers failed. */
	lock_ret = regmap_write(data->regmap, LMP91000_REG_LOCK, 1);

	return ret ?: lock_ret;

>  }

Alternatively, wrap the existing function (this will make code cleaner in some
maintainer's opinion).

...

In any case there is a question how may the caller distinguish the error from
register write and from the lock restoration? And what will it do in either of
the cases?

-- 
With Best Regards,
Andy Shevchenko


