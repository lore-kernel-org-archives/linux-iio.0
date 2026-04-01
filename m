Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7D8361DDA;
	Wed,  1 Apr 2026 15:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055612; cv=none; b=QeVKRcdP2q5ij2TPArcglx55IhedSpvyTGo8nq/ur+QRAb8C+FfVqkwDOR/4XxCb6rRZF0Wsz9FUkVDZNF0EWmtGpAprScZccLvbTvf5aBxfikYyI8sbgXmrZ4BDDoY/R0YD36w1YvXcx+vP+rZ/Ezyh2MS2YbRUGtXVdXXU/Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055612; c=relaxed/simple;
	bh=yVuphPX3xS1lH696lK1JckikCZsb/HCV271AHeBB7+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqpUEbFjPUHCDt7AcLAd4am1vbPyijd5vdrI0bg+FyRJ2zfswr/vpMa/Qj+/JdhLcnDwhLJamxQCB0dtxok4s/JYtRXCG97HtedPX5070q5SMyU3YM7ZJmvclnpIONLX8WjHiHC6qCuh8vvyn/wDWWPd7pPdaG13jZYtNui5/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kgMGczoJ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kgMGczoJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775055611; x=1806591611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVuphPX3xS1lH696lK1JckikCZsb/HCV271AHeBB7+k=;
  b=kgMGczoJOjCosp/263m+IrjaHf8HQrdFU5Fs80OyR8bIABKG/5/KahJv
   ensULEXNCk9c2kKr5aTBpCfu1bpxXdAnF4yRWum513Kn6Gf3URs5dCVTJ
   3c3bnci89kcvjjksqBhNlCS2ma8uyQeik8I562kkF4PPA0V5tobUc4FcS
   45BGJD/ywuTQ3DCAU22l7ZBnduAUszCeoVKQaVfV92IKr5CkHEa/Ow0ez
   JQhNd8b1yl/25mrpJGtdvVA4rZ8S8BT4W5rrVqAehttYseiImJKu70+ds
   wklIHs+Mg7wkVxztK/AVkPOzbtWDty6AZsBj3sp6TVMCJfMw/n9L48t4I
   w==;
X-CSE-ConnectionGUID: OVr3pRudQIm9liU8VRWA5A==
X-CSE-MsgGUID: NWXur+UrSHWTc6sgF6EMDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="98707647"
X-IronPort-AV: E=Sophos;i="6.23,153,1770624000"; 
   d="scan'208";a="98707647"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:00:08 -0700
X-CSE-ConnectionGUID: i+3EvXgHTOqjDHMu866Eqg==
X-CSE-MsgGUID: 7UdqstlNS1G/ZzNVYlhv0A==
X-ExtLoop1: 1
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 08:00:06 -0700
Date: Wed, 1 Apr 2026 18:00:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/3] iio: imu: inv_mpu6050: use devres-enabled version
 of pm_runtime_enable
Message-ID: <ac0y8wPpxpgN3iZp@ashevche-desk.local>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
 <20260401082737.781018-2-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082737.781018-2-andrej.skvortzov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 11:27:35AM +0300, Andrey Skvortsov wrote:
> That allows remove driver-specific action, that does the same as
> default action.

Don't use the Subject as the first sentence in the explanation. Id est
always start a commit message as no Subject was ever existed.

-- 
With Best Regards,
Andy Shevchenko


