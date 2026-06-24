Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D028E0F;
	Wed, 24 Jun 2026 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299599; cv=none; b=jH1rFHMoRcFbEEcjGCJjVQVk9zGKCl5e6+BZjbeF9rSnnwYIX/qp3XtaY5G/lJyjGDY6COYzjqXLHoOAy5Sc18y4lYmVuDE1Rt8PLxaFu7YqxP3Z8o4ET8QDPtymzhOn9O4NkdztjD/YzRo4AHcBd5eIIA9pEPfVjk/0IEBjAcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299599; c=relaxed/simple;
	bh=Y1mjq2Yknk3wL59CtXT0SQCGv5OLZG63SQqiJM8ssxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7reYr9sWzgA6Bw/rYWPMU0LeqVL+dbLQiSq0lCRk/niw+aZc2F9w9kMI19Lt7of0o3eu0vna2lG9HpiIfMbXzzE5OEygrwk/CiZQKuYVAxcKuPGEbeKkxzDnIP8BvELKmvOm58xZNawtfCchjvCAGSSNz37888bEjXLizhRvzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZubwrKQQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZubwrKQQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782299598; x=1813835598;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y1mjq2Yknk3wL59CtXT0SQCGv5OLZG63SQqiJM8ssxk=;
  b=ZubwrKQQUgsuHz6P6d3VbqL5DtAyDWDP/BNlhhe6XDWgTaIVLVraHgeT
   Kv+6HuXh5nuGTxz8deyR9RhBJeDqgCZnawjvkv6BnnZVRpM3TU31WcqBV
   rgsTnDAz83I+uSB2zriLup0fwKZ+isol0rERexDKznv2kH5oki2Wb8Ttv
   X4mOh/wy3zxC3YaUIF8ZBQaSElfKqNxdFs5onGC781eak3ioWqsvzr0/l
   QcPfWMR4Q2PpgS+yD8bzxBxEBRnodUsQFVf15yiJArTIZ4e9Jo8FUEHET
   tHGmSCXn6XpWEh7bJXUCalKNh+wgitDvaonfIzhtP/UVdwimRWdHA8ds5
   Q==;
X-CSE-ConnectionGUID: Vb8Nv4yiSWGG1exAbPl7aQ==
X-CSE-MsgGUID: 3m00QVnNTv2l72uSMeaCSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="105851215"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="105851215"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:13:17 -0700
X-CSE-ConnectionGUID: 1WrtED4hRbqcBtWgVgp1Gg==
X-CSE-MsgGUID: hRPaf3LXRyiUON5mq9S5ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="253705299"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:13:15 -0700
Date: Wed, 24 Jun 2026 14:13:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Remi Buisson <remi.buisson@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm45600: Use I2C match data
Message-ID: <aju7yYxhdYGfa4My@ashevche-desk.local>
References: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624053823.73969-1-pengpeng@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 01:38:23PM +0800, Pengpeng Hou wrote:
> The I2C driver provides chip_info through both the OF match table and
> the I2C id table, but probe reads it with device_get_match_data().  That
> misses id-table driver_data for non-firmware I2C matches and can reject
> a supported device with -ENODEV.
> 
> Use i2c_get_match_data() so the id-table chip_info is used when firmware
> match data is not present.

Currently there is no problem with that. But in principle I agree with
the change. Also it makes it on par with SPI glue driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


