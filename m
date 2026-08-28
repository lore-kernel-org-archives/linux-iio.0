Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AC3CB55C;
	Fri, 28 Aug 2026 06:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899226; cv=none; b=jRWCeN3Q3FDNUTxxFD9gnLyoHLm/vzIVPrUUXbbFebwC6kRuh6M1n3jNFMsM3DZ1bk31i0WfqiDH4dMQIU/38YlSjV2d4SZE03LSRxbWYJ5tHbDw8WT56hj1UevVApL382zB+MMzQ9WMbxswxmVH3kLkKhjaYOLYqK4lIX8xlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899226; c=relaxed/simple;
	bh=9QvlRBJUdn2N3iAU+FRmGum1UMlhk2pHgIhQjwENwGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGfQzWce5CiseUHDx0U9w9OYGBCe5W0cq9h7ygflLTlugNhXtsaWcpMue1a9xXs21N7Nm73Ozc/7/LUAxlrr31dBhLjYuzvQ2to8MtWTc60XT63Fci7gckMKNsbrwlbRtjf03Ha9+LdKZfLxgqlGEMvWaoOP1WPTBgGQImGOaR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afa7oUL/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afa7oUL/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787899225; x=1819435225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9QvlRBJUdn2N3iAU+FRmGum1UMlhk2pHgIhQjwENwGw=;
  b=afa7oUL/xa6JkM/JFEikSymi7Nxc4hzUqXHXz2k9LYc1LTOteJIOJI3J
   hecZOZkOMBI5gMtxWvaOcYdsXnjTuUkldOFoBQBN8XuJ4S+I6DFrsVCM7
   DtarO4inBDCd2Hh6deLZu7eCiF1/oCdA9eocHp7c04hEx+tWUFaEdyMFN
   1Drbn5tWf6tW3wnH+ihoY0kMPlN4cx6joNCiaZtMqq2XbrFCY1Mc4MJYd
   myjlcGgxl4tPef7hU9U3Wb6ZIANWD2qOcUXYEvticZpUjgrvgHwIBRdKu
   a3EzQpwzqByA7nL0MOC1VjkIVJIdvuYuIwjolDlkG2F3i/obnNKMc3uKn
   Q==;
X-CSE-ConnectionGUID: Op+8oKEgSPKN7P3jSgUJTA==
X-CSE-MsgGUID: LoM3SbQMRoye/sfK9GLwrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88261038"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88261038"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:40:25 -0700
X-CSE-ConnectionGUID: mK2sQyTwSWSIqCCAx4StHQ==
X-CSE-MsgGUID: 3ozsoMwcT5yZnVHFkjtDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="268655173"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 23:40:22 -0700
Date: Fri, 28 Aug 2026 09:40:20 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
	dlechner@baylibre.com, groeck@chromium.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com, tzungbi@kernel.org
Subject: Re: [PATCH v4] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <apEtVIAPv07KFPQB@ashevche-desk.local>
References: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828021350.1666063-1-triet.hoang.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 09:13:49AM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS() to DEFINE_SIMPLE_DEV_PM_OPS()
> and pm_sleep_ptr(). Also replace SIMPLE_DEV_PM_OPS() + EXPORT_SYMBOL_GPL()
> with EXPORT_GPL_SIMPLE_DEV_PM_OPS().
> 
> This allows us to drop the __maybe_unused annotations from the resume callback.
> This is a straightforward cleanup with no functional change intended.

LGTM now,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


