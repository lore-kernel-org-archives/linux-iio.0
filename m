Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA92422156C;
	Mon,  9 Feb 2026 13:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643932; cv=none; b=niY5FOiejGA35rCw8uWrSNZBNk9AZU6hUHiXrAsW3xDRAVYoY71WnHlnTWTsvDkx4lV/+SviMUJzysRmY8HIRKZ63/OC0j3JAubnjmxOhB3hm4XgbvbGMv2GIFEkdnKRqFnEr/nGPXHsm+SilGjJJ7+MBO6EyQFXe5fpigBSJDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643932; c=relaxed/simple;
	bh=imGJywAsiB+mcMsj+sJWpg5PKXxvQguvl7NhHz3fxLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLwREjUglTui4fauhWagpv/YQfRsnqEjgZ3iolEOHxPE8ImM1un2Tbw+6Guv8vcEq6RHSCOSDQfOmVjMJlOhvley4cenKxFoaypTVEJr4hUBDMl8xH+Ify9fFfkuRoOW4e2LcKmPRRR8WclBvjd8hhN/S7CXOUgPozW49g+WpIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gn6h+ymA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gn6h+ymA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770643932; x=1802179932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imGJywAsiB+mcMsj+sJWpg5PKXxvQguvl7NhHz3fxLs=;
  b=Gn6h+ymAhYdSyrzumUFfVWrZDMIbHamCkA3VKSFCYZRqbWWD8jmY1/bQ
   1xWkj6Yfn/JhwWMfqV4rF48YKkh+Q/1hjJ34rIbl3gm3TUQN+EhSPG9nM
   LLtie8YCd1DO8mL/8Wyd8LOknurZLScbQG3KUXzYd9p4l9bmaislUunSM
   8a+Oqp9klaPQtqVrSnn0N12R0s9qlTIISApWESJzg2z00GchYEj01pdOH
   g3y2nZxKSFQXKXuSFYA6f+bEM7ghgaDEF0u2dG0YqbvL/WmZBTjkq03Ug
   XsQqf/GM+QImLpSZ9no5a1CjpVSV29rhjtqdrRIiXoAa6IThGxxUhYd5D
   A==;
X-CSE-ConnectionGUID: oBvUDpZtQYaG9ZfXrEEM5g==
X-CSE-MsgGUID: iT0jOQ63Rd2aenIyESfCfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71656012"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="71656012"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:32:09 -0800
X-CSE-ConnectionGUID: QWYRlPULR5meJ5Z2hPYCcQ==
X-CSE-MsgGUID: mCTIl6UcSWaXM3zHVzLlCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; 
   d="scan'208";a="210891743"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 05:32:08 -0800
Date: Mon, 9 Feb 2026 15:32:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	"Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/2] iio: gyro: mpu3050: fix pm_runtime error handling
Message-ID: <aYnh1IjCfeZz7BH-@smile.fi.intel.com>
References: <cover.1770636034.git.antoniu.miclaus@analog.com>
 <CY4PR03MB33997BF46685A6E43BF40EAA9B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR03MB33997BF46685A6E43BF40EAA9B65A@CY4PR03MB3399.namprd03.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 12:13:28PM +0000, Miclaus, Antoniu wrote:
> > -----Original Message-----
> > From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Sent: Monday, February 9, 2026 1:33 PM

> > Fix pm_runtime error handling across the mpu3050 driver. The existing
> > code uses pm_runtime_get_sync() without checking return values, allowing
> > operations to proceed even when the device fails to resume.
> > 
> > Replace pm_runtime_get_sync() with pm_runtime_resume_and_get() and
> > propagate errors appropriately. Unlike pm_runtime_get_sync(), the usage
> > count is not incremented on error.
> > 
> > Changes in v3:
> > - Rename patches to focus on fix rather than API change
> > - Add Fixes: tags
> > - Collect Reviewed-by
> 
> Sent by mistake, only the cover-letter. This patch can be ignored.

You lost me. Did you send the cover-letter by a mistake, or
the entire series? "This patch" is absent in the cover letter
and for the matter of fact, there are two patches in it.

-- 
With Best Regards,
Andy Shevchenko


