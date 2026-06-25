Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413332E06EF;
	Thu, 25 Jun 2026 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369597; cv=none; b=YVG7xoga7pFh3Qyv2BE7OAmVDQEvMxdJ85WMoQX359B8sl9qAUb/JcrYgtmk5Wukjc65Gj62uxpU/mZQludnW1SzQZOeLNaWRl8bDsNzB9A4JvUzHtrHCuDC8khgW6QHb5NaQSqAkpEOuClsDfFvdCJY8znlbv6ORuG0aGmTeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369597; c=relaxed/simple;
	bh=H1U5HPMKrIozup9DRb2fFQeTEazOZmA/TFMaDqkKSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reojOPWVJiGhxd8wZyK4LLer3DUaJAAWmOW+jCmp084gBJjRUiv9tJ70/mGq7HVxiEmQkj3VZnGAPzlCVu17LymGDQsEd6xdMf7lFkIxbOp+8QzW7xDyvdm14NVbyq+1cBXJ5/CMkKVF2Fg8E3Xa/KUq724jn+AF6cdlJz4L1dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ouct5J9H; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ouct5J9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782369592; x=1813905592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H1U5HPMKrIozup9DRb2fFQeTEazOZmA/TFMaDqkKSUM=;
  b=Ouct5J9HRR7abhuiulg5y6wkpjp4KHmEyRVYbQste4q/IYVyAyqvBOY0
   z/X9uIFUPCCuuX30EKxfs4u3U06E9Qti+xdULyUA1RgmbJz2IxV50Yee7
   CosNo/Bwt8HFtPXxIJyPwNSFUTHuzPplbOGuTo5vzn9SyyT/PelimMn5Q
   qy1rURh1nf3x0zNvwAwq0TQNTy4eCZ6TbRvMwla+E47MRB7nKJ0bcoV5j
   kZuPPXntLjBCJ1/sq/Zujhx1Wl6En3PBOWloPuq3C4o2woYZJSms5jxNX
   colNeaRVNfDm2Qjgn0fpRIxrX+noNIEmj8ICgvmLcf7v+AI6NXB96zNRq
   w==;
X-CSE-ConnectionGUID: gSgSxDf/Q7qx5oG6yC7Xyg==
X-CSE-MsgGUID: CvMgZ8FORiyLXcs23mVLVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="94260693"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="94260693"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:39:52 -0700
X-CSE-ConnectionGUID: kfioLnCES96wOa9kWUV75g==
X-CSE-MsgGUID: O3qYkQFKQyC3+PICjc/G8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="280578625"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.93])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 23:39:48 -0700
Date: Thu, 25 Jun 2026 09:39:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: light: al3000a: add missing REGMAP_I2C to
 Kconfig
Message-ID: <ajzNMwT8Y640fnw_@ashevche-desk.local>
References: <20260625-fix-al3xxx-kconfig-v1-0-d41cbc0c3cf4@gmail.com>
 <20260625-fix-al3xxx-kconfig-v1-1-d41cbc0c3cf4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-fix-al3xxx-kconfig-v1-1-d41cbc0c3cf4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 25, 2026 at 07:20:43AM +0200, Joshua Crofts wrote:
> The KConfig entry for the al3000a is missing a `SELECT REGMAP_I2C`,

SELECT is not a SQL term here, but Kconfig, hence small letters only.

> causing build failures.

-- 
With Best Regards,
Andy Shevchenko


