Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9640098A;
	Wed, 12 Aug 2026 09:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528183; cv=none; b=EY9gjag+5FjIEPZduFSa7VhFBcmtF3+k7wmbuCtxnF1hB3DpC8P4PrZ8tZgHwMbrCZ39wqwfFdjLkoNHG7InHNCp1AqkvBdIGDenuNAGDQvRhNSeLHo4THgloBdDUIR8tuce3/T1l99gjkPJQ61jWj6Mik5mJ4j8cIGHR/rNKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528183; c=relaxed/simple;
	bh=0UOWgurJJQTT2QEe5k3p5EdDhK+Xs7tTIgbyRlTBv0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyhGeIzX8v3uHQc9v6ZpPDPX8suHdGkAKsDo3fZRAERUnVjzYQIxXAmjLFr2ie7Bsd5i4RV0xxRmSX5KTLDNA+y3+QN65jXgxhHhtK57BG8abFFDDMyVbRkpN0d0lg4w45IFzpBP/VuHBmAAidQcv35QhEbhhCv3oyYRYz5Wzz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neywHF4i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neywHF4i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786528182; x=1818064182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0UOWgurJJQTT2QEe5k3p5EdDhK+Xs7tTIgbyRlTBv0I=;
  b=neywHF4iJ4Ez/4fKoqeGDBgx7vPajq8Fzd/MdpqLpt7ySFpnMybfngRC
   Yaabrz6nE+spws357DuipikhZxhN/w2vhOk2rH8dhlvHic1Bk3L+RYMRm
   q5ahad5QPeB8z3wXFxqAsfTGGaPCWH3hKsJxfqtEVQyWeGkT87lvoAHNu
   FnDrkqmq2sb0HV5CRtq+y9bB0HOWjvMNha6lgYDnRWGu/naCcU/fHoBhp
   /wX5FPZ55UHCxczCgoKa/A98u9kbCzbSeX7k1qsKAlrPaZL8QRPH+5OFo
   4UbCLUwbmcA0LQUQW1ooZgyFWSm2dK6w020rCr+Bkh6uev1d76hoe1f8F
   Q==;
X-CSE-ConnectionGUID: Cei8nfFlQu6Z6VCkE28vjQ==
X-CSE-MsgGUID: 8KsUMroBQi6h/6elYjowpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97422864"
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="97422864"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:48:54 -0700
X-CSE-ConnectionGUID: ucFPDaGMSoqWV8fGx5gHIw==
X-CSE-MsgGUID: BGaCgkYPQxKXb8hrGHejaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,219,1779174000"; 
   d="scan'208";a="287025672"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.92])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2026 02:48:50 -0700
Date: Wed, 12 Aug 2026 12:48:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anxBgJZH57acnOZr@ashevche-desk.local>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
 <anwwrvNLP2OujnWd@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anwwrvNLP2OujnWd@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 12, 2026 at 10:08:34AM +0100, Nuno Sá wrote:
> On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:

...

> Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
> is because of __set/clear_bit().

Oh my gosh, true! bitmap.h implies all bit ops, so no need then a new header.
Indeed the whole hell is due to dma_cap_zero(). So, while your patch won't
change the current state, in lieu of the said previously I would like to have
a split, but since dma_cap_zero() is used almost everywhere, perhaps make
__dma_cap_zero() an exported function then? This, of course, can be done later
but if we start from the more mess, it will be harder to untangle, so I still
think the separate header is a way to go. And perhaps these capabilities also
can be split to dmaengine-capmask.h (with a fallback inclusion in dmaengine.h)
so in the future we can only include it when it's needed.

Looking into the structure of the include/linux/dma* I even would think of
something like include/linux/dma/engine/*.h with include/linux/dmaengine.h
to collect (for backward compatibility), where the first citizen may be
your API, followed by split capmask.h.

-- 
With Best Regards,
Andy Shevchenko


