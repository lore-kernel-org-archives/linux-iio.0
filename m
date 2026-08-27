Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80D377019;
	Thu, 27 Aug 2026 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787861696; cv=none; b=hv9jyTRhfVbya7r+13zP7EQMDpTbICjt6XoHFC68GcCj5fG+Cyj3PBwo0oTdO3sgStK0eY57b8QpDV3bbS7U/qqk/5gX5ebU8nG6gp/WDwKcvYhS+mOs0k3d1337Ql0ehvVGIRcZFe0wZuOPv+xEc5CVK6pUb/eIt6+C1wsjnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787861696; c=relaxed/simple;
	bh=T6BZYAi0AfsVsygV7GVLz4LmL113jqV3G01/uWrHP1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THtYNVBjoiUYaaLKUYItZ94GAmMO5FBkc6t35kMZsEfyEB0DYFb4wuoJo+E1iUkU1XtrxfdSvBV5GjxiD+hYsjk2kVM9z5oWN/+VHJsFweEeOPDgsLYYhULGCkqzmD+60nzvoxiH3d6tWGgFAnZG4Kr4G+DD5ioe6fQmpH7pVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjvIugXH; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjvIugXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787861695; x=1819397695;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6BZYAi0AfsVsygV7GVLz4LmL113jqV3G01/uWrHP1w=;
  b=PjvIugXH+MXVtuom/nubzZv0XTxFfkKqZOGjch42PTThBhHvGyQxw5uo
   NiLe+4JSP8dRjlhzEiCwuYleK/eneL0qu3iDkVB+Jy/MrUnpZq9VaZj8v
   9f4pH4NSKc8F9707zxQaKr/UlQKOWPkjuVETJWMHaNg4BygpOGq6tVsPQ
   4grqZnOc1XVnndCc07ftKxpVd+TO7r1A9SFWRV7tncXkEvc8rgyt8T6cl
   yPMdwNua2QmrcvL/tFBQ/Qa0f2VPPZ/2GW+dzkKhP+maW+HoinZMzzWE6
   MAYnc7u0cfai0rndEfG61kpLGjuwyaX+886t9/MZjGaekGlXPIpeJ/hnC
   Q==;
X-CSE-ConnectionGUID: 0A57+dVyT4y8Pmp8TeNfLA==
X-CSE-MsgGUID: umZWfQkhSl+lexYlgnveGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105892953"
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="105892953"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 13:14:54 -0700
X-CSE-ConnectionGUID: 4gkvo1wpRYagxAhxdaN2hQ==
X-CSE-MsgGUID: dfg/XU0NRbyszKrU0Ky+Tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,247,1779174000"; 
   d="scan'208";a="267368969"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 13:14:51 -0700
Date: Thu, 27 Aug 2026 23:14:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, andy@kernel.org, dlechner@baylibre.com,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: iio: adc: ad7816: Use modern IIO attribute
 macros
Message-ID: <apCauAuswGTMGfVI@ashevche-desk.local>
References: <20260827195642.12831-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827195642.12831-1-mdmahmudulhasan1511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 01:56:42AM +0600, Md. Mahmudul Hasan Mabud wrote:
> Replace the legacy IIO_DEVICE_ATTR() macros with the modern
> IIO_DEVICE_ATTR_RW() and IIO_DEVICE_ATTR_RO() macros.
> 
> This includes renaming driver-specific callback functions to
> standard <name>_show() and <name>_store() formats.

...

>  }

>  

Also drop this blank line. Same for other cases.

> -static IIO_DEVICE_ATTR(mode, 0644,
> -		ad7816_show_mode,
> -		ad7816_store_mode,
> -		0);
> +static IIO_DEVICE_ATTR_RW(mode, 0);

With that being done, I'm fine with the patch
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


