Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E493FC5B1;
	Wed, 10 Jun 2026 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089085; cv=none; b=HPwUe3qaL4xyDtx31a+oh/OxQhkSg/YFSYcDM1gRcmx8/nvaQRsads7JwRZtNjZtxoqwbhLQUglOF7McskPq0TL6sTRldemFM4Lp9lM2EmDo9YHQdpW/ux9ah0EMRjVW1JZHveM++EFS2KpOZ2SIAvFeSiZ9LMJIklDSR2GqWns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089085; c=relaxed/simple;
	bh=WSksGmD4FHjjJwY5MvvQ6VCQmu+xswe/bxSVMLsGtmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1jiGDjfFfBaSVgQ+/yXZXlxnGJUj736cJHP5cMFxzycQYyeNiLvpePDLd5ZcL2Ess9jhWlBuI9L1TtTeY2AK/b4WYQpDHozlX+s8W56X8jt6TIcyFRbsQ6tQjWkJyKSTDtiI1PG8NjXK0C+42WPhq/q7S4WL+hDdb7MoO0P23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIRAM210; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIRAM210"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781089083; x=1812625083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WSksGmD4FHjjJwY5MvvQ6VCQmu+xswe/bxSVMLsGtmU=;
  b=bIRAM210fa+kqf3n301dyAufWeSlZpJ0kV9veUGjaxzUa2PIrkRXM90P
   wJNk6Gr54gu4fXUz0+DHL0vAymb5E5x5qDnYunBvst1fXv/oHdGhTvGXs
   KGG3mHVSauNCl8NV0+ubYqy1Um4lsQT5KeQepmc96+u2nxJN8ZRNCDEet
   nOqsPGCXr08o40S2GzBfV7sSJf7lU+qxev8QeFC0etdHREWIAdYXThCTZ
   0SBhHxdwEOwHonHXHNexX5qMNodv7S0IrLN2nt48PA8OuEh79hFvdCGqb
   CG4KDZRdSbAnUAYHNsvNHn/GQegBkbSNKTfldUAuXG9pFelKVZi52uj2n
   A==;
X-CSE-ConnectionGUID: 6olM3GRZTviL9P6s7RiCSA==
X-CSE-MsgGUID: WxRlbXVdQc2SE7qlw1VsSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81989243"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81989243"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:58:02 -0700
X-CSE-ConnectionGUID: +x1lNXUMQSyuE/AEBDMRUA==
X-CSE-MsgGUID: m56ejJBBTia+l2aEJ2Oz7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243675044"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 03:58:00 -0700
Date: Wed, 10 Jun 2026 13:57:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] iio: magnetometer: bmc150: use FIELD_PREP and
 FIELD_GET helpers
Message-ID: <ailDNhOwRQYuiSZT@ashevche-desk.local>
References: <20260610042418.90308-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610042418.90308-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 04:24:16AM +0000, Hungyu Lin wrote:
> Replace open-coded bitfield operations with FIELD_PREP() and
> FIELD_GET() helpers where appropriate.
> 
> Also simplify bmc150_magn_set_odr() by returning directly from
> the matching table entry.

Thanks, v4 is almost good. A couple of nit-picks, and if get addressed,
I will give my tag for that new version (presumably v5).

-- 
With Best Regards,
Andy Shevchenko


