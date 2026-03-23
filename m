Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3B36494E;
	Mon, 23 Mar 2026 07:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252529; cv=none; b=edicbuQvK90IjbIYwAZqYh2Qb8xVX2UO/GVRBLlh6yr2OqNKoGl5BgeUEedyJgN00mV3vz+M/Ba0oWOFszGzmYrBjmmSEQwUPo5VjBivhrnFsMH6rsmT03KgVEMWIR7kAlH5aHhQQWTzq5fUsV/Oi9gfiH+J5vcfZCSo/UGSkAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252529; c=relaxed/simple;
	bh=owvtYeTUbbA3TgdihxMC7YgENUJxawHLPvflL7SRtn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UodIQ4fn8qjub6fcq0PhHxLLqn7HTvxZN0D90i1GN3J57ncNR18Ix+QB139wh2SklbGfduAMxMKbJnMUoZ+vJ1dmHX9Bvkz0kDX272Az6a4DTDXU5k/kR/IhL+utD5Zf78kEd4wiM4naYjkWwSI9AX6Hw8k/dPatjEo8AuGHBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UlZvEo1E; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UlZvEo1E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774252528; x=1805788528;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=owvtYeTUbbA3TgdihxMC7YgENUJxawHLPvflL7SRtn4=;
  b=UlZvEo1Ery64snfhi8SI7bselOlbzh8Uil8C53ebk71Cqdjga3W3bn8p
   1rcylqpjN9hUcoZwRyzHfU8sFI237l3m8lLQLoBmr34YnGMK+1oGNfNOU
   k26o9BasT17o3Yk0A+PmhjHgkrrN9iXYkMRsboWKtDzfgNe9uZ3643RRl
   HpzaDcU+O3a7gsVwtNl3onrwH/HTK6VMna0EVnqrkTuGiZIOrqYGeYyfn
   0rPXVO994My7bVJrOGxUAsgB5u32oDFfwxaPWWg+DB4YLFBjefvKcyzR5
   Ct3OrBgzjgRrG2eUJeWH5QJBATwBUUBHBes9MREC+D8IlDErc4LR/QiuH
   g==;
X-CSE-ConnectionGUID: sWFluW4eStOMSTQkBDHfug==
X-CSE-MsgGUID: 1oVgVsi7RM+fnrUhaDa/UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="86316579"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="86316579"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:55:27 -0700
X-CSE-ConnectionGUID: IWOUnePpS5CjHS4xrdO1JA==
X-CSE-MsgGUID: BwEE3Ci7RAax/y1HfAm8eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="228871391"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:55:25 -0700
Date: Mon, 23 Mar 2026 09:55:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: adc: ad799x: cache regulator voltages during
 probe
Message-ID: <acDx6nORF5zX4UjC@ashevche-desk.local>
References: <20260318092715.42538-1-architanant5@gmail.com>
 <20260318092715.42538-4-architanant5@gmail.com>
 <20260321182710.1621d1aa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321182710.1621d1aa@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 21, 2026 at 06:27:10PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Mar 2026 14:57:14 +0530
> Archit Anant <architanant5@gmail.com> wrote:

...

> cleanest option might be;
> 
> 	ret = devm_regulator_get_enable_read_voltage(dev, "vref");

> 	if (ret < 0 && ret != -ENODEV){ //get the actual error out the way first.
> 		return ret;

While the comment is true, I nevertheless prefer in this case (basically
regulator) to avoid double checking for ENODEV, id est...

> 	if (ret == -ENODEV) {
> 		ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
> 		if (ret < 0)
> 			return ret;
> 
> 		st->vref_uv = ret;

...put it here as

	} else if (ret) {
		return ret;

> 	} else {
> 		st->vref_uv = ret;
> 		ret = devm_regulator_get_enabled(dev, "vcc);
> 		if (ret)
> 			return ret;
> 	}
> 
> Then no need to undo anything by hand in remove() and no need to keep
> a pointer to any regulators around for later.

-- 
With Best Regards,
Andy Shevchenko


