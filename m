Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1793D36167C;
	Mon, 23 Feb 2026 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771846604; cv=none; b=nqAwqxdcjCNCiK8E9CfgyrRpvJWusX6cGMuH2ffqFLor/Bgk6A7hmQ93bAmU5vG+a4okphBxlttCCgDbIs3A65VI/Sgwdk8QQvw3UPut+TTSviFQruRRJB6d2KkSr3AXcx1yR0bCiTDOQ1edh+/iGJBdzJ7EHFHq4eRy5VhA/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771846604; c=relaxed/simple;
	bh=+CiWkSJvSDG/ZBxYikJ/9AIqaQHxe9V9+vF40kWmwxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCHWl95kTHYq8U2ioQhbPu9XHKm2X8rrfZgBWCby6O7IPMDc8gyDPDRSLC1wp2HvKjbNkk7H43bwk84FDG7FiIF39adOdNC27++NDCDlwSCrs2XrwmDG3ySlPXUW1qon8kn+bRYl6RIfx7tQYnz+pd0cShs/k23WdOLvglm4ft0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ImYzLmlg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ImYzLmlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771846603; x=1803382603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+CiWkSJvSDG/ZBxYikJ/9AIqaQHxe9V9+vF40kWmwxA=;
  b=ImYzLmlgdCMeRvvxGfxSigZht1IOpG6rvFUrKJMhXxCBxKwelm/C4bcO
   xn0i3tznpyv9pGnLAIcVpT7qku/OcRPzf3KLqPLiiyTyQMDs0Y9FgqylF
   Fwho21CP4ZXzNaGWc+uOiJt6nqqg1lPew6Ex4wQY/V0vQDkq/Vn2X19Od
   RrxB0lSm6xkGQQsz0puu3IJ1inqmQonJO9oktnrMZ46+6dUFMzdH/0+5v
   4z2W10G2Go6vLlNwZiVm3YDrT+ndD9ThfimUGKNOjjvaSqMPPayAuimJw
   YBm+irutNZV4ONJLU5Tw8z5iBXHexPJ4sSDh6Ma3cCXFBtQjGD40ETJ/I
   w==;
X-CSE-ConnectionGUID: LCZOgPcUTbaAog8Dforc/w==
X-CSE-MsgGUID: 9SY2j8maRAWpC+SxTXR0WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="83154723"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="83154723"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:36:42 -0800
X-CSE-ConnectionGUID: rDrk6PhmQ82ySnjYmgj5JQ==
X-CSE-MsgGUID: qbUkeSdZQCmtX1bshfBm5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214622948"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 03:36:40 -0800
Date: Mon, 23 Feb 2026 13:36:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Felix Gu <ustc.gu@gmail.com>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Message-ID: <aZw7xdFd2GE10u0B@smile.fi.intel.com>
References: <20260223-mcp47feb02-v1-1-41f80bdbbb45@gmail.com>
 <0ae976f070b0bf5a13ba5985b8e7d0f1efbb2cfd.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ae976f070b0bf5a13ba5985b8e7d0f1efbb2cfd.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 11:13:33AM +0000, Nuno Sá wrote:
> On Mon, 2026-02-23 at 16:03 +0800, Felix Gu wrote:
> > The mcp47feb02_parse_fw() function uses data->lock, but the mutex was
> > initialized after this function in probe path.

> Actually I think the better fix is to not lock at all? Why do we need a lock around 
> mcp47feb02_parse_fw() if it's only called from probe()?

+1! The lock should be called when it's required. Any explanations from the Git
history on it?

-- 
With Best Regards,
Andy Shevchenko


