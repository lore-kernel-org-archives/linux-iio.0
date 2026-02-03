Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C309027F749;
	Tue,  3 Feb 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117495; cv=none; b=LdPR/rZLtua8XA0k9Y05UfQX7f4HCUnhEejupfiQ77peKlW01YsAOoj5pyo38KuBG8iDi76CZLxppJDSLzWH7mkQmOPowUniV23caHsa0XXuU+JtfBdGESDsT7MoC4APbL4mpPqj8pfOIyWbM5Fh/t96TPYm4QyYkoy10dwm1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117495; c=relaxed/simple;
	bh=5rDfthah3Km7Gek2QPzX4QoWC3VRFSL7+NXK+tUBbG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNe20F9FND9PCnN2X3H702kuSywlDqTya7fKbNbagfhpi/l8J121Oqy2rEW2CVBlIACyEc494ro/OpReMANJsS/grBgJPWAA0KLsRSrxajJ1n6ybSH9Iz26/kGXuHh8oC/JB/wTcXFqLPXQGKuJcIyeAmimSkx4VUkmFSWli0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rh1TuDTq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rh1TuDTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770117494; x=1801653494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=5rDfthah3Km7Gek2QPzX4QoWC3VRFSL7+NXK+tUBbG4=;
  b=Rh1TuDTq7mJ+m7vSJMnIUzhaYdGzNgjPejVJ6hfiw3qBreIUsOpYnD92
   oGqIe5WSljfjAKRw0ZEUvMLSoY7WvDNjLf0ltX/IrSr+rBljsW/maQCA4
   t41ewQm2+5sUHFMx7rqcCnnFYihnr4QUjVW66auaWsl/GJU45EGCZgrox
   EsAURzqs48sRGthf/qFuCc+fMVIO6yJ6wSvfCiIdOg+aLBmKmVVqF80t1
   wCsxsjaf+5L7IJXpV6+vgFm+06zj/Ay1p01TO7U8MBjrQYIa+t63+n9h0
   Ry1TKL8SymiAswaRe8fK7ng4RcLx8aVD5P5TvFqGoDORFQrZJeqRHgwrH
   Q==;
X-CSE-ConnectionGUID: M0b2Xp8ER4KoQdH56udAKw==
X-CSE-MsgGUID: M7M5T7CwSgyBBFQcQkAjLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71008016"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71008016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:18:14 -0800
X-CSE-ConnectionGUID: 4nrA8IhWRPOGItcXqRQHWQ==
X-CSE-MsgGUID: MBCzLDOISmitB8rsEYgF9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214306742"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 03:18:12 -0800
Date: Tue, 3 Feb 2026 13:18:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	Salah Triki <salah.triki@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in viio_trigger_alloc()
Message-ID: <aYHZcmZUZApdmE5I@smile.fi.intel.com>
References: <20260131092333.247931-1-salah.triki@gmail.com>
 <20260131124416.19576731@jic23-huawei>
 <b06bee455950f59ea3f2cdcd37ec4f6d1be68b39.camel@gmail.com>
 <20260202205217.3534d14e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202205217.3534d14e@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 02, 2026 at 08:52:17PM +0000, Jonathan Cameron wrote:
> On Mon, 02 Feb 2026 10:12:10 +0000
> Nuno Sá <noname.nuno@gmail.com> wrote:
> > On Sat, 2026-01-31 at 12:44 +0000, Jonathan Cameron wrote:

...

> > Andy already fixed it for the main iio_dev allocation:
> > 
> > https://lore.kernel.org/linux-iio/20251112145735.2075527-3-andriy.shevchenko@linux.intel.com/

Right, and this thread makes me check the status and the series wasn't applied.
Now I need to go to that thread to see why.

-- 
With Best Regards,
Andy Shevchenko


