Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB2F381C4
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091141; cv=none; b=CJFEr+k2HC4XoLW5fzu77ue3j2hqbILeLyeHUiC6MtPZ8Qt/wvwwp3H4OfZVUCkrDMJhSi/2zgd6URsMobZtizh6E2JenW4WDsEU9q0zZgv2DtETIVg2ZtAzzoXpHZJ25ShxOmXkYasCgXZR1cu/GbfM+Lnx72xTk23K4j15dy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091141; c=relaxed/simple;
	bh=BKsmAN+zIW3N8wUrclG44XilvraROBCACan0IJUzh30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jckz/lf0zP9EonC0qVLLTSbZGmLK5GE5iwKwoNddzYUPjn5VvCS9YM2KjlDI2M+Bn+DTmdngjOVYypYCBpMG1EmWCqqsdrLc/x+kKlmDUZIsUo38OoYSoFH2nHtRRnyyy8uiScfnZcMSUM5PTaBjBCaHnpfV8NHHpshwkgGviug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqcuvvTU; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqcuvvTU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779091140; x=1810627140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BKsmAN+zIW3N8wUrclG44XilvraROBCACan0IJUzh30=;
  b=MqcuvvTUlcIhVA9hXq8is4VjzP4m10wJMBlkIEU3iu5pfCh5xPc9xjQP
   iS2RR92QTBiCHni2HZpLcZhQoD2m9Ou1wQEAJGBGLTimkRuQj+qZ5SbnL
   XC5pMVviB3Uf85gPG/kZL5684e/3/S4csnbRB0PCkLvLRCbhVWf+wsehY
   LeCLlwpWl4QzV3OCcxQWre3cf8YgUPgOqbYM+jD96LGgr484H91t89loR
   NUkh8hsPIlKkRJH+DHnIaHst2U0XF5Bf2C4WHJ5VVaSiaySyfmnjv4Sv7
   P9bflbOEr9xWX0GsZdck3wLy3r/55toB1duCNP/vgneRAY0+09UGyqX4X
   Q==;
X-CSE-ConnectionGUID: D1n81LiPSem8L2nJ18iEVA==
X-CSE-MsgGUID: ju7s53MzQHeQzcy2ToXRZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="80059426"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="80059426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:58:59 -0700
X-CSE-ConnectionGUID: k9yZKUDrReWFbjxQaOtGig==
X-CSE-MsgGUID: 2pmwY0fYQ+6ZCAOZm2Yb5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="241174016"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:58:57 -0700
Date: Mon, 18 May 2026 10:58:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Stepan Ionichev <sozdayvek@gmail.com>,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: trigger: drop generic interrupt trigger.
Message-ID: <agrGvgYmFvEfTrCT@ashevche-desk.local>
References: <20260516113219.573610-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516113219.573610-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 16, 2026 at 12:32:19PM +0100, Jonathan Cameron wrote:
> There is no way to bind to this driver from firmware and no explicit
> platform device creation calls exist in mainline.
> 
> As such it is dead code. So drop it rather than potentially wasting time
> modernizing it (see #1)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


