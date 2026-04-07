Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DD83603EE;
	Tue,  7 Apr 2026 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574492; cv=none; b=HuWD1fzA5iV0CtAyWrOYi3DB+bMRSA0muz4kh7OmbR4n36cj6MkFvRGo/N0IbV2a1Ip07KoJFoYlHB5wTQMm9BeJP0u3GN3DkvyKk4HedbI+GLELaRjriL6wFCB09l8ZTgbTdUrqL8Kk21BPKkvc6v7M9EKYgXkFYuflvyqhyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574492; c=relaxed/simple;
	bh=dNgaNK5H+jLSs3bgDgOQM+RWRhzFi9TURbA2sMUnWDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEViqM4BmLsHp0dIArUwIOcZzG0VTDiroVSW+ZnxjHDDJ9ug37E9vWc8+I3rG+TayCVXwPxLdJyApkyv3to96DSSVxh8KoGgod0bal5gWtFJKFH4KfrAhxw4cao1k8FdFVEX7stfn8Xj5voEG3IBwyJKTuoq7eewqiTWisVPIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DCEILXYu; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DCEILXYu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775574490; x=1807110490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNgaNK5H+jLSs3bgDgOQM+RWRhzFi9TURbA2sMUnWDU=;
  b=DCEILXYu4takbXkH5vCLIk8RIhV1BqrzLJH1y8d5Q1W8t2IxGigDgVWG
   rz7JtFFpQGNRFXpGEuct7DHvtGb27/k5ZPCQhjPLXCHvQIfUOAju2YcIB
   /8wrZzgCYHYRT1O1tnfs5mDbrxp04PoAL9cLv+dLnHOBZ127FXpGLn214
   NzTsQrXZB9pFilNNPFWuSNf0545ADsctPaBS5AikWYqOzZrhlCJYNWBgY
   HFuSbn1O4sZMXczilTv4YfreXrMrwEFSsc51r80XKAP9aiDBuSEQTAzce
   P1IGfQ9hPFcX6LEWJaHHLH71zjVt/VQz4XueP3tOX0VgZ5Ad/1sv0rCgk
   w==;
X-CSE-ConnectionGUID: zK724T3USRKU1M6j+IS3IA==
X-CSE-MsgGUID: QMNYjW55SfqP+50BNTBWNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="101993552"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="101993552"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 08:08:10 -0700
X-CSE-ConnectionGUID: +gR3b0xcQbyQonDnNNb+eg==
X-CSE-MsgGUID: oBNQawsoQ4KiEom2MlCkaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="221619687"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2026 08:08:07 -0700
Date: Tue, 7 Apr 2026 18:08:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: magnetometer: st_magn: fix default DRDY pin
 selection for LIS2MDL
Message-ID: <adUd1Zs80z9xjqR8@ashevche-desk.local>
References: <20260407072059.222597-1-advaitd@mechasystems.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407072059.222597-1-advaitd@mechasystems.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 07, 2026 at 12:50:59PM +0530, Advait Dhamorikar wrote:
> The device tree binding for st,lis2mdl does not support
> st,drdy-int-pin property. However, when no platform data is provided
> and the property is absent, the driver falls back to default_magn_pdata
> which hardcodes drdy_int_pin = 2. This causes
> `st_sensors_set_drdy_int_pin` to fail with -EINVAL because the LIS2MDL
> sensor settings have no INT2 DRDY mask defined.
> 
> Fix this by checking the sensor's INT2 DRDY mask availability at
> probe time and selecting the appropriate default pin. Sensors that
> do not support INT2 DRDY will default to INT1, while all others
> retain the existing default of INT2.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


