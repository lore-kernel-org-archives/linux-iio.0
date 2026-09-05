Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F51367B77;
	Sat,  5 Sep 2026 07:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788594714; cv=none; b=qYvb9sgXHSNqVxnEterNip3t6Z+10VBuYGqymJ98ee3zMdJFiLYBcJYi1Ywt3TwHDfZiLEHu/kMLCmqlO8uPbFls8BUjYGVKOlDdzQtrFs+gJgda1ktbmq6jw14PixXr52G/rSlKuRE/LUzGN5LAlxDL3qd2TCE8ilmkIQx0IdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788594714; c=relaxed/simple;
	bh=LWY8tiTk5qnc52EJdSFD7boNBmN8diWz2g/O0olX4V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjW0uspaRycW5SrMXeLfnjzS5cBQWTB/agMxjFCWyW8KSw7R4dPjQhEHQyFKF3/nXi+4f2IpVz4JqPH/Ks0yejRTJBgs4kLgTzssass8Xe1CDJ7F9BWUu0oNmZPc4LCbzV28iWy8BHWJNOBBg3GiuDSzvlaQ25DRkiuZoXdfC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VtMkae3P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VtMkae3P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788594713; x=1820130713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LWY8tiTk5qnc52EJdSFD7boNBmN8diWz2g/O0olX4V4=;
  b=VtMkae3P8MgViSUI6E74FruC6j/1+g88Lj4ZwlYGbIlSijX2eZPfJ8Jd
   1poU2zTyfJhAJBnfhZiJ3YNRGq8FaF0MUsqQOfMfc184QZem+s+T2cUdp
   YsuPMxjWqMOAQHPzp0fLKYEDZs5zIK+7ietApAlxD5s3ulctXZW7AM63k
   U2tIgw2eaht3HCxp94uyK0xyYo89pKpwbmVm87wKo3PEE0/WsCZP+gI/y
   ehPE+M9qtJa19oqFjvUJTBn+vj0EqnE7E5N5v+AQ4IEA5LuyP32cmKBhc
   dO05/l8HNUSpJljDbuTF9FNPOKh9EunrQgjbeBBAeEbaEEhoOZd7shNe1
   Q==;
X-CSE-ConnectionGUID: rQmC41L4SdKXhAVfrjQ55w==
X-CSE-MsgGUID: 3eqm4TMXSxeIRdzNm8LcbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="111862456"
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="111862456"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:51:53 -0700
X-CSE-ConnectionGUID: xXt3xrzWTxiTye9NbUNLSg==
X-CSE-MsgGUID: xrGG1af7R6WKtkAp3Qq/Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,263,1779174000"; 
   d="scan'208";a="273787017"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.105])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2026 00:51:51 -0700
Date: Sat, 5 Sep 2026 10:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for AS7343 multi-spectral sensor
Message-ID: <apvKFENwRCFrZhDO@ashevche-desk.local>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1788586814.git.marcus.yu.56@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 04, 2026 at 10:53:24PM -0700, Chang Yu wrote:

...

> Datasheet: [1]
> 
> Link: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf [1]

This is a Datasheet link, no need to have three lines for it, just

Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf

-- 
With Best Regards,
Andy Shevchenko


