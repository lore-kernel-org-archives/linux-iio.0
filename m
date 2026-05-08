Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4829C33F;
	Fri,  8 May 2026 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225279; cv=none; b=OphvmeeIFGIa8l1SC4Sa6VWy6zHCL68KQYv3Y2cyI+ZWcHkO6cdK392jVFXAFeUDfKp1c0J7hJJtmTGSaV1/gETC4m+w4yxI7WyyP65tcRCdCwyDQgJrnRTugDZ5A8tgivr7bAJbKiM/FTG7WbPLKIJ4qHLVmrUosPQnLWDSViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225279; c=relaxed/simple;
	bh=NMZ2A0xOyVGOBW9zZwRL482D2NxfIdoZH5kzV5L+V78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epjqQlOb7PoX//wgci2GJyMhH7woN6XxP2Amoqm079fh8o1AltkyUuhaJ0SolHGJx58x6aydoopnIxTQXLyamkdeyff/r6Y9ldmug1bgDgvIzDZhY3arwqtXrRic3xOrVuizy83uZRQ52Zf9pONW4j/aii4ryJhcdj9XUCJetF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eE7GPVPx; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eE7GPVPx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778225277; x=1809761277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NMZ2A0xOyVGOBW9zZwRL482D2NxfIdoZH5kzV5L+V78=;
  b=eE7GPVPxgUe+ivJThlxpRmLb2YenZHBUfAyFRlG6FBcmzkVUk0vQPhba
   EHNBRPUCAhGYPAnO87cZvEy7gOf6+o/N95cuXsUWYKIKMh+Sw5qcqcWNP
   1SsUSO0Axu5Rfjq/tvcVTA00JH4jxTe9wy/raHm8K5a4Hl5+gCT+yiXfw
   aFISVKK6BDdbA7j1Wmdrnsv5222a6bc9ctfxlZZ2nOtcqmFDVgdMvh9Vx
   N7fu3JENO67ImOFfNZlHAl5uQaAE6LcF79xrMkF0tHabwMRiguu6h1ZHe
   MOxhMu/Zfjh99i67h6XxPbtGDFFbIxP793F8gPgVTUamtMOXN36uqGpEy
   Q==;
X-CSE-ConnectionGUID: CHBssxnxQOmWzQfcpj/HDg==
X-CSE-MsgGUID: ZxwGkrviQcKN5VGZopMyvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="81751842"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="81751842"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:27:54 -0700
X-CSE-ConnectionGUID: gF9FA4tYSluk2mk47zi+jg==
X-CSE-MsgGUID: apVU48TGTO+jm3ItyuOokA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="241702556"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:27:51 -0700
Date: Fri, 8 May 2026 10:27:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <af2QdVmncMtTS-Yf@ashevche-desk.local>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:
> Hi all,
> 
> We have a request to support multiple devices tied together in a single evaluation
> board. The goal is to be able to read them simultaneously via the IIO framework,
> while also controlling them individually. Currently we have two ADC devices that
> would benefit from this, but there might be more in the future.

> To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> is to allow users to aggregate these devices so they can be read simultaneously
> from the user space.

This paragraph contradicts itself. The they share the bus. The bus is serial
and can't do at all what you are describing. Try to rephrase, or forget about
this, it's simply impossible.

-- 
With Best Regards,
Andy Shevchenko


