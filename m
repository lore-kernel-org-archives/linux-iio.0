Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5936C0AB;
	Sat, 15 Aug 2026 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786783663; cv=none; b=CoXiRIs0aOpQv7qIOZjK3Q74jFdJnkhxOPenTVQzRAQ4yrWowMFxKHK4xI/VBilvZtaZkgNhsWMxECDjXmBjMciFjXgKFNcm/Zj0J8eEw6k3jLiggdIP6JnUq17SiNqvOHuTFIxALydJyD+xuBM1WE03ScYk+Lqblrj56Y9SvUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786783663; c=relaxed/simple;
	bh=be5HSlP0qdZQNDYuoQFaNzzM9cjrf1T0tcjNxFoP7qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNFoajxR9yV7p40XGzYj+A3dlQfMYVNkKLasw33iUB3Vm7FZPNAYGpzMdoSbWF6lYWrD2nGylB9cbnMdRRAQs8Yjk42Q83ReHYYlUchkp9Qq+jBE1Lt53J/DgI1U0jSEWqC3bAHXqzSwcE8EH66xia+hJ6vjol8Smcm6Om0qm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWy4L+WH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWy4L+WH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786783660; x=1818319660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=be5HSlP0qdZQNDYuoQFaNzzM9cjrf1T0tcjNxFoP7qk=;
  b=SWy4L+WHEsqv7PpoaVQmDfZV0U/hyEPwizXaqAe7MK7I2oz4MrC5qpnx
   VSHNQhZe/e54nZI+hdbVXshjb4TDIhd6Lr/Hy+26HK+ow8UCmf1uZGMTX
   XXB29eSD4KUEZ9kZEx0KkLb/hQGjoFTaiLnU9YJIHMo1tQV1Cq7vYYkkk
   aWAzVs3jm9nnMUw1lZkYkhlTT541pGyOO68qjxszfecrCjm11WRXJzuD1
   WLxDEQAoBWO0woFzvmAi4u2iBRNWn++MFUO5atIIP5aw1bAJsMIKXUxXQ
   OHWIOXTenFeK03xRmP44ywi6hUNbzpJU9R5qlFcKE9b4dTfrSDo0N/dB3
   w==;
X-CSE-ConnectionGUID: x81ZQ0nGQ7moy/n0aD6i1A==
X-CSE-MsgGUID: s85z2szCRuiiw9jjs4MalA==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="87223826"
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="87223826"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:47:40 -0700
X-CSE-ConnectionGUID: FIyPWv3OSceeO8qlGVftag==
X-CSE-MsgGUID: I6Wo7RB7Q6O/yL6x7yyjhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,224,1779174000"; 
   d="scan'208";a="265048837"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 01:47:36 -0700
Date: Sat, 15 Aug 2026 11:47:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arka Mondal <arkamondalofficial@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org,
	venkat.prashanth2498@gmail.com, rohitsarkar5398@gmail.com,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: imu: adis16480: fix unprotected debugfs reads
Message-ID: <aoAnpsItOh2WvKJY@ashevche-desk.local>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814090728.965922-1-arkamondalofficial@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 06:07:26PM +0900, Arka Mondal wrote:
> The firmware_revision and firmware_date file operations are open coded
> and never call debugfs_file_get(), which debugfs_create_file_unsafe()
> requires. debugfs_remove_recursive() therefore does not wait for a read
> in progress, and unbind frees the iio_dev underneath it.
> 
> Use debugfs_create_file() instead.

This one looks correct, but would it be possible to switch to use
DEFINE_DEBUGFS_ATTRIBUTE() instead?

In case Jonathan wants to apply this
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

Also whenever send a series, add cover letter to it. Your patch preparing
should be like

	git format-patch --cover-letter --base ... -v <n> ...

where <n> is patch series version number.

-- 
With Best Regards,
Andy Shevchenko


