Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F95C301471
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777491583; cv=none; b=BkAj/mAEADEhiZKURPAvJTPjLusoUc930c7fuCaqQsjbAXlTNwGQlEiUUh28T7y5gQS624RS5e9MuAPw0UGzTeZ2phO/mBLaWK+49pLRzTDyaGfnBP1cmChdQBQOZZP7PEDTp5osehzTSa15k2uUIex8W5rATxYKtFwZ+V210mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777491583; c=relaxed/simple;
	bh=4IlsVdrasPj06Cm2j7y5jI6kOBgHVgWWkQumeSY++OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRWkvg9BVIFichvO/6KjC3eyD834q+GkoMhX7EEadRvpWggHAa49Pj3NtV06lEWjFkaqBJzmgH8byQFEAs6gs2346rvLqgWxIvS+ZdtEX96n7b1PJMSZ/4sBaRaRvSQicmcLJTrcds2Q0WGvTHNZsp6y6bbLxFJYMGytNUwpPXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Expp90wK; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Expp90wK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777491582; x=1809027582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4IlsVdrasPj06Cm2j7y5jI6kOBgHVgWWkQumeSY++OM=;
  b=Expp90wK6ncRDHbZXBaStDdQj03RFmI3Wk1Rm8c7UDAe3CyZ3vCOrmsC
   rY80tOMT3cJMN882bU58MP63YcBVMq3G83nWHpwNDpZipKwLC/DsTjE1+
   UH7Q6MW6dDN5VZ/5dcJDM2ABi18pg99N6VHJbqa7mNxmAaV+nWkV9j99j
   GNwymkFjU82dRGpfykBWL5gRZkhidHAUv6uLvdzAlumozAs5E/ajBbZi9
   /ipQdpXaaThxWVvxbypS7Z62fFt8RC8rv2RZSYyqGaS9vIWZAz4hb/WjX
   uoy4W4ixpF/BW/tgryo4CZltKcIwmhwNWkFNOcmOOE8f/7zZvdZmvZ5fE
   w==;
X-CSE-ConnectionGUID: whMlkmTPSXm+Q84XR/tV7A==
X-CSE-MsgGUID: KLnb1jcfSo6txvVdWdhVtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="65963001"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="65963001"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:39:41 -0700
X-CSE-ConnectionGUID: FaGOw+C2TpuSkrO9x3wGxw==
X-CSE-MsgGUID: WKMRARAkTvKFJJGG4puhrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="272488038"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:39:39 -0700
Date: Wed, 29 Apr 2026 22:39:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	Felipe Khoury Dayoub <felipedayoub@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: stk3310: update includes to match IWYU
Message-ID: <afJeeREcy8d-Tghm@ashevche-desk.local>
References: <20260428134205.1137419-1-rafael.guimaraes.dias@usp.br>
 <CALoEA-wd9jo_bPCGF0GqLH9SX7vWsCN7oyvkN3Q86R0F=WTjog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wd9jo_bPCGF0GqLH9SX7vWsCN7oyvkN3Q86R0F=WTjog@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 04:33:17PM +0200, Joshua Crofts wrote:
> On Tue, 28 Apr 2026 at 16:13, Rafael G. Dias
> <rafael.guimaraes.dias@usp.br> wrote:

...

> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>

This is implied by interrupt.h

> > +#include <linux/kconfig.h>
> 
> I don't think you need this.

Definitely. This actually should be removed from any driver using it. This
header is so special (hint: it's ALWAYS included by a Kbuild system).

...

> > +#include <linux/stddef.h>
> 
> You don't need to include this.

Depends, but since we have types.h, this is not needed.

> > +#include <linux/sysfs.h>
> 
> Remove this too, the driver already uses the linux/iio/sysfs.h
> variant.

Depends. If we use something from linux/sysfs.h it's still needed.

> > +#include <linux/types.h>

(left for a context for the above)

-- 
With Best Regards,
Andy Shevchenko


