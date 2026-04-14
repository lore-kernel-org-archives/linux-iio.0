Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680683B2BA;
	Tue, 14 Apr 2026 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186604; cv=none; b=pTUjJeTffIfZw/MisD+nQtuzdPVKtdVyOEzvntrOmPOiyMHOTrCfkHR2GohhmGxSvsEpdS5Vd7Vi0ri9Pjv+YuHpO8WqSqEhtIYM8HJzscjCNmd4qs2NNZtzm2bdMryX1FFLo21lmEnOHTB6U1EYuHcmJTvj0PyMg+w/vDtfSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186604; c=relaxed/simple;
	bh=CAo+uRjqi5k/KOmrg3V898ihkEa6qCe6uWZ+vO1sqmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUCkR8GTA/S5uCK6GAXzblWwn6+jpwIg8+gxPEirQxOccxAy2KFDzc5PkP6jF3xH6ag6Vc8o6CVoSRUu4H+Kg8flMFjFOTEJm5nt7++7Sb3u9w+FvM3rnPq3Q2PLNoFA0coXSTXm0sSayKJqAD8obSIs4MqK6ItjSFwWrbSgDFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SZeXMRro; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SZeXMRro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776186603; x=1807722603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CAo+uRjqi5k/KOmrg3V898ihkEa6qCe6uWZ+vO1sqmI=;
  b=SZeXMRromxvtBUgFDy4wGl+RMi/T5GmAJyL1KJyLS+M05mynqdH5kuwm
   dqpvAlE+dnY0XJ+gPKdDHD8EkBy6CNYxN7ddrDFaaMzg+XHnxs/OhDgh6
   MBiTYijqbxC+ftcZAjeLvvxRAsXEPzclzcWMGdVRFgzdePzohF5u6v0BH
   Lw8k+CQ/QbkElW5hA6X741kIiwLa2x8upDWxLCyxO11PK6K3uHE7UMquQ
   YAVZY4zlGpQ/63EsLsY1a/Qt7eTQoH6GjtqNqGJwbVCBDVRLMdKaEnnxr
   D5lwBi6xnbDLGqvUogNDpg/spJGd5HXjiTX0r3/PrV91aIFQyXnvhRAUe
   g==;
X-CSE-ConnectionGUID: +MY3fVemTcOszM5LEy864g==
X-CSE-MsgGUID: p6xHLDb1QDqMnzva6OfkLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="88533228"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="88533228"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:10:03 -0700
X-CSE-ConnectionGUID: JZ0cB85xQ62yFFowBWpj8w==
X-CSE-MsgGUID: 3WEpdOghRL+F+/wBv+PMkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229286780"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 10:10:00 -0700
Date: Tue, 14 Apr 2026 20:09:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 0/5] iio: adc: ad799x: modernize resource management
Message-ID: <ad505ojCcZgkyIFg@ashevche-desk.local>
References: <20260412093739.17116-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412093739.17116-1-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 12, 2026 at 03:07:34PM +0530, Archit Anant wrote:
> This series modernizes the ad799x driver by converting resource 
> management to the devm_ infrastructure. This results in cleaner 
> probe error handling, the removal of the ad799x_remove() function, 
> and improved overall code maintainability and safety.
> 
> Key changes in this series include:
> - A prerequisite cleanup to sort headers alphabetically.
> - Static allocation of the rx_buf using IIO_DECLARE_BUFFER_WITH_TS()
>   to avoid dynamic memory leaks during scan mode updates.
> - Caching of VCC and VREF regulator voltages during probe() to 
>   optimize read_raw() performance and simplify power management logic.
> - Migration of regulators and mutex initialization to device-managed 
>   resources (devm).
> - Fixing a potential race condition by moving mutex initialization 
>   before IRQ registration.
> - Removal of the manual ad799x_remove() function and all goto-based 
>   error cleanup labels in ad799x_probe().
> 
> These changes ensure the teardown sequence is always correct, 
> following the reverse order of allocation, and remove unnecessary 
> boilerplate code from the driver.

Some pieces still can be polished, but this is good enough, let's go with it!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


