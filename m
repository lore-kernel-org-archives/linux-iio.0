Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71E372ED7;
	Mon, 24 Aug 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560039; cv=none; b=KjLbqhUnRb/7vzsj5igKirI/nQBvpHuwKNgQyvelR90wUvQWNYTTS4Z7ebwgO3mzvQWHUhR6YklUqdLaszMtbetu08nv7zXEsAkvVUwe9Gu9Decf87auhjrrWsnrJrlkJtuXHYlodw+hUsZkEMd56zPFF0Q30+N1dRVYjHW5E4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560039; c=relaxed/simple;
	bh=rsOHpy3VkSI19bIvi656wZloP/q0x5cM0tz3hJCSp/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxOlcUZMd+WM4/SYaAmaqjOOrOa3dm9fjyx9OOD9CA6PeHo/Ts6O2UPhAaA3Jb13rMXT3KO+PnSlQxOBeuzow2YvQs6BJFQSsVgvgC11Mqd+X0KAeLP2DPJg/mDWbmAXh659OL5+Gj7SgwA1RHQiRLWPx/nUsynL4HYtyUx3IAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G1N1rd5g; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G1N1rd5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560037; x=1819096037;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rsOHpy3VkSI19bIvi656wZloP/q0x5cM0tz3hJCSp/Y=;
  b=G1N1rd5gDFHmZF2a1ykQdaswzJ5yt33I5hapZJsWWNySqiKbj1y27fxV
   E/7TVLidj8vKZbTXbPG3qkyGKOsXAvsVHdtJDikDo9nQKaz6CEkVpEjFR
   3XOUuMtWwbTONfBPn9VhWEY7tMpAyBG/pX1aLURNL5vchelEikUagPhn8
   sDhwOb0gPGiVMhSVG0S8/BJD9dz8bTSVnTUUvfB95SjIoubfs8zs6/hPC
   ae+84wnWLXPHPX5Tt7bUePv2RNOoa2pHtY7yfyRqQdeBSCQldqWFy6SGD
   WV53BDfuWPRpKMppBiTcZXEZwmtDLYHY3RjkaSkcctMHQDMqaNu/MWYxr
   w==;
X-CSE-ConnectionGUID: n3wVZnjHTl2cwC0THqLFjg==
X-CSE-MsgGUID: d+CgDTckQI6kSOs4HwbwMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="91819652"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="91819652"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:27:16 -0700
X-CSE-ConnectionGUID: RBJjBVQkRouvvWWUuaXAfg==
X-CSE-MsgGUID: SpmE1tdWRWyOfk0BS7Qghg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="266416975"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:27:14 -0700
Date: Mon, 24 Aug 2026 11:27:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>,
	Puranjay Mohan <puranjay@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] iio: temperature: ltc2983: make headers conform to
 IWYU
Message-ID: <aowAYN7j8_UXkxQD@ashevche-desk.local>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
 <20260822-kernel-header-removal-v1-4-ee31b124be11@gmail.com>
 <20260823185219.222c7990@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823185219.222c7990@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 23, 2026 at 06:52:19PM +0100, Jonathan Cameron wrote:
> On Sat, 22 Aug 2026 10:02:31 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:

...

> > +#include <asm/div64.h>
> 
> I think we normally use linux/math64.h for that one.

Right, the rule of thumb is to prefer linux/*.h over asm/*.h in the C files
like mere drivers.


-- 
With Best Regards,
Andy Shevchenko


