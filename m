Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327233;
	b=gdj+pibLKb/MWOY4EBBUVlbhrTA+7llCsosnYSn2li4nAOTKcP30+pI5FI2C3bB8XEbw
	 uwgFGUjqF2CFU3Izai5g81OYXFAdICfG4Cd0477nOr7ZYRMW1BT+zm/UKxsm3STQzVTPB
	 5hy8rhlgEXhZDeLBFBMRmiaWH4d9DYdLeT1TrzXu+v1BPJOxky1duK3CFs2Y2ulhdJAaF
	 h+ltoUP8zPmJpUcAs2v05XhKBv/wWav51wA22S7gjqXcuev6BjTSoVdRBluTOdhSnEKWT
	 BLlGvf3sEfPFSZGPhxi1zHFFb7yfya50uF2IaHVkECER6d5YEudPEF3lIprTeOAw43A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327233;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oHP5B0UlB7/SoTwhxB0AOYNlEwskAwU+hgd9yWW6YwA=;
	b=hHlJcA49ClLG9M7WV92YDcJ8xoHvhE9CgIo4Lz0dgt5pxEtEXDgxuKA1t04k3+gLZx//
	 6OuwNkqSRQF0CJilXzO8Mi3nWPemzc0Z7rjWsowgUnLJ0RejJiRoGkgfkK93Afsun5HSf
	 8etiL8heloofpdqyGhO/AToDMailMcJszRBlvLxx0LIU7jX1wiqYm1tCdeeYOlZuzXV+p
	 kKQnxJMlPEdfQYOQ6cUXcFUgc6zTnSoqw5uUJu5Pk7whKZgETMs1uR3jfpwUEFjH9tFjv
	 lkmgzfGrjFMEK84rSLor5Vsspf63fqiCdOrL9qKwB5M+ivTOMvAWCb7yS/5bRf5N3JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iuhyK01/";
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253E606A32A;
	Tue, 10 Nov 2026 16:13:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C253E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iuhyK01/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794327231; x=1825863231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b+GfY+61OeZggR11g46pkfalBMS7RT2Vza+al9X93H4=;
  b=iuhyK01/N5bPFL6pJWyckSnPXskOBFd+00DROYC4tpEDnjevG0gM8yVj
   roIIv8ewdkZ8Z0al1klzwil5rIK608Lprg8ffxqcx5dYfNimORPk/eht3
   ghmGBEl4LEaSxnsg8rhK3dkRXqYNSf8vDiiE/gsU59rvRyeRirfegiWob
   0mkNXsiqQMKAe3US34OkzwDIYSDjgpWOvGFSD+Wq6+2Ut4GtU87KoJOWc
   C9ozSLCrtMYfbgX6u7r+6Ggg7WoARqdePe/UcBRVKUhtHCFgtIHU0Vwa5
   1d42g9dUIApWAqpsuY7Ec2lItI5/PKTH/soRQzHYMf7iL6NKz04MEHlqF
   w==;
X-CSE-ConnectionGUID: bkxSH62jQSutgqTU5vg8Pw==
X-CSE-MsgGUID: mOE50LdpTE+6selZY1buEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="2949302"
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="2949302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:13:50 -0800
X-CSE-ConnectionGUID: OLMcxOxJRmK8fg92V8WCXQ==
X-CSE-MsgGUID: tTtacSy3SlKPGm6b8dLczg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,206,1787036400"; 
   d="scan'208";a="8518342"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 08:13:47 -0800
Date: Tue, 10 Nov 2026 18:13:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v5 07/16] iio: adc: xilinx-xadc: Use guard() for mutex
 locking
Message-ID: <avNCuWIuS5iFrId-@ashevche-desk.local>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
 <20261110050201.1850399-8-dileepkumar.nagavarapu@amd.com>
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
In-Reply-To: <20261110050201.1850399-8-dileepkumar.nagavarapu@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 10, 2026 at 10:31:52AM +0530, Dileep Kumar Nagavarapu wrote:
> Use guard() helper for mutex handling instead of explicit
> mutex_lock()/mutex_unlock() sequences.
> 
> This removes the need for explicit unlocks and the
> error-path labels that only existed to release the mutex,
> simplifying the control flow
> 
> No functional change intended

...

>  {
>  	int ret;
>  
> -	mutex_lock(&xadc->mutex);
> +	guard(mutex)(&xadc->mutex);
>  	ret = _xadc_update_adc_reg(xadc, reg, mask, val);
> -	mutex_unlock(&xadc->mutex);
>  
>  	return ret;
>  }

I believe somebody already told you two things on this:
1) make guard()() be delimited by blank lines, so it's visible at a glance;
2) don't leave unneeded variables, like 'ret' in this case.

...

> @@ -101,9 +101,8 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *va
>  {
>  	int ret;
>  
> -	mutex_lock(&xadc->mutex);
> +	guard(mutex)(&xadc->mutex);
>  	ret = _xadc_read_adc_reg(xadc, reg, val);
> -	mutex_unlock(&xadc->mutex);
>  	return ret;
>  }

Same story and so on...

-- 
With Best Regards,
Andy Shevchenko


