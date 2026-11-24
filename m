Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510211;
	b=wQUH5Bh9dXZMGSdcbTqoXGVV5kE2UvDLmt6pTcBILx6o+nCNqk4goRdJ0UyFRrGSSHQt
	 8JfAYJwOUth/ve0IsIZr0CWrkBHbq4dk0jCNboGNCi18Knt/qHamv3uhhwwqS5sC0gAwA
	 bs6o+KOyplduTOTOuK/Mfy1m58fVm2JMcB8TjN9hlKSnfhJQfCLgVGhNIonrQExg7f+wh
	 0gwqq0koaVYyvahQGRBh0Bl0dCCprjWNLvqMYTRJnb/Krr4awhAIbtbu63lSlBEAIywxU
	 /IjQeTqw9ExoSyId4wuValpyUL+mPQ7OQwXa1q6GaiTli6l5l6Oj5bUl5Xb6Epn1q2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510211;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=cAZWv1J5h9sR/nU1CV9haoog/YOQkcMiNcrM/W6MpiY=;
	b=2RsoLOli8mR1OQY0vl7WeSW20rf/08ZZG27sCocyIiZKwLEL00R8T9QgD+SuP2KVKQ6j
	 b3XcQfGFu/lenS95CSTcRV2iq4Fa8ATwiPkwnewzHEW6aiLQj+xPjV3KQaR8gxbD9pzQy
	 Yq2oIGYzy/85sple22YsNhPA59BM7Kc/wyP5JH9PiMUOnhhCzSJK4MWV1sJ6EMn8k2N1j
	 Nmk81oWLt67ZzCAOSxw6UXKHmsOj/brZSE3576J5a5ya5nsWAji57gWDZ17UVgNoKv5U0
	 5obh1RAaOL967c19AF3CGYSneNEdi/j6sa844Fo3/RvmJIoh+Ly4KQ5077+y5YJLVSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJkx2040;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7A606A31E;
	Tue, 24 Nov 2026 08:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCF7A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZJkx2040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795510210; x=1827046210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4MZyUGIPMO09FWen2gHchcNcLkG633lgWXSjW+jl+zo=;
  b=ZJkx2040RV4wqycnpSMMLF21vmALvh4qb1kjq9//A1NRF7qZY1CMvpq9
   cjpHcI+1Hc/wN9om+emDj+STj+YXT2fLK6ukqlHytpPS3m891A5MCgJ+E
   OzYDNWgl6eyWtXfCCscpxhkvyDGYhO5k4jEaoh3uMHYT0oFmY4Z/5uPS7
   nS8lvbybN/ftMLAJWrNZr+kDaLsk/HUhZXxDHt4xKsOKTJwpoNHm5zemA
   KA4LMe88QCPlfZO3cPmztPdB38Kn7+TjwcWBbWoR2M+hQWvMkcLlhDSz2
   N3/PWpS8F/6lh/cMuHmYQmTOCYk79ozc00XbYRlejPdQrEulSCTVgGkzV
   Q==;
X-CSE-ConnectionGUID: d6uyKHCtRBqQvS8JrbGM8A==
X-CSE-MsgGUID: VomM6u7fQ26cV02NYd/3+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4316145"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4316145"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:50:09 -0800
X-CSE-ConnectionGUID: OYVfEHlqRo2Jn7FmMYJOqg==
X-CSE-MsgGUID: lmNVR7H8RIm536uiKTvy/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11420696"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:50:06 -0800
Date: Tue, 24 Nov 2026 10:50:03 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: debugfs register access through regmap in the
 core
Message-ID: <awVPu-reXnQHbr9y@ashevche-desk.local>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 24, 2026 at 08:50:10AM +0200, Rupesh Majhi wrote:
> More than 25 IIO drivers have a debugfs_reg_access callback that is
> only a regmap_read() or regmap_write() on the regmap of the parent
> device. Patch 1 adds a core helper for that, patches 2 to 5 use it in
> four drivers and patch 6 adds register access to dps310 with it. The
> other drivers can follow in batches if the helper is wanted.
> 
> The helper finds the regmap with dev_get_regmap() on the parent, so it
> only fits drivers with one regmap there. Existing callbacks that take a
> lock or claim direct mode around the access are left alone.

Nice! But I think we want a bit more to do to prepare for this change.
I was triggered by regmap.h include in IIO core.

I can see the first patch in the series to split debugfs bits into
industrialio-debugfs.c first, and then your first patch builds on
top of that.

-- 
With Best Regards,
Andy Shevchenko


