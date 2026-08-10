Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B6427F9E;
	Mon, 10 Aug 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380035; cv=none; b=ExPf7vRhQPgIUF93GPXvnIHzK5HyLoO39vnETUoigvwCw3d5kkjGFLgUpVWd06T6zXjPRN1YZHTwaTYMQk4dD8L7drjgMToyK8b75HUKCd7wE+csPYQ/F6sd53QP4r9aIN34cAp30skFFDQwY3vmaJGsUJnuVtn7tsgBa8ZPxuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380035; c=relaxed/simple;
	bh=6bka94qCXLkxxKxYMGy5L/+fdjutV4evZrWjERQmmK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVw9/G1JZv4bCKQaP4B0V7OqrQxZLnYjVKAYq2D2y3/cTE2RXR6ipm5RGyhq3NmeuRoT9H6qygG3OOaVltGVmmRFMJL+IaV2aUvOpbMFyO0B4/S6dBGDtvXC2CgHzlPVsqeNrWrrfmSScfZPIdqYegkWOo0FaocXFpEsFCHD2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNHFv1MR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNHFv1MR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786380034; x=1817916034;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6bka94qCXLkxxKxYMGy5L/+fdjutV4evZrWjERQmmK8=;
  b=GNHFv1MRLFkxaRwWv0BpT2oDICB1z/AbtFA03tx2t+QOtVI89AYotxqX
   DJATuwFlDGZUOEFgoLEh6za49yIoHB20Kiw3MWWeGDSkfj0Cndy+6fV4M
   wXS5jTVMEV8T6mR4TdbfuyqDvBTSL/uoKiwYTwXIpqI7zBI9pepBfA29s
   xcjExmxqyh6EPdDgylBI7mOo0Hes19CnYY7eX0qpi7RvRuGKy7Ko6GZPu
   XuqixbNwSNSitZFZyZg2HqQ2xpoWpoLynYY54Edop0C8rp6dEVXyVItPh
   Yt45s0xY6Pxv0PTWhCFQzZww9BPXqS62oiFNhpO1Pgi+2gm//397WW25s
   w==;
X-CSE-ConnectionGUID: DHJze0vtRKqKOW6je8TczA==
X-CSE-MsgGUID: JhOChRpdT3GzV2lH/y3ecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="104432282"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="104432282"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 09:40:29 -0700
X-CSE-ConnectionGUID: 6PKzKGuNRQa6Y9gd7Espyg==
X-CSE-MsgGUID: D1ZNIAGpShekzEIKt8WNsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="286503623"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 09:40:25 -0700
Date: Mon, 10 Aug 2026 19:40:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v3 3/6] iio: adc: xilinx-xadc: Split driver into core and
 platform files
Message-ID: <ann-96_VVW6mGzJX@ashevche-desk.local>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-4-DileepKumar.Nagavarapu@amd.com>
 <amuqm5qdzXqKutPS@monoceros>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amuqm5qdzXqKutPS@monoceros>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 30, 2026 at 09:52:24PM +0200, Uwe Kleine-König wrote:
> On Wed, Jul 29, 2026 at 06:24:52PM +0530, Dileep Kumar Nagavarapu wrote:

...

> > +#include <linux/mod_devicetable.h>
> 
> I wonder why so many people recently add <linux/mod_devicetable.h> in
> their patches. Is there some tool that suggests that?

My bet that this is AI agent suggestion based on the previous numerous
recommendations to include it.

-- 
With Best Regards,
Andy Shevchenko


