Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75F319B5B1;
	Mon,  4 May 2026 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880414; cv=none; b=Hdun02tI7AZaktDQc6n8kAFPxqR55e0Ehw5BGOYf1E1xEfzfTLV7p3AhDEm6kG+4MJ9xfQJdXG1YWnI34vK7imctpo6avufCcIsns2cY52jnFIoyC9sgA/cXU8u4ftz/rHc1v+U+IqwBw1KpKI8Puiurwjia+hLHHZSfBmrxlyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880414; c=relaxed/simple;
	bh=JofBANnhKCUvrs2IfAUTSJcqnKg6hVmdN9zZwqdF3E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iai8ZgJXXhc2+ZOm3/gwq4cXR/BSoWBB7GAmaFw8hVlN5+EdvijSGaaVh7JpI4OOMMi1pSwCnR+i+YtQlJYnj7BUEm7oSQB11vxo7wzkAypYFxt/Y13MgHix8pjzpi7AzO81PKxUSRURHanXmyTtA1EGtiojPDEV/ZxDWCbpMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WhQF7NZW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WhQF7NZW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880413; x=1809416413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JofBANnhKCUvrs2IfAUTSJcqnKg6hVmdN9zZwqdF3E8=;
  b=WhQF7NZW/XnP2YhGZKHB8pYR6HYNN7h3seLNl5YTiN5X5x52lFt8NEqQ
   bbSwwXFClL5/7TX3rXIv1kvoAB8wTMIA2bv9lV29eys6DnK/73+xbekUa
   1112SKwAq2kwleNi96dKN/2lpaC2ytsUt2fVHioKyWND7KniUsIeDzGfT
   of/+Yw2q9nmaXj+hd/Aa5SwXsSNWE6sm06ylgjSxK1swtMCUCaJKymZEG
   jU+uAWk/KOgQIoy+d66eYuSIJbFnqmIOlOXYPzXMo7hW/ImHnGNfLCgfY
   Kwtw5iqDSVxidpLv/Ij6IsC4hL/88KVLu8/+oWB+jJMvQOpzTnJXIlhGF
   g==;
X-CSE-ConnectionGUID: BE4CN82oTj2a64kGvr/9ew==
X-CSE-MsgGUID: I0UFmvpgTtK9M6C8k/XYFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="89041884"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="89041884"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:40:12 -0700
X-CSE-ConnectionGUID: ExjKcI8bRTm+KX3yMnsd3g==
X-CSE-MsgGUID: LM2bXvD1R9qDcSGKaihvzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239416926"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:40:10 -0700
Date: Mon, 4 May 2026 10:40:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	lars@metafoo.de, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/5] MAINTAINERS: update iio adi entry and drop
 redundant entry
Message-ID: <afhNV4Ja60rxk-rp@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430190642.3434650-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 12:36:37AM +0530, Sanjay Chitroda wrote:

> Following suggestion from Jonathan and ack from Nuno, prepare change
> to add linux@analog.com list to has always valid coverage for INC IIO
> drivers and drop redundant entry and make sure same has been catch by
> the wildcard paths under ANALOG DEVICES INC IIO DRIVERS.
> 
> Around 40 entries are redundant which is covered by wildcard, to easy
> the review process split entry in multiple
> MAINTAINERS: iio: adi: consolidate entries changes;
> based on mutual understanding we can fix/squash entries.

I think you may not do that (at least as easy as this series).
NAK from me in this form due to the individual records having different
maintainers that are not listed in the end result. So, what you need to
do is to split this per driver (record). Grouping is only possible when
the same (or subset of the same) people are maintaining the individual
driver, like all drivers that are under Nuno and David (in the condition
that they become maintainers and/or designated reviewers of the whole
thing).

-- 
With Best Regards,
Andy Shevchenko


