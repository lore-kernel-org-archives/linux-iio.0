Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D349315785;
	Sat,  4 Jul 2026 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783167230; cv=none; b=Ab1AeCuC9P+lzGGcg/SF/LD2H+4XiTY4u5ELnuQsfo9qKU+vLL3kFgfJZw779yTRdcdiwINYgCpDiXsFbREuJNwBcneLaWLhMesMRHQGUP2zT4O4B9zlO3QkJftcR2AKCPhmJgPG+Xozm4c97kVPIDfpMtUuRkSDkyv7gPXDF1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783167230; c=relaxed/simple;
	bh=LKbfborWO1n7a9sQJsyvJxo7HzDrxBXQasvVawPnoqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtpS2S8gjPb+illJwgrKPBX0lhK8VqkiYElhyq1vjRiBRmvKIgSY6uMVI+Ba6WCYN+XMXjQP29YcWXrNNaQ3saL/djqUsc98n58eGGlliHoAuKGJORzS4gfJrYyqXfV1vTda6RLKoLVYKbMHKWxtN9wBhz2wJI5h8QqkveSOkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bD2EfSZt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bD2EfSZt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783167228; x=1814703228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LKbfborWO1n7a9sQJsyvJxo7HzDrxBXQasvVawPnoqI=;
  b=bD2EfSZtUjF6wScJ15/j9zg/czTfxTwNX/P8+2J0UhWiDMqM+jC/z4T1
   rBcIXobvrl6qLo0QuMJvSEzq1Hh+Drn9n1gVEP4p3f+DVzRP49gyF4K36
   rUso2lzFcACi+TaIZ9OKIQ1pukHW9CcxbDxo3odYu22QNZF5k+gclph1n
   94gWGnwSVA+Otq9ZCBsx2DyzIAF9sgn/poBTq2fzPclnP2gUF2kwEMdTB
   6f5pJFA2z669BGIN65D9D4tw5V8jNdIdNKM/j1hohcA7abdVIxX7wxPuI
   ub8L1zCsu1vmCyvgmvEsABqzAXl8/a5p8NSe54epkGR8C4J/WE+zckXyF
   Q==;
X-CSE-ConnectionGUID: pgeaoTfgRdikNoym4PPoTA==
X-CSE-MsgGUID: QVJeN+lqQSi0DnVVJJI6lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11836"; a="82985016"
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="82985016"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:13:48 -0700
X-CSE-ConnectionGUID: Xdf0EY4URKKUjrLHt7UiOA==
X-CSE-MsgGUID: njo+kOPrTJeTgWr1KGMRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,147,1779174000"; 
   d="scan'208";a="257630556"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.218])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2026 05:13:45 -0700
Date: Sat, 4 Jul 2026 15:13:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: light: al3010: fix incorrect scale for the
 highest gain range
Message-ID: <akj49teBHChc17uB@ashevche-desk.local>
References: <20260702052913.114130-1-vidhu.linux@gmail.com>
 <20260704115245.11167-1-vidhu.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704115245.11167-1-vidhu.linux@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jul 04, 2026 at 05:22:45PM +0530, Vidhu Sarwal wrote:
> al3010_scales[] encodes the highest gain range as {0, 1187200}.
> For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
> 1000000, so the scale 1.1872 should instead be represented as
> { 1, 187200 }.
> 
> Since write_raw() compares the value from userspace against this
> table, writing the advertised 1.1872 scale never matches the malformed
> entry and returns -EINVAL. As a result, the highest gain range cannot
> be selected. Reading the scale in that state also reports the malformed
> value.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


