Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D2286A9;
	Thu,  5 Mar 2026 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694438; cv=none; b=nqsOm9LGaa/QDWXZY0MDD9ZywRu5q/1+85SpDCfYgWR254WkhrOgoVzXOud4wYxkZ+x6kngE4LvWTzDgK61XLBpU9LXgrVlnhdvM7MS3CoZJ6QuaZHANPNCxkp+RW+UpXeUk2Pi3sUdKQVrk2Ca7hGvyj577JUV8ssJbM9G6hhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694438; c=relaxed/simple;
	bh=ykPG25XRAmCgWWtavm3fTfLHkIVCpVBqLS2NaPGB1z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F6P2yYQxjOt1vYv6GT0KoVwe2Ub6oxHlMH8IkpcSyvKaCKPWGj6N8aL2/V1MWCtRoFQ1ep14MfV2q7MagbqPGE5sWiLHMdtDntoFAcnD3DTN9MLHqLcFTtYRZ7CttMWkIh72DD2JkropPlgh5WmPbcJpVayT7XjQfPrHE6G9dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4kqR0FY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4kqR0FY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694436; x=1804230436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ykPG25XRAmCgWWtavm3fTfLHkIVCpVBqLS2NaPGB1z4=;
  b=N4kqR0FYfJXE+1ur2uEkEnKz5boTh8MaczfJqOKjca6QqROCl6iptLBL
   jhXDzXUzBYZ4/LJz+/4AYC9xlcShGJwIFEBUDTUhf6ExtuG6uw32MvvaE
   BZFbr8vxMIXq+fuiDVwzkGWRhxp1IW1989J4sRu40ysZhVud9nyyfMhLN
   wfDBswI9cjvblm6OKn/76iV+fVOY3Z/BtyDPnXLMco73ERuIfeOQ2MIRO
   Sot/EjuEdneH9FGRMdQ7hA5qtku8NebBgiqTYeIwpGGbSf7S35l3NyQi7
   YtmH2CiSr4DUEXvWa7GKiqdwJbdscb3GfzYb8MxaFyGOmwRBmMi35TAo9
   Q==;
X-CSE-ConnectionGUID: yzDchKQ3RfuLgkIRb/UM0g==
X-CSE-MsgGUID: 4OJfXoRvTr+1Ymxg246o2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77643010"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77643010"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:07:15 -0800
X-CSE-ConnectionGUID: 6QEa+MOJQqGQ7QRQuxMgwg==
X-CSE-MsgGUID: UNoC72ALRd+ltsFEAO8Paw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215864006"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:07:14 -0800
Date: Thu, 5 Mar 2026 09:07:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chunyang Chen <chenchunyang0908@gmail.com>
Cc: kuurtb@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1018: fix type overflow for data rate
Message-ID: <aakrn40DOvSdRgQP@ashevche-desk.local>
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305021550.120614-1-chenchunyang0908@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 05, 2026 at 10:15:50AM +0800, Chunyang Chen wrote:
> The variable 'drate' is currently defined as u8. However, the data rate
> values in ads1018 can reach up to 3300 Hz (e.g., in ads1018_data_rate[]),
> which exceeds the maximum value of 255 that a u8 can hold.
> 
> Change the type of 'drate' to u16 to prevent integer overflow and
> ensure the data rate is handled correctly.

Needs Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


