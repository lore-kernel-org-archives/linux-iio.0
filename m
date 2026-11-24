Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795508698;
	b=rcyLrIfECCukv4jXD8HWadCglcTqfY7VtAXUMMN1hDFgZCjCjsX7zq07z961GHp9wAUv
	 Plri63xcPM00Z/GHMrGyVy9baWAx3Y+mD9czx20FuYncRhvp8OCNjczhqweCtxhQtlqaH
	 6yPCIdtEApUt4WZldgccPTDpAGS0E6nPLE4e7suLbU3E2H2uPaEWeX67jBI0Audhil5dA
	 g1KSCfxv813U5ghDtOLnHxnt10zULC2ld+LeSWfhwtbX1i+Uo+fRvVQnwVvWcPyGTc1CE
	 4v4ZY15e/CA9iW2TZ3QB4RHNWb1+Gya0b12HGAQiqgxv4YbCKR/oqSAQdukHx3arxpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508698;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=UEEx2FnoftIf8oWozsudJd6BrkDAw0S/DBqGkfvKW2Y=;
	b=c7KAmGjHMMas1G+Zu5yGS9sB9iF9o/qteZqxdp/w5AVu/cBu3zTLTgKu5f3spaz1+axr
	 Hg2VaVgPAQXlu5cyQXGTmNI8mKCX6ayCbuhpXnorNbxa3XaDN95dKDMW/1dQ8/G/zS8/w
	 BxVXt7mL5Ih8EbFS+brutFSVMgagoL7kiM5roncZ4wvmKtIdiuTSWaCYPxXIdBoyDm3er
	 8hJWww2gWqK9Ijx4/LhuC52TdoMWGUlpsEzwtO6DMFa4THcCzSnqqyVdhcP3L0olJG4ui
	 Ls+zaEZQAMkywxnwbEoG2XYMfy/FVoKPYni4LYAPNeORj4g7uj6h2hrcpiHnyORmrNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LJU/ZkHi";
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE3F606A31E;
	Tue, 24 Nov 2026 08:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AE3F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LJU/ZkHi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508698; x=1827044698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D//+AMT8ylX58y2FRlIEcxYpzgthetMQjhdwTXIrfg0=;
  b=LJU/ZkHiuFeK7YgXWaSiBqvnb0ufwop9QMEYewm6bPA/dsPo7PaAkNLJ
   QxOGZeWXtOQkHmbZ/XPPR3ap2tQA0RpkW2lRDIBgSMExLf/A4JM9Y0r9M
   8ym06GBqK/7lVgmJxELw49J29XvMEBK8pl3e/FLtstR+3a+bcXzHb72fR
   OmOTPmeB9IlqcjQrhfbAQtgwVfGPZTAjEheT8Wsw1Vi/s3U73L9rNC+Dw
   hrupyYKTjYJjZqM4VzMUpUIiHeSBi235p4ywgAOKTvASj/lfTiv8pxcI5
   pAdlDDFiatnbUlA5h5p4VQudpAZkOfcNO7Kok8/n8mfU5F4cukzbd4IZF
   A==;
X-CSE-ConnectionGUID: Vq4HVTB1T3u1VwWTkV7vug==
X-CSE-MsgGUID: b/4UeSwZSoqH/2b/mCoF+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4350480"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4350480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:21:02 -0800
X-CSE-ConnectionGUID: pdlKjHb/SpSX5UbQXRLOBg==
X-CSE-MsgGUID: zj7MOG5tSM6T35EYhby3VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11720752"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:19:59 -0800
Date: Tue, 24 Nov 2026 10:19:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] iio: pressure: dps310: read the coefficients with
 get_unaligned_be*()
Message-ID: <awVIrI4SjCuGO5lI@ashevche-desk.local>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
 <20261123220649.36887-3-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123220649.36887-3-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 12:06:44AM +0200, Rupesh Majhi wrote:
> The coefficients are big endian fields, some of them 12 or 20 bits
> wide and not byte aligned. Read each with get_unaligned_be16() or
> get_unaligned_be24() and let sign_extend32() drop the bits of the
> neighbouring field, as the ZTS8032 coefficients already do.

I have checked all the lines (especially ones that use right shifts)
and found no issues,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

You should probably add
No functional change intended.

-- 
With Best Regards,
Andy Shevchenko


