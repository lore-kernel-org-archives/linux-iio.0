Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBE39E167;
	Thu,  9 Apr 2026 09:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775727100; cv=none; b=h5xUdR4d70lzrhpiayeB59RiK67yDEdk0/lbkLZd/XRkGWNdeAy8zz2yIw1NvKwlhYq1HKX0IvZZ4mGADk5cZqomGkl3IYo7XXU3nYPrsC4BsIW5wFb2ZHJAZF9FI35I1S1Cd3OvuUYAM64VYdUA2CeNQ6D01FXSZ5H6qfG9R1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775727100; c=relaxed/simple;
	bh=HmnOlD/J9eFP1HN1NOirpGR7Crxw6vBEDNVqDS/lLUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8K3Ap97+n2/rAdCT4AQYpAy/4Rohn+xOE0pVBgjc1PJNSvbLWW/w8qJoCEv8q2Bt2hbTaMPWx2GeHQG2G+lfpfopVahEEba0nYDntFK+OR9wTeWe+89ph6+V70IZIj1zvVa4vwRdowPz+6tuHB0hwWDBipvBFyvWcdpE5BEDys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gFUFuAJg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gFUFuAJg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775727097; x=1807263097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HmnOlD/J9eFP1HN1NOirpGR7Crxw6vBEDNVqDS/lLUw=;
  b=gFUFuAJgoiaa8vw/ArAYFeP0VGf301VMoL5iLypwF+UglaXPYUKt/R27
   FgeR7p/dohsH/DXuGRC450sF6FOtf/rCMyrjF2NVz63QcRhqWnUEZm88q
   KDO2tOfWPP5O84is9GEjVfRw9YhOedoa5KKfpsmnb0z2QIXPtu8eZuD7Z
   U6JAdUoXEG6N6twuscYdwrVisrqs56RAZ0I/BguRe56qA+kLaYX5+Ckix
   1mRD2eNrDzxUSwe0QTf9ID2cm5r3fxOeqgSkYWAxP0uSMIBvmq9rD1jSY
   fXdqp+zgQoz/mlojcW0QJTZW0GkURzvJ+/brQATqiCIfAD9rDa9qQqzMV
   Q==;
X-CSE-ConnectionGUID: P+iCjG3PS3GfKTaZb+qt/Q==
X-CSE-MsgGUID: wKthB1hRS5K6KBp/WyrrQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="87015939"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87015939"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:31:33 -0700
X-CSE-ConnectionGUID: UzNdD7QoQqyTeqfeoH+t6A==
X-CSE-MsgGUID: vufUELJnSYWhfXCFPQ3JvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="228606592"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.162])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 02:31:31 -0700
Date: Thu, 9 Apr 2026 12:31:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: light: vcnl4000: validate device by prod ID
 instead of table ID
Message-ID: <addx8GaFwY7VUH6g@ashevche-desk.local>
References: <20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com>
 <20260405-vcnl4000-drop-enum-v2-1-7c8dc98c3974@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405-vcnl4000-drop-enum-v2-1-7c8dc98c3974@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 05, 2026 at 07:08:38PM +0300, Erikas Bitovtas wrote:
> Add a new field for vcnl4000_chip_spec and check if we have the right
> device by that instead of the index from enum table. This leaves the
> enum table being used only for picking the right vcnl4000_chip_spec,
> allowing us to drop it later on.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


