Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703364;
	b=4VLYPudb5q1EwFKiTkogtfXs8KnJEQy86cUn6RrqXgwPEoekCGOR9xsjhB7ShKC4ukIU
	 bpwRB6DkCpGHLGMmMPeAWqKe890uCPS0uPIQB4ojtzrjLN+C/wE8Pwme4xBxga4CQEtnn
	 lcOuB9fOGjJo7kDKZ68f5P3zkNJRjuuF5STNn6BL3Pk0E7iHQGC7HIZmictGW+dbdjpiY
	 65MfP4FmcGaCUUw+2MeTTyY7nQCq4ymB+9FVGdojKpuXt2PLP7WQug94pdbQ3djc02hf9
	 kU/G3v8Ygf+ZRX1gF4CmoOnHzVmlJMfOn9lxLdCAqsofXUFZPfJ3YoJrp/dD0jfLQsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703364;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c8ypPy4IKCS5Exc1KP4Dj8WUmKLSL1iaZVC0m9BJn1o=;
	b=k5FJgtFa7qUByoKeshuME1fc73rNWgFYHjJx0XMhZQCL39903z1ISUrSoE2vHz+n4Wq+
	 1BR/60TJRSVIr1ZyWqXvU/zqVQPpEkEMCFIZV0MNSYaJJGaaq/PwEwj+ZHUYz0QesEF+A
	 LhWWkn4G/Jq4jm/HR5Mlz4DLdZUFXXdmfwjDi5yDsFZCi77Z4yrM7rhvG+FG44nlDqcaG
	 0w8wE9CrqMEvY09LGBBZNxrEFzgg/cV4+T2zSR2CXaz+thQvnYDyOlubhGcS1zSw5fUqX
	 wbRPvhTWaCZC+noYjfoVcjb7X0wxckU5DL2PHlYzNw44K3OQjIkCvM1Y8gNufwwkdCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IHRvKyhP;
	arc=none smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFCF606A31C;
	Thu, 26 Nov 2026 14:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFCF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IHRvKyhP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795703364; x=1827239364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LgFh9SZr6VHq9k/9mUzAWZHJXqYsP3jfd0eBkAxbe7o=;
  b=IHRvKyhPVyHKU0tnC2PylrE2wBvurvgmdUmX+1uedcsMvhEXi006d8tI
   eTAm0wGjx3DDI7TDWIwyT7VA2uRV0CWaYo65kpdIy6i4+2ogRKXavEj/c
   IzGT13Fnq7X+pIOB6ipBmWXuyisPJ1IBfpYdaZR4njMqL3sjDiCU7o1/6
   Og2hU7SutXUiFM50Z5tp5OWyW7tb7gluBkrbR01OxhREK5/zozY0tNL5A
   uX3mbDq5/aF5lDzwgWMsdezoHw/XGqqUUf/DTc+lmWLxZAcMcOF5vZNJD
   T1pZpRH2SjDjbcpWvUrxG3t8sOr0vFa3X9NxwewRdg1ZZhVG65frAKATc
   A==;
X-CSE-ConnectionGUID: F6waalXXQu6Ncidtkhgwog==
X-CSE-MsgGUID: Y+Jio3oLS7SJ+6xyf6DzKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4523916"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4523916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:29:23 -0800
X-CSE-ConnectionGUID: eJp3by4pQ5CXiEffueeoJA==
X-CSE-MsgGUID: i/E7VtbaRlSJdaCrjbuv/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="12512708"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.208])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 06:29:21 -0800
Date: Thu, 26 Nov 2026 16:29:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Wang Shuaijie <wangshuaijie@awinic.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: proximity: aw96103: report negative proximity
 diff values
Message-ID: <awhCP9c9O2QtZwIw@ashevche-desk.local>
References: <20261126053033.603086-1-kapoorarnav43@gmail.com>
 <20261126053033.603086-2-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261126053033.603086-2-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 26, 2026 at 11:00:25AM +0530, Arnav Kapoor wrote:
> The DIFF registers hold a signed S21.10 fixed-point value (Awinic's own
> aw_sar driver documents the diff data format as S21.10), which goes
> negative when the measured capacitance drops below the baseline.
> aw96103_get_diff_raw() divides it as a u32, so a diff of -1 (0xfffffc00)
> is reported as 4194303 instead of -1.
> 
> Do the division on the value as an s32.

...

>  	if (ret)
>  		return ret;
> -	*buf = (int)(data / AW_DATA_PROCESS_FACTOR);
> +	*buf = (s32)data / AW_DATA_PROCESS_FACTOR;

The type of data is u32, however regmap expects unsigned int.
I would change the type and leave (int) casting (yes, the change
is required still, I noticed it).

-- 
With Best Regards,
Andy Shevchenko


