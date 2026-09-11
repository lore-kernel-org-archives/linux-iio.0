Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB08A25F7B9;
	Fri, 11 Sep 2026 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118196; cv=none; b=j8WSA/N51rFkmBX88wynOICzMcZEWYkgBxj6h37oDazo0yJgn5kmHpYllZvAmM4C9z2mvWBfVtuq4ho4w2Ks7InKwsWzKEhYDUi09D3y7vE6CKZvc6s1RYJsIywZu5YWGMR5NH8OVrvtyNZ3K9UZCsB3NzFvjEKcFk849az+Gq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118196; c=relaxed/simple;
	bh=c2Dh5Ps4HCEYmdO/y3/boPf580Nz9FzsHrF7psZoJbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG46MqWaCvpkT64LcQPHD6fimT7QEuxd0bT2hzqpkPvD990vvwfQWtL3gTbZoNH/CFZD7fE2TJ27C8EAQ0671CHBEZtePgnnz9Lyl4I5FkpzLZqzzRFqu2VAjbZuUsRS0P89aW6MaVVveeIvYymCu7KhP07X7u3M1nqLNHNNdTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUuQ46Al; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUuQ46Al"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789118195; x=1820654195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2Dh5Ps4HCEYmdO/y3/boPf580Nz9FzsHrF7psZoJbc=;
  b=mUuQ46AlWp2ur2D8GgiaHnTnr0q7pkyvj2j/svyX9YRMbgjD76ZFLc9P
   1fYNrYhSZRSpTvp2Z6JbZkFRVfwZic5G/Fv+vmwqvHRI9+AnnHxcysJCN
   Mh5l4k/Bylbbnhh4TgibziCN6lVW0K8BTsfhf1d8ShJ974yhSgjQqFlAp
   VH/r/nxbsaIE8zCamm1Xx6Uxz7E9r2sEsVEvSgLGFrdMsiwR7yNz5kza6
   osS2jeQg5d13m0EinAkvJyS8E1olTKrbj5WMB9SmDPngVKo60kMaVHwRJ
   e2ASmz41kx+u1gfyRpKt5X4Shy3I8AoA9rebisD8UX6wIr/969l3p7qxI
   w==;
X-CSE-ConnectionGUID: CbiKaOKtRiK/UrwRciQc+A==
X-CSE-MsgGUID: Ghl7FEiSR1GyyfJIdUZEiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="93445980"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="93445980"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:16:34 -0700
X-CSE-ConnectionGUID: S1kgFO5bSu65DLAIPlKtOw==
X-CSE-MsgGUID: y8Xs3XfrRoGpoUIv4voI3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="295348713"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 02:16:31 -0700
Date: Fri, 11 Sep 2026 12:16:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: "David Lechner (TI)" <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] iio: adc: ti-ads112c14: support external clock
Message-ID: <aqPG7GvpCFhmC7Un@ashevche-desk.local>
References: <20260910-iio-adc-ti-ads112c14-filter-support-v3-0-e5a9b27ddb1a@baylibre.com>
 <20260910-iio-adc-ti-ads112c14-filter-support-v3-6-e5a9b27ddb1a@baylibre.com>
 <20260911103827.00003bde@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911103827.00003bde@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 10:38:27AM +0200, Joshua Crofts wrote:
> On Thu, 10 Sep 2026 16:13:05 -0500
> "David Lechner (TI)" <dlechner@baylibre.com> wrote:

...

> > +#define ADS112C14_INTERNAL_CLK_Hz 4096000
> 
> 4096 * KILO?
> 
> Otherwise LGTM.
> 
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

HZ_PER_KHZ rather than KILO.

-- 
With Best Regards,
Andy Shevchenko


