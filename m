Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D743933A;
	Mon, 10 Aug 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387697; cv=none; b=G3KVtaCLWkIl/hGVVba/xyr9q48nJW2uz4CW3aY20z8KXf5YqrPuWVtMQzTJoWEk0w6Y627WPwPgciC5NoyF3gsC+E2nkFxLg8jFVd/dL7JJ0hIOqXtbeyP2pi1BYq9zsoD1psLvwe/daSndFCkXrFlmGcLZz7fn/zjTVRVrx/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387697; c=relaxed/simple;
	bh=X9qy98+ubxciT7b34PF0D61w7e0KocUkktx1KBlx8hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qd+Ftmvf8b8ZTk66Eo9epr1EL712K/pgYryzKPPF4dtZsigA0G8w7FqrkT8L7vkyPOPVInOmeERSKrNduWUPT7ZhiwWP4a8QQPb6tJ7LnuPvLXYFxqSsbPig4+zsxQFKZvanyYcBKdlhrkbjDSJmbA/zjKHdwBrNcds/BSFpLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMsrz9b1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMsrz9b1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786387696; x=1817923696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9qy98+ubxciT7b34PF0D61w7e0KocUkktx1KBlx8hI=;
  b=fMsrz9b1ECGFfYZbEIw4etdAPQpXXJO+FVb0ptL/6eX+voLK+PVu1hWY
   e+NCW37f4ZgsmijkvJYfH15SgRxCZKXBZ5rjoM2BMt1aZwEi6pV1/4ik4
   h4VnI8PLpLsISITxzl4KfbPNd0c/SMur9wEroo1l0MgwEMVQVC5Zw4iSV
   gip4Q9rYncrejJTeIixj41g6d3qKfuJgLPrqlqSIk3ULzy+EwmDl6LPfV
   cqiXnb0Kp1LTT3tGdH7/zCxTeob7Pgj65gX288WAka17ThLo26BTrbNLG
   g5DO67WUrHOQAkiTaFX//B9ETLFq9poV/vfPc2KDnECvVvKHw8rpsmP45
   Q==;
X-CSE-ConnectionGUID: hn7r3xuaQU2DX144FZv8LA==
X-CSE-MsgGUID: A9EhDKvjRKys+DWt48WMwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90726120"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90726120"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:48:15 -0700
X-CSE-ConnectionGUID: PZ04vSuOS5uXjOk3GtCv/w==
X-CSE-MsgGUID: F4qTmzg/T0SlqzXeEHJ3ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="262612772"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:48:11 -0700
Date: Mon, 10 Aug 2026 21:48:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 2/9] iio: adc: add the ti-ads1262 driver
Message-ID: <anoc6axjV0uSXDzB@ashevche-desk.local>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-2-f89925d72792@gmail.com>
 <ad95afb4-e667-4290-8878-fdd7067f20fe@baylibre.com>
 <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKK9QWYHOBOT.2VD8XMZTE65H4@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 09, 2026 at 03:26:57AM -0500, Kurt Borja wrote:
> On Sat Aug 8, 2026 at 1:39 PM -05, David Lechner wrote:
> > On 8/7/26 10:58 PM, Kurt Borja wrote:

[...]

> >> +		ret = fwnode_property_read_u32(node, "reg", &reg);
> >> +		if (ret)
> >> +			return dev_err_probe(dev, ret, "%s: failed to read channel reg\n",
> >> +					     fwnode_get_name(node));

Use %pfwP instead of %s (same for all other cases).

-- 
With Best Regards,
Andy Shevchenko


