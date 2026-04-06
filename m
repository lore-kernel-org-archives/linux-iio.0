Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E59390222;
	Mon,  6 Apr 2026 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775505060; cv=none; b=C4zkA9fZ4FdaJxpeA5lMIfW0ulnGaWqjBZ6GmP/ooy8lHs8/UGTQ3f6B6UxG+8KLyvGgJysaXGStvyfgMRPxtQWOJuQRDhvO4r4McUacvfT9axyIM574k9y+c7xAi83CVjAfp0vba39l+7XVnJ91dkBpVwfg4u+eer9axET/KMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775505060; c=relaxed/simple;
	bh=9HsoYKKQCtYxPkQZP7vbXfcqWs4ITFIChHe2KTizuAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfBc8aRsNu47ZIzrL+nC3O6AqWgUtonHTPPldMIcvxbAlqnN/xUdivUvNl8R+HGEcQmakrgkL+CowfHBLLUA30sfxdk6IJO7Zjixh3K8OwTHw7vP0xjIQyiPJhFt2lRqRVb9m/seJfFh3lVrFGlCE25Y2RUfAHZkSFZzHjLKBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E8lvlYgh; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E8lvlYgh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775505058; x=1807041058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9HsoYKKQCtYxPkQZP7vbXfcqWs4ITFIChHe2KTizuAY=;
  b=E8lvlYghq0WFQRyHAJOzuSpKsR+NEb6jsCzwlzK3b7bfJj04gVBLmGt9
   gOrk7L96tdoSZ8r9ds+dtIbk6fy6CIEVbyMf0WsdKtvN3Eq9Znv+yQNV/
   wC5u/TV1WL1VwhkC8do3SqLiGCQbe1iMJ76UkgXBH3m53LtdO08d5E1r8
   EBtlN9lQ2ZjwHLVrUiVQr/iItx+nRNjm0W3KmZ9SVNnc36hvm7xAJxKfu
   K4uO/9hpxiqt6KZ+QgipfyirCknTz6ZZlNAuioygcdYQ08GtDsaHNWvmh
   JsMLeXQ/sr0+9SFdnznrGr00w0kMfiuKiH+oXik8Jkr/pFDtOqhKHSwHm
   Q==;
X-CSE-ConnectionGUID: imy9h7p5RfWRfMtViN/S3g==
X-CSE-MsgGUID: 9ndMq2vLQLSr5tked98rrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="75500398"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="75500398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:50:58 -0700
X-CSE-ConnectionGUID: IyQdbS30QVam2CVFChOuXQ==
X-CSE-MsgGUID: akqCnIIaQTWSpyaAcKALKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="251090491"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.73])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 12:50:55 -0700
Date: Mon, 6 Apr 2026 22:50:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4170: use lookup table for gpio mask
 selection
Message-ID: <adQOnSHRS3baSTLv@ashevche-desk.local>
References: <20260405213725.25426-2-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405213725.25426-2-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 05, 2026 at 06:37:26PM -0300, Guilherme Ivo Bozi wrote:
> Both ad4170_gpio_direction_input() and
> ad4170_gpio_direction_output() duplicate the same switch
> statement to map a GPIO offset to its corresponding mask.
> 
> Replace the switch with a static lookup table, simplifying the code
> and avoiding duplication. This also makes future extensions easier.
> 
> No functional change intended.

If this churn is okay by maintainers,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


