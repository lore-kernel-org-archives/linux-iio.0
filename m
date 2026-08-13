Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D733E34E;
	Thu, 13 Aug 2026 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611094; cv=none; b=mdORJCE52SFGJ4p//my2OvkyaUvPdHVeySnEF1O1oYfEI4BJGw2qkYsdolBWl02wNaVuP7Zr4mFexuimVRou+eZQ84Bj+fQy4HE/5T5joeZk/0aBR0+p8EXEhKK9ANATOocBXBR1E2dVNPXuSyFrwfA91Lfwh8aZ9XJ+4gKvKss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611094; c=relaxed/simple;
	bh=Xn1Whnx+f/hbXpD42Z0pIMrzYfErglD221sXvE1AKfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOdLK+U5B70hVefquMyg5xRxy73POkc+rsvEaaaBzCH5EIaxOJseH+z7HLffNgUMIfINyt0JwlUzJuIxoNnuiu+1a8dYUlJWynUXw6XFvZNuM8MFyK/fIPtn6xPvnsDWSs/i3pfOiTFfo/6WAD7ptPgPnDs/h1cHVj05VUy7NW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJzh5yUQ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJzh5yUQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786611093; x=1818147093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xn1Whnx+f/hbXpD42Z0pIMrzYfErglD221sXvE1AKfI=;
  b=VJzh5yUQ/udloIyhdA/53X4S2VmBdo7nSDRhFU/P5+lHS1LY7yjOwE6Y
   VVLlg61HPLJ1c8XAFykDH9nQJPXxAcKp4tRPLqHXmH0JmmOFuXuHM/T24
   uoKZe8RM2NnVNUPZmfu5uIhCpL9QRtBa36AaaFCtDSuBrb3ga7kyxnXjM
   shbODgdr1YBYDUBDLBdsJc7jmY7Ndln1jCBNBnRIEhNVZTiIppJcLF4Mj
   3gTsHSt7AwUuKU6bxDUU1jMdUWk6wce61o4to+VLDOR+M88HBZzjBl+4d
   btVlf6vAfmR8J7s4Xt+suXvi39kciO/iSp0U34pMymnNaSceDb0d9yh0q
   Q==;
X-CSE-ConnectionGUID: CutsWyQBSgyuOSnCwvskNw==
X-CSE-MsgGUID: Umxe6DgiQ1uoj/yx5oT0ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="97527925"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="97527925"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:51:33 -0700
X-CSE-ConnectionGUID: N4nPsqKnSGu+WbhjRl6bwg==
X-CSE-MsgGUID: ZlW+FO7pSRWhxx37emUkvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; 
   d="scan'208";a="259635615"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.250])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 01:51:30 -0700
Date: Thu, 13 Aug 2026 11:51:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/8] iio: adc: ti-ads1015: fix PM leak on probe failure
Message-ID: <an2FkBoJNRCaeAkk@ashevche-desk.local>
References: <20260812164433.23011-1-architanant5@gmail.com>
 <20260812164433.23011-3-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812164433.23011-3-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:14:27PM +0530, Archit Anant wrote:
> If iio_device_register() fails during probe(), the runtime PM
> subsystem is left enabled. This leads to a resource leak upon failure.
> 
> Add the missing pm_runtime_disable() and pm_runtime_set_suspended()
> calls to the probe() error path to ensure proper cleanup.

> Reported-by: Jonathan Cameron <jic23@kernel.org>

Was it public email?

> Link: https://lore.kernel.org/linux-iio/20260718225515.7e49a458@jic23-huawei/

Ah, this should be Closes: tag instead of Link.

-- 
With Best Regards,
Andy Shevchenko


