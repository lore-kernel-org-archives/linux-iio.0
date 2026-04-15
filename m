Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE0A329C6B;
	Wed, 15 Apr 2026 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248487; cv=none; b=pD5pN/2AuZcdqDMhYLbLlg7+KkOgaqQDoNqwIX/iDLWqCnQQemZ4PW1cpnxrABMeireaxL04iJ4G9S89C72gSH6AVmxWRMPtRyDL418jw9ou+10I3meZon/IeDCFgDYX2mc/CAGKoGqF/hiH5vZonB1p7Oe4rvWeF2cNonjNivI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248487; c=relaxed/simple;
	bh=iK/BUXDcVx6Cw95XilwcoWg+IyNp1IQFUvfOWwx3Lz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MF63Ubbj5ISYVL3IGL6PPAyj/IZDBLnXHLCFYRg2bxVJyzZHiDWkLTpOwqg0nwp7TV0Ko1C9e7Nyv5oP7ToKvMjOnRSCi9ODvbFCA42ttuMro3kquej7njNaTCP5Yscs7ba2M18/jzCwarWW2/YHbXpzHR7g5tp+kdSCioFlwdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SQB8Ahwu; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SQB8Ahwu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776248487; x=1807784487;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iK/BUXDcVx6Cw95XilwcoWg+IyNp1IQFUvfOWwx3Lz4=;
  b=SQB8AhwuwOjDcKErn1rVJyjLisiMltGT1BwYm6csgu6pQt/M8zxjTl8a
   yBIcEAoZxBflZNWRtMD5GH1E8jNHpX7gTQe9xMopVvsX85IleK6OMKPBH
   EpfGImflC0jO5PksVJ3NswbeMOl6KVW2H6CfVNzLxwjaKtnwqa/Yb37kI
   vKhRnJdWZvD7k3Rcq70qQeOiDbpniH6ihqnVW9II6lGgaY1DlHaC4Y9E0
   ZUTE/dGhaW6ZP0nTNVzBIIckTP/dc5v6JB7tfNb/1nkFbOwYVRbWSGcBP
   x1lKN3fp/LnF6m2t3LyfR49GNW1DHl1+CYmw6Zy8F0LiH9jAIq0v/N5/i
   w==;
X-CSE-ConnectionGUID: ML207PLIS5mOgBJ0yrpgwg==
X-CSE-MsgGUID: ckXzjmpvQpezZZYsbW91nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="87527835"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="87527835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:21:26 -0700
X-CSE-ConnectionGUID: +x8Cg+QlQqelMZw5CsDDKA==
X-CSE-MsgGUID: /Eqdf3lrT5WJ01YxI2hqig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230237166"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 03:21:23 -0700
Date: Wed, 15 Apr 2026 13:21:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad9moW8lYDuOf77B@ashevche-desk.local>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com>
 <ad9SzwJDwRNldv_z@ashevche-desk.local>
 <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
 <ad9jThxf6PINFFmo@ashevche-desk.local>
 <ad9jtH1YgA6N6FYg@ashevche-desk.local>
 <CALoEA-xopdHNGtBJQk1_cZZ823qu1_8EM5GR2tB+RdYyuWpWEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-xopdHNGtBJQk1_cZZ823qu1_8EM5GR2tB+RdYyuWpWEg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 12:17:13PM +0200, Joshua Crofts wrote:
> On Wed, 15 Apr 2026 at 12:08, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > Ah, all of them have the first one an AI... Perhaps you are right.
> 
> Therefore, should I send a v5 amending the period and <linux/*> header fix?

Yes, please. And don't forget to carry on the given tag.

-- 
With Best Regards,
Andy Shevchenko


