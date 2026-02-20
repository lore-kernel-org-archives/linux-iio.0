Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075434BA56;
	Fri, 20 Feb 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596555; cv=none; b=lZJrclwezrHEaMKe4FwMTpF+B+w21Xy6FRn9D2vvzpLR3qlRSqZwZUUvoUtO6u4UDxF4/USVPc8BLnFgPjOKRcwo7OaValIy0MpDXzkU9jiEKDElgadQy0LzUtUQGGaXTT4knhY/EEdvhCp0UIxDRpbq7wc8AmX+xz4oA55Th00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596555; c=relaxed/simple;
	bh=78yQAl6xdrj5C0fq9y4YmI+ySSZdjmYn4lpBTX1kzJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYOITqUtE2B29lYTipNCAgiNqN7YjgF9B+5zShtn6djGlEuMBZiG0TSO7ScY2D3NHxWp/sCX3wxnmzDY+h1eHA1stRuPeUCgTukECzvMSg9UD6K89gM+2r9dGDjv68XQp6EOoxiZy/0bBOBnzSZGTsS1+d8pwxmsQ0YstNLxqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iiaXGQG9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iiaXGQG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771596554; x=1803132554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=78yQAl6xdrj5C0fq9y4YmI+ySSZdjmYn4lpBTX1kzJE=;
  b=iiaXGQG9TyzI1J4P2pzhgP9uufCjPPct67IrnA2s+39uR9g7TM9nmuRB
   Pk/xq8UToKyVtqLsXv+442HrIYRYm07UkYKSbwc2Gwn4Emf0WOTBFKQrd
   RXbyAtzHz7l57zXczA1Rd70Fh/k8MhlgjQZ4vpvySwcWSew64Q9iWrAI/
   GiCFnsDCSkeYNHnqNKHcq7e47wGTt9lnzovfjPRLfIBW4vq7shygTN0JF
   rXXbua2B8KaCWw7zHzgsr2GTofFOiaydYwmNj+Rs2rJgvEP3iSdniKmG0
   UYs27FqiZmf46vjTI80BZrje2heSv7Hxlm6HxK7zhZPKGIHfu9xXMLEOS
   g==;
X-CSE-ConnectionGUID: UduEvCTXRBut5Wa+/Io7AA==
X-CSE-MsgGUID: 0GJXDqi3SP27SsMk5HM0AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="95309133"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="95309133"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:09:13 -0800
X-CSE-ConnectionGUID: QrCbqcAoSu2TBj48SPp0QQ==
X-CSE-MsgGUID: Wwaq4ZpkRS2jgw0ZWpp9yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="219400447"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:09:10 -0800
Date: Fri, 20 Feb 2026 16:09:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ad7266: simplify error return
Message-ID: <aZhrBO0dkftNJ_z1@smile.fi.intel.com>
References: <20260220131847.76968-1-antoniu.miclaus@analog.com>
 <20260220131847.76968-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220131847.76968-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:18:46PM +0200, Antoniu Miclaus wrote:
> Return PTR_ERR() directly instead of assigning it to an intermediate
> variable first.

Definitely!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


