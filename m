Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DCA30DEB2;
	Tue, 28 Apr 2026 10:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370707; cv=none; b=UtFOaubeMi3TalXFTfqnl+0Y/RDZ8Nu69TvUxy+LTJJXfEPoj8TcZh8kE66B/y1QRNpT4YG+4544Xkr/VdLwrZG6LM1IIFvSQXPydBKcnjkUoaJ7NO+mNs8UTBtIjb5xznb4Gj5wNDwuZBPnFinUvT4FF6EnfQO5/3rh2F7KR2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370707; c=relaxed/simple;
	bh=UAOung9tAI31Vj+/d4tywEME/9ueL3l9u80LuDJVl8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOCGC0Vk3+S7nl5pZpyT7TnjATKQJ8HElAa0/0s00s0TK6/41rmo6uqStXDkZxFz+jN7C70ibIhq97APexCCshrOWkKChpNZAG66Jcko1/zVi17Jw0CUvX4fY9Ll4CoWLV/j9i0nqQEFAL643cztoEMLS8pU4jJfNcv6kw/jcjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agEenG99; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agEenG99"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370706; x=1808906706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UAOung9tAI31Vj+/d4tywEME/9ueL3l9u80LuDJVl8o=;
  b=agEenG99x34JJSlLz3BSKVYFvyOQMEjYwfVdoPoni2LWLUpawBVF7liB
   WYE+P/U+DPtYuqtiGHMHWxnktY4SkPwTJ06jOG4s6c7qg0WZyuZEzsfAH
   41K8EHeV2rhCLq00UWb/JX82WYGmihEYuYRuAbgLmzVmheafkrYfGzOnU
   UJodrsjaz8exSopAcWDH1OMOAdC8PNLAYW2VSv8ozRd8sVzeH07OoXSc3
   KhVLWD67vG5b78latSrUP8KofdBHhJ9ifb9NQHI5qCfB0YKOGEbE80Sqd
   Ufb7teSackV6NDcZelOmWjcWNqCY/zUVnx75cx0n2LmQ0AOzfn3NTiqx2
   g==;
X-CSE-ConnectionGUID: rZYtm7dnShKuyE5eXUu7/g==
X-CSE-MsgGUID: O+2UbyhRRmGHtQ82vZVjAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82127207"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="82127207"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:05:05 -0700
X-CSE-ConnectionGUID: nwh6HXThRTC1i7XWOHSOrw==
X-CSE-MsgGUID: IVek7zjwQAG9G9rIReBrsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="232904025"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:05:03 -0700
Date: Tue, 28 Apr 2026 13:05:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: magnetometer: rm3100: Use scoped_guard in
 rm3100_trigger_handler()
Message-ID: <afCGTCygrPDYs2-C@ashevche-desk.local>
References: <20260428024339.45109-1-m32285159@gmail.com>
 <20260428024339.45109-5-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428024339.45109-5-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 09:43:39PM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in
> rm3100_trigger_handler() with the more modern scoped_guard(). This will
> help modernize the driver and bring it up-to-date with modern available
> macros/functions.

...

> +	scoped_guard(mutex, &data->lock) {

> +			if (ret < 0)
> +				goto done;


This is simply wrong.

>  	}

-- 
With Best Regards,
Andy Shevchenko


