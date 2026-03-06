Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB5C26E706;
	Fri,  6 Mar 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772799318; cv=none; b=NH1yT3nZPpgdMYiCMAmi5ryyF/klCOQDmAQgNnNhdndkDj33czZFSx98KnRlpJOlau8oNjAM2Rmq9iqfJxUHr22ClrwZ5YCQpcJVLn76DKuWPN8UupOO5qbC/VrGi5BntIkjDINuGAUR77GhwU+YvW8ojKJQqUeCT9VNs8cCTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772799318; c=relaxed/simple;
	bh=NOK9MTd/4P7V1LU80Y8A7+QlHVwq/lPkRU4DrDWu//E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipkvo5/bm/WioogORLXPopMfY+o912oTlGbV+Fox6ILvNcAuy+Gm2R6UlqG6pXT/s8v7nBQd4v45yjqMq82IkdFWkpD11flhhCwsOV93PdWoguApu1ueCrF3/T8amLdxbUXm2TTkX69gZ3LejkWdH4VZWaRcAEd3paKcWWcJAn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWrwofNL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWrwofNL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772799317; x=1804335317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NOK9MTd/4P7V1LU80Y8A7+QlHVwq/lPkRU4DrDWu//E=;
  b=NWrwofNLfG8/AA8sN9mHjqsmu+iURNLcPOg+cTEU+JCXLflj+BFIR3Jf
   cSYOFIEGloJl0HqqJYtO6Lum4VIxcAShgSuGrxDPDPJ+jFtivh1yO1rHE
   /cGagvV+WXxgL0cUJDOJj5QyBF0fJpGNxKJWi/a9q97iynmjDWo/O5ouR
   qxvb+bz0bcVuX97FVYeYhXdNhDsp/d5rLQHTvXGf0xn86z8cC8ii0ZZKz
   jb8tUS1hXC8hhIwUzKRVPvJ8CnXQNzMcI+gjjxcDZHnHXoAEji5irOinD
   O0Ix4EF4DHz6RJ9G/YxSI0gqdGTTLcJo/zz804/zN19ucV3g9/gO1oVcI
   A==;
X-CSE-ConnectionGUID: PXT+dHqyQxKNjDtGxz7rJg==
X-CSE-MsgGUID: ZL7w9PfjRN2dccOIRq5oZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77506473"
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="77506473"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:15:16 -0800
X-CSE-ConnectionGUID: NTuYTsMlQC6tbAuZzveBlA==
X-CSE-MsgGUID: dP+d8Ou0TcWlUA7c7mg7nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,104,1770624000"; 
   d="scan'208";a="223686923"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 04:15:14 -0800
Date: Fri, 6 Mar 2026 14:15:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, mazziesaccount@gmail.com,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jic23@kernel.org
Subject: Re: [PATCH] iio: adc: fix spelling in comments
Message-ID: <aarFTxzKEWrj-MRY@ashevche-desk.local>
References: <20260306062107.51886-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306062107.51886-1-i.shihao.999@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 06, 2026 at 11:51:07AM +0530, Shi Hao wrote:
> Fix incorrect spellings in comments.
> 
> - informations -> information
> - specifc -> specific
> - avalable -> available
> - Digial -> Digital

Only 4 typos?

Can you run `codespell` against each of the subfolders and create the
respective patch series?

-- 
With Best Regards,
Andy Shevchenko


