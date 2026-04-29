Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4502740FD9B;
	Wed, 29 Apr 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488856; cv=none; b=TgqG3FDAEFYDETQkU35zG0A/mGVs1NBQnbnxeKg0CVmUA1LlF3Eh7nz5fI/l3KcgJVDYUKcX9S9tJMYJ6etfPasCzFKOrqjmqX/rKNt78cTtoax2ighDSMIttKCKkrbgTxaZbfhVXaZ2AfJZhvPcg6MFUcCqEufkr9Uj38TH1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488856; c=relaxed/simple;
	bh=KZl02Po9IPmaQkVCuSyyY76lS/rJyX2knPHAqd70zSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CONm4dLx/31LxMI7i4ZSyivdH/mzSSfcqH6qKu0N42vykc5Hmx7ky11sVfeMtoOVYq/tCkPxpXShtKLup7Lx4kWiPgKcAAzSGWmqAun1KxphnIfu67ZRfuWCkp287Zbj8RTUUHk/yc0Lev/Cv7a97XZFoxRlSwgrcl8H1u/mSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkjNK2K8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkjNK2K8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488852; x=1809024852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZl02Po9IPmaQkVCuSyyY76lS/rJyX2knPHAqd70zSI=;
  b=kkjNK2K8UuaqabDjgQxXakAp9DENdByzN4zQPPhIvHYa1D/kA6jdBXjn
   WcBkrSDA9DGQhNMgfcGp/R+pmINQ+t6uwoyc2Szuab+5L1gg8gVMnICuM
   NuHWXzWBupE65fDCIu/PGTTd5M/juINcB158SYI5jahtYunkTHuLauHys
   VXLTDmp6H3H0TQ9HPPMNpk0ezy8uTiLbMRCyuj0Hd6WI4oMOXt6iVRHK7
   eGdoPjlPBCiUoM3XUeUhpykFru/n4oZ9rZpJJ9Ade8EcBxzMhtYejr+nL
   PNWrXqrxROHWYsGzyUiD557XDbcUzZ+I+nt8XZDzNGZo27xpW2c/mUwOp
   w==;
X-CSE-ConnectionGUID: fsNBMbVWReCTCZTaXyL5Zg==
X-CSE-MsgGUID: 1ka9J0iXSo6JBsv7zbVrmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78300804"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78300804"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:54:10 -0700
X-CSE-ConnectionGUID: UfGUAOLDTOyu9cWpodKJxQ==
X-CSE-MsgGUID: l7Vhr+hkSuOajtgvdhuf2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="227849870"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:54:07 -0700
Date: Wed, 29 Apr 2026 21:54:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/11] iio: adc: hx711: pass iio_chan_spec to
 hx711_reset_read
Message-ID: <afJTzdLxRZI_5wdT@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-10-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-10-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:42AM +0530, Piyush Patle wrote:
> Change hx711_reset_read() to accept the channel descriptor directly and
> update its callers accordingly.
> 
> Split the existing HX711 channel-selection work into a small helper so a
> later variant-specific change can add a matching helper without growing
> hx711_reset_read() further.
> 
> No functional change.

This one LGTM.

-- 
With Best Regards,
Andy Shevchenko


