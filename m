Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E91D307AF0;
	Fri,  6 Mar 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799668; cv=none; b=ZScz7HbPYQtf4iuZz+nJDMi8P/3IHUJZPS9yi4o4i905iK7sdprqufEs1xl1j4lkVjBZOhFc3OXY796awrtGayulWGAfGi9MWS1apxKK2ZnLpFbll+663YrQF05lONwCg3aick5kmpTYmfbpNupFsM2htiR+rpHhxESiaSLfRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799668; c=relaxed/simple;
	bh=sk3aFiNNV01W2ZP7tfl03RrvHBUIrc5sl5Y8fAP3MQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKvm3zrQIhOCMFsc0MGHfo5UAkGCm/czm569Dd3smz4znUOjigPJCGRp+qOP5wJZHfZqbwu1faNS+lNGp6qAS2rk55jTXnG5D1LnFXUvRxNo+eeX0PL5HIK2xL3rOQvfUG0DjU0dTgavmDUtlIIiA59ba2w6fWUslGNDIZ76EXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfQTrA3D; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfQTrA3D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799667; x=1804335667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sk3aFiNNV01W2ZP7tfl03RrvHBUIrc5sl5Y8fAP3MQk=;
  b=gfQTrA3Dg5jH1sDL18w+EHRM/vQjRyXSi8+QfBQUO8jcwXjHk/CtvM4A
   bULpeBQLPyIIWBWlpSsmBwtbD2hXbpCkpq1zK3IyLI/gqUFwPVXcD/U8M
   UpDueCYl7pjksqV3/fSDh1uDS1IkZ+OxlsekuLoVtROUnttjlebIBqiVS
   puAfPyNPM04MZ7Tla5GADr7f1L0wMxfXunWXZVFkW9lDOc2xJRNvr89x6
   K+lXPpxnUGJrpqhdppihMRjzYxT00g3KBDYIJRwSNnZ/WUxU0chj3YZkL
   qu84Z+b/U6eSMs9s76cRZnu7Y+YF+HygQXskec68u8rHQyagnmOctFngt
   Q==;
X-CSE-ConnectionGUID: Z+VZptZpRZCiWt/ct1ahKQ==
X-CSE-MsgGUID: BXKajHNpQvmMTJ/2IEVJyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="73779518"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="73779518"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:21:06 -0800
X-CSE-ConnectionGUID: 1HoNh9dwQcivIxs09y7GiA==
X-CSE-MsgGUID: txmm8NiVRa2Yqbz/6Dk60g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223120743"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:21:03 -0800
Date: Fri, 6 Mar 2026 14:21:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 6/6] iio: adc: ti-ads7950: complete conversion to
 using managed resources
Message-ID: <aarGrAtrVbJgxoK8@ashevche-desk.local>
References: <20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com>
 <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-ti-ads7950-facelift-v3-6-a23fdd1a079e@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 11:21:57AM -0800, Dmitry Torokhov wrote:
> All resources that the driver needs have managed API now. Switch to
> using them to make code clearer and drop ti_ads7950_remove().

...

> -	mutex_init(&st->slock);

I missed seeing the + lines WRT the above removal.

-- 
With Best Regards,
Andy Shevchenko


