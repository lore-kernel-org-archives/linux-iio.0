Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011137B41F;
	Tue, 11 Aug 2026 05:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786426969; cv=none; b=AjMMhb0ZK8D2v/R1la9ehnuawgnl46UbTBoDkYbA7kjbf6H8A+k+Yu5XZsGa8qAaBa4ElKCdrhxw83uk93dJQI1HE2Xyxm9hZirRmjZIQHbrDVYrRYt00yJQjkNTapTfOPdnqEgTP0z/0mFdlVZJlLswtarxqhvkSPqbbuZ9H7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786426969; c=relaxed/simple;
	bh=jBdDr5+zYESwQ6ezlgAcxddFBKF7TxDe8OsvLUhsx70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVuPBgaCzCMKKwkcGkNt/upUCESanWkDjbSOF3tHlESsWRedD0SofRiTeR9amSHQ7GHTxSowRE91f+hxs7hCXZUk53W8tJKo2c4MwjyB/kpE27JVx8FPWPq+UKdaLIET6FdW9PfmKcEfUL6P2kAV15MWgemNEEV+GQrJGVy/GH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P4z3gDD1; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P4z3gDD1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786426968; x=1817962968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jBdDr5+zYESwQ6ezlgAcxddFBKF7TxDe8OsvLUhsx70=;
  b=P4z3gDD1p8k9NuZAe1vDknjsbb5T6dUkEgi3G81I3cEbujiBoZF9LnXt
   hwwW5NkHfSkQV2I51TtbjZ66gUtfPVbRDjNYCv1M7dTc5tST7GtQx6A/5
   rcX7iHc3YgwWMgO+Wi0gNU5N1gAjX7Uhm+47an12Yn4n9J8aMC4AZNcQo
   XDq8c9I2uo5TEUobDZfRJ79obh/G8gEvtzsSb4La7bjkojg4mR6M8zvo8
   YFo1jbFIi1kNFcM75lvBpNy4k8VZLGQPfY0j8P3k7YjUiZPN/UY7OEqM1
   PtVIVO/JTu3t3srEwUeh6gcsZc5o1M8L+tuL6xTeIYVYQNxRhy6UF4QJ7
   g==;
X-CSE-ConnectionGUID: Pn1OUvR9REqVnKYp+K3nSA==
X-CSE-MsgGUID: EypBtwYFTceyzCaA1soXaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86071740"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="86071740"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 22:42:47 -0700
X-CSE-ConnectionGUID: I2CqqCRPRi+MAH0BoEgeSw==
X-CSE-MsgGUID: zlXKvOq2QtKZ+fK9e2EAvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="266731101"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 22:42:45 -0700
Date: Tue, 11 Aug 2026 08:42:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/4] iio: light: veml6031x00: add support for events
 and trigger
Message-ID: <anq2Uo8We1Lgao89@ashevche-desk.local>
References: <20260807-veml6031x00-v5-0-e60876fb3640@gmail.com>
 <20260807-veml6031x00-v5-4-e60876fb3640@gmail.com>
 <annvIc7WLeWEDCAC@ashevche-desk.local>
 <DKLN56PMUK93.20VF8V664A37X@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKLN56PMUK93.20VF8V664A37X@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 01:09:29AM +0200, Javier Carrasco wrote:
> On Mon Aug 10, 2026 at 5:32 PM CEST, Andy Shevchenko wrote:
> > On Fri, Aug 07, 2026 at 03:51:55PM +0200, Javier Carrasco wrote:

...

> >> +static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
> >> +	__must_hold(&data->irq_lock)
> >
> > The sparse annotations is fine, but lockdep one is even better.
> 
> I have seen a few instances in a number of subsystems where both are used
> at the same time. What is the preferred alternative here?

Both. lockdep is a runtime check, sparse one is a build-time.

-- 
With Best Regards,
Andy Shevchenko


