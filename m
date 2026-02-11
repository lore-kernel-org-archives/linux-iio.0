Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C534FF77;
	Wed, 11 Feb 2026 08:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770799220; cv=none; b=EhJTol13Nlj3FRFhISPKfIO4/vbEWySODJtHiAbQ9yNXsZOeld5/Wrhte/2qsd6LkmJgCy6omRWbjEk9js7NGUTLFJNyUV9go5Ze0atY/c809W2WXbzpO9FCvkhubWvay60pVAKq7ykpet8sI1jni2RgE5uL7xmaf8ZxVO7hl0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770799220; c=relaxed/simple;
	bh=Ywg78rujmRv5CJeNKXw4jDa5pvKemfHcQa4xOODkAL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogXaObAHva+7XGhcRFN2siqs415PRBXerklSuVhGvLjYPVTtDBhg8zIcMiMlZAVupTz2sTGSK3y6bpDQEp7wXuB/eP913fTgiuUVfr/eKLkESnUin+1RpPfwkIXGIcC8/HX7Z0DR2Sodgzzv4CtPF+1liXN5TOZ4LLSmAOYJ5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JBC4i9uw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JBC4i9uw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770799219; x=1802335219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ywg78rujmRv5CJeNKXw4jDa5pvKemfHcQa4xOODkAL0=;
  b=JBC4i9uwRLBFoJWTwOrszIKylHuBHTId+5pqMbDrN+A9WfoXQmrC0rH6
   mT2l/AMXjiVVCYsjUI/xnnYCrGOg4DkkO31Do7C0Y6TxH5FKkPerb9j50
   fVJXHuAH6OSirSFmFTcG87rmbzBEbQRQW6ILudnH0jUhvXHZg2oYo8/xJ
   h8yqLZH523Jb1azpTCOJFE5s99GuvlYSt6F3GzMMc9zWuVEIlnrzD57Dh
   z7x8VkUJC4+iCbXnLRQyASn85kwFjIMUOwqdpVp+9ivq01cGKaC2dCE5c
   7D4oCrimsd5pyww/36N29Kc6vjxSYigMTmsXt1eaqcQFbnd/yEA+AekQR
   g==;
X-CSE-ConnectionGUID: i7gb48WkR9mDf7z2xOCnqA==
X-CSE-MsgGUID: FSqYg16pR8SeUsA4noHUwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="97400827"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="97400827"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:40:19 -0800
X-CSE-ConnectionGUID: h0LWK1+sQ2abg4osQDwZPg==
X-CSE-MsgGUID: 4MAdg34gTV6pn+QfvJd8qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="216695171"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.220])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 00:40:16 -0800
Date: Wed, 11 Feb 2026 10:40:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: magnetometer: bmc150_magn: replace msleep
 with fsleep
Message-ID: <aYxAbuaZhrOD95QM@smile.fi.intel.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-3-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210233945.40975-3-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 10, 2026 at 06:39:44PM -0500, Neel Bullywon wrote:
> Replace msleep(5) with fsleep(5 * USEC_PER_MSEC) to allow the kernel
> to select the most appropriate delay mechanism based on duration.
> Using USEC_PER_MSEC makes the unit conversion explicit.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


