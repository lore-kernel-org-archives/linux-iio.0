Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC7A3D1712;
	Fri, 17 Apr 2026 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776420010; cv=none; b=M21GM14OSqgTlG0SPEikeZjneaRThyJ0N54NA2faQTpqjc+tPPP5oQ4MkHZHQ6IvPFoseYR5xBtfyqBDZxMGp3Kbau1DdZtLexYbO6/859A30IusGuFgSqX/8S4U4oh2WMV/FFKeHK/YgJ2w4tcK+dnlqC22YD8YskRVqO2UilE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776420010; c=relaxed/simple;
	bh=UNMTxtos7VGB7+j7mhl3k85/Qt7mOCDfYjjW2ncm2C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/fK9C4rABTsLUzInPuy2acjlqfk5zSHyHeSLIZbTiw34acSR7IsnVqKqfLhlejrLnupXCP28i75mjL4SsMh10dSn9/pODm86Re3BjUg5JbvJF5b7t8Uusg1t7uRIS1EcdML3XCaboreop9FcIz6LzBGNgIdu7bjWE99KJfgKzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k2clUR3u; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k2clUR3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776420008; x=1807956008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UNMTxtos7VGB7+j7mhl3k85/Qt7mOCDfYjjW2ncm2C8=;
  b=k2clUR3uQyYHV3MtzBkoioU1qwuVur/6VaRRKXYaVCWf18ptZqCch+PN
   Z2O+7C6Yzyx/vHevR+OVbM2KM6LkFWIl5Lqgem0n15P9IJ2NJGEHLFY64
   /ELOuThnvjHeveHs3WSpBBki4JWiAU109h2v5Y8YxsNPALOjwCkQ+Ys+L
   o+C0Mb5yR5dq0KIZzx4d6fKEe9M3mzwNruagmeaqUVhR0tnVUpqcbT4+f
   Iwyj8vag52inqQgog9m0bKe8S1jUABZebwFoTym1D+YRtisR4+LnR5qiQ
   g9xwwDd9KCUd4LOS7gX1L4ihrMRTHOjEW78latXqXQzX9SfnPxJgcNFVg
   Q==;
X-CSE-ConnectionGUID: qfcr1aFtRVC9ce1ZgbCAhg==
X-CSE-MsgGUID: I/yMP0EaQS68SMwzh6QL8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="77303853"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="77303853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 03:00:06 -0700
X-CSE-ConnectionGUID: /ULVo7rtSjmYIlFMtG1WHg==
X-CSE-MsgGUID: OgeZg8QsTP6iMHjJkCc49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="230924764"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 03:00:03 -0700
Date: Fri, 17 Apr 2026 13:00:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header
Message-ID: <aeIEoJnkzO03Rz01@ashevche-desk.local>
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
 <20260416065118.1299-2-joshua.crofts1@gmail.com>
 <aeCe9Za3aGPiRFC1@ashevche-desk.local>
 <CALoEA-wTk+32wUv3M_wLX-+4Fi=6BjLh6UsRZYqQM1Wcf+-+5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wTk+32wUv3M_wLX-+4Fi=6BjLh6UsRZYqQM1Wcf+-+5Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 17, 2026 at 11:41:28AM +0200, Joshua Crofts wrote:
> On Thu, 16 Apr 2026 at 10:34, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > While I gave a tag, it still seems need an improvement, id est
> > there are missing headers:
> >
> > array_size.h
> > dev_printk.h
> > kstrtox.h
> > mod_devicetable.h
> > mutex.h
> > types.h
> >
> > asm/byteorder.h
> >
> > and unneeded one(s):
> > device.h
> 
> Adding the headers above is fine, but removing device.h even
> if there are things like struct device_attribute in the code?

I don't see it's in use. The pointer to it yes, but it's a huge
difference.  https://en.wikipedia.org/wiki/Opaque_pointer

> I know linux/iio/iio.h includes device.h but I thought that we're trying to
> eliminate these "includes in includes" unless they're trivial (like
> linux/bits.h in linux/bitops.h).

-- 
With Best Regards,
Andy Shevchenko


