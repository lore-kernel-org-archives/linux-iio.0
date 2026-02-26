Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA6847ECF7;
	Thu, 26 Feb 2026 16:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772121761; cv=none; b=BglXGlZudXxOQVwaIjxUX/IGsqI+CGJiWJ3ALGAJ09+lCIIxDNhcrM5DylbtYLfS4zABROPSB9E/a0kOxUa/Ss0iwtfU0pM+UFzYhzxX6wovh6zW/AZCuEiKLNN4/9XodLlDuzM13TnUnOXL4uQDUmtM4seH1yO1vAlmCtj1uSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772121761; c=relaxed/simple;
	bh=jWiuoX15Mblrwz24tNf0ikmUwKfACgiLh6JFtmC53E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRbEhlsKBzkiic1QcW7qksMFvRqbgQEr0/brPYRQtb2RDWiu1Vo9OavDKJBO7rW3Hxqia7lCiPfm6oJAQAtypKIp6cU9i+N+p9lPIjgfIyiIxnl5hDsSVR+hWQ5jIrhUXsuUw4RvZm/kkBo4IbfLPdNVjEHlvF6XJ++WVLMJMnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgphthG4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgphthG4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772121754; x=1803657754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jWiuoX15Mblrwz24tNf0ikmUwKfACgiLh6JFtmC53E8=;
  b=KgphthG4UPxUE2pplk0YjUZmLRT/tJA+APYZNsBp8WJgdmWhPDShlO0t
   s0dWlFdu297pe55nYga7BYT0JXWRkCuj9pt9AppL3F8k89MHZhC6BW5p8
   pLujCJ9tfDA6sljYHhh4RZnsM0ijzp87+xDqr1ovuz61G+q4gRCG2lXQY
   i7tGiOJ4a0lUTCFxk8CwxjdZqQKENl8oeCOrW3nMVJU97iwO56PfSpVCP
   JJUgjRR8o1qRDy0Uq7aKREcEmO28kx1CPxV37PEUp40po/Zxawh1uzCfk
   hhGGs5b+vY7RyDyMhW2n8+KsgAwLzE5imVzE52HaNPce+x35gcZA/AcMj
   g==;
X-CSE-ConnectionGUID: HXxh0IHIS3KOLHdMieMOdQ==
X-CSE-MsgGUID: yU+yt7L3Q0uShO9sdElqZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83821878"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="83821878"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 08:02:33 -0800
X-CSE-ConnectionGUID: Mxyc/Dp1Qku9BksrkJTOwA==
X-CSE-MsgGUID: Sye3YMt8TJK0sPAAecFJyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="215730743"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 08:02:29 -0800
Date: Thu, 26 Feb 2026 18:02:27 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: Michael.Hennerich@analog.com, andy@kernel.org, corbet@lwn.net,
	dlechner@baylibre.com, jic23@kernel.org, lars@metafoo.de,
	linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v5 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for
 double tap
Message-ID: <aaBukywfQqqAjB0U@smile.fi.intel.com>
References: <aZ29vjil1d7NF5su@smile.fi.intel.com>
 <20260226150318.21168-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226150318.21168-1-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 03:03:18PM +0000, Taha Ed-Dafili wrote:

> Thanks for the reviews.
> 
> Regarding the bouncing email: it is an archive address for the Linux
> Foundation Kernel Mentorship Program. The guidelines recommend CCing
> it for the program application to help with the selection process.
> However, since it's bouncing, I've dropped it from my CC list, sorry
> for the spam.

Do it Bcc if it's needed.

-- 
With Best Regards,
Andy Shevchenko


