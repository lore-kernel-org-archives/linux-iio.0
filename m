Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ABB3998A7;
	Tue, 12 May 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593843; cv=none; b=S5JMIU3Wb8wvKOJkjlvyjiCNleO6FYECIs5Gn/AjwkCcwMu/LvoR8K21u3PXoyQzoNnpxpFXXnjB/k5g/ufWRhBOya40wYOBje18eupvU+iIkwGerbFs3PwyBEeJc9+JTY9+Ukdit1isQ5rXVvhI8u38xr8MwOsogmH6k2GDb9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593843; c=relaxed/simple;
	bh=hmVffbvSzjq/z84hTirUUpOvf9U9zXSnbQBAcVn7s6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3OMbt2WWe3joVQdWJ1oKELVJ8QwJ9EdYkDKxBb6wVy7JuV2xEoOS9HkLPtjd4CUKmBxp0O0nIAB87/2SGi+RZjgWmXFNe6Xg/UaJFlpRz6FKIWs0db8cldb1zynHHxXohVStUTeif/MRSTic8JqqofXPAapk4NQZ05AApLYZ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTqx1PrZ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTqx1PrZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778593841; x=1810129841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hmVffbvSzjq/z84hTirUUpOvf9U9zXSnbQBAcVn7s6c=;
  b=UTqx1PrZiMxE2fA5n5RMb2++YIBcMt8gqgOXdrOxoyrX63rnGS0ZS8U4
   qgb2C1q3o1lUCUjso8zUrdhqAWp5/Euqfubf4BfxdJxdAGhSXlnTnM7Da
   WUeBQZ64AvfVF17VjbtGvNHtskYvTd68X/R2+MNIg1cVqni5ujgpad019
   kLzFnRI0UBIFFFacR5JOYH/nvktY+gGzXVw9dApVNm6gPHnxHPa6UUn2X
   0bO73KhluMc/KRSCWhNoDJoz8wTrAiiSTBvYAGGWEigOiRJxjQBfVyjHG
   KkgWA5Y908weqMWue4IxEVlBLQROCj+RV6AHJhuhLAKQVhMh51iuXOJk7
   g==;
X-CSE-ConnectionGUID: YYqAb077TtCh3I+N42E5Dw==
X-CSE-MsgGUID: XejKTXEETVq3x73PlJqtew==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="78648613"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="78648613"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:50:40 -0700
X-CSE-ConnectionGUID: Hu/RcsjeREecqiKVawh7mg==
X-CSE-MsgGUID: VSaTucAuSOii8ZxwoyYGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="239598091"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:50:35 -0700
Date: Tue, 12 May 2026 16:50:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v12 04/11] lib: math: div64: add div64_s64_rem()
Message-ID: <agMwKYtrkfc3shuE@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-4-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-adf41513-iio-driver-v12-4-34af2ed2779f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 01:42:22PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add div64_s64_rem() function, with 32-bit implementation that uses
> div64_u64_rem() and a branchless approach to resolve the sign of the
> remainder and quotient (negation in two's complement).

Cool, also chance to address:
drivers/iio/pressure/dps310.c:687:      /* Kernel lacks a div64_s64_rem function; denoms are all positive */

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


