Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5388178372;
	Mon, 26 Jan 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769439995; cv=none; b=Tye9NoYq//G4PW+yBjXz69Gc/+80q+Eo12u7X7zALXfqtrUfC9M7vq+8/C85i0tEYA0l8S9EHCvqMghF+gC9f/Pl2+zsJvC+M7c/7Qx9pLwl9I+8Gi/dLHEfO0e67wvuRCtdcQYulGRuf2wvvWu1pMO9NztXFEvaxUoz/B5Nk9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769439995; c=relaxed/simple;
	bh=Tq+xqXHdYJEuF379M6efosfM3KbtbZxHtop2F74uvzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HK19bIb8cpjV/wyk7hOqMG27A+50MdHHojFlz2LHE5mTuAMkrhJ1CDhMgnsprAKhEdCaGV/Ba7Uc2bc8LLxm2iLFJPvWAKDYqDtxNJDR1PjWj+/tbDs1aOKcvUvkahuHDnXCABmiMkt6PClI2Y+4mIXd9f7VhzHFIMST5hMx3N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y8L8n9ll; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y8L8n9ll"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769439994; x=1800975994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tq+xqXHdYJEuF379M6efosfM3KbtbZxHtop2F74uvzE=;
  b=Y8L8n9llxPOp3qd296BBNyZHMLPEU6CHtkGEQZ1+yjIT2Vt6LtRaNas9
   +NXWP/R3VLEWQ9JVaWE5FXOTGwKA7lBjuYkT1q8MUcwjUujWODTKPJsqj
   34YXBLxz6U21cZGDJk0rh8cMWadllx/UpmrZ+vQ9UQafm7oJ0ZU+9kW+Z
   GllcB3M7GJ8wqgZS3p3vNEG2kO6Udq2W28yDMXb/AUjZi2ivfA8hdpVXu
   1F7Qi+jO8eqVIfKAPTen9SAkWr0KeCuUX6vHzIDBwZ2fpY6Gq36l2/oKx
   oF7uB67vhTshv1yZcu1ZFYm0EOEV/3bdSu+Cnbh+4bD1EywwOFVMpJpmC
   Q==;
X-CSE-ConnectionGUID: RPopneyVR8GFg4ZlG+1hXg==
X-CSE-MsgGUID: lqqkA/dHRlqTloko4HQngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11683"; a="81336521"
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="81336521"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 07:06:33 -0800
X-CSE-ConnectionGUID: xI3zoVmPQYi0NEITP+0+NQ==
X-CSE-MsgGUID: xb4M3optQoWw6kpUEnDTWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,255,1763452800"; 
   d="scan'208";a="207724098"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.122])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 07:06:29 -0800
Date: Mon, 26 Jan 2026 17:06:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v5 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <aXeC8r71LqdpozDG@smile.fi.intel.com>
References: <20260123-adf41513-iio-driver-v5-0-2dce812a2dda@analog.com>
 <20260123-adf41513-iio-driver-v5-2-2dce812a2dda@analog.com>
 <aXdUvRZ9NmP5Nh95@smile.fi.intel.com>
 <udbqdpfcarcngai23u2oo5zekjzvu6dptem732rdvlsxiry2vs@aeqvxjusdx5s>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <udbqdpfcarcngai23u2oo5zekjzvu6dptem732rdvlsxiry2vs@aeqvxjusdx5s>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 26, 2026 at 02:56:34PM +0000, Rodrigo Alencar wrote:
> On 26/01/26 01:49PM, Andy Shevchenko wrote:
> > On Fri, Jan 23, 2026 at 03:53:07PM +0000, Rodrigo Alencar via B4 Relay wrote:

...

> > > + * @integer: The integer part of the number
> > > + * @fract: The fractional part of the number
> > 
> > Can we use struct s64_fract? (Yes, you would need to add a couple of lines into
> > math.h for that, but don't worry, I will Ack such a change immediately.)
> 
> Sorry, I missed this. s64_fract would be declared as:
> 
> struct s64_fract {
> 	__s64 numerator;
> 	__s64 denominator;
> };
> 
> and numerator and denominator is not really applicable here. This type seems to be
> used to declare fractions.

Ah, good point. My memory (on fraction part) made a joke, I truly believed this
is the same what we need.

-- 
With Best Regards,
Andy Shevchenko


