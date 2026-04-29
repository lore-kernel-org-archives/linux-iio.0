Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960933FB7C0;
	Wed, 29 Apr 2026 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471778; cv=none; b=IDTDYYFhMo6LNuPig2WAp8r15Z90r45PJExhNy6aElNAi4tqPvCMddvbmsK8s3DSsWbrG9DhDAeJYYW4R60TT/0RVeUdUX13VMZVHIPrkRdV32HCbr5w6fQicw3mCx/ToiCzDDd1m0as6ZerJjCW4SgNyPS/UkXUbwHE1PiMakA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471778; c=relaxed/simple;
	bh=lskTL1g6fQD0+DMgNuyX3pVzkrIWpPNRWPKzcQAOTn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPeN9u6NvFlCl/JGhPXzuNhelVo7C6issFPodwD6MuXg5MdZQChSHd+M3g5p3WL8JaCEyZ0/sKI5jzF4VgfBmfIG5TtCi+hK6B1D4l+l1TNd8j7LEeHmnTniVjtb+Ldu7cHgCTgJced3T2wZeBdpQvA6EFSr1DBP1EXnLNl9Akg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GC3/wHAE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GC3/wHAE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777471776; x=1809007776;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lskTL1g6fQD0+DMgNuyX3pVzkrIWpPNRWPKzcQAOTn4=;
  b=GC3/wHAEoG3m6/+orhs+6mmAHcp2U4ZoIrUylB1wuF1nfknCRYzDvpVP
   X6V0aKpevuQ4oWASdVD5KjMMc6gDQCKAZXSFJMFW0rZxo+vPz4din7ObX
   8wLFrUpAeTIie8WU8pkJdhE3dKtuyHZC+/j/8TtYwsewGiHUdd7kkDk7o
   /VM6GhQLothUSRMeqXnQ16yeIRNCoFvDq7m500a+eetgnqunwrRjQK3WG
   1CEal1OrY75hpLP/02Wsmcc5exfmHsmr6T0gD7i9pUq/KIOlYU72v0949
   yggM+fZWw0XWcFMHEXx75+vvXHlr1O0xrtTIq2I8lRHaap0aADOzf4QmO
   g==;
X-CSE-ConnectionGUID: xeGl/ADaRLCxKmuDnKulEw==
X-CSE-MsgGUID: LEoAsnsbRzWJg92k2bfz3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89093731"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="89093731"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:09:36 -0700
X-CSE-ConnectionGUID: S/V6ybTvTkyF2PT9oV1XOg==
X-CSE-MsgGUID: u5eZLWurQZKydHLywG4Tgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="257604312"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 07:09:33 -0700
Date: Wed, 29 Apr 2026 17:09:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v4 06/13] iio: dac: ad5686: refactor include headers
Message-ID: <afIRG2S94JEn3Oqd@ashevche-desk.local>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
 <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429-ad5686-fixes-v4-6-bb8f1cbd68e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 02:07:36PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Apply IWYU principle, replacing unused/generic headers for
> specific/missing headers. The resulting include directive lists are sorted
> accordingly.

I haven't checked this deeply, but I hope at some point we will have
more or less usable state of `iwyu` tool that may do this automatically.
At least current result looks better than the original.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


