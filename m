Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6A4221FB1;
	Sat, 13 Jun 2026 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781356471; cv=none; b=KLOBPrpT7IdO+xjUOl8UWfcwaASBVMivWdH15K4c1wKR5pQi3fKIYckyDm+gzELW0xLUygv4RkCr67IrJPpneQ3Tu/2rzXD9QUi4g28qvJZfBAhALyCJiFFFtZrYqqFwEPQOuTUwNfTTwAHETI14fSrVDV1sTkjlZBxgx8nN0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781356471; c=relaxed/simple;
	bh=GQzyzqfv3cNOvwBv+wYbWajQm0iiuK5x6/kNvv3jw8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1K2QXOGacbqJXAyyMBH5KW6vOA+BqxLQfEb6NCC02d52RpveCsBMXO+clkq44ez/gioVJpjca/Huf/2ljWzqxHlxpLZFD53GpHhiiMMUiB52KI+N04ru1h3s9Up4ALMcNdpPtdboY6RiKgbPBnRteClz+HuSArNIiyrT9Xjgos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gq7p/9vK; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gq7p/9vK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781356469; x=1812892469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GQzyzqfv3cNOvwBv+wYbWajQm0iiuK5x6/kNvv3jw8w=;
  b=Gq7p/9vKFXb4zvBGPbBZStkJrtz+5lXryMzuEX+tNtfPU+2YKqQ/w05o
   2y5x/izWcwGSUOTEKZVIxe7eYqkiyA66+TgU5taD3GhYQkTZ3m+ISlncR
   BFm/QwB4uxPsgEkoS7k5dYE3VN56JAKCYYdwhtvVDNtWnHEPxhQSR52A0
   5QdVYM7I4bJvtjJdqmQML2jENU9pLQFj0PbP8U4Eo1CCijy5YZPg4s3KK
   sb5b1bpydMsovKVWMKK+SdaR79xfmZaZlHi0pYYzUzgj44sRh2aHsQUeJ
   zTGxKwZW/s/eZKQw9KWv7JiSJpAfCr+8TTrxzUPUg0azwHlCJiKzyLvYI
   A==;
X-CSE-ConnectionGUID: YyCtfEeuQeKX5cI8AUYWoQ==
X-CSE-MsgGUID: OhTYuwwPQKe5O64cVGuffQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11815"; a="93660279"
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="93660279"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:14:28 -0700
X-CSE-ConnectionGUID: 4eZ3BlnNTfG6my6V5Durcg==
X-CSE-MsgGUID: 33gQTsgKT5iZZhtf6CNo4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,202,1774335600"; 
   d="scan'208";a="277249309"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.184])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2026 06:14:27 -0700
Date: Sat, 13 Jun 2026 16:14:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: todo: fix typo and refine resource management
 items
Message-ID: <ai1XsFfGi8_dVkRv@ashevche-desk.local>
References: <20260613033132.2344644-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613033132.2344644-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Jun 13, 2026 at 09:01:32AM +0530, Sanjay Chitroda wrote:
> 
> Fix a typo in the staging documentation path and adjust formatting of
> existing entries for readability.
> 
> Add TODO items to track conversion of selected drivers to device managed
> resource APIs and evaluate usage of cleanup.h helpers for simplifying
> resource management.
> 
> These updates aim to better reflect ongoing cleanup efforts within the
> IIO subsystem.

No objection from me.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


