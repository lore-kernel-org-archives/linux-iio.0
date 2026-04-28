Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A37282F27;
	Tue, 28 Apr 2026 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392423; cv=none; b=uG4fIvwPDwm3RiQ83btvrwEEjdW1pHEbzTpcA5EQ4PJ/sis0zkJHHomJSVGBEqq4jk+69CVlxha48Wy1vf9agdFGCr739GaKNFBq2eD9NVw3IEOWClZHLC6CvEf3zPnpoaimpc8u8WP52bAW+q3pMrv5mTjiAq15VVI86P3ehtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392423; c=relaxed/simple;
	bh=zO3nIxj5QxDC+GKAJ/tNp1jd51Eeha8435p04Wrwljw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7o+NvndA+MyQy0+m199Lr4JJaqCC8WzL1N/RT1hSjMlm25WtWdROptxe1sDw/XgoJsL695qHnPa3JHVfCTzfjQN/4MUJJL34VLHN8VrE9jdXxeiSINqg29dlN10+MRggZmlFVq5ruN7GJMpzpmrHWhJBBWgPYLiK0I/IolSp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5VTo7D4; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5VTo7D4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777392422; x=1808928422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zO3nIxj5QxDC+GKAJ/tNp1jd51Eeha8435p04Wrwljw=;
  b=O5VTo7D4+dF10lwKw1aQp3KlCf/to2S/4yHhKhiSJiAWxKu5FSSHmrcq
   lWctpxGOUavDbtvoQpVXQucfp2uYjm+LDXr8lv390XOnWhEWmcebOTu/t
   P9IxnggWzPTZlVpW2dqDxI5DkH9D2Mtui4oThIJ77KzEWPgPloT1edvb1
   eKLuyScg7kg66oZiNQgr7KQWA8BInj12Ls0OWSUkg5jTp791z62hyT2lR
   aTj67Zldacq/dQbkI9mW5vXwkd34CE5Cvg4lH7I/yiEJ1j3nPy5qX3rqM
   922akXQVbUiK4X3BFyMpD1hFdqmdJ9DeOwT1IoTOxbL1m0DMI2x++N11u
   w==;
X-CSE-ConnectionGUID: nPjMMowIQwGHJ1rKAYsfJw==
X-CSE-MsgGUID: iRoycb8zTYe8dg+AjOrTeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="89685718"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="89685718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:07:02 -0700
X-CSE-ConnectionGUID: nbGHmmoOQLO6GZuQ1iUKSA==
X-CSE-MsgGUID: sPRcg+fqSh+0bhu7WZzRRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="239039512"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 09:06:59 -0700
Date: Tue, 28 Apr 2026 19:06:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: buffer: hw-consumer: fix use-after-free in error
 path
Message-ID: <afDbIWd-TLrpF7UZ@ashevche-desk.local>
References: <20260428-iio-buf-v1-1-dcc63ff7b800@gmail.com>
 <afDZYNprYaQzcfpf@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDZYNprYaQzcfpf@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 06:59:28PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 28, 2026 at 10:53:25PM +0800, Felix Gu wrote:

...

> > -	struct hw_consumer_buffer *buf;
> > +	struct hw_consumer_buffer *buf, *n;
> 
> Please, name it rather *tmp.

Or *next. The point is that most of the one-letter variables are kinda reserved
either for integers (like loop variables, local size or number holders, or some
char * pointers).

-- 
With Best Regards,
Andy Shevchenko


