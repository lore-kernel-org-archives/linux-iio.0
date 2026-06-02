Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D4533B6FB;
	Tue,  2 Jun 2026 07:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384388; cv=none; b=g6omkfisNU6EAbSqf9RGvm9F/nyo3GL7EwnFe3i/iVHJNMJ7yEF88oms13xiB/XOY/t3n2HD49DU0T7x8w25cEY7j+rzD2/GK+d6VsbaNmBmDhxPA++Obtf0Z2yk02J1fEOkyZvw9KmMMAiBiZ/XYxKtkMTtDlNUpjd/4Bt5Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384388; c=relaxed/simple;
	bh=pZqgUSeb/rj1OBHjbRTsgmbRS24jpq1fwdWN7QGsAsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqnjhPUz9ttE+DLuDVnkZ6UF3v9VIVXDRJ7vLuMGgtWFn+sIjKcRYaJ2fCzJwhQSW4vK60VkWtd9o25gRT0J/JUH2eGvYcW+MrDcEYGCgoW5/0XD5cOQm56Nhth9g61KGp0bBaPHe/qIm/rSUdYAPMYZU5ZJuARYP0UtbSmAdi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lfAO8Sqq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lfAO8Sqq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780384387; x=1811920387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pZqgUSeb/rj1OBHjbRTsgmbRS24jpq1fwdWN7QGsAsY=;
  b=lfAO8Sqqy/xnNYAANaoL069WVWyV9l2oj2EkeUeVemOcP+hYYMd9XDf3
   aKUunpkrLtsQQjRmC8ofUm2pJ7OlY4FnFc5Wbz7kElYo5lj6CvTRnfH3w
   LYl/hp6gprrowE7qGVYZx90uxPlfZPF/p4bDkuqzO16tYCeKvbiy3SpXY
   b9tuiITczdu4UJsChI7cuY5XTjECcCFiECFgOzzxtzfrQs17Gi7jidK+5
   8vGsKtM5QpCxZhX/YtlPXhmpF2GCFnpUSifZA3FBVHzaJKINYOTdUf/mg
   GyoPvCydb8i4wsFatSbgHyU0pRjeAY2wyIi5evTsxl3AFpoBhXF53tzGZ
   Q==;
X-CSE-ConnectionGUID: FG4T3jYiQpW78S4wdh65hg==
X-CSE-MsgGUID: nm5GgEMyTcKOxXQY5NiLCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="92647630"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="92647630"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:13:06 -0700
X-CSE-ConnectionGUID: Fv1U44AmQd6WKo7zxF2mCA==
X-CSE-MsgGUID: zg/Po0SKSV6HK3FzFi7Shw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="239656018"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 00:13:04 -0700
Date: Tue, 2 Jun 2026 10:13:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tduszyns@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <ah6CfotGBX2VIAvL@ashevche-desk.local>
References: <20260519212602.30541-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519212602.30541-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 19, 2026 at 04:26:02PM -0500, Maxwell Doose wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.
> 
> Add guard(mutex)() into sps30_do_meas() as every caller locks it's call.

...

> -	mutex_lock(&state->lock);
> +	guard(mutex)(&state->lock);
> +
>  	ret = state->ops->write_cleaning_period(state, cpu_to_be32(val));
> -	if (ret) {
> -		mutex_unlock(&state->lock);
> +	if (ret)
>  		return ret;
> -	}
>  
>  	msleep(20);

Hmm... msleep() under the mutex?

-- 
With Best Regards,
Andy Shevchenko


