Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7C134C12B;
	Fri, 20 Feb 2026 14:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771596817; cv=none; b=kR5UDiUc9uZJHPB9J+sG8fiZioEVtrCRgyN/8MugEILW7rNlWUstUuEFIrqdy4MSDWPmu6pAswrLCvBFBRTTFHNxyBkIT2ovof3ZdIRvGpVhQ8BpqHKy+2Q8WcQfwf5Lr2C/j2FBaLkS9zT0By7xTQCbiWDgEEAoEeXVfODNq7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771596817; c=relaxed/simple;
	bh=Ricffq0oqSpdi7uAnjy/I2GGr4qcDt/O01brfry+eg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuOS8hcrgZkUAUKsrHbn2zo7cKms2oNEgyrtCLoxDz8Ws9MNgSWi8GV8bx+wHwKR55rIvVnCJdHOG+YDaTLOI8PwNL0B89OyoyMTdPcqClV3QrybmDbNfxBpfxne8BotbljWygLh7X3Om2qdKffT61MjNyihh/84XBj1p4ViKvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mznTQJyo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mznTQJyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771596816; x=1803132816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ricffq0oqSpdi7uAnjy/I2GGr4qcDt/O01brfry+eg0=;
  b=mznTQJyodGxnt2bOC9b7rrtiDGvQs5khplCi7ceqFQHYOv8OcMok1Fc1
   IbfC5FOewDK2fsNAaX4zuCea7zhaD1+jrjpreUwIitiKWNsUBWnQ3cx9X
   TZPsM6d2JOqrA+ufib1aJsW0BKLN54mukxoHTCqg3rJRdkVAGXqv2F7X1
   y5OYZpIRv4cRwk+FDE8Y/oQA/LzouyQaz+Pil/xIookix1lbDgeHvOSK/
   1UU2A5ASjnHo1ZPsiU23Q740OZWaONEpDlVvqFK+9D0cbPBx/7NiJrnZh
   waT0+Tme29B08+R92ljzycJOGpOSQl1G1vhMnaJIUeZXm/F4sHX40LXCJ
   A==;
X-CSE-ConnectionGUID: jKLAOXoQR6q0DTG1PMPY0w==
X-CSE-MsgGUID: 4xCNQPSqQYmsJcetiF8Mmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11707"; a="83007851"
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="83007851"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:13:35 -0800
X-CSE-ConnectionGUID: +goicDu3QQepo1Kz8Kxm0w==
X-CSE-MsgGUID: h/tADwqJQRKDMezuu5u7wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,302,1763452800"; 
   d="scan'208";a="214975763"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.25])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2026 06:13:33 -0800
Date: Fri, 20 Feb 2026 16:13:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: remove redundant else after return
Message-ID: <aZhsCm4W5ZjLHh0J@smile.fi.intel.com>
References: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220133337.85216-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 03:33:29PM +0200, Antoniu Miclaus wrote:
> Remove redundant else branches after return statements across several
> IIO drivers (ad7298, ad7606, ad5592r, ad5758, admv8818) to simplify
> control flow.

While technically you are correct, the only patch 5 makes sense to me.
The rest might be better with 'else' be present. It depends on the logic
between the lines, if they are of the same semantics and it's not about
returning error code vs. 0 (success), it may be better to read them
if they are started on the same column.

TL;DR: I am not going to NAK, but patches 1-4 is an unneeded churn to me.

-- 
With Best Regards,
Andy Shevchenko


