Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC8352C2C;
	Thu, 16 Apr 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331248; cv=none; b=ODDhARbbMdLNu/RZIMsEGJvzndFo+XW6G2oOSZBeDMd05wdDpgnCNmJZcMb/2oEifeuCI02Ip9zBdd/c+XJIhYhKrMrA3JkHl8XrLnKliaPlKZWCIyWMvLkNz0NDgYNh/LDEfF1Jcp5MLi1s4PoWuvc8yYa6xr1NQ2unzCsoXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331248; c=relaxed/simple;
	bh=17unDIWkC8FsTmjOXLEs3CFFeqMlV8nuXhcuuOrQ8rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5RLbHp74GGJ4Ann8m38/5+PTDIyd66k8F++KlP8f/2ua0Jscytg95o24CA2/Bv9yEIhzaADgw6YS8JyrAQyV59yXKTfnJIOeAxKYC3cuuxqGG0viZPxhRl0FAKfjmldZ+umymbSjzhzol7T4cV7m4FR0Yvu88xeqQfwd3rdX0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAz88Z4w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAz88Z4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776331246; x=1807867246;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=17unDIWkC8FsTmjOXLEs3CFFeqMlV8nuXhcuuOrQ8rw=;
  b=QAz88Z4w4yO66mKU2KkQQrMuKOrMUEGFc+Vlyj24wgRGqBv8vY8mvSc7
   +7Gh0pWR0eO2rWZJ3Xm1BC9Frg49Ekjy17S/AQrNVdZvMXMoVi/uhEkeb
   +XVkPBCwi9O+U9yq3jHQfe08HVPmLLfUpTy9PkdcExL1EI1a8w0QvFZSS
   TfhAgEbDpvik3h1uXJubN9Qkpgm3QW2Xl9+7XwToGuckSDxa3MvZp/bV8
   OqcRi+tvbR+68dmVhao3pSVUS/gzCw5mG+elDuBMch5XwJxqDd7Qd9ywX
   C+HwKLqo91xLGI4rckePphDK7PZNoVvHC/t86pxfuksQSUjbGYUVBysNl
   Q==;
X-CSE-ConnectionGUID: AYd1V7wjRg+OGhYu8ufhVw==
X-CSE-MsgGUID: fdQ1aShIS1uPR+JL6YpH5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77343866"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77343866"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:20:45 -0700
X-CSE-ConnectionGUID: tuKUyCAKQGSgU75pm8AupQ==
X-CSE-MsgGUID: PoGun2CJTwKK97hSsAyt+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="226343737"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 02:20:41 -0700
Date: Thu, 16 Apr 2026 12:20:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: ad9834: clean up includes
Message-ID: <aeCp52arIh-wNzSi@ashevche-desk.local>
References: <20260415112030.1324-1-joshua.crofts1@gmail.com>
 <ad-iqJxCoZ18nESz@ashevche-desk.local>
 <CALoEA-yHcXhM=zNtZa_x=VuAzGCbLD8QCHPGXA1GFYHG+0ZtOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yHcXhM=zNtZa_x=VuAzGCbLD8QCHPGXA1GFYHG+0ZtOQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 11:05:21AM +0200, Joshua Crofts wrote:
> On Wed, 15 Apr 2026 at 16:37, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Still missing types.h, math.h, and probably more...

> I don't get why I should include a math header (I presume you meant
> something like linux/math64.h), since we're only using do_div(),
> which is a macro from asm/div64.h (which linux/math64.h includes).
> Last time I came up with this, you recommended working on this in
> another patch.

Ah, sorry, yes, currently included asm/div64.h is fine. If we ever
want to replace that, we need to do it treewide.

-- 
With Best Regards,
Andy Shevchenko


