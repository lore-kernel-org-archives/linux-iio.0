Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793457816;
	b=pLybPuZOqMmPxnh/riCA/r+DLpEi9D0gS+nSTzxtSOJrP5eP/VbMBHUG4kXweUNuF4Xn
	 4dFykREpUSmuUk57zULzELrbjzAkuNYb5l2snxu9r4DRlY7X2w47lFcOLA3HYh+/02RtX
	 AWO5AizBP8Bxfovu7cd07s0J+TPp+2FCbwxJIaa4/BYwAO8GLKygMlFrAd4DJ44e3VsWg
	 WxTwhyQftJjMZAie0H1XshTABAvdvAkjb8g9S7b90bPnx4ERJ21zTYLgTPtqcO2mgk7id
	 Iylfw1vvRnDdgx+hDD6mGGjFSLqIgAqk5mmB14MYQqM8WIMVWXXHypl7WB4NtaxSmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793457816;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Jp/qbABu2xYdYezApmf9e3cfkZs2Xefy/ip5fPGbGM4=;
	b=n46T2x7ck8jMDWIM5ovg0t+ImbJ+FksRmXDyIoisM/aw9i/5F2LHBLVUxgB/zLeOw/id
	 WppMREEZAbpnZy9M280TqdnGm0JtwiY/YS7qunCXAFrATj88mDBjEXmShG7b3CLRxXDW2
	 Cq2f6c3cDbWWdQoyUCSLH3TTuSdkSrWec9vFuneFr7TbmZuk6xTu0VmSuLexEjg3tsDfL
	 mkM7a7dz3WqHAn5nZcKopel7wEoABMmEWfZgao8E95zzpU8EzVKV2jGDbhzuOAm4IzKCf
	 xk8EduqmPNi6M78Dghr/4+hKjqqqUInk8DXj4B0VVAVQxzNV8q+0/X/gvm+Mh7i6MMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oLBUOrac;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297F2606A31A;
	Sat, 31 Oct 2026 14:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 297F2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oLBUOrac
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793457815; x=1824993815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lDwww20U4ajtSvt9y5LrgWElYlKiEjSAEyvs3/05uHQ=;
  b=oLBUOrac1ITSxFBJoRyIkQoXpE0ykZQ/viC9mxh25aLKU7pV4wciC7ZV
   CDW0VF28NPo/Pq0MUiUIw5ofEbRar9aNRhXuKhfoWVb7lz+/zXnrpAJSr
   LXI7lTJgzqPHn6yz1QL76LKX1fCdTmfuIcXbZr+MAN4uOzxwY+P5WYfU4
   ICA8SnMAna2p8kn64cNEMVP+I0idhkcNw6z25+WdcMxPVDgijSdZ2iOuT
   he82BIkSZd2haujfxYL29W3Zh8MMO6ePLvlYDtNedrSu8/ZUzi4PgpEjo
   MugpZY25tjnedd0INcFzjwz219DYwWz71UTvFyrbG8CWlXGQvMJq1Sh+d
   A==;
X-CSE-ConnectionGUID: iUSRZPy1TCm42w+eb2lFug==
X-CSE-MsgGUID: Z+n4N9uaR76ht8Mq/6DUiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11952"; a="2196827"
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="2196827"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:43:34 -0700
X-CSE-ConnectionGUID: jnE+Du3sS3SqwPakrvpdww==
X-CSE-MsgGUID: pLNCF1rtT3+3bc9JXOB+Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,188,1787036400"; 
   d="scan'208";a="7511512"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.127])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2026 07:43:32 -0700
Date: Sat, 31 Oct 2026 16:43:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marius.Cristea@microchip.com
Cc: tristmd@gmail.com, jic23@kernel.org, tristan@talencesecurity.com,
	nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: pac1934: validate ACPI _DSM return type and
 bounds
Message-ID: <auX-km8yi02_me95@ashevche-desk.local>
References: <20261030123528.606107-1-tristmd@gmail.com>
 <6eb7177ec4730be9307a3f4d29a53a952a7f7bbd.camel@microchip.com>
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
In-Reply-To: <6eb7177ec4730be9307a3f4d29a53a952a7f7bbd.camel@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 30, 2026 at 04:32:51PM +0000, Marius.Cristea@microchip.com wrote:
> On Fri, 2026-10-30 at 12:35 +0000, Tristan Madani wrote:

> Reviewed-by: Marius Cristea <marius.cristea@microchip.com>

Thanks for the review, but we don't allow min_t() without very good
justifications. This code doesn't need that macro to be used. The author
of the code should first get a bit familiar with types and integer
promotions in C programming language to understand what's going on here.

-- 
With Best Regards,
Andy Shevchenko


