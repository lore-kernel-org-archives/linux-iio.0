Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6439D6F4;
	Wed, 29 Apr 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777445950; cv=none; b=bySmjmebNv7U+iNeXbZHU7TPX1lMu9O2Oi+0untxbEHpSUGd0C0gwLKOa4riEGg+VOukOrSYZ+ty9+UC1VvpjPtiD8G/025H6mrDyhjlxTiFHDLamE2QItmIpnD14+rSyyoDQJHJEUJ0iaqu392OmOOqLU1WmWid9U7LBk3ZAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777445950; c=relaxed/simple;
	bh=4eanrgIpPu0mL/zJSGoZXRCMHZPHe++1mCyRrVKTLiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imDuoNtORviSvCl0sISWdrn10l/Az0K3UmQweZvhW3MZVKfAQ1wQToVyDZVCgg9ipFUlGsLSkwIkMPxoAuGFW+/sLVXnG9AIfnWMI/yAYcIfgmqg5BV30Q/NLWdqMqutI+8iaKBbQjSykZVnJD33yscQ9Jhtv0PmS1F6TAxOF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vq6AndB1; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vq6AndB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777445949; x=1808981949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eanrgIpPu0mL/zJSGoZXRCMHZPHe++1mCyRrVKTLiw=;
  b=Vq6AndB1N6+yoFqKBQ/Xb0b2KU8kjH84fOy2OWmvTbguBFZ27hHOhX76
   5ICWHr1wrlWkv7bQ/rKmVtFLCheuVftXP1NzQIYYqfAn7jG4Fmc7i3ts0
   mzAnYJoVcSbWGyX4cK4X4OK/glbFtRUGLsAEtg4zunOZ8UVv08D5KEoT9
   NNu5AT4s4FsZu5rJeqJhXvMXwbP9Aidf1O6vfzhRUEiQHY05/LMKeLHoG
   fcBR9aIcf8wcT1SLfJ5Au/X6I17ELrnfovMK93wpqJBuDviDbJmciLjph
   QoL8zhGY7gsxboezqVNiXZMY2YZ8kzxQJ9Sgvs+OvQf0hK76PwPQuTkpU
   A==;
X-CSE-ConnectionGUID: NYzD5fgTRq2sludW56t9NA==
X-CSE-MsgGUID: qXnOBRRTSPiilATJWDVGEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95786466"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="95786466"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:59:09 -0700
X-CSE-ConnectionGUID: Ij2TSfrsSB6ywZKv0Uo6Rw==
X-CSE-MsgGUID: mGf41k8JQh6r4uLw8XlJEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="239173078"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:59:05 -0700
Date: Wed, 29 Apr 2026 09:59:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, andy@kernel.org, dixitparmar19@gmail.com,
	dlechner@baylibre.com, nuno.sa@analog.com, waqar.hameed@axis.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v2] iio: light: stk3310: Deal with the ps interrupt issue
 in PM
Message-ID: <afGsN5RDDQJZt8ok@ashevche-desk.local>
References: <20260428192213.7c5c80e5@jic23-huawei>
 <20260429065123.205449-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429065123.205449-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:51:23PM +0800, Miao Li wrote:

> On the Inspur HS326 laptop(which integrated with HiSilicon M900
> processor), if the STK3311-X chip's PS interrupt is configured
> in "Recommended interrupt mode", the interrupt cannot be triggered
> normally after waking from suspend or hibernation.
> 
> In this case, neither disabling and re-enabling the interrupt nor
> resetting the PS threshold register can restore the interrupt to
> normal operation.
> 
> If the interrupt is disabled in suspend() then reset the PS threshold
> register and enable the interrupt in resume(). This resolves the issue.

...

>  	struct mutex lock;
>  	bool als_enabled;
>  	bool ps_enabled;
> +	bool ps_int_enabled;
> +	uint32_t ps_thdl;
> +	uint32_t ps_thdh;

I still think we shouldn't add more {u}intXX_t into the drivers.
Just add a patch on top of this to clean up those types to use
kernel regular ones (uXX/sXX) instead.

>  	uint32_t ps_near_level;
>  	u64 timestamp;
>  	struct regmap *regmap;

I also haven't seen the response on `pahole` run. Is that tool happy with
the proposed layout?

-- 
With Best Regards,
Andy Shevchenko


