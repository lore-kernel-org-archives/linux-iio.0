Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2763932CD;
	Mon, 10 Aug 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350405; cv=none; b=j+q8TMrZ3XlP5HzEJ51feKh+81bc3Do0EiizF63w8RQrjIr+4U0RPIuTn2RkE4YG9E4cbN8YYFYhBnvFGRoTohxWqf8R3pvqBCJMpSnDmM4G3cpdgitHlC9jkRYMMCGJ9oY7RJ2tqs0xi0YIZbh46EXRELPgZPVlJSPmKcoKoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350405; c=relaxed/simple;
	bh=I+uvV4fVrNWKtuIs7EPZt3PNlff9PBOCKPezXlsgBoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nah8uAUCHNLnTf/wmply9s1LCe3q3s2yq6NLRI34IvaZbTyNhwl65027A3k8XJ3eeW9J4ulE49/T4XCYLQ5OUL2jqVndkakS7krd3Yn3aLTSM7pOydeJMlUa3S9cbYUgwBdGt0GcGRo3bouk2K8J5wk6ei0mYM+rdkfaLEmkcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NPS+JQSW; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NPS+JQSW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786350404; x=1817886404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I+uvV4fVrNWKtuIs7EPZt3PNlff9PBOCKPezXlsgBoA=;
  b=NPS+JQSW60OfyEv61oqmEimVfulbuFmYzU7lDMsTP2zh6UrX6oYyQBS6
   sz8S7QDpNyFpsGze4TOst9kGE2F9tKMaDe9CeGmE8nRGHPDCnBxh4Opl4
   wYd1ZlPKIDiHVYSRLRT+aDps0SI/2fc1iTVMJ953z743V7mBB+OgqwQl/
   GI7yZyB/2cMToqQUz8PaNBFPHLkZ+4hxcCIYhFxQzuM03EZGWK2hdd+oB
   Tzwhs0oYDYFhhYWJ4/28wcvXLRcmCTYW7IIz9t+DmQkmvVRGVEuoJ36cU
   YWSOzdu8LjccY7sRIgpTE+BSY8slXlt6tyDmygg+GHb2FEYXfYa3wFXEc
   w==;
X-CSE-ConnectionGUID: Lg7OyzzMTX2xWsAmmSFvEA==
X-CSE-MsgGUID: EH3sftxCS3WgkMaS8D3lwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="85976404"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="85976404"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:26:43 -0700
X-CSE-ConnectionGUID: auTyl09QRNqrr1RebhmFJQ==
X-CSE-MsgGUID: GjUCenVnRi+6b30eZH28JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="264960689"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:26:40 -0700
Date: Mon, 10 Aug 2026 11:26:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: mdshahid03@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] iio: adc: bcm_iproc_adc: Introduce local device
 pointer
Message-ID: <anmLPn_6JYqLVcsa@ashevche-desk.local>
References: <20260806023902.8608-1-mdshahid03@gmail.com>
 <20260806023902.8608-3-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806023902.8608-3-mdshahid03@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 08:09:01AM +0530, mdshahid03@gmail.com wrote:

> Introduce a local 'struct device *dev' variable in iproc_adc_probe()
> and use it for device-managed helper calls instead of repeatedly
> referencing '&pdev->dev'.
> 
> No functional change intended.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


