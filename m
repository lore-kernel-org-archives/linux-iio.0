Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52B835836B;
	Thu, 11 Jun 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205678; cv=none; b=mtzbUn8XXrX8bmi+uc1z0g28TVktUHUbfLg6ef8NNMrREhbch7HHTa8EHDMdYSzaj2/10UnVakmcqOOiBPz/Wl1NyTjzEM17ISnntQc0zEEN+nclta//L9rARDx3T2HPs/aQGLxtwlBSkOmXhLXntjU+1OWI/1seyeyXU9A63gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205678; c=relaxed/simple;
	bh=2siqGVOyTdjqBI8LXLnE34B+Qkp88yzK2QrXO3Iuf14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BhACvLwhnXliyf3ioR5IbKYfwDK8TXBBac1wMTuflcXaU2i1JGOXtoE9ylDCONCaKH0IWLvb+vSY57zh+lp7M32NV0PI6aB+5lL+ked87hz6j2PXXakD+Ij4LF/KJ6NF9ZJq0E423CksiQ5ZBo7E+80hu1C8heubhp5gaHUvpQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UfRovwAU; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UfRovwAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781205676; x=1812741676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2siqGVOyTdjqBI8LXLnE34B+Qkp88yzK2QrXO3Iuf14=;
  b=UfRovwAUVuj4m1nwE0MzNOMKl1Ia1YAKfsYAWZlMuke++YEYJG8YL50q
   W5QP5njF63HUMJh0pQo6PK/w7d3irT/p+NkJZD7Hi3ThoPkgHfiw5OHZi
   V8MDkNUTVA5v4UtxrynW3YJVy+e0xQngSfIGTkhgwPQiYnHGdAHmAK64n
   OGzasbzWJKOG3ymsqtseKypwja3Cmco1CookdIBAJ+uCMi/po60cQi2ka
   dSG3sjIahwc1dECi5aeo6yKO7vQdVR6Tr2/TqgZ1lu1LMKMftPr3oMAJP
   saaXVLrqENmCrIXVe0zY1ZYo9dauaxw/pqrq67Tobhvu7re0dXqRIs/xM
   Q==;
X-CSE-ConnectionGUID: /CYjdzCGSeOnx5Wphed+VQ==
X-CSE-MsgGUID: ucYDXylyQvG0ZeH899PSGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="84600359"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="84600359"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:21:15 -0700
X-CSE-ConnectionGUID: omn5vSxQR6ilKB/hTx4vMw==
X-CSE-MsgGUID: qI1vfuoUTcK/+4H9ZX7o7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="244147539"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 12:21:14 -0700
Date: Thu, 11 Jun 2026 22:21:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: proximity: sort the register values for
 vl53l1x-i2c
Message-ID: <aisKqD7zjKxa7L0P@ashevche-desk.local>
References: <20260611134245.30042-1-email@sirat.me>
 <20260611134245.30042-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611134245.30042-2-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 07:42:29PM +0600, Siratul Islam wrote:
> - Sort register defines list

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


