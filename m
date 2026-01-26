Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887032F759;
	Mon, 26 Jan 2026 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769422740; cv=none; b=iSRSMHk/9ldSgNldJmMA3E7R3y+JcG1mqKy8Z+9eOuRQipY7fusRXybSkHlmhReeQwfhHO7mxyjuPjjEY5DZ0tyMQQwCsRvJpsYxxc7cIlSYmzH4/PUnloZuKkofTcWC4FxMHyS1Br3+s0SOMwOLbx+3dGjhs6z/I9Kk7yOthv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769422740; c=relaxed/simple;
	bh=c4xALx+ESdGNemm8lmTcc/sEUHGE8+oRPnuW81od2DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtuhAHSUT43sHpGOR9MCqIxDlUZxcpw3rZOYIgaib0CJ+d+C/3kMY+xCYwODbM93lUjhU/hKLx3J6fq3/5/wC3TDOYNYK2KhyyCjgZSbd7xxSXpGgyiwyZ7IvAz+kbtvoGgVwFD0PZsLiWXXyrac/r0OUEruVLA75EHP7C5gyhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZdbOgKh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZdbOgKh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769422739; x=1800958739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c4xALx+ESdGNemm8lmTcc/sEUHGE8+oRPnuW81od2DE=;
  b=lZdbOgKhuD3dQdUOKBnm6dYcg2oimZUuhmpQyZ3Jf5U2qfXHi32urZq4
   42LjcvkJS+X0qwjDIsyASaOLLVTFULGkfeH1Y+mSiAN3Eynjxgha13lhp
   D4V4JrkaJt4Vlq+mbsxvGW+hQziyL9zKEFI/Zi4d6LS52K+13izD+HpuP
   FDdNG5CMiqicsW4yRslVaunSVz3JF5dSGhsMSEvs+gG7Sr+SJRlCl343u
   RB0X4aMrbgadwprDRyZzYSblmJsUp+1fV7TrmlyCpleCqtyscHtuh4Cpq
   VYRuj7yb9rsZsNqh5iAMPLSork0SFEg5dzxzu4HP4P+mOclR2WwnhWiQI
   Q==;
X-CSE-ConnectionGUID: gLBC+kkeQrCU6i66QyyAOg==
X-CSE-MsgGUID: rHKRQqvwTzmJuRt6QOzniQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74464878"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="74464878"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:18:58 -0800
X-CSE-ConnectionGUID: DEjMzLv1TqK++j1QZfdsNw==
X-CSE-MsgGUID: BQWZNl9hTI258ZfhLj+6Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207702117"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 02:18:55 -0800
Date: Mon, 26 Jan 2026 12:18:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iio: adc: ltc2309: add support driver for ltc2305
Message-ID: <aXc_jMxgaqyCxssw@smile.fi.intel.com>
References: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-add_ltc2305_driver-v3-0-951349a87f97@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 09:29:40AM +0800, Kyle Hsieh wrote:
> The series add support for ltc2305 controller from 
> Linear Technology Corporation(lltc).
> This is low noise, low power, 2 channels 12-bit successive
> approximation ADCs.

Apparently this has not been ever tested IRL. Please, be sure you have tested
stuff before sending out.

-- 
With Best Regards,
Andy Shevchenko


