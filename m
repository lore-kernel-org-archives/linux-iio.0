Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565683F1AD9;
	Wed,  3 Jun 2026 05:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780466012; cv=none; b=eWKdwKQvwIWi349NgQPML1lPe3h3HgEIIx2Kpt0o0aMcGBeYaq+/IksVYQkqwwF5anAFAc82r66Tj2uCHEpbiWKlUg2gogGqnBKvHWExsnsT8FU0h4IbGxbG3PIc2iJqdp8q2W3cp+KRJ/o7hU6VtXHBl6ldhfmMPd+gYkieWMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780466012; c=relaxed/simple;
	bh=Iaw95b1gB3Q1xhmCgA/gV3ngy0K6dLnOE58VVL4vxqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDEFe/7+VwIzCAI9ayjIInjXu1+f2gqY7pE2uwOKKuvsdgOqRqXn0mfnIOYzIWmtYZCmgwkmnykQEgst9YmQI8E9Dv41n2n6YY2m++1OSnC2N8lGEN3V1QQAM7jSGCNCkp48XdwJl/WGE40NYy9OWJbSxCn5q6xUJRvzJyl1tDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jVbF92E0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jVbF92E0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780466009; x=1812002009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iaw95b1gB3Q1xhmCgA/gV3ngy0K6dLnOE58VVL4vxqU=;
  b=jVbF92E0qWpImUQ8ZEM1xn5f0rlrGnI0+Se21Tfabx7kUENvOEevMWrS
   0wj9R8sSCDZlbzFSft6tqdlpWOCzcr9nzNOuiuMQNOmjo88U0C/ty9Q5Z
   h7f9wtAAWgz4WtVrHIKNIcgL1Fhf1C/LorPms3KBis9BCj6FHj6Jct5tC
   /ar6PDvrYMo0kjbUlitt/fDWyJ4/nXpj7GoH5+pzlyg94QSTEJP88sG/0
   aViISXtj2kabDJy1kOKYA2u3oLGAw0Nypk+zUtcRt5vI36qe+e8vOUKLP
   1Gpjb6zFZ5CkgRdeVPUdVBLt17yQJA+U4J7IGDDN5cPcC33227TnMVG70
   g==;
X-CSE-ConnectionGUID: vV6iAb6qQTGMPEZY175tyA==
X-CSE-MsgGUID: GzQVitWZQiGDVrgAJ1oU7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="98827704"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="98827704"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:53:28 -0700
X-CSE-ConnectionGUID: Zf1flSd9R/iWdFfoZYVDgQ==
X-CSE-MsgGUID: +Qw4nNHETh6D4RFtX3jtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="237769422"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:53:26 -0700
Date: Wed, 3 Jun 2026 08:53:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Miao Li <limiao870622@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, dixitparmar19@gmail.com, waqar.hameed@axis.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	limiao@kylinos.cn
Subject: Re: [PATCH] iio: accel: stk8312: Update includes to match IWYU
Message-ID: <ah_BVAIR40VIquaY@ashevche-desk.local>
References: <20260603014754.187465-1-limiao870622@163.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603014754.187465-1-limiao870622@163.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 09:47:54AM +0800, Miao Li wrote:

> Update the list of included headers in stk8312.c using
> Include-What-You-Use (IWYU) tool, mainly to remove kernel.h
> and add missing headers such as array_size.h, bits.h,
> dev_printk.h, etc.

Same comments as per your other patch.

-- 
With Best Regards,
Andy Shevchenko


