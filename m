Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3B2749C1;
	Wed,  3 Jun 2026 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448373; cv=none; b=IYuQGMSCdBnr8wPpJon+qTIORI9WD63oR9ZsJWVQtV0Ge2VgqKQaWcvrteiFl5U58H2mHIXkK+Zm+NiySgylWi1C4ilTxjitE2lRyyHU5QcPvrTMwuiwV7M6XE/vJqqjO3KKSNpMgCFakdPBvyeiEgO+M1fF6BA7GuMKwtR+Efw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448373; c=relaxed/simple;
	bh=Ckke8GC1AU2oNhV+t7PumoiYW2C8NFhUydnzX2SFYTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRf/BxuihPN9iFyr9Qv6yMX9F2k7Mq5dtnBD7O1ikD5bGz6xMUNQup66OMN9H3FlnDB0MPR0HjzrKW0H3o/25F+g1AInjex6IcFiHE5PMJSBgsj1D04tozMoBGKiFsJuQcb+LvKlybiO9xPZdXuueoak4tmqfuGmY6JhnrPpIsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ipPXuxwH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ipPXuxwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448372; x=1811984372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ckke8GC1AU2oNhV+t7PumoiYW2C8NFhUydnzX2SFYTg=;
  b=ipPXuxwHpS9jxyreF7GHk03fX3ANwv2IcguKd+WpFe5V1G80Nm3YcOfq
   rIo53psMWXYGQ+MRELombMBNevzM42f8Gyz+zkHnI3M+3Q642D4fTUtbb
   Q6N1wV6N/1T7JgJldqbBudRdv4hHyTeXif1EKbmhjMWkk0U/Zu3+pALHi
   x74SUetjGMyIge78zhiCp/QYvoXfvRkLw0TFVO+9yuagjTKFhztIA9Z/G
   +ftupL9iXc539svU8CqpxubYWQ4DCiw+LNBji9Uxayw8OQiT3sNTfKcXE
   7yz7lDtDVBttvo2PY41HLAUppt60dN3Kvme41y0eU7nhuCpoPXwQg6KZO
   g==;
X-CSE-ConnectionGUID: 99oWYbnxRfWHiwPi6ZyXpg==
X-CSE-MsgGUID: IE5kdrMbTsOBGNql8AEy9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85133190"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="85133190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:59:32 -0700
X-CSE-ConnectionGUID: jP/WJ3EGSKiXFR6eBCA/ww==
X-CSE-MsgGUID: d3GBVgo6RjGVEuKId/MtCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249146770"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 17:59:29 -0700
Date: Wed, 3 Jun 2026 03:59:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] iio: accel: mma8452: convert to bulk regulator
 usage
Message-ID: <ah98b2Nc6gm3Alco@ashevche-desk.local>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
 <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-1-26d6dff8fc55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-1-26d6dff8fc55@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 06:59:22PM +0530, Sanjay Chitroda wrote:
> 
> The "vdd" and "vddio" regulators are always controlled together. Switch
> to the regulator bulk API to handle setup, enable, and disable paths in
> a single call.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


