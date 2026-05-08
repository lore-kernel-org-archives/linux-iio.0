Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4CF317167;
	Fri,  8 May 2026 07:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225948; cv=none; b=LhZLylqTcUwgqav4fx9AMOSAnxrROm9FPPKTgIUgh7bThbE+1T3KMxQt0DtDXvQZID2+/GH2Ixy0c7LEGUowQmPQ6CFgOvQJXpRAmH7+/0zcNPxVTRge836gygCbGXyffv/OWRNFjztNNr4xXo2tCdY1itQe8sIfMDvJh0xhxM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225948; c=relaxed/simple;
	bh=3KJYvNlKK18VM/TurhmhfXvLMyuHRaKhUpYV/Ngmd5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDZ2MrzwmU/76iBX5h3SuA42LjjGjcFOppHAQIJ1jhv/DkqHlgMV1BjEb/4MWsrBwUbFtJMjPi8SU2WNSecXBv6vzhRYDfDqffSPS6mbjqif0k/4luBs0g8ztW9owkOmvzdKcFECsYrU+R2ueV8mFr8FSfopJturC+Eo0EPHpxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iERjqM07; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iERjqM07"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778225947; x=1809761947;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KJYvNlKK18VM/TurhmhfXvLMyuHRaKhUpYV/Ngmd5E=;
  b=iERjqM07p6DuHz+HK5nU/yF/KkmpLPAQGhXIo/JAiKPRDH1NGXg5Xlxc
   PRKz2l5spjjmAGK3nKO58Rj/PBGrAiqWbnqoE9vclPappSCWkDAGT6dxV
   fIJxYlhQVlovlG47ZzGWqN5/YAD1EOhBEKI3+aDnlKWHt465hSKgd6TOT
   ujnA3kkVyaMEmrkEVjOpdbLX5l9nYhBSUGXANy+lfEtAyD6py71L4kDCz
   EF1sYXkEOuh2P6urHn5iW192LjBDOmoixEaQNiuyfwgN1UwmJONc6tr3a
   JRV4+bWJ5R+V5h64RIxh0cKKVOIoDR8NV8oHMwW/WjpK2sroKc2nhzM/x
   Q==;
X-CSE-ConnectionGUID: Wvb8U+sCTnO3fJDCBwc9dg==
X-CSE-MsgGUID: RGquxJuXQzq7sd+789h6Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81753492"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81753492"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:39:06 -0700
X-CSE-ConnectionGUID: 6V972PdpQJqr/arHx8qmYw==
X-CSE-MsgGUID: gzK5TLZIQeOMFhHR67c2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="235866325"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:39:03 -0700
Date: Fri, 8 May 2026 10:39:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <af2TFa3qd_7tcxeR@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 04:35:49PM +0200, Joshua Crofts via B4 Relay wrote:
> This series is a continuation of the previous ak8975 driver cleanup
> effort, as most of the patches were picked.

It should be v6.

> Changes include:
> - using BIT() and GENMASK() macros
> - moving to devm_* resource management
> - adding a scan index enum
> - moving from using wait loops to iopoll functions
> - various code style changes

-- 
With Best Regards,
Andy Shevchenko


