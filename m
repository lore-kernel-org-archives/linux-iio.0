Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CB329C6B;
	Wed, 15 Apr 2026 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244979; cv=none; b=T5KuaIjsKNR26mmenmXP2h2sJV2gZQtQi1EspPUoPhcmezlk6RYhQC2W51a0yP6EyIonuYsFVfTFeas7WP4trMQH81glh91juXqQaAhqlHhfvKLj97FNNvtKlmEWrGpzL95lTrE8x9Oe2QCxMQ18EoFm+3Ntbm/Im7C8y/LMcg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244979; c=relaxed/simple;
	bh=FwMuDLVtDkdQq8o6iSQyEVk+FJBZjNYRfWX2S41AlpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZHYR4cdTQyUGJkCz4sq5w60WkWIJrCM7VlglxsbvfXB3qM2QNWeSbFGLL3oEkqFGUPOYlGge4E+hN2w/ySsZfZb0tOOj3Z556nc0BDVDA/YJ5BL1vUt2o+CbacebfUeChXTJUj12vdDZa9e+Wsw6U4Ecza+iApu7Y541Ih5Mtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cOqDK/LR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cOqDK/LR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776244977; x=1807780977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FwMuDLVtDkdQq8o6iSQyEVk+FJBZjNYRfWX2S41AlpQ=;
  b=cOqDK/LREYhUYO+cpJHZ/Ls0qkZaqyJx0ZwvBaqNJ8Ot1MjsVIhOmZol
   Hwbn6F2cSBI0fdcwF0L10sZUONTAKeFLF2nk04E5BeeMQE6X2SDZmehOp
   8h/zNEbAuxs+2pAxPMD3QAtZ+QmwXRjnKgaifj11YcX2TPEDvJFctFEz0
   4TMNJnUMAshkWa6xAXP24Cj4DJO15YgX/EZjKWCcK9LlmVehKfe28DUsa
   xcSE368ftF/fDt1gWC+G5HXTOFqTFtq2Vst2xPPjqhesFTOr1Bn4u3QBB
   DFaHdSiS8RcyIyHGcytxkeG0JYNNmkiFceaIKnLtsSVBHhXF+8r8gYrp1
   w==;
X-CSE-ConnectionGUID: IflMMsveRPG3f7ZYxJP2Og==
X-CSE-MsgGUID: Men0ErWfRUyEBVYt3Hv7iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="99857821"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="99857821"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:22:57 -0700
X-CSE-ConnectionGUID: tTMAPzULTvWhLnooAPH6Vg==
X-CSE-MsgGUID: G3zNy5EoQ8ObZN82RKw2hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="253781601"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:22:54 -0700
Date: Wed, 15 Apr 2026 12:22:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/7] iio: ssp_sensors: factor out pending list
 add/remove helper(s)
Message-ID: <ad9Y6-WHWs09hkbe@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-4-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-4-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:45AM +0530, Sanjay Chitroda wrote:

> The SSP SPI transfer path manipulates the pending message list in
> multiple places, each time open-coding the same locking and list
> operations.
> 
> Re-factor the pending list add and delete logic into small helper
> functions and drop use_no_irq variable to avoid duplication and
> simplify transfer flow to follow.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
after addressing below nit-picks.

...

> +static inline void ssp_pending_add(struct ssp_data *data,
> +				   struct ssp_msg *msg)

It's perfectly a single line (we have limit 80, so up to and including 80 is
allowed).

static inline void ssp_pending_add(struct ssp_data *data, struct ssp_msg *msg)

(it's only 78 here).

...

> +static inline void ssp_pending_del(struct ssp_data *data,
> +				   struct ssp_msg *msg)

Ditto.

-- 
With Best Regards,
Andy Shevchenko


