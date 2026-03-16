Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C41531E8;
	Mon, 16 Mar 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773670079; cv=none; b=JuJAWjcn9roPMJ1Q+9Xj03hFWGX7EDb7iXHf1VtV47g4tqvIgObgeTzemzrosRM33x7fx4RDjTQeyA/Pl2UZ2g4d8koonumVMhMwAFzgcUHjlGp/FyhMK84tspy0LvTiTnFtIQzCprPznPufHWkeGcdjtoeozEmbsXg1oB7xQnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773670079; c=relaxed/simple;
	bh=ya7+eQtwk1+JvViJKJt0v2ewcZJpN6lrLcfC6QEBqxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQDC8p/5jSSbx5ASrDs6uFfDQQbuk6YQnHiseUZh3yC4WDpHxpoJolKk2bdoaSL3XIuKIQUMxPgFo9d5J0TXx8k/cQ68ujcRfJ3dYkmY3I/zXse+kkIBM2f6nrXNvqg+9UHRp6v9wOIDPdNWbNWWgmzqR+/qpBfrRKSlSK9e7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iQNkpjtj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iQNkpjtj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773670079; x=1805206079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ya7+eQtwk1+JvViJKJt0v2ewcZJpN6lrLcfC6QEBqxw=;
  b=iQNkpjtjFcKdcAaP5AB8DnyOoiQxDy1IXKIuwsKADjDdKUcJOVPy7W/n
   8le8eBY8IWYkChKZqr1l8zNDl65BYYpeGw2YMKJ+K8eAhtQSwftnI67ak
   Eyolcn0rncRz1wZ3XmHqzdyfSy+/LP680NCwErwtdz49jbTzkUW6hnAaj
   IKMNpi5XcnS+edEf5v22lYs6OWx3VAFrYzf9pJPlKdceSaHIBKnDXMdQF
   g6VdNAp72eLVb4uvRjk2wdkwwIUD7pqm76AKkvjDekm8B//xkucVVpTwA
   RpVFfuey0WJej31Xgl9KsGJzGTgmWvsOkKZecshTCkd4+TtoqNg6G1EwG
   A==;
X-CSE-ConnectionGUID: 9KZBd7koT7WheLbl3jDC1g==
X-CSE-MsgGUID: gyJpFY+0QoWrvlB/QdQ2eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="86162126"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="86162126"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:07:58 -0700
X-CSE-ConnectionGUID: Lnaxk02TQFmt/SZksuMKzw==
X-CSE-MsgGUID: 8A9f2x5FQgGt3uQkHnez0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="226052223"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 07:07:56 -0700
Date: Mon, 16 Mar 2026 16:07:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: frequency: adf4350: replace loop with fls_long()
Message-ID: <abgOuRDBt73Wv2N6@ashevche-desk.local>
References: <20260311020115.56321-1-neelb2403@gmail.com>
 <20260314172006.69744-1-neelb2403@gmail.com>
 <20260316135151.309207ae@pumpkin>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316135151.309207ae@pumpkin>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 16, 2026 at 01:51:51PM +0000, David Laight wrote:
> On Sat, 14 Mar 2026 13:20:06 -0400
> Neel Bullywon <neelb2403@gmail.com> wrote:
> 
> > Address the TODO in adf4350_set_freq() by replacing the iterative
> > power-of-2 shift loop with a constant-time bitwise calculation.
> > 
> > By comparing the highest set bits of the target constant and freq
> > using fls_long(), we can calculate the required RF divider selection
> > in a single step without relying on expensive 64-bit division.
> 
> Where is the 64bit division?
> (apart from in v1)
> Indeed where are the 64bit values at all.
> If this code is used on 32bit it has to work with a 32bit long.
> Which makes be think that the 'freq' variable should be u32 (or possibly u64
> if frequencies above 4GHz are likely - which I doubt).

I don't know about _this_ device, but before looking into datasheet I wouldn't
put a low probability on the frequencies higher than 4.3GHz. We have (or going
to have) devices that work with up to 26GHz frequencies in this folder.

> In any case this looks like initialisation code and the existing loop
> has the advantage of being 'obviously correct' and small.

-- 
With Best Regards,
Andy Shevchenko


