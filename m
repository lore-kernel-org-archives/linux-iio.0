Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C27F3C0A1F;
	Thu, 25 Jun 2026 06:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369699; cv=none; b=RpaCrvtowkZHhGeWo7GPYtGUM7dU/GOAmyR9xGNNOPSxycyt22WXeEoP086O33YRXUC0/VJ28vsjQ981ZEI8hbUu3Z4nZ//dSjK0J6gD4ztMWNk/4YHQy2t7sUW1uuXZ8qC6gP5Kcdp2XLZeOGH1EDtkBQn96VEXBG6ETTlu6d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369699; c=relaxed/simple;
	bh=OdMgO2jHkQV1Py9yugE9RMJeGhINPyBxfih55OxkOYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ue9mzLR8cG0f12rkmvs5/ZPg1n0cNH8CDdLtfAUkfISA8IAIX+12wgzHrkw7FV9ZhM59BrwBHCItSNGdSPWtci4kPR/B1GW86v8QDPEFxpO7amGSOrLKsKPAPTfYSO/GT6zfqHnJ/aNoZV7QyZ5V0Tj7GHrQfgWco/gVkH0zPGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F7OS1oNj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F7OS1oNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369698; x=1813905698;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OdMgO2jHkQV1Py9yugE9RMJeGhINPyBxfih55OxkOYI=;
  b=F7OS1oNjEGq2GRVjk6uoOVvdMReF7GMAgPgWnS1V4xKs/XDCemiEtih4
   2xTltpBouG11gVHhb8bTOR9rtOgKhiJvfKmWgKUgA4ZYzJTHDmClmz/I7
   MV8RNBmuwnJY08Ndf5fdfLFrfl7ZQvMVDpTV4G51R4rDsWGk1D9CE7TrL
   YRANyyLHQNdAZviJHYipkjia0FlMoUjq5tWcO9kyChmzpWUsWjMgZYMms
   OAPgVsmvgBnfDO/0HHD4HPY8Q8gFj/oZpVrx5IddCl/BvXmNN5iS8L72l
   MLFwVOCHHwVWo6pq7C2SL56ER2ZTLJMcGDRdLWEmM64GTSeLQM5UNsXQ/
   g==;
X-CSE-ConnectionGUID: ys8gf30QSWq90WpWYaTd2A==
X-CSE-MsgGUID: TMNzBfOFRA+V/0RzdtLYxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="93794600"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="93794600"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:41:37 -0700
X-CSE-ConnectionGUID: pW2byeIyRMGnvE8mKYMP6w==
X-CSE-MsgGUID: zZM52cmbT36hwSFV9itRTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="288499552"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:41:34 -0700
Date: Thu, 25 Jun 2026 09:41:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: light: al3xxx: add missing REGMAP_I2C to
 Kconfig entries
Message-ID: <ajzNmy3Vhh_Zl9Rs@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:20:42AM +0200, Joshua Crofts wrote:
> This series adds REGMAP_I2C support to three AL3xxx ambient light
> sensors that were previously missing this dependency, causing build
> failures.

There are two problems with the commit message:
- SELECT versus select (see the comment against patch 1)
- you mentioned build failures but haven't provided any evidence, please
provide a reasonable lines of build output to prove that

-- 
With Best Regards,
Andy Shevchenko


