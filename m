Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512F2E2F0E;
	Mon,  4 May 2026 14:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903585; cv=none; b=eelIBck4ixKoQAL6guvBWvZZ4kWhEHGbbkS2wRZu5NfoK+NlGgO5IbSBGoI3b50L8PAx/WJhZqZvPEzSglZYN5oc/NH4t2vsBeyyh0JAn1S04tjF5tYPtu7gyM1zCF8e45sg/N/noN2GSoqpxxHqGbz0yWwgQGASTNMA7hpnjqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903585; c=relaxed/simple;
	bh=uutRUYcFCy2H34g9TXXWdfRQOYsHRH/XIT5koSSD4no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQ58qhuPEuO9z6gd+3wj45ThjexDXb+ZhneJDplsBfZOigeW3kq0iszzkht/mJIXI7PYp/Q9ITRX58le1DvH546d4qtU2Xu7eO38Z1LS+yCa3aPd5SHaULqjiwMSmwooWVAvk0rA6qbKONoXKSiv/93ieYG8hhelswq6FQfyNsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a61d/GLS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a61d/GLS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777903585; x=1809439585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uutRUYcFCy2H34g9TXXWdfRQOYsHRH/XIT5koSSD4no=;
  b=a61d/GLSo2llZcHJW95t5QHpRvKrRyeaLeLGC73ILRVXUSOrDKUCNyu8
   DIz2y2UUuBOiXUBLMuT0uWsnegUkF9l3cOLL0GH5JXiPxZKgGT6LpvlDq
   w/rQvZKYqAicebDaU1riul9nlImVltYArWAi3YAh2b4tnlLtAlQGX4STa
   cw7QJUzrAxKYR4G7jWgm112twN/QLi7MEkaFbVm39eSh7us5MuCtNsshP
   rXtBbTw68rOiPdi7/ycftTLPjQ1fa2LoOCVu4JjD7LAfgOA6UpcJCI1TV
   DejjL+gURPdNgItu1To5UG2NBpFcbrcm9VhSfKbq9fjBNH6G1UiktlM6q
   A==;
X-CSE-ConnectionGUID: XG6md2UHQQu0jOhbuQcTYA==
X-CSE-MsgGUID: CnugmXWVQc2Y5tGW3GCqtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="82370679"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="82370679"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:06:24 -0700
X-CSE-ConnectionGUID: SqajfutoR46yYI3WvY4rGg==
X-CSE-MsgGUID: CcI++qyyRKC1HzCze7Nrvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="239824424"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.198])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:06:22 -0700
Date: Mon, 4 May 2026 17:06:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] iio: magnetometer: ak8975: pass conversion
 timeouts as arguments
Message-ID: <afin2x3jBmBRKsuY@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-7-a291c2a7c71a@gmail.com>
 <afh-smyJoL7xRiqZ@ashevche-desk.local>
 <CALoEA-yr9B+74KdSY1iEYssvPQoSXdYjXpNFBzrdZm4RHvJ1jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-yr9B+74KdSY1iEYssvPQoSXdYjXpNFBzrdZm4RHvJ1jw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 01:25:11PM +0200, Joshua Crofts wrote:
> On Mon, 4 May 2026 at 13:10, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, May 04, 2026 at 11:48:19AM +0200, Joshua Crofts via B4 Relay wrote:

...

> > Hmm... I don't think we need those, esp. taking into account the difference in
> > the timeout_ms for different cases.
> 
> Okay, this was suggested by Jonathan on your v0 version, but I guess there
> is no need now that there are poll and timeout parameters added in the function
> (or maybe the suggestions were for the parameters only and I
> misinterpreted them).

The idea is to see them on an average one page in the text editor, all of them
at once. As long as they are quite close to each other, the temporary variables
are not needed. Moreover, I found them a nit harmful in terms of readability as
one will need to jump over the code to see the values, while with explicit
numbers it's all being concentrated in a small code stanza.

-- 
With Best Regards,
Andy Shevchenko


