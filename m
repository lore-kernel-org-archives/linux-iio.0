Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA981FF61E;
	Fri, 27 Feb 2026 07:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176734; cv=none; b=niDiwwKdh6wywmDkM9BRW+FNJWuncTtrsU/FReFW98BG8RcgSDfEGCLfuwGSTvfBpk3sLb0amJbrxd2ftgfRO+68fADt3I6UaOk5B/VPbgX7T4wix6xaOuAT8d7XqrifUvv0BkPR+lJA3zMthWRfTGyfXn27CO9weHPSLR5DFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176734; c=relaxed/simple;
	bh=vKlX+XdXmHKr/V42Qk495PS7BvWnNDoei5tY/l8B/UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZoek04zdJNva0SeisJp+CjdX3sO6jGoxkOYifmqlp1acnxZJ0gMWoE/SAHZPpAfpLZ/hdgfXfuZwaHCjA5DRAFlCrnk+x8aXbqj4HiJ31I0xClyBwuIiaWNJbBvXdz1jONJfsH4rtNCgk9Tmh4CBe6j9NAwq1JNLG1OHvjKhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzrTL0Ug; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzrTL0Ug"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772176734; x=1803712734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vKlX+XdXmHKr/V42Qk495PS7BvWnNDoei5tY/l8B/UA=;
  b=EzrTL0Uguu7c7xrLvw44yeglDknn6VLiEH6z4S6nEtDoGUPW3AndC3A9
   +ZJuHaqjGF3wrp5205dgkQlEJSKKYj8CIDc4YttlhchWdm1nFzXEmvhJN
   po2dPk0O7UxOTeH5LiJ3TRxr40TJ37TjJf58G3WWVvXerDqaluJapeL22
   BKM5f0deiRaT12cwWWt8loSthbXfOvWv7fko6cww3lRpsEVtzNRnIuYxD
   /rFX0oaPg9S9opML2p8mQ93ItSTo5IjFdXU4vTUao/UuAHBjT9gGE9cR/
   +gpAWQM92fLS0KBUBNscwVbrZiWCEhCvGBxKhrpiIJ/QASd48RiHrWzKg
   A==;
X-CSE-ConnectionGUID: 89fOjsJAS3SN3mJA4ujwJg==
X-CSE-MsgGUID: 5m5c658wSLeSiGQsJ9tclA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83587066"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="83587066"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:18:53 -0800
X-CSE-ConnectionGUID: bWy89iN/TnqWbWePEFCl3g==
X-CSE-MsgGUID: bKLLL2oPRSG7PSZjy8BEmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216830790"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 23:18:51 -0800
Date: Fri, 27 Feb 2026 09:18:48 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: filter: admv8818: Minor cleanups
Message-ID: <aaFFWKsTcMHGyR5D@smile.fi.intel.com>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
 <20260227061424.1135505-4-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227061424.1135505-4-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 12:14:24AM -0600, Ethan Tidmore wrote:
> Resolve every checkpatch error in the driver.

Poorly written commit message and Subject. Please, be more explicit:

Ex.:

  iio: filter: ...: Fix indentation issues in a couple of places

  Fix indentation issue of the parameters in admv8818_write_raw_get_fmt()
  and remove extra blank lines elsewhere.

Read this: https://chris.beams.io/git-commit

-- 
With Best Regards,
Andy Shevchenko


