Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E2435201A;
	Mon,  1 Jun 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339861; cv=none; b=lJH8jItm6mPpEdibwGwugpoTE8o3LOzEO8DQm9aTzlVda5TlsNKeE3gXN8ei1OiNnJQPHK7igUjz1cMFiXX4DKuVVgC/A9j/qE0lHOcB7f7CT8z4LPg+kZkJxovfH37Vl8RYYnhHMuv/g6fsiKnpkZZGFVy+0VsT/UF28MVC3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339861; c=relaxed/simple;
	bh=DryslYpeymIi1YeWJQHgEHy8SMX1B03EOCjGZoiiI64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCYvCelcWZxQ8IiltihH2znXWnVpkBvz2MiwWz+pyDvF8cVozgxyKcpjxcUmCDwaa1eF5FYvpKjCdLdgfwbB33EVyr8DVhX0wKOxDc1vncxDLghTJFkWMyFsGLYK+Er9Y6Hj2IiSQ7Bcw34b9tVqev2uLWhRqVqXQmAW5SMmf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoEJs6vh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoEJs6vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780339861; x=1811875861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DryslYpeymIi1YeWJQHgEHy8SMX1B03EOCjGZoiiI64=;
  b=XoEJs6vhsdhB2MHF/RAAEmXZfqTZCSKrAKR6tmAr6Plp7f82FQ1umOzA
   T2QKcZr1XoKuuxYxPaYqas6p9z4vr7IMT1LzEImMEzckQDzQAYzcBkECE
   dun2gzthSyok5VMTlh8ENKMPb+yoYHHENecEF0dOGlFnjRHtErQB6STea
   CT95io4GGVNyxtJWsdvym3Nwk7Mmautnh/V9GdJ8FLwdolN8AJRqpzku6
   siue48Q1izFRWpYRvFiFnCt1UVrXR1MRGbRaVXbWE7Zi3ElftVRhE29Rw
   lwmeABrRUlC+2REBOQb2ocbnzKqteHZZtVjNnvqMOpdOrkqceL93lSZNm
   w==;
X-CSE-ConnectionGUID: JL2xq6IlTjuWVcRA7nbVVQ==
X-CSE-MsgGUID: g4PfveC6ScmLjf3ycDW5WA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81168674"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="81168674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:51:00 -0700
X-CSE-ConnectionGUID: o6zXrnonQOWCR09JsCSStQ==
X-CSE-MsgGUID: Z0YCIZfUTM+ylf5YessR2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="243770786"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.111])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 11:50:58 -0700
Date: Mon, 1 Jun 2026 21:50:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <ah3Uj9K91xD8G1-P@ashevche-desk.local>
References: <20260519131944.25174-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519131944.25174-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 19, 2026 at 08:19:43AM -0500, Maxwell Doose wrote:
> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
> 
> Add new helper function scd30_trigger_handler_helper_locked() containing
> the critical section for scd30_trigger_handler().
> 
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.

...

> +	if (!iio_trigger_using_own(indio_dev))
> +		ret = scd30_read_poll(state);
> +	else
> +		ret = scd30_read_meas(state);

Why not use positive conditional?


-- 
With Best Regards,
Andy Shevchenko


