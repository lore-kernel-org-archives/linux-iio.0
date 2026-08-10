Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE3D34DCE3;
	Mon, 10 Aug 2026 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786351264; cv=none; b=q4gohpPMn1b/7uNPApY7g7YLsIteETz87JXExAeEQoP16/IhO1M6D5cOiOYqRtaZuPVu7QYeQvG3ySb3uRoaxMVdwmwTZPG68e4l0SWpCb8W0usK0Sw0sj6d162c/VTSwtQH6JFFe9HJXR2arsSfN99CzaREKpVGq8OaM6dIqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786351264; c=relaxed/simple;
	bh=mydhGTiTEGTNDOXpFu6N3HDDqglmZwg8RIia1cp1VsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M6kdYCwkmuicI4k9IKqlPMgic4Ib0YBp5Oql9t8BUCf7o+zMKF0pOXmskasLYo3EWLPFlz/6otC77agUeSgiice94kD8KwvQG+dEr7qMKb5WK6WzrRB6F5q5cRpRvqO6zAnADKDLfkK+DeR8CDVGs3zTHMvltO3nGeOn+3yJOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YgE3rYsh; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YgE3rYsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786351262; x=1817887262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mydhGTiTEGTNDOXpFu6N3HDDqglmZwg8RIia1cp1VsA=;
  b=YgE3rYsho8u08f7deDIlNTnaqyFvAm24h+IPSruv90R0glvgclQXEsWa
   T2VCrOROGOBf/GMKMFrH72yYT5gv5vaJfLVnXuacuS6h06/c4MZOnATRa
   B+c9nO3CyEcVYvC+PoaMOkZySrWdCIi2af3l07Tnoyf1JzgdD8ncK4d2d
   rQRao8YBZJs3ckcL3ggyVfnuqJP26m4CeAdGlBiwpeToWaSKzw905sIRF
   /z9xZ9kwjibGyTg4cdjJPSa6Jwa4NVn0lW36Gm21iDa7fNampI1Cve2fM
   7fexr92SvXst7LmeYqKm4IF/E64FnL5UKVFm8N1AY77cAEn+X8G0uExiV
   w==;
X-CSE-ConnectionGUID: r6eMf+q6SJOhbvrdwPa56Q==
X-CSE-MsgGUID: /ZCG/PGdR0eIzplFGW167A==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="87075571"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="87075571"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:41:00 -0700
X-CSE-ConnectionGUID: QFIoCPRkR8avgLG/58XL4Q==
X-CSE-MsgGUID: nvyInHNsTFGbBBlHh09uqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="287685893"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 01:40:57 -0700
Date: Mon, 10 Aug 2026 11:40:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Adi Nata <adinata.softwareengineer@gmail.com>
Cc: lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 2/5] iio: humidity: hts221: Add a blank line after
 variable declarations
Message-ID: <anmOlz_4B5zaEwPx@ashevche-desk.local>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
 <20260808090026.34187-3-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260808090026.34187-3-adinata.softwareengineer@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 08, 2026 at 05:00:23PM +0800, Adi Nata wrote:
> Improve code readability per checkpatch warning

You still need to respect the English grammar and punctuation. Here is missing
period.

-- 
With Best Regards,
Andy Shevchenko


