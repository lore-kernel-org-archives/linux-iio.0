Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B98B273D8D;
	Thu,  5 Mar 2026 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694288; cv=none; b=SjNfHmfCr05QvdSyDLrdLYIgeMv0rar66jLNONJPir35iSDf58vSdF2F4oqwHOa+VEv8qB2Pd3UQtGvApn712QvdOfTAxoYUhtyH7rEWxp4o23RCwQd2IabEmlj/bWTKxah5HfDdgaZ9zRTcILxdd5EsLwYNRlWU47VfvFVkOms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694288; c=relaxed/simple;
	bh=eVeajWinRoEMygc4R0PdwmCsritkll13QqXUmqKyYUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zw51eCMf4RkNNWXvYr6bp0eVnWOLuIf0fZkBPQUE2NQL2KecNdjOGjnjLsptam5exlkKhpdjXve7Dg9sIny0zqLLFPkRIXq3Nj3O2d7pxukaEeRxHA9VSlDyW34ewqLLq08khbasynIi8UAG2Xpbdx/7Ks36ZVlrbxX4prT5KnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZNQkbzuo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZNQkbzuo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694286; x=1804230286;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eVeajWinRoEMygc4R0PdwmCsritkll13QqXUmqKyYUo=;
  b=ZNQkbzuoNZ0ej8ngLwwvkcDG6J/V9cq0pihx9cHT20xAOQ3sMjAz8zx1
   p8Qv1GQxkiiZCplcN0sTkcxD13pYem8K52dZMNVRlz9n45iwJDp2n31WM
   /H0Pg04zaDNvLssTm/SqoVVTTi5C/M5xVqbJThxtv2NfFi+QWfH/73vSf
   +ajjkb0CpYUulheGowrL2epwjNFl1UoRAruHrVrR5gx0l58FNnQTNLxro
   5SYwxO5iY/s+lFUJiu8PU3zp5nx7418nNrM0cPPblxHdXeOJXtImOJmz+
   RG6wSwuictCJC8HH2GrawsA3yvAP4yP/L3w9FHBzSGJscAXNvsoLTt7Dh
   A==;
X-CSE-ConnectionGUID: g6WfQy9VSwen1chGGGGm0w==
X-CSE-MsgGUID: sC/luMutT3yWUpdKWwmATw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="91344044"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="91344044"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:04:46 -0800
X-CSE-ConnectionGUID: pCkYUQ0CSHihgOSAclg5eQ==
X-CSE-MsgGUID: dtjLh/GNSbiRSzLD6tGVzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="218728108"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:04:43 -0800
Date: Thu, 5 Mar 2026 09:04:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iio: ABI: Add partial quaternion modifier
Message-ID: <aakrCIJBdHb1T30Y@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
 <20260304080706.2844472-1-flavra@baylibre.com>
 <77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e10517-2b6e-417b-95d3-185d3a067ba5@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 04:35:39PM -0600, David Lechner wrote:
> On 3/4/26 2:07 AM, Francesco Lavra wrote:

...

> > +		- the quaternion vector is normalized, i.e. x^2 + y^2 + z^2 + w^2 = 1
> 
> Isn't this usually written with w first?
> 
> > +		- the rotation angle is within the [-180, 180] range, i.e. the w
> 
> Best to say the angle units. IIO standard unit for angle is radians.
> 
> > +		  component (which represents the amount of rotation) is non-negative

Based on these, maybe the name should be

  normalised_360_quaternion

(or variations of this)? Actually "partial" quaternion some articles use
for something different as far as I can say.

-- 
With Best Regards,
Andy Shevchenko


