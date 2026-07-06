Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA27348866;
	Mon,  6 Jul 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783367924; cv=none; b=mWc6dqCQ958pefuvv5KrYSXJ8HBRqYzeKAki/ij1ap2NJPR2f8OTTpa0yDS1UuwpDjLzA1Mky159c9C97yWsarvfvWCt2mlKeASubeG5zbLKrD0+LB1NDZeLEcJTC/jwADHqc8GmhhHElFsDCxp4vw8K0En9on+QxsmhiPDwWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783367924; c=relaxed/simple;
	bh=0tpzqMoX9d+zzi/OmTw0TXb34LcQGCJ7K5MlAPpJ5Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NAy4USzZVY4QudhsZ0bmJfEY7j4R9g/UKu7HonlKKw5URf/0qSl2GytCvxKj1ZCYbGrVrsmWm53ixrpf1M5jYM+iSVkJoh+1kqZm9is76FIyC+div7n51+EgR15v33vO1XcXt7VNlB3tk2SyqQMmcOJ9ShUfYEMxhZCyIEEXrRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mceQ5Wjn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mceQ5Wjn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783367923; x=1814903923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0tpzqMoX9d+zzi/OmTw0TXb34LcQGCJ7K5MlAPpJ5Z4=;
  b=mceQ5Wjnuc1GH1gMQWS5lidgXNgNTajkZ0ZU5GTOE7QK2oqVOprS/DsL
   M/x/5REHLQhwxZrkxDbtiYrrB+e+Bul2esVBoPgp97g5qH8pGBKS/8R4X
   8bs4EToZKdH1xV7Vdc6a69Ib9vAPGB+ilYEW/s8rovFGx/FtrDiutuwsj
   cvw48b08gSYXzFsWsjHoO0tP/a+sOep98C8t87YuhkmKI02OcZ6kbve+D
   w2p22VSVPbkBhi/svj6eA4cAKaXARHg/Klh7wM5F5OqqvxSsR5KJ95n9g
   de6GBvLWCU8KgVxa6mjjpHqd1HbFId/B998VKjErg7mdI/9LI92ZjFD0I
   A==;
X-CSE-ConnectionGUID: DGrfSX6xS/ikPLjNd2QxLQ==
X-CSE-MsgGUID: j8g2Rh1bSsSxQrcbP3nXtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="87689398"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="87689398"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:58:42 -0700
X-CSE-ConnectionGUID: L/e9sIpbSP2TKwY3Syh87Q==
X-CSE-MsgGUID: 8GaJbOXuThOGlKLQTLgzRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="251124659"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.48])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 12:58:39 -0700
Date: Mon, 6 Jul 2026 22:58:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Paul Geurts <paul.geurts@prodrive-technologies.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, tobias.sperling@softing.com
Subject: Re: [PATCH v4] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
Message-ID: <akwI7bzJUZasGbq-@ashevche-desk.local>
References: <20260706074803.13624-1-paul.geurts@prodrive-technologies.com>
 <867d2cb8-a1f3-49e9-a8a2-04e232f404ab@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867d2cb8-a1f3-49e9-a8a2-04e232f404ab@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 06, 2026 at 11:30:59AM -0500, David Lechner wrote:
> On 7/6/26 2:48 AM, Paul Geurts wrote:

...

> IIO style is to have /* on separate line for multi-line comments.
> 
> > +	/* Reading the statistics registers reinitializes them. This is unfortunate
> > +	 * but necessary to prevent data races
> > +	 */

Also multiline comments should follow English grammar and punctuation, in
particular the sentences should have a period at the end.

-- 
With Best Regards,
Andy Shevchenko


