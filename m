Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC42318EEE;
	Mon,  4 May 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884795; cv=none; b=nUgzBrkUB/PKdDHxxtAbTC04X3jH62WPChA9AmGgRGe43EXRqi0mCyFpU9ZwdwYtkzU4+cd7Dt1kr7oKwixiDIwCZf0iIUhs5FfktI1hjSt/ASY+ypRiwnIjc78vII/UckAh/YZK+U8R7L7mi1xR3SkG6aEnMeY1vbsmtzLdEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884795; c=relaxed/simple;
	bh=3niF7jt5OUQOr23bm9L4XQd1ENFeOiicyRPbLOsmEw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLuLkrmLq0OHL9snf82N8AkvzbsESJsSiSYUBRK9gICuIc+0jiDPlZFQ6gp2p/ZUy5B1vopuOYlDFEl5h00JTC112INhQjBOETAzaxNzQ+z60isNs3T6U8r6IA03hSr3o1N2MZiLXTWXv7t2fmRSMYLzlOiS70Vw87Wl+gnRX/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oEfc52WH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oEfc52WH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777884793; x=1809420793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3niF7jt5OUQOr23bm9L4XQd1ENFeOiicyRPbLOsmEw8=;
  b=oEfc52WHvrvYVDQkrb4fXnp/maLpGZ0sAprx/SD8sVwDVUnCR0QwovFK
   FeopDQMv6KysvdE7GjbgPvsMRtNYxZ1doQ2Q8QzcHE6HHdffdBO0/aPge
   bQAFDZoibErczmPDPOU48vtODAnxhd9GyJrdK9wciQN+UB5MnggxT0Pik
   7g0gtVYXGkf9ppCrY46jgS27mhSUlkQaLDqyPv7uEkxU8WWbcRJ93L6Q9
   aQdO2B6H94tnK3um7x6nieKWYSsYsuGv9shXs8QngrhcW8CwyLSKTgaE/
   u6Rr7NNLsQuTnIZWF/BuJlSyOLX/fiEo4YUo0fo3A9gTBcAuyTRHVtQx7
   g==;
X-CSE-ConnectionGUID: 64WBq5vNTyOUgbp28lRknw==
X-CSE-MsgGUID: WtwyvLEESe6BgJv6tDdOQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78789109"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78789109"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:53:13 -0700
X-CSE-ConnectionGUID: XN83xtCwRQK+jk1Uu/iYQg==
X-CSE-MsgGUID: S0yt94gkTEG68ObN6SJxTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="228965719"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:53:10 -0700
Date: Mon, 4 May 2026 11:53:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/8] iio: light: si1133: add local variable for timeout
Message-ID: <afhedNn1hSAXyqK9@ashevche-desk.local>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
 <20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-si1133-checkup-v4-7-fb3e9dce41bf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 30, 2026 at 05:04:27PM +0200, Joshua Crofts via B4 Relay wrote:

> Add local variable for timeout to improve readability.
> 
> No functional change.

Hmm... I am not sure about this as previously it was one jump and now two jumps
over the code to get the actual value of the timeout. OTOH, I don't care much
in this case.

-- 
With Best Regards,
Andy Shevchenko


