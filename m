Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500539CCED;
	Tue, 14 Jul 2026 17:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048740; cv=none; b=jgngh5RdYdrd/CC1AVokNHPrKeT/k0dxY5SjyTFmI0hFeSM8wDe3UqKSSOjUMwb6+QAn7yrg+DtFHx2fc1Tl7uFFWwrHg3Tcr8jAq5yX24SKl3+cfnjVSw9O3mzh14UGGOVH/jkJ7gC1RD1iWqZH6B8vTwZECV9y/kpl812lDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048740; c=relaxed/simple;
	bh=Pg8CnYTvMz4nIHKqp6VMsK/QEoiefp7+lcDM56QNsgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPumpva89EXiMWReljSbeq2lpnr2YJxtUO9FfpfUEqFfcZDVHwMq04xjRSuF/p0iSC3qOtwefCnSJgbfo8d+K4R8pZ1wDsGZD3csa8VDBKFjHwXbYD3cf03Beo/3/JhigeHkEODgFTtQKWX0IdxknaoGBJY/+JKImtHvhLHnsmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G8yxJ4hH; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8yxJ4hH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784048739; x=1815584739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Pg8CnYTvMz4nIHKqp6VMsK/QEoiefp7+lcDM56QNsgs=;
  b=G8yxJ4hH7AI2SsIn/sGO2MdtMoWhcYDD2Ic0f8Z2jE8CRRTv7nroSdw5
   Nj3Hjk78pKq432zf1u6LxEo+pquzctt1hc+07tzT5tuJ7b7esv87U3hHE
   vNNZmJ8RH14L3xH9pWiSaNL0Dp8FPUiudYxBHvIcgDrQ7uDeVycMFeu2I
   Y48WKLD46L1mj32DzwpfK7m4NPfjJYD/lBhmTlCAIESg3g7x1iJYOpOfb
   MikZEChTyzys7zX7U0+kjt20IJl1MaVXcJp8NYR5rO/nCNeDqMich9nuF
   D/cPi+cgTYY9XWAF0ISbBfYSFUTeng4P+njsNzOmujafw+0/6fpL4fU9t
   g==;
X-CSE-ConnectionGUID: VASUp/XBRYGPWiiA1C9cMw==
X-CSE-MsgGUID: qNn7c03DTHqDeBBXi8Qo8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95323287"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="95323287"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:05:38 -0700
X-CSE-ConnectionGUID: KcXEyK0IRKKmnW8rbBjs5w==
X-CSE-MsgGUID: G/gVSr73T7mfCS07WreYag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="259762191"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 10:05:35 -0700
Date: Tue, 14 Jul 2026 20:05:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Erikas Bitovtas <xerikasxx@gmail.com>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] iio: light: vcnl4000: make read-only const array
 regulator_names static
Message-ID: <alZsXBdAJEjkpKZR@ashevche-desk.local>
References: <20260714165740.186119-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714165740.186119-1-colin.i.king@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 05:57:39PM +0100, Colin Ian King wrote:
> Don't populate the read-only const array regulator_names on the stack
> at run time, instead make it static const char * const

Makes sense
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


