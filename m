Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5826391E68;
	Thu, 16 Apr 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327394; cv=none; b=syAHjjkPB9wfuZZwdm/Ahwn514xHEgwiphCm3cUgJjZw1dlmiD+ph8eQOZPQ+n0XqDNcbRYvovFlgd4v5z6Z1P089RInS+FZTqArJA8+/6ixE3hW/nwr4i6qV5GH6kRlmB54HJS9YLGy+ZnYPX67XxKM76S+AgpzXhNrB6W8JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327394; c=relaxed/simple;
	bh=SUx4UuIlTyI8ZRvl3hu13wFdSKSdiQsWl04z6Yyn9P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhjYGYJVEq6q1fhpTpxriMfPyuvbGqQaJm6Nskrm9sdr5XKU4PsUNToSv8HX0OBad2pmfVufs2/M78yFXNuLgkqMEejyA1p7yBTQCHT4i60cWBafKPj7zrZJ17WtntQeEGfexZ7WMjd3kzCT6QZV52cEjzvvtK56FyCJN4kwdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqpOdNX8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqpOdNX8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327392; x=1807863392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SUx4UuIlTyI8ZRvl3hu13wFdSKSdiQsWl04z6Yyn9P0=;
  b=YqpOdNX8azu2NTHHVwzckdImi7/UQKc2p4OMKNL5oAXSqVw23E6IrmIE
   Rv0ol9LdPlXPC0LwJQuxE0szCGorwxDO106+QuvioG3xsxLI1MrEScfEW
   0t70aDsfBOWYr15vyr4RTNUOGgjsqZhQ16eH7EFTkyOZQrD6iQFtIewke
   s1T5LhwRET1AiMx2bJ+0SFeMo5rzS1/CV6JRsxvvbaD9WMqLLgXoAd4wI
   4lM1QKiiyFXfsKYLCvITbYwdLb71SVE+RaEom4GZb5/rVqClHQLETtio5
   6/npPe2LuQ/e8ohlIUgFo/KuiP7v5LU4XeLVbGg1ispv/y+lmKD8hUm3T
   w==;
X-CSE-ConnectionGUID: 4div9XdTRliIRhd7XIpxkQ==
X-CSE-MsgGUID: n331JyjnRbqJkSEuTblt4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77227482"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77227482"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:16:31 -0700
X-CSE-ConnectionGUID: sETbGGDISN2UY7f9ow9r5A==
X-CSE-MsgGUID: Rsi9pjafSFSMlNhqHEx/dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="232407465"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:16:28 -0700
Date: Thu, 16 Apr 2026 11:16:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: accel: adxl313: small cleanups and
 error-handling improvements
Message-ID: <aeCa2i0ekwZMBTS-@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051631.551250-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 10:46:28AM +0530, Sanjay Chitroda wrote:
> 
> This series contains a few small cleanups and robustness improvements
> to the ADXL313 IIO accelerometer driver.
> 
> The changes modernize mutex handling using devm-managed helpers and
> guard() to simplify locking logic and improve safety. In addition,
> error handling during probe is cleaned up by switching to dev_err_probe()
> to better handle deferred probing and avoid repeated log noise.
> 
> No functional changes are intended.
> 
> Testing:
>   - Compiled with W=1
>   - Build-tested on QEMU x86_64

> Based on:
>   <linux-v7.0-rc7>

Use --base instead of this comment (comment may be left untouched, of course,
but --base gives a hint to CIs and other tools.

-- 
With Best Regards,
Andy Shevchenko


