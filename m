Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC80444CAF1;
	Fri, 27 Feb 2026 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772209415; cv=none; b=QpoqV5nauKKLj9zVOPAooFU+WfyrimWXXTOHZucgLrtD/TVAYbDTy1IQCC8ZeOefln/JxhA435OG88baWWKDKoXFUlQ4VdF2jB5VuZA9oNX/2SpM4+XJ/KNP0L5YeU8sAwTbf0uFqm7weFSGTCIoivBGaJz2n6yXZjg1ghnBI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772209415; c=relaxed/simple;
	bh=1gljr/ovEB37ZFz0gYQZokjJELn12CMureHNmT7xAzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/VEmTG59fnl248VVBvgoKYiWr5JNFsHgJCALDZ9QZq1ThFQtF7/kjsBEFWH4dxgS81JfNqfjtlBwRU9iUbNfyTvpKfCfm9TkTGgQx3HchUgsq/n/QTvJo2G0mlBY6SOEdmtYEUuVT7MWKo+/G66Z7YHbWDC2Nzux1hZVUDInNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JsG0cz9M; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JsG0cz9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772209411; x=1803745411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1gljr/ovEB37ZFz0gYQZokjJELn12CMureHNmT7xAzM=;
  b=JsG0cz9M3YH77/Y9k8O6CzlqJWk4nqWY55bdehHfI8ZkTYyS9KvGAyC2
   h6ic/wUESMsxCpVh1b9ye8B6WxLj8iprVybXBGskxKeCTFTqtlhPFJp0S
   kMezHNVGYNHVmS/Ppe/9KMhUOv70TswqOunDZLjPtqG7TOnp3C7FYrDIb
   OvcsTvI19FQzE5pb5zLYHW5NnGMD6TrrjZ8nxA056VNP0V/3q4PhplY7r
   /ayQWga4IdHcQvlqdNgX1c9zpmjCiWSVqW6oEHa9EDXBNAQAKEc41g6uu
   HYbZDO+w1rlnMgzsuACrR5GtxR66n/J7WsaRZHXXqupFGhPg3rn2IUfle
   Q==;
X-CSE-ConnectionGUID: EovyoRAOQjOc2/+qp0QMDg==
X-CSE-MsgGUID: GN4TIKlAQzCh9xF9EQc24Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="73200740"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="73200740"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:23:31 -0800
X-CSE-ConnectionGUID: OxVPDDGfS/yXa7mqECtF5A==
X-CSE-MsgGUID: gEpE8yoiSau4ECxnjQLRgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="247450456"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 08:23:29 -0800
Date: Fri, 27 Feb 2026 18:23:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: admv1013: fix NULL pointer dereference
 on str
Message-ID: <aaHE_jMwDsspaYRO@ashevche-desk.local>
References: <20260227131631.62303-1-antoniu.miclaus@analog.com>
 <778d2f20a786985ee3bc465e33d7706c1e051748.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <778d2f20a786985ee3bc465e33d7706c1e051748.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 04:14:10PM +0000, Nuno Sá wrote:
> On Fri, 2026-02-27 at 15:16 +0200, Antoniu Miclaus wrote:
> > When device_property_read_string() fails, str is left uninitialized
> > but the code falls through to strcmp(str, ...), dereferencing a garbage
> > pointer. Replace manual read/strcmp with device_property_match_string()
> > which handles the missing property case internally.

> > ---
> 
> Semantically it is a bit odd to use device_property_match_string() given it's for arrays.

Exactly.

> But it allows for some code simplification so why not?! And we can always see it as
> an array of 1 element :)

Shouldn't it be device_property_match_property_string()?

-- 
With Best Regards,
Andy Shevchenko


