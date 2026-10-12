Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079764B66C2;
	Mon, 12 Oct 2026 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791839137; cv=none; b=Og3sDnboh+LDOI9B89NLwgHUTDbR5c4j00ntXBlk0BXJH6C0YAeHQFarNNo1MXREAFXw6kAj2n/sfwNCa0HcHY8vk2WBSqhCCuy6ry3GjHTqVD+OQAtyH02jfcXgtp/RarDsySeJvEhiT2rbBa5YpYk5Nfb5WybYl6puj0fKPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791839137; c=relaxed/simple;
	bh=SadU8DnjTI8iqyC9HjuGra18BDSNoEP5rD9TJRC3DAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bp+zsbNjFmbKVm3xn7qo8Iurkaf9A0DhFUHVX8eUbrLkVvGaza98pH6fkadPbKVxI6i+JZf0jcPH48ugMLLRd232Q6SPHGwvroWdPFq6gbeIbnMTADRJHOpG/8jEsVgvUITUJQofgFtUIbNs+xAwOMDnn8kIRcw9xtlJxYpq9BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyjXkzuh; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyjXkzuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791839137; x=1823375137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SadU8DnjTI8iqyC9HjuGra18BDSNoEP5rD9TJRC3DAQ=;
  b=cyjXkzuhFPv3Y/lvZmXjtj+eOvierli5uP88MSyaEXNs8MxAh+niVvZA
   W8ntmzhQuPD8weMwQwl0NYbJvvSPquvlG4JMpnWaFWr4tMUmoBvdHwdot
   mDXVAbbe5XA7fCM6Isj9evQFeKpsrc6ccbdoMmpJRswCqkVXD5uuYhNgr
   4j0+89SLoycE/3OqRMmZ7fGz8Kv0j/C3WBAuhQtUvg42XA8LMgnlHyinM
   ML6wSrXuyPyfIiZ3Aw7YP+CP7AIWs3UtK05pkw6o9FJ/h1ERz+H8Hpfp4
   SDSx3M4skdPfvWzFyndWlbnXgbKYEtTRdEhQ2DhtjhBav9i1eS6q2PQn6
   g==;
X-CSE-ConnectionGUID: 6+Y0onN+Ru6HRVuAwMkm/w==
X-CSE-MsgGUID: xecZA1i1SYORTLPrWmW2Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="565678"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="565678"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:05:36 -0700
X-CSE-ConnectionGUID: BbQrLs3JSOSEu+A8+2ob3Q==
X-CSE-MsgGUID: WLVyzymYQLGIGJAJSubY+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="949457"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 14:05:32 -0700
Date: Tue, 13 Oct 2026 00:05:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <as1LmjjV_gLvgwiE@ashevche-desk.local>
References: <20261006103350.32853-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006103350.32853-1-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 06, 2026 at 01:33:50PM +0300, Abdelnasser Hussein wrote:
> Replace manual and unsafe character checks (e.g., buf[0] == '1') with the
> standard kstrtobool() API in sysfs store functions. This ensures proper
> handling of standard boolean inputs, fixes potential safety issues, and
> adheres to the Linux kernel coding style.

...

> -	int enable;
> +	bool enable;

>  	if (_adt7316_store_enabled(chip, enable) < 0)
>  		return -EIO;

Makes sense, but check that the type of the functions in use take now boolean,
ditto for the rest.

-- 
With Best Regards,
Andy Shevchenko


