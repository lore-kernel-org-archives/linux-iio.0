Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8636DA17;
	Tue, 10 Mar 2026 11:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142585; cv=none; b=sSWN6nGX8gU+CbmEwmQya4HLbjaQxO3nfr5r+GNVQXNGIjJPNw4RdDH1c7dkMp/oRDVcZhkvRGItiUqcWD5OqhJqGnm8GV++pGRM/rrxqEn8PMubvOFOLol07VjBRNZ7Rkxsu8q60IVZjE4U1T5vq+waJ/1jZp4bL7ktDpxlXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142585; c=relaxed/simple;
	bh=1FR84GduZu6DLSsA0pFw12mivztBTgh2wW8vSHBFQ9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK5hw5hTPEDQVM2a0zsXPGUbVFGGpfX8RUFYPjrI6Goe9YgBHMStMBcUh/OkbomJXgP9fY3zqjtgcBjoHKzVH5jLmCJt2iipdbQYNIwKjZT2UV+qTGRn2j6FDRYEQ/JcT8Wg4VuYaWdcv1mw9eRRGGLVzXhaK1NHRhksy2Dj/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZW4XP4cx; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZW4XP4cx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773142583; x=1804678583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1FR84GduZu6DLSsA0pFw12mivztBTgh2wW8vSHBFQ9k=;
  b=ZW4XP4cxiEPBx+W5rS4uUp4UU9bBRo6LANhNdPMTuAhZF6Z/j/QDMs3d
   RTSX5x5mxu7lpbtz5UytqY/rMoRHLsVljH09rI1JgkcD9XIFEmP4zwIOv
   A7cFMvh1DrlZIF7i7tH1MugQi1cygJsJ9yTuxb+gFScrXQ76AOAZZlSSb
   QjigEt7wdOt0SnsfmFCC2haptyO36xMOejkfmA7ZE5y05ry3VrMlhzVIb
   XQTlLFguWGa9ocMQKsmzypVYhkA7hZYwAXiEaljBLimNY9UK4/Er6dEHb
   dbzGTz0AH2UiVj8hjIilihQW0ZIJDMFqunEc5Xh7xo1EO7ROhOtF0yLuC
   w==;
X-CSE-ConnectionGUID: xIwvuxM2ToCJudIUBGwBFA==
X-CSE-MsgGUID: FL9KEpcXQJW/2ST17eTx9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="77791044"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="77791044"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:36:22 -0700
X-CSE-ConnectionGUID: tMXKAcvaTNKcXWbqzrxLMw==
X-CSE-MsgGUID: 9CjY8ZDPTv2sh4h3nlix1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219323679"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 04:36:19 -0700
Date: Tue, 10 Mar 2026 13:36:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] iio: imu: bmi160: Remove potential undefined behavior
 in bmi160_config_pin()
Message-ID: <abACMNYNE5tpr9ZB@ashevche-desk.local>
References: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb653ed07fa99e3ebc51374bb367cba5712e4ca1.1773114154.git.jpoimboe@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 09, 2026 at 08:45:45PM -0700, Josh Poimboeuf wrote:
> If 'pin' is not one of its expected values, the value of
> 'int_out_ctrl_shift' is undefined.  With UBSAN enabled, this causes
> Clang to generate undefined behavior, resulting in the following
> warning:
> 
>   drivers/iio/imu/bmi160/bmi160_core.o: warning: objtool: bmi160_setup_irq() falls through to next function __cfi_bmi160_core_runtime_resume()
> 
> Prevent the UB and improve error handling by returning an error if 'pin'
> has an unexpected value.
> 
> While at it, simplify the code a bit by moving the 'pin_name' assignment
> to the first switch statement.

Thanks!
Are you aware of this: https://bugzilla.kernel.org/show_bug.cgi?id=219192?
Perhaps also needs to be addressed? (I haven't checked if it's already done
or not.)

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


