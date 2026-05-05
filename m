Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D38E3A5E62;
	Tue,  5 May 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963914; cv=none; b=JE+Caew701ejX3bxb/hje7D6x5sN6lszjuHDzlfBjN79MQh1FQhbmb72Gc99EdlaKHdflLpGK7f+o50+nEw/txVm3EMisruInwdKn6onFxwPoAmMEEk2mV8VFb7vCbLK5SLIHDSzl7wwSVSqRazwADo6YkGi8/P6pf+tRHnITkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963914; c=relaxed/simple;
	bh=Fz+sk9+RcUVrJBgTRkGcMT7og68K8rOhhxsj3sQ3fws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XTtDZr1/ssJMvtcjIFh4FPYRbZ6NOHz7YXUvXBLvrh9OwLZjrfPu16Rk1d1OgUuXxY76jEgUD2v2/djjfk/JYpSMyXSgJ+80MV10NFthgGx04q5mNJJagwpOkJ/jofMlv4t0r7rqejFlbUbpBryLmAJ+Qyy9CnKonTtt2Hmcq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S7mMVzmg; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S7mMVzmg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777963914; x=1809499914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fz+sk9+RcUVrJBgTRkGcMT7og68K8rOhhxsj3sQ3fws=;
  b=S7mMVzmgbzVGkQWiJcDMPUWdNEx+zRtr+3ymctUOp8PhX5gjSghtdl6z
   nNJNO45eLKnfleRwYBzNedAvcfclZm9q8orXqpmP+dFG2y4lxXQPPKTqe
   SO+OfW09IJWxRMUT9hDHiFZ8SNqnksb6jRX1YGCEsAfbf5YNBONTbmL9t
   Ff+DRY6F2pRgWfnF/F4gUkd5JfHr6W1hGugqB3bquZu1YXBb3A8BKHmnS
   EsyZ0/bPJyQEVJP8qYgx2IUJFShHatU89Snip36cHiRIsnVzyIUn7dn01
   vGg7cMAUPGFn7S4jSjnvhw01JrnSu9ST+Llj0goSQGHlY2h891f/XWn2R
   g==;
X-CSE-ConnectionGUID: Sd7NWsRaTb+4IgzCKLTBbQ==
X-CSE-MsgGUID: 4cwpGnTaS0mcnXqVEnFisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78851119"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78851119"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:51:53 -0700
X-CSE-ConnectionGUID: soFSzKwNRhWhtxI3a6JJCQ==
X-CSE-MsgGUID: A6iJP+5tR4+U4AHgLVOKkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="235980752"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 23:51:50 -0700
Date: Tue, 5 May 2026 09:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, dixitparmar19@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v4 2/3] iio: light: stk3310: Replace uint32_t with u32
 and reorder members to eliminate padding
Message-ID: <afmThFDzB8fr9kwu@ashevche-desk.local>
References: <20260504030408.105762-1-limiao870622@163.com>
 <20260504030408.105762-3-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504030408.105762-3-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:04:07AM +0800, Miao Li wrote:

> Replace the uint32_t type members in the stk3310_data structure with u32

stk3310_data structure --> struct stk3310_data

> to adhere to the unified kernel coding style, and reorder the member
> variables to eliminate memory padding holes.

Might be good to add `pahole` summary before and after the change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


