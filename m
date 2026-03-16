Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB0335571;
	Mon, 16 Mar 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773678179; cv=none; b=RPWAt4A3JZGrYsHEx8eJ+6v6cW7Mh3E+WvwgiCz18ThWGVSYrYJZnwK/7SuAtcXRjs34y7W9k4hj8Qjh8W/azORkAn6Jl1zkqssO/HTr2Utpzmn2cLnAMWg7tGdStETtWeHT+GRJoZpph7glOdBexyVUOjLybbad/lwDTqWtEZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773678179; c=relaxed/simple;
	bh=vg983riz69yjebjwXKNFPOFG9h0AUuR18C8R5PpH0Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhi4Svg1e7yzn4j1lu9M4PnBLgPBnogMORFPmTmwYuN7+Qiucx7/1jF8szHue9mFxUnFAWIw4oYUiFri726I8iDMpKj1+Z1AVWgndYrmAIVOsTCbNmHIm7FqA7UopnJ/oJM/d3vK6TBQlQFxRvWhgz++BRF/EeQtlCe7+y8Euck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM8cOPZO; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM8cOPZO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773678178; x=1805214178;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vg983riz69yjebjwXKNFPOFG9h0AUuR18C8R5PpH0Y0=;
  b=gM8cOPZOWSpU+GavKbnHggWzrBd/ynnerW7qy+fZVghGMWZ9ThCTk33T
   IV5yWrJHFVHg7u76eEXkLZXnacgKAwfDdXqxvZ3/ltEIPmNe7QkjTuMnG
   gdrjwTPFqMi5rym1PA8WiOo4OfauvDqa9DGAZ/pl5qwMtuJj7/CE2Uc+L
   tYw4j53G/MSZhY+Imrr/wLZBp+RIDE5bAzpxT5w+fh96NNBKBBox1pHXK
   3LLSxTauqMWz+n2X6NLVK+Tg1HFo59TfdwQeQSIuFzxVJeDlbOTU/OTun
   F5f2ZkU97OGpe/kLb5cU0sWorlzJaiQN5bJ6LkZMOGU13j+hxAGZzRsxL
   A==;
X-CSE-ConnectionGUID: BaxzR2GySVO67e6SmQ32gA==
X-CSE-MsgGUID: ntGfyw2FTsaYtBE2zAqZrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="73882381"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="73882381"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:22:57 -0700
X-CSE-ConnectionGUID: zXIpnoz/S/+xa1lwW4DRTg==
X-CSE-MsgGUID: rVbXuQoNRw6xgWLccOdnRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226644588"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 09:22:55 -0700
Date: Mon, 16 Mar 2026 18:22:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shi Hao <i.shihao.999@gmail.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	mazziesaccount@gmail.com, nuno.sa@analog.com
Subject: Re: [PATCH v5 08/14] iio: resolver: fix typo from degredation to
 degradation
Message-ID: <abguXZJjIXMdqcU5@ashevche-desk.local>
References: <20260316090023.14691-1-i.shihao.999@gmail.com>
 <20260316090023.14691-9-i.shihao.999@gmail.com>
 <abgt1yoYTnQEiAlk@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abgt1yoYTnQEiAlk@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 06:20:44PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 02:30:16PM +0530, Shi Hao wrote:
> > Fix incorrect spelling from degredation to degradation.

...

> > 		/* Sine/cosine DOS overrange fault.*/
> 
> Side note: missing space after period. If this is a single issu in the entire
> folder, fix it here.

No need to resend just for this. Let Jonathan decide what to do with it.

...

> > -		/* Degredation of signal overrange threshold. */
> > +		/* Degradation of signal overrange threshold. */
> 
> 
> (Left for the sake of context.)

-- 
With Best Regards,
Andy Shevchenko


