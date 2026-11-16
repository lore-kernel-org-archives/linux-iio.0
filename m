Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794837643;
	b=JDlz5p94p3lf4klXEC8DvfoRbv3DppmcRAc9wNEhFEEiGYWjh5EpIL2E/Vi3aFJ/wWVT
	 vQTShKwAzXzDxOfo3nAVNJdwZTRJ4BKQDpi4JCO36Q8jaHD0sBHyjqsYosWsEsXelfDoX
	 RraxmBJcIbfzT8/+vRS0s6/tk/3z30fEnO3CfLYAwwBaNrDol5BkQrzQSXMx7Yjucjtur
	 YdZl3LPJotEzqfg2Mew1wXHCMzwe/F7SP0LOaVvYutmiFSjXMgWkeyxgvpjjq5p4E4kmH
	 h84w5/Mlm0tpvW09vYfzGwS6z+sDxyixcYg7qNAHeXt6Md9f1+801P2DvX5H9RJcLjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794837643;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=76sIVwFPCfKxiJSgEXvE82pb13aFQ7DioO+UfrZ0PFQ=;
	b=PoudtPYcX4/k1HWJrDo8WCT85d0v3qb7KFrUHma8DbYV57q8Kk+XEuiSJQ8elaCopeS0
	 mNguNzzHqWBv17ke+3owZuzPLy4V/GTxR6OEzzEIPyoyKQ0kMjQb6X8tBBuv8ZxzuM8+B
	 whYDT+F4a7zFOvE0RAeC7Is8MWc1Vm+U2N5iqqVqSxI+3TorYa+HA9JObTV3PJy4Uzgzp
	 QUm64amJJ4CcKG3sb+Iz1eRz79704lj2d6GgOXtfCw6X5zsUmn1tTJabVxBI2GvLhlCUu
	 9pm27xP+dsufXDuRk8qLnUYakp+C6ururolUyd5Uy6GnyrNHKIOwTxjUlBuswlMBVVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7OTSz33;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212F606A31C;
	Mon, 16 Nov 2026 14:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6212F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7OTSz33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794837643; x=1826373643;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igwFy/Gf5g1pZTtJ6Qmv7Gr/zqjC0ak+LrjxDFvwDq4=;
  b=a7OTSz3307KD5Bu5O9lB9OOPaNzTeDCTUG6ocGThPnBmh01cQLmFIRxU
   aStlXqf+G8ibq0ehe5Hro1Xsbo2JmSrf14jRnlAUwWFmEYnF94UNUC2cd
   g1Hu6lzllVjbzaHT7nG0a4EAmFVEsEe1LyujuI6VMnPfIyzsV4CdtGXGg
   erhc+FNXZ9y9IR18QCnvUcUxXT+ABmA0fMVSA5eCU4RPLcbEp0ZQ+z8r/
   VcCBsESOy4TV1MuepvcAoN1r13na7pMWxJaoXdCpRf642slKOYtV0Sb4U
   Q+X1C7of7uEdeOecFr8KUm2NAYlGeh0fcNbkSR3jd1jdwrJ8WAXLjWtmr
   A==;
X-CSE-ConnectionGUID: rqowM20lTzKl2XugfwwqrQ==
X-CSE-MsgGUID: x+Mvm198TSq4vG7cUa8PDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3582679"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3582679"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:00:42 -0800
X-CSE-ConnectionGUID: RYfPYRm6SsmrfSfLcaXSUw==
X-CSE-MsgGUID: FoOJVbwoTXqFBNiH2HFHfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="11347728"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 06:00:40 -0800
Date: Mon, 16 Nov 2026 16:00:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iio: core: Export iio_find_channel_from_si() helper
Message-ID: <avsMhZRNo7nJaGDQ@ashevche-desk.local>
References: <20261115083049.46840-1-clamor95@gmail.com>
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
In-Reply-To: <20261115083049.46840-1-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 15, 2026 at 10:30:49AM +0200, Svyatoslav Ryhel wrote:
> Export iio_find_channel_from_si() in the Industrial I/O (IIO) core to
> allow modular drivers to locate channel specifications by scan index.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


