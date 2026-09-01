Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE6041378E;
	Tue,  1 Sep 2026 07:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788248344; cv=none; b=PHwtTJ3f0GDUI0P0djyKCw4vDp4gWmzNb3MXEDiz9HezqAduZ289i1YVSwj++Ro09NwhVgwtZtBAQRgB1ep0U4o907N5Rt8cW+/xtSsw8vErqofgks3rBwgKgYG14CtEYuh9B/A3VpYyt9JzE7aPvaeutvzUyG2d/WSFtrurqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788248344; c=relaxed/simple;
	bh=0cZtu+Ngd/TqfYEvxZ++tw2mGa+Bp0qj8+hNN6xp+0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwEmKHWBC4qtrWEKtwPFuYTpbLE4FuiOIYc2BYCYfCmr0/6I4HlrD2QRC7FlLxTvdcIf+UcWLQQ0sjMLZmcGWSLMO5RgcNNH9BRoWhqcVDwlj95xikcNlWGMALfpQ/7QTzgC0DBO0j74FZs0CWcTlr9+WMqM1pi+Xo/AqBmoLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eikKlob0; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eikKlob0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788248343; x=1819784343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0cZtu+Ngd/TqfYEvxZ++tw2mGa+Bp0qj8+hNN6xp+0w=;
  b=eikKlob0ZQzgNfP4hiQhwv8G/DC6QrI1DjdEOfvULK8Kt1wcWtqvb0RR
   komv5GziZeykDni9INvJnQWL2nT1LOF3FTDsFzy4jxEXxMcHLXqQHnmVA
   4rLh3S/22QOcGC5symIAP3L7JmRdXzXpO7I4h4OddfWUPMscrVEHVSAV5
   5LDYMGFNGoUbdLTcHHBDJQRfS5d3ibl9MV6FMgLuDDJMgtNzqroUV8a3M
   iJ4ty++eL3c+ZsBURCedhc0JzLdCKMfdz3I1bQ4sIs1Sf4bRNTnXxK/7M
   EDzUUWGCIzUvYjAgLzS86S5RlF45lnwCsaAaGsZj0p1AP43wPlibmyi0M
   A==;
X-CSE-ConnectionGUID: YV0RTizCROevI+KKDBCCNw==
X-CSE-MsgGUID: 9hr00K1DSR2e9GjrH1j6JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="87805104"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="87805104"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:39:02 -0700
X-CSE-ConnectionGUID: IPwZs3/MQeGLrzwDZkpA6A==
X-CSE-MsgGUID: 7FoUlTcsRZ2D0PbJy0o4lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; 
   d="scan'208";a="265302753"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.222])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 00:38:59 -0700
Date: Tue, 1 Sep 2026 10:38:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gustavo Silva <gustavograzs@gmail.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/3] lib/tests: Add in_range_inclusive() KUnit test
Message-ID: <apaBEU2h99BHhFSC@ashevche-desk.local>
References: <20260831-minmax-in-range-incl-v3-0-30444a2fd2a5@gurudas.dev>
 <20260831-minmax-in-range-incl-v3-2-30444a2fd2a5@gurudas.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831-minmax-in-range-incl-v3-2-30444a2fd2a5@gurudas.dev>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 09:26:29AM -0700, Guru Das Srinagesh wrote:
> Add a KUnit test for the minmax.h in_range_inclusive() logic.

Please, name it after the whole header, id est minmax_kunit.c.

...

Also would be nice to have a couple of tests that combine this macro with
others from minmax.h (see previous reply on the possible name collision).

-- 
With Best Regards,
Andy Shevchenko


