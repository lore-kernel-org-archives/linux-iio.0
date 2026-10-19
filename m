Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAD4A0918;
	Mon, 19 Oct 2026 09:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792402453; cv=none; b=cJ5mT9/EhUcltNol6X1YgTO+K3LIoQHfmS65Y9NZ0RJk6EjGV0xagtszugmPB6yoqlsHgHIy0zZDpObJqYg7yLk3PYnuLBlFVp1Ux/OY+AkOM3YUu7jdOxMptj1/xxJzckQkjqC4mI87TMyjTu9Ul7oqG1K2AmfkuQvBrIXMn9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792402453; c=relaxed/simple;
	bh=EyuxdG7AXXr/Y9TuCwVf7IWJuhW1DJZfRB7CpNeJsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILUmFfeKJ7ES0IF0PuWjq5b9C0EE/U6653/7+4Y9UBp5mIW+Mq5ZuPuYfJuko50Q770CGz4PFMPQ06Ezwow75z+/gr8EuFL4xoiSas73DzKlTImSdEnuRp8wZwJ1wG0WOAWn6FvlGGyru33kVAIwVz2bkl5d4fEegPYM3+BMMJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBGFqaG7; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBGFqaG7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792402453; x=1823938453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EyuxdG7AXXr/Y9TuCwVf7IWJuhW1DJZfRB7CpNeJsEM=;
  b=IBGFqaG7jMCTmyDK7UMN6mcR3IgHhg8rPLwIDiyDaZRBUErow6KcfZPP
   QcTkyhCwzZjbRSyt9cPN+2rnZ6SaBIr4hP31rT7iY8SwENnE6aUMOpWJe
   65+MkWD3yMJ2kvsPtTi2I66ZaMSXXyX93C/fMQFrNSiDWu7dPsPPGlHHI
   C7VPDRnQXjFIKFBtxOMhrw3smzzfDjQ4deFVDYDWywJbni9g212ho4uSJ
   yvCP8zBd3pg6HhyB5K3TMboTauqOX3BRgGTcImHYNyO/ZhObjlpJk5wrm
   zWbkTdbkORmio6exrtvcJ9hy0BwilZwwztVktzihIKLTEZ78LocT7/n2j
   w==;
X-CSE-ConnectionGUID: bYZrHs/mTrGu/C+zXiVezA==
X-CSE-MsgGUID: IjQXIBjpSZyesgfR1v5tIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="1090016"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1090016"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:34:12 -0700
X-CSE-ConnectionGUID: eBrZwxzISSypt/DoBWVmNQ==
X-CSE-MsgGUID: 7NDFoBuMRj6F6jQQjhuY2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2494202"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 02:34:09 -0700
Date: Mon, 19 Oct 2026 12:34:07 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>,
	linux-iio@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <atXkD3WIgaeamrh9@ashevche-desk.local>
References: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
 <20261019040919.0381d31f@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019040919.0381d31f@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 19, 2026 at 04:09:19AM +0100, Jonathan Cameron wrote:
> On Sun, 18 Oct 2026 17:31:08 +0300
> Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:
> 
> > Replace manual character checks (e.g., buf[0] == '1') with the standard
> > kstrtobool() API in sysfs store functions.
> > 
> > Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> Ah. No need to resend just to drop a tag.  I did that on v3.

...

> >  #include <linux/i2c.h>
> >  #include <linux/rtc.h>
> >  #include <linux/module.h>
> > +#include <linux/kstrtox.h>

May you also move this before rtc.h to keep it a bit more ordered than now?

> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/events.h>

-- 
With Best Regards,
Andy Shevchenko


