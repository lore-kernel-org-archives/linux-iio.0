Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D212C187;
	Tue, 17 Feb 2026 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317444; cv=none; b=HiWeo+uzbI/vFZqCyT3HWlKI8wohyxGy6ZTCy2ZQHp9ZoqmSvR5pmK2n12oXQupZVc/5sgOcI357U41R43Xsc7jAspCu4S0knzRqlY4evs96+akuV6t0xNtPmdUbRbWimhAQeohSHVNFD06RqWpPGMwa4g/dtrck5hmobRF+xWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317444; c=relaxed/simple;
	bh=1aezwOgVG/DQ9NWzBo3TUZw47EUrAzNvOkRVjQceqyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzK1RIMC9MWzSUgHDs7MVKG9UDfYSRMhPbJDSaYqb+Nd81+blWReQv1Wb2hmNJrpdNVNndS/T7bFIMoUtarWDfK5Jeldjh+ajVjI2hBrZOR0pixfBA9JgbXd+dss7vEgmT8FwTHBan5ccTmHT84FWl//Oz37LtY4LLbCEtohl28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C/N0v/8k; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/N0v/8k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771317443; x=1802853443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1aezwOgVG/DQ9NWzBo3TUZw47EUrAzNvOkRVjQceqyk=;
  b=C/N0v/8k6bJv4YpfwmLgbkEZnJw4CkLNmxE5aSVpmpiLoIVqTOaLvbZj
   crSGpPXRoe52LvAJdTOtVjlZhyN7mQiQz+UEMAHRXfLKyQmHxYynmRYGa
   Rj9+ROWz4+X+VQzLl32AdUxO8eWVrjrEyDu+0O8dWiDHig4BLx+r270u8
   4KKGPtLURq5Y++FEBeuw5d2OZhuosnItvlk/RqKgZ+9mQeBef4uz1iT6C
   V5VU8evrtAJSdCjAEXW4Zzo/CGi569FWNVQZFcEf8gwKpqCD6sqTJPg89
   sOAeK4+Ea+ooo5YppATwb2nXpiomLJ4DSO7lGrtuJu0BPn+K2HESDFQwY
   g==;
X-CSE-ConnectionGUID: h8NBwNrfRDCUHVZrPC8qNw==
X-CSE-MsgGUID: 8g2oPzPFR4y+nvj+VMX5/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72289233"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="72289233"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:37:22 -0800
X-CSE-ConnectionGUID: 46Cpa1YpSwCkAWY0vpNa/Q==
X-CSE-MsgGUID: 5ECHu3HaS12UWHMy9gHIAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213061421"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO localhost) ([10.124.220.245])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 00:37:21 -0800
Date: Tue, 17 Feb 2026 10:37:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: gp2ap020a00f: simplify locking with
 guard()
Message-ID: <aZQovkDI3G9-B_Zr@smile.fi.intel.com>
References: <20260216005317.11763-1-ethantidmore06@gmail.com>
 <20260216005317.11763-2-ethantidmore06@gmail.com>
 <aZLCe_5C8e82EMGO@smile.fi.intel.com>
 <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DGGOWGRQGI1C.XSJ585TPVWZA@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 16, 2026 at 03:04:55PM -0600, Ethan Tidmore wrote:
> On Mon Feb 16, 2026 at 1:08 AM CST, Andy Shevchenko wrote:
> > On Sun, Feb 15, 2026 at 06:53:16PM -0600, Ethan Tidmore wrote:

...

> >>  	int i, err = 0;
> >
> > Would you need the err assignment now?
> 
> I'm not familiar with iio_for_each_active_channel() but, if there's a
> chance it could run zero times, then it'd run into if (err) with err
> not being initialized?

Have you read my other comments? I also mentioned to replace

		err = -ENOMEM;

with

		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


