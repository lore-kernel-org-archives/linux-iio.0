Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6698433D503;
	Thu, 16 Apr 2026 08:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776328444; cv=none; b=qwj3vizz9unUtw8ENY5W28vWuTAgct2YN/nGFhFO54rKtiIpr1OVgLwdNohPtitvWzMFy7rhq0kx0jDICDzb5yIp6u4zndsTRYsDWLcRQ1RGqEYRsPaEUgvII7YXy1sYpc8GoF0/84Deu1PVumAuk+Jd5HPm5DyFZa38Du4w5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776328444; c=relaxed/simple;
	bh=Fboridxb1qyw9JEIDnC2HnduOhB7dk1a1u1m9n9ElLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjkVYMMtYIUVAFudHhJ5YsiMwGR5OhFwH7MHhZnx72D0SAP+idP2sAA2xDL5jQ3O9m9QKmGs5EP7V/vSQvUteiXzqVwu4UetObc9cb1cJJgg6Yk+HIWzq1zdeTLOV5JRIQxu6YN160JscamsxGlj/wcxqkg3UiUr5ODo+HyvmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRF16ngH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRF16ngH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776328443; x=1807864443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fboridxb1qyw9JEIDnC2HnduOhB7dk1a1u1m9n9ElLY=;
  b=IRF16ngHzRUvu/zQR78L4pNgKqD9anT82+AHPNWxzWtmbg3wtUNs6Oh9
   faTqiHmY+hwYA4phm1EnGyOE+DHk9gFghQ4aeXOppTVvIxFXMoZ67su9L
   fpcgUh5/PZ+GqFPG+gER3mmkb/OkH9gkvcog/I/JvuFb/dVQErKsNb/kh
   mSs7TPL6AJt0o0Ug80oIYZVsavGoq5oM0T5Q0FMSnwlGFkY6lHXqnqi87
   dxlpiZaFgObFhC0dG0C4TYkpDwy6ugvzu6Nwy4goWmZ1BSLd1nV9XYFVh
   MC9CKt9CMmtJToZEWowrYKofUtEmyoYtIyBKNrz3uhW7W3HNaQtayyaEK
   g==;
X-CSE-ConnectionGUID: ynU3W+i+TvmRsRolC+UpuQ==
X-CSE-MsgGUID: 6criYXeoTkqSflv9i4ebdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="87941217"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="87941217"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:34:03 -0700
X-CSE-ConnectionGUID: kLUiUJm7SVK2Bl78QeppOw==
X-CSE-MsgGUID: ugy0uzlUTXWvwEnDkePaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="234686052"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:34:00 -0700
Date: Thu, 16 Apr 2026 11:33:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header
Message-ID: <aeCe9Za3aGPiRFC1@ashevche-desk.local>
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
 <20260416065118.1299-2-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416065118.1299-2-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 06:51:17AM +0000, Joshua Crofts wrote:

Sorry that I missed some key points in the previous reviews (see below).
v6 is needed.

...

> Remove kernel.h proxy header and add bitops.h for
> better dependency control and code clarity. Also
> removed slab.h and moved asm header below generic
> <linux/*> headers.

The comment uses too short lines (50), use up to ~72 characters per line,
please.

> Audited using include-what-you-use.

While I gave a tag, it still seems need an improvement, id est
there are missing headers:

array_size.h
dev_printk.h
kstrtox.h
mod_devicetable.h
mutex.h
types.h

asm/byteorder.h

and unneeded one(s):
device.h

-- 
With Best Regards,
Andy Shevchenko


