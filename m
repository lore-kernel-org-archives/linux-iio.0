Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603A83ED133;
	Wed,  6 May 2026 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060048; cv=none; b=H73mp1+9VTsySIu+bEZvZ01V6JilMmCP/B1bDmvw9Xh7rT+RxvH7TdiiX1t47QBHPunCtJ8DfGhvgeE7C0pigcu2OBn01BhXZITGm3jZeXa3w9VCpx1uktwvclXyHZkyntudBTz460g5SoHr7J3qRUK/IijCjiTB3y2ZU6RHcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060048; c=relaxed/simple;
	bh=2ENLF8a+7LKOJP5rOpLzkZENLlGYRgzJqwlC3Cewjg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGBvVqcDZ8Tu4CIw/dYGi4SjJGtJ4bDOUTKN+PhX372J05qFANPGPzSSgx+uFg+pBsNRtevVC68ZK7OKCymv+9GCC7tBpM69yBbtFJvf0K4R8N3P5NOtS8lzV5gjMON6c70NO2DgrOPocw+6qw1QgiSujmlFhItA3+orhs9zAxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c26isJM+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c26isJM+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778060046; x=1809596046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2ENLF8a+7LKOJP5rOpLzkZENLlGYRgzJqwlC3Cewjg0=;
  b=c26isJM+/SyRWxl2a52Cl2r/9fKRZ9YTli1XUvWeU25a32x1eJIZxxkd
   ZStndxkx8GTRYMY03IHwRE/rkI59veSPkhWEkEDC8/8zlw5eZ1OhFFUGS
   KRVBSUj1/REgWI87k+3DNU1yPCBwXa4a6bJdoYUwejDjJLbvXEJ9+UKvI
   LLBH+EZHtwrbF0do5qjcj7uJ6m+zI63XZg48F1ESnaM57TFAWBQx/VeE4
   pb9TXug4EgmKP5TrYlLG5Kk11AUzaqUe+Z7JfBrFvwdab4I0XFd2Upc2V
   XUR/+cpzwOAkhflyx7MAmobzSWKNW+R9sa4fyCRUEkP3ZRTnZSk8vtRBp
   g==;
X-CSE-ConnectionGUID: zvwqw25GQcaVnWp8UJaqFg==
X-CSE-MsgGUID: Yl8iNcNAQO+Zk+No7cQW9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="81548671"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="81548671"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:34:05 -0700
X-CSE-ConnectionGUID: a3wq0c9SQ9Gmnn+FjzoQOg==
X-CSE-MsgGUID: 8JLjm/P9S8WIB3B1ebF42A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="266442843"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 02:34:03 -0700
Date: Wed, 6 May 2026 12:34:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, sakari.ailus@linux.intel.com,
	christoph.muellner@theobroma-systems.com, martink@posteo.de,
	mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/10] iio: accel: mma8452: use local struct device
Message-ID: <afsLCKIEqzyMRL-c@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
 <20260505174640.3998281-8-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505174640.3998281-8-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 11:16:37PM +0530, Sanjay Chitroda wrote:

> Introduce a local struct device pointer derived from &client->dev.
> This avoids repeated &client->dev usage and improves readability.

...

>  	data->chip_info = i2c_get_match_data(client);
>  	if (!data->chip_info)
> -		return dev_err_probe(&client->dev, -ENODEV,
> +		return dev_err_probe(dev, -ENODEV,
>  				     "unknown device model\n");

Now it's a single line.

...

> +	pm_runtime_set_autosuspend_delay(dev,
>  					 MMA8452_AUTO_SUSPEND_DELAY_MS);

Ditto.

-- 
With Best Regards,
Andy Shevchenko


