Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948113DD86C;
	Wed, 17 Jun 2026 10:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691730; cv=none; b=XXIm/d1XNoS/IA2gFVXcb5mlsBZCmL7Ka5rABQ//Njh+A+aYvktiE0KdkAj1x+XvO9owM4cbdArCR04MpNzTLykWqEPBAqv6d7p9D6dQjBL8Cbolovut7LApCe00wRZCCiDJodLtzQgPvrMv80MFlSBPK99S8RuuBgm23j5cbkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691730; c=relaxed/simple;
	bh=YSPgxoWha09Yd2dg1rxm70EUVXfbcct4GM2FCMzrFq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7958eOlAABxVKeAEzmwHvU8pPSFg/DtmqSZjOiHISOOSLoMk0M5hobwKHR4NgVgTTFJshZAGW20/OaYlvYWlxgEKl2EcpRaRdiLe9sv0bxZYIsAuitUX4DnBpVJZPj3Bv4Q3MgY36WNSob0b6MIRH84+ofe8/whf0QBUGmuOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V9TlrkPt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V9TlrkPt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781691719; x=1813227719;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YSPgxoWha09Yd2dg1rxm70EUVXfbcct4GM2FCMzrFq8=;
  b=V9TlrkPt/VgF0rU/nSCJLGppEUIRdLS09foNhvUYymS3qyJAl7ngeDXu
   P7AlT+kWnRMqIYZ1twyCVSk81IQixbr3f/IRCXilf5yKZeEJ1jE04M6Wt
   ddQY/g+yVEGVXSmXclbJGluHzDoeFExdNO/lq4CyaWQO3M3wzHiMNvPkX
   ylzz9S1JSgM8WNC1FCGN8hKQ/RGUGf308+DQchNag8fSA2++BI4FJ8JN4
   ih9/j+Dp/NYWyzSgYn1muXJMS9zCYyos81CFV+BaJ1vY02y79MiDNDbbY
   4nQEWxEPWZ2I1pDmmGkdAfPVOBMR1GnWYZXhoiq6+QVmT6AEXHCmhE1Oe
   w==;
X-CSE-ConnectionGUID: N6QKB1sATlafn9XVd3s6Jg==
X-CSE-MsgGUID: dPt4ciYkSHOsNiFxLl0tBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93593550"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93593550"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:21:59 -0700
X-CSE-ConnectionGUID: lKdJPMjxTse9akrWxedP+g==
X-CSE-MsgGUID: qGY3gvC3Q1iTegfOB7NWTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="247137153"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:21:57 -0700
Date: Wed, 17 Jun 2026 13:21:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v6 8/8] iio: light: opt3001: add comment to mutex
Message-ID: <ajJ1Qv-oC9QcTsYh@ashevche-desk.local>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
 <20260614-opt3001-cleanup-v6-8-e3f5901dcc26@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614-opt3001-cleanup-v6-8-e3f5901dcc26@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 14, 2026 at 03:19:10PM +0200, Joshua Crofts wrote:
> Add comment to mutex per checkpatch.pl report. While we're at it, add
> a comment to bool ok_to_ignore_lock.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


