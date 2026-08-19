Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E33672AE
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172880; cv=none; b=WMr7TviCBdDdAserufyTCpIkmqiF4J2URP2ygPjLiOhdW1srvJ8vw9ZCtve6QpBuaBadnlVoHbqgbfQGp0XIQCZc0w1OYU8IOq6j3CUnDHpcuHnb49Z6zkIQyLm+2AKT3iFA3JNeOkPBnEQwSkwiNQ2C+ar/QrC3UG+EzxJMYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172880; c=relaxed/simple;
	bh=VMt3E467MJcn9Jj3C/rRMxu/icVnXceWcDD60wF+YkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmPFzQM/bj9U7V1FQBMvrFGQcd0ImuJD0y/Oi1T2Jsss6nA7Mzjrar6+TgMEotl49CxiQ6fobMycDfhpPu3GBQG0Hp63hbTOq6CwYJsl+4PTUpWhU365DCefX75v0b4g3AEgeZHvav4PEFQgtjIZtAwvjOgFT3g5W0bndDbqp0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DsoX6spZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DsoX6spZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787172878; x=1818708878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=VMt3E467MJcn9Jj3C/rRMxu/icVnXceWcDD60wF+YkE=;
  b=DsoX6spZMpWQaQ0wdYJVAIuAaVtYyaFAWeISVMEZFOiXXjcubSaiGlWB
   ictg1SJPfaE7tNoOHW8nRUPhm+Sooyttxt+KTJ6Dced71z6rSytTMia02
   l6bB2Ldwbj27gLivSadyraN4lYFbPuRkL58q4hjQW3b+UG+X+jPzeNLht
   T9bAzmg5fC/ts8ggx0PNyxAjIWnweYBFHvZzQ76Swbej1Du3r1+eGte4i
   2ACkzxWdOsSNqAElI+m2WRRE6fgZ49WDVvDKXcdxRAbyoP50U0Z0s35x6
   Fk5lmHtTFqt3bKidX4uyqOmiBbuTqmsoxJJIdpM5S0M96s1to3EoD93Pf
   A==;
X-CSE-ConnectionGUID: ZAuRhTGbTHGX+/HDdSENdQ==
X-CSE-MsgGUID: DUveF/98ScegI7y/Jl2ARQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86654244"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="86654244"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 13:54:37 -0700
X-CSE-ConnectionGUID: QJYaPQrdQU2sErENVRTtGQ==
X-CSE-MsgGUID: cLsKAyBfQvOSliNDStLw9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="295581449"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 13:54:34 -0700
Date: Wed, 19 Aug 2026 23:54:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <aoYYB5ANWI6GILER@ashevche-desk.local>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
 <20260819014104.56bd4157@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819014104.56bd4157@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 01:41:04AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Aug 2026 17:45:29 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:

...

> >  		sgl = block->sg_table->sgl;
> > -		nents = sg_nents_for_len(sgl, block->bytes_used);
> > -		if (nents < 0)
> > -			return nents;
> > +		nents = sg_nents_for_dma(sgl, block->sg_table->nents, max_size);
> 
> So this fun function will generally give us the number of sgl entries, but not
> quite always. It will give us how many chunks of up to max_size fit into
> a particularly large entry.

It gives the number of SG entries needed for the case if each of them will
satisfy the limit. Whatever following code does, it may allocate a new SG
list based on the number returned by this function and resplit.

> > -		for (i = 0; i < nents; i++) {
> > +		for (i = 0; i < nents && len_total; i++) {
> So this needs to be more clever as we aren't just iterating entrees and filling
> them in, some of them could at least in theory be too big to fit
> in a single vec - hence you need to do a loop in here that sets
> multiple entries if that occurs.
> 
> If that can't happen for some other reason then I think you can 
> just use block->sgtable->nents instead of the more complex call above.

Perhaps sg_split() is what people are looking for in this case?

-- 
With Best Regards,
Andy Shevchenko


