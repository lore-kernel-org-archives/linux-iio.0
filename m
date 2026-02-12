Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEBE55A;
	Thu, 12 Feb 2026 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902465; cv=none; b=JmsDnpUrzHXzla31mhh74ABRkKnBTg9w+4+aQMs9axWsuKILkRRhF/W0yJQBUuFZfoX7VJd+XAiPKbeb4WU5SXBgsegv3W4TTcgLZ7a22n7aif0iL4QV5Ujq26a5Q4avZm3NCLaY6E1hX9Z2Ya+muOwFEm9HJNdFNhYGwRSlDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902465; c=relaxed/simple;
	bh=nyMoRJ8TaAJiwDv1+u+JU0mCEydBmB9pkcQSbOPj/sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnlZzidQ3UvjLibP5JXynVe/DvwpvzgPueWAvQfxMo7p2KchW7J6WPInkLwMnUnGUYyxHKlEj25Rzgm2+5hTg2VsqDn/GUmdofvgc6aQttVr2+DT+nvV1PrbmFwI5RRlMmmToralALQKcT1M0oKpwxAQE31uy8RF3bjvYDhVtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDEfnyrC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDEfnyrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770902464; x=1802438464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nyMoRJ8TaAJiwDv1+u+JU0mCEydBmB9pkcQSbOPj/sI=;
  b=kDEfnyrChLimaftcAf/f9ky5hqhcxrFNWtvtnlgWUH1FN4YzR9CJrpQE
   a1BTVzw3IidfZsjV5wJIW4RiBAWZVISm8ZTGzwAmWmPkve7/Z6bqqki0y
   gkJjj0uuRL2tZ5OQpmN6wrSySWP/x1ejw/9bEGwns7hRxEcmK4+NAavwa
   Ng2Cci6nO/a2pYPTvyX//Ckg4G3Is8TOIHf4NtoRJ6b6oLlCZClFgoxVu
   Tk9dzVQ4596x2Pn9U25ILRFUlBI1LYrNsv1yhiV/QnQYKnHAMlbD8vcA0
   6Bjd+9s0jBzcAEn5GJdl3GtVr8qsNmzYUjarMQxn8b++igm6zUjrx4Xgb
   Q==;
X-CSE-ConnectionGUID: 4P6JFHoJQGmcj78W244pLg==
X-CSE-MsgGUID: fjCaPe3NTpyoAgLsZHqg8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71273829"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="71273829"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:21:02 -0800
X-CSE-ConnectionGUID: YTn32IlCSUOhkW+pMO8ZlQ==
X-CSE-MsgGUID: Ym37Rmv3Rgmq48USqcxQZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
   d="scan'208";a="211469249"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 05:21:00 -0800
Date: Thu, 12 Feb 2026 15:20:58 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: chemical: sps30_i2c: fix buffer size in
 sps30_i2c_read_meas()
Message-ID: <aY3TutupZx-9A-mf@smile.fi.intel.com>
References: <20260212124609.24745-1-antoniu.miclaus@analog.com>
 <20260212124609.24745-2-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212124609.24745-2-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 02:46:07PM +0200, Antoniu Miclaus wrote:
> sizeof(num) evaluates to sizeof(size_t) (8 bytes on 64-bit) instead
> of the intended __be32 element size (4 bytes). Use sizeof(*meas) to
> correctly match the buffer element type.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


