Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A643235E1D1;
	Fri, 19 Jun 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860463; cv=none; b=Ctf4eouahBWie7WOaNz9wJANU+Z0KiRNOn+hMapYJcylGgR4QetdQM0zfntwg9B63C3ZdfXHjwgmOT2JzehzpbWSGuXa8rvzGDbwoX/ssKLlegS3X7cOW8v+XJl6HETUD1yvX1ECXpOFxcbxgPDupcvTu+qxaogNQlyMgKrudz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860463; c=relaxed/simple;
	bh=Vs2uglCQ/qIs9uyj1BppkMgnT8Pf8iDS8dGs2H72w/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CoX1QCFUDb/l8rCTdSaJOgXs6gqNNQc4YBclx4RlCrgX0HWKGoQOxDhnlWvHyPtwPTa2jRIElFPcxgbM7389n6l9K2t5CmEzpAXInZfLjhgYDT4emQN61iios6V1XPVXy0AuWeal1QF5wOG5qiaJucKUJDObVK6WLOyPrs+SIps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hpIEcuPy; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hpIEcuPy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781860461; x=1813396461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vs2uglCQ/qIs9uyj1BppkMgnT8Pf8iDS8dGs2H72w/k=;
  b=hpIEcuPyryugZG7QC/FyDv0MxUxsqvI5OoW1E9yzF4X+Ew9y3CCmfSzo
   fYoUr8uwLuam1Y9pkpA9IPVwQypHFOV5P4mJE9d9C3C0TToUmj6l7YacD
   piJ6ANPFPj1vZ5MD61ZDR0LbKzENxb94gDgJe8+lay+xJ3NijA+pQNicD
   39jw95Pz8gN+/QWvnS8gy9ZRuPEYI3mf/VBrAeA8OgSWfJR8TF/phu3sL
   4erqi973NfWAVaoYitOPcrvlTzmzXB3pWXhUH4sSIVfEvzsiDri0MoM2L
   6aEiyWzprdt2jtjd5O/nKtjOpGInqnX4DEoP9CbuYE77j7Qj1pnXbunNQ
   Q==;
X-CSE-ConnectionGUID: pumZkS7lSbah8ifH2r+DIg==
X-CSE-MsgGUID: cqj9ARAIQQyQUNHdEYrVTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100258663"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; 
   d="scan'208";a="100258663"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 02:14:21 -0700
X-CSE-ConnectionGUID: OBVLxJgVRtGT/14/M6eynQ==
X-CSE-MsgGUID: Krj/BmieQ0SJhftR9bdx9g==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.170])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 02:14:18 -0700
Date: Fri, 19 Jun 2026 12:14:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Miao Li <limiao870622@163.com>, jic23@kernel.org, andy@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, dixitparmar19@gmail.com,
	bigeasy@linutronix.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miao Li <limiao@kylinos.cn>
Subject: Re: [PATCH v3] iio: accel: stk8ba50: Update includes to match IWYU
Message-ID: <ajUIaOsJ6Tn_Nn6N@ashevche-desk.local>
References: <20260617013834.166337-1-limiao870622@163.com>
 <20260619092731.0000090f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619092731.0000090f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 19, 2026 at 09:27:31AM +0200, Joshua Crofts wrote:
> On Wed, 17 Jun 2026 09:38:34 +0800
> Miao Li <limiao870622@163.com> wrote:

...

> The driver uses sign_extend32(), which is included in <linux/bitops.h>.
> Consider removing bits.h and adding bitops.h instead.

Good catch!

-- 
With Best Regards,
Andy Shevchenko


