Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D62F1FC9;
	Tue, 14 Apr 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153471; cv=none; b=e/R7CTwT3rNHIpUD0RyhULI5VAdMikR86DyRt4eZCwQMbdSE1Rg6ne+DeZ7J9uosiapECD3FjxxoSA/QJp3r7wgWElAIWfCfrHRNJo0YzSBJ6/DYFOX/uT1oGfa/rErrpz8cjt2nRFoTsmyJhyhh4JDl+79dnet3nRZ+o/NBH3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153471; c=relaxed/simple;
	bh=OPnm3JdqsauFGWH7TRASse9MPBrY2xxNWyGojiWHDcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NRFH8aK9eRtgKrZcd0QIv0m7nJAcKgmWD+g7XmbrlhkwKioFESwJTIJePlfvKb5qQ2e1SmA4lcoHfzy/0RthGnpoGyN35cQPrTUhsMHmJEC4y2JokRZ1zWMtPG4mbMmkJ/FMF5MbkVV6skNHvB1ci/WgZaN+TQqViXIeTpKN0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ab3+3z3x; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ab3+3z3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776153471; x=1807689471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OPnm3JdqsauFGWH7TRASse9MPBrY2xxNWyGojiWHDcI=;
  b=ab3+3z3xLcnFyvdzQkwIqrXX7pDh8fKkHlIITNzLcVIz4YgIrEr/mDsu
   vxlbcbqxa0gttYYSNPzx06glfOF6l0lFb652E1TOpLcRBxddFDw+1T+kB
   mTe2t+z8eQVCegVDhB4WPwRNMY7f7yHmuXpvhhT/7jTkepeeQwgqsnBBe
   EZip+szyC2eSfNEQlLRuDXiyDzpgQP4x20sNvGc2xDklMNR+cx3B7NsqE
   XyKTiGDONPPEA0E3hX3Frc6X/P7cRM2aQD1cXSsQr/dZQdhFe4d7oM/b+
   wfVAdw8qSJvGCZwEdfByo+GqHjV13x16MLxPmD2jzQ06p3cfTR/X+D2ax
   g==;
X-CSE-ConnectionGUID: UEpHXlGyRzeB/mXS2TC1mw==
X-CSE-MsgGUID: HIHKdgI2SYa65OULD+04LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="80694592"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80694592"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:57:49 -0700
X-CSE-ConnectionGUID: 5vIgm81RRIynmHTrSIl2mw==
X-CSE-MsgGUID: CCX2iCDdQY2LNpTkWz5wSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229897681"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 00:57:46 -0700
Date: Tue, 14 Apr 2026 10:57:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7173: cleanup codestyle check and spell
 correct
Message-ID: <ad3zd34HnrzB0TMH@ashevche-desk.local>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
 <20260413134223.2331911-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413134223.2331911-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 13, 2026 at 07:12:23PM +0530, Sanjay Chitroda wrote:

> Reported by checkpatch:
> FILE: drivers/iio/adc/ad7173.c
> 
> CHECK: Avoid CamelCase: <AD7173_TEMP_SENSIIVITY_uV_per_C>

Fix checkpatch, please, to make it understand the Système International d'unités.

-- 
With Best Regards,
Andy Shevchenko


