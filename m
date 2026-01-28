Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066BF2D9ECB;
	Wed, 28 Jan 2026 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605393; cv=none; b=fEi2UIMfMVgcS6M7pTucDtGYLm5NFqXtIqLkGcnkDtOFN+hTGRoUpV58qOdu9xbBWWLE43ZWbquCXLkAWd2v/AmcZbbUelaA7YuzjuhxslaIYZPb5pq4jhMRvxeDNtZd7JObm4nHvaD17A/yuNaxQ2IASJdrtAHTxnwNH1I6DKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605393; c=relaxed/simple;
	bh=9VeMSKI8DojAAIJMAcdPeV0cDHYbKGdaSooE40SZqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkEkeNJJ6K+1ise007ZcJ6bPnaR4+amf173yttp5n54adCwqM+wLujLFSWfKKQyK2Oj7wzgHjJZ8VBNHeWhw476ed8vghGSgTMS93mNn78nESM97C9bpHpoEE6yisbrTY07KT5yOUz/P7a9PpnXV+Z73dQ4Lob72SWC70MAPo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MQuXh9tx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MQuXh9tx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769605392; x=1801141392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9VeMSKI8DojAAIJMAcdPeV0cDHYbKGdaSooE40SZqbE=;
  b=MQuXh9txT89k+UyARPJwt9OR/B8G7OuSM23O7S17C0C5uUqxD2enHWod
   Nz0lC0vHCgNEaag8ZtQCcKrSmY5u89f6pMR5ba7gsc2tYS7KEWehHZgwz
   0FKm4ZacgKxbjkVI33BadgR87fY5FUHNehd4k16tT2zt9GcAJVpkKxifW
   nL32zx+Qeuzjmm5p+LoqrTovKnOyoc9BriXiq/bHFfkyzot88gbj5jN8J
   7JHRGScsmL1HMRXYA4Ygk+aD6XeubAdOHmMgVCGPWS+cToW5noEbSppi7
   lAubtRhRCFtdowdhsV37Vmz8htLJbisTnRMHuO/byyMb7bIBdsAv8Toqt
   w==;
X-CSE-ConnectionGUID: nZhWV8cXTtWWrVr1SKaAWQ==
X-CSE-MsgGUID: pHP9Y9mbSwyUUDCwmP1FJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="88389110"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="88389110"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:03:11 -0800
X-CSE-ConnectionGUID: Q3kGoT9RSfiYgBWXgNFcaA==
X-CSE-MsgGUID: k37s888XSyenFJoGqe7/AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="212360775"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.196])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 05:03:08 -0800
Date: Wed, 28 Jan 2026 15:03:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 16/20] iio: Use IRQF_NO_THREAD
Message-ID: <aXoJCmySAPIWlXYY@smile.fi.intel.com>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
 <20260128095540.863589-17-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128095540.863589-17-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 28, 2026 at 10:55:36AM +0100, Sebastian Andrzej Siewior wrote:
> The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
> other interrupt handler and this supposed to happen from within the
> hardirq.
> 
> Use IRQF_NO_THREAD to forbid forced-threading.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


