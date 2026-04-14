Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C00838642A;
	Tue, 14 Apr 2026 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153359; cv=none; b=KsCCyod4vOh3qZ+FE9bqUdmmwVnv41aCYRIVYSrb4OQqxmAValHQ0/2DwNYwvR4970EfBWIvCM7vwSOJNSUiV2XdPJVRlxgMOYUqeeS/0j5vskxSyql+51mjCW2SslfIoL071+JfqUKf4OdF1kQiSwfjxTzxotV7pMOI9ISaW1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153359; c=relaxed/simple;
	bh=3MfM9rHwoHXpLHNk6cMHA+frAMMGJzx6kCYu5m6Lw3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9aAKtUzAHANOPDeB1YndClaEFUOk1FZznOanrR3R8p49d+qyIchwzA1R8fK2nPN3H4oJq7x0DsAxbtxPAnePtEXcjQ25hejEe/vFt166WW3tpWNS77dd3fcxCP0LFNUjrb/DPfKq60GwnQDURxdjoLppcOu5TJWMZ3jm6hdCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTxeMe9s; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTxeMe9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776153357; x=1807689357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3MfM9rHwoHXpLHNk6cMHA+frAMMGJzx6kCYu5m6Lw3c=;
  b=aTxeMe9sxijpA+JAYXRyXLF6tC+MjOylz7Gao+rlDoJUZ9lYbl/0MGjV
   9OYSjPNKx6Z7KsIa70Bn4+BEvcC/3/KSwiBx7iuX6b33EV7aq/bKkvKfw
   6a3vNh0ACstfsgDJAr9w7N4RE6KbzhX99uP1bNJHnxcck0kq/VL7dyXNC
   XZ9R0q/xyUPoJ58t6HKSqaBjWbqEHao489b6m33oqNIE63dFk6imf5mbz
   3d6TNa3PdxT8o/U5BTJUTB2LNlSPeNvic7QGYt5R4O/czRIVkND03hYSM
   Mx/T4a/RS+7W5AHs2pXwqzcinLm72Bi71VOKGdq8nRBFj8XuldKKB4A99
   A==;
X-CSE-ConnectionGUID: FfBXGP6vTCO2W/knKO8NIg==
X-CSE-MsgGUID: nBPeymGHQti8OTUQvEwBag==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77284638"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77284638"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:55:56 -0700
X-CSE-ConnectionGUID: suzTAvuCTA2TkZkwa5cvyA==
X-CSE-MsgGUID: NOuTKiBFRvekY1xTs5iG+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229145700"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:55:53 -0700
Date: Tue, 14 Apr 2026 10:55:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: adc: ad7173: codestyle cleanup
Message-ID: <ad3zB7nqgJ2BDS9w@ashevche-desk.local>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
 <43c5cae7-9689-4dad-ace8-e8165e5fe6e2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43c5cae7-9689-4dad-ace8-e8165e5fe6e2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 13, 2026 at 09:09:15AM -0500, David Lechner wrote:
> On 4/13/26 8:42 AM, Sanjay Chitroda wrote:

> > This patch series clean up error, warning(s) and a check reported
> > with checkpatch and no functional behavior changes are intended.
> 
> I'm pretty sure someone sent a series just like this already.
> 
> Patches 2 and 3 were rejected. Patch 1 is probably OK.

Seconded. NAK for patches 2 & 3 from me here.
Patch 1 is OK, though.

-- 
With Best Regards,
Andy Shevchenko


