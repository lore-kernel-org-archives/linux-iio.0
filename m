Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA197397B0F;
	Tue, 12 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593916; cv=none; b=ZJQwgTWvqk4p8/cl+Zz8yfuPkedx1vVypdRtSAb+pqAf2OUC90Q8BF7T887LoUs6UydL66EFlfJULzeXQIc9t7pEFAcckZnE2iNvA8rA8gNj3bEGTBV9w6xwocfxNk59gGwkSGpEYjqJ5PfaEnOrceTArkXDJ1NY49HV5qWCzKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593916; c=relaxed/simple;
	bh=4bcw/QGUCsKM8pagXrlTL8ZxHoSsmyHotb14LwtQjQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMOYwpJ+iEKWn5NbPM2OkzfCGIkMDbWEsL0SPuNjED4Xk6vOP2Uh8WKCt9Jn+Kf5YEw72is/TUQVKX2lnERXF7ehTWxWQGhTcQuZzzcNdU8q5SqXMmNCYn2UtpYy2/7f2HmWPtYKAzPYVuqpwGSu0Jd5oDVr9rmJuw/Kb+xGIRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GuXv+/WB; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GuXv+/WB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778593915; x=1810129915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4bcw/QGUCsKM8pagXrlTL8ZxHoSsmyHotb14LwtQjQs=;
  b=GuXv+/WB+SZX/CIMUpXfCEvoQnr/OtMfOYzDPr/6efQl70MwIknTag9f
   aNm5uI0VPZ/zce6bH3Ralc5dp82GwiX0jtnWSXDFZfw8Dz4oMLknu0zg4
   7D1/JMnvsadanO/Dqc7ADDRR3Z+y5MQ42fLA1RwNKRcMA7byuGIFACqIU
   PpiFlxIIsCGAHQrS0hS5UTJwQf5mGiVbxe4StF0TBIqLB33pEkUNQwmPW
   LWXbe/bdBjgbVxhepj3gswbNBQl+KrKH1TrRDfLK9BDGix4Y9mCy1GPcp
   EOT1fxFZvmuRLC5dOdG4lAQaDGbkG0zRiv2vXCh5sKCVKUVimTo+6m91L
   A==;
X-CSE-ConnectionGUID: +hMD+UZaSru3Pf1sFuN1Eg==
X-CSE-MsgGUID: iCD2IfMWTsKN8Ifbl+ertA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79522657"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79522657"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:51:53 -0700
X-CSE-ConnectionGUID: Dctv8Xt5Q4Kc5w4usCacQA==
X-CSE-MsgGUID: sSCSRKpDQuSjk/8GaOdg1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="236917194"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 06:51:47 -0700
Date: Tue, 12 May 2026 16:51:45 +0300
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
Subject: Re: [PATCH v12 03/11] lib: test-kstrtox: tests for kstrtodec64() and
 kstrtoudec64()
Message-ID: <agMwcZUD0cwcJZFv@ashevche-desk.local>
References: <20260510-adf41513-iio-driver-v12-0-34af2ed2779f@analog.com>
 <20260510-adf41513-iio-driver-v12-3-34af2ed2779f@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-adf41513-iio-driver-v12-3-34af2ed2779f@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 01:42:21PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add tests for decimal parsing helpers kstrtodec64() and kstrtoudec64().
> The test infrastructure is reused from other kstrto*() functions, i.e.,
> the decimal parsers have fixed base of 10, so base field is used as
> scale input for the helpers.

I think I gave you a tag at some point, but in case I'm mistaken here we are
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


