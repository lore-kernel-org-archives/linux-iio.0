Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C5836604A;
	Fri, 30 Jan 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769750510; cv=none; b=WV264jCdHHoPorbhv5qn1kZxOAg+Fvd1Nuns/VGnS3IQaZ/2JPbnRORgEoXu+zlAnWtiFETYwLQa58lLk8Ecwsx8jA8X56BJeTrM9XenTflV7WT1unJbL74pyRCHBBbS/AUPMgvHp0ykPRo/njv54XgF8RDrNyOGhPtiz1oz7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769750510; c=relaxed/simple;
	bh=bdoLgWpZ7UahpqyDKtnDcEakSyHAdNTS0xrJFoSElbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDdHs5zbwgfTruaDD2645FX9i1YilIPBfGYKIp++2vH5SBd0Jh9yqC6eBqEQi9JDvtZDicfugyL4TJ3vBaE5Dmva61O1h7IN/GqvEGYoOOOarxg/FnAEltM80SL6LYTyNU1VUkBq7aJ2Ksrvn04ywKFvP3OzuZk9oshUTOHwsEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXm6lLnN; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXm6lLnN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769750508; x=1801286508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bdoLgWpZ7UahpqyDKtnDcEakSyHAdNTS0xrJFoSElbE=;
  b=mXm6lLnNJq78tp/kPU++8C+eVBq5Wat44TeWPrSi63S/lPwWGS58CRes
   51wwJ+Y7nbFUrpQX74AouGYtOcYbGNhV8cTXBAYHTLEcx8s2ziWI3Rq/Y
   Mrg7+wtYYgSicYmmAS5RYhxFKNqxb82aLqfKCNExn5Q2h8v2YfugJ3ywU
   ItXLwGE+9xnKPPDmROrHitS6yOCwKfeN1+dkG2p1PSWPEQqT+nhqmTVrV
   1evqls/XRg5uYgT7DDRUvCHPfjBUPwE9xqObBoDpDn9nH5CmK3MYLYxmE
   lc9GPV3a9z5SaaeztVm8ImEKFXjKamuSHOI+15YSVCKd/0aMQciO4EdXP
   g==;
X-CSE-ConnectionGUID: 79bYNeSGSR+ybsPBfI8sKA==
X-CSE-MsgGUID: TXaYEthlRIannRSBaA3tSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="82109437"
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="82109437"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:21:48 -0800
X-CSE-ConnectionGUID: r9iCrVLTQOi9E7K8I7wS1w==
X-CSE-MsgGUID: aPaI/LeTR7202olmvtq1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,262,1763452800"; 
   d="scan'208";a="231687574"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.227])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2026 21:21:45 -0800
Date: Fri, 30 Jan 2026 07:21:42 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Fabio Estevam <festevam@denx.de>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Chen-Yu Tsai <wens@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4080: remove unused dec_rate field
Message-ID: <aXw_5nryp4dKHVfm@smile.fi.intel.com>
References: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129172340.34216-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 29, 2026 at 07:21:58PM +0200, Antoniu Miclaus wrote:
> Remove unused dec_rate field from ad4080_state struct.
> The driver reads/writes decimation rate directly from
> hardware registers via ad4080_get_dec_rate() and
> ad4080_set_dec_rate() functions.

It seems you missed my reply to one of your previous series.
Do *not* thread emails which are independent!

Really, you should have something internally at the AD to explain the process
and the simple things like this.

-- 
With Best Regards,
Andy Shevchenko


