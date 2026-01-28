Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55606350D51;
	Wed, 28 Jan 2026 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605549; cv=none; b=plUUra3MtL3dgGycM17NvUgwkH1jtxHiWB5eVPe2KjV3Az6uYaYvA5sQplXL9ypQEpDp+9SyqG8oN3Xfe/YszpRyDO7iRRt1fYDcRFVQMCZGBu6RYKUHFucXvNTSVjWv2k4wD2fLw6jNlhO2WA/V/r033OWPpTez3Hhc5SSzfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605549; c=relaxed/simple;
	bh=P6rk6Ov4BcfhXIp/Hf/iwGegQogNQuGCnKUmPHMhwo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uaz57ZkGtu4tYImgwRentkrF1+oWLFphGamAyHiuyPPWl8bGqM1qD6mT2A44Q9cj2U4NjwLVW/SENtGrkA7Q+4G3hMKgAM+ZPQeo6gpkCZffJY6KSvSIHj/xrtNTwLYeZ4Nm+zc6PI3RSbBSSH+drRonL9qmnZeFujs0sgeMf9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hlixH3nK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hlixH3nK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769605547; x=1801141547;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P6rk6Ov4BcfhXIp/Hf/iwGegQogNQuGCnKUmPHMhwo8=;
  b=hlixH3nK1TFGEmD+M5oUX3ArOr74smkSSyl//KAeVYbFhIyuXmW1yb+Z
   dyvkuY0oEXjA2VRF97de7fCcQtV2wpm7CsgN4bTGLFQPgaPOvGbaJxxzu
   h/2yiML2H9/pLO2+akqvdICb3ZBXvtjIEsmVOj1f3xIRTikqNLe7nwr33
   Fakr+4NS5jv6BCLB3pBIWcrRECbjXNLhRaJQVIPkoslLSI4Jcwoz3BBuJ
   kqExEPceYpjEL3KERwwkIbBo676FOGCFmfcDZ4XeT08dZm7TtosdyEWal
   SNSvA8KWm0qFFTtp0hh2AjQ27Lw4mEv4KmhWpQPQeL8qosobcPH4xM959
   g==;
X-CSE-ConnectionGUID: qf6MaTbwTreJdyv4khnc1w==
X-CSE-MsgGUID: ZqRrv5nfQj+H53Ey/L4L2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70872532"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="70872532"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:05:42 -0800
X-CSE-ConnectionGUID: BTmgqy08SrGQkhh8DG/+WA==
X-CSE-MsgGUID: 0aoknMvGSEeHGe6n/+PaQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="208329701"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:05:40 -0800
Date: Wed, 28 Jan 2026 15:05:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 19/20] iio: adc: ad7766: Use
 iio_trigger_generic_data_rdy_poll()
Message-ID: <aXoJoXgliFimSE-r@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
 <20260128095540.863589-20-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128095540.863589-20-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 10:55:39AM +0100, Sebastian Andrzej Siewior wrote:
> ad7766_irq() is identical to iio_trigger_generic_data_rdy_poll().
> 
> Use iio_trigger_generic_data_rdy_poll() instead of ad7766_irq().

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


