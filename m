Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C824315A;
	Tue, 14 Apr 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183610; cv=none; b=K4SNSMpTQrbTdI+wpp9//G2BAjRUiaJKuuGx8+5afBOM797t1oCDFMHUhKrQr6Ey0Cw9V4BMM/lUwEUUdbcyzru8QUpmCsaylbpjaDriqYF5GuoUYZRiedj8dETSNMLj1inK49+Le+GgEfn53gmbVKcXrsMyXYdpuMu+3q7JNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183610; c=relaxed/simple;
	bh=oysW24PkqwpL26ptgVVrktJ+LcZE841GAkZzX/GVttY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6KoviocPxbmQxbD8et/HRu02z9zSuWjPE1J6LodLVIJTl2Xtku+itzlN5DaI5Uif1N8df5GsLFKXQlRG7FooKBSE2HtKgNYzBOeZexjPyyxvLsCPmxDw2hIqxzs5mLbvv7R2R36HIl7WjCA9dbgT8969EPLGBJJvO/ZnPEDIgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbEdOpA/; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbEdOpA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776183609; x=1807719609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oysW24PkqwpL26ptgVVrktJ+LcZE841GAkZzX/GVttY=;
  b=mbEdOpA/dzCK7DvNDCDAAsbnS51BDx6W16YcaPoSDPexF2inEX58icAL
   OWii1CvpnGx/5Re2ZgdxTQBSlhHjgJZIkW5/LK2uRtMeJAWcu2UnlD9oh
   XK/tLQHA1pBCAliJoFwYPH49lbpJc6A3c7Oelr2LStndfPe6tiTvGCrRR
   gRqjurX4MnYMLUTFiowAnFJvLERTBzOxxRIY9pWAD3gF3xTGYB3jvxIQG
   gvE8XlJIinDOCqomk3IaLbly4v983OQxhCxuCN7l09wpDpFp27c9uADCT
   I8M/zR5Nxv6LtZhogg0n0AyCp31jWfQtMn9jYL/dCM8GMaWdKvk00tKDj
   w==;
X-CSE-ConnectionGUID: PxLAkiWcTtmcc6QbET7E5Q==
X-CSE-MsgGUID: s6kF/0gCRBO5aaNzzV+j3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77259234"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77259234"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:20:08 -0700
X-CSE-ConnectionGUID: snNGZUpZRxaNZkFNV1/oNQ==
X-CSE-MsgGUID: 2Bmyev7UQT6JzSiYxQU+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229275320"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:20:04 -0700
Date: Tue, 14 Apr 2026 19:19:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: dac: Fix passing uninitialized vref1_uV for no
 Vref1 case
Message-ID: <ad5pLcBjNYNOdgso@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
 <ad43ofFZwzEkYifY@ashevche-desk.local>
 <70eb71c1-d239-4618-a12b-e64fff8e54d2@baylibre.com>
 <ad5o5OTA19UvyLr2@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad5o5OTA19UvyLr2@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 07:18:50PM +0300, Andy Shevchenko wrote:
> On Tue, Apr 14, 2026 at 08:21:00AM -0500, David Lechner wrote:
> > On 4/14/26 7:48 AM, Andy Shevchenko wrote:
> > > On Tue, Apr 14, 2026 at 03:33:38PM +0300, Ariana Lazar wrote:

...

> > >> +	vref1_uV = 0;
> > >>  	if (chip_features->have_ext_vref1) {
> > > 
> > > I'm wondering what will happen if we do the below unconditionally?
> > > 
> > >>  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> > > 
> > > If we have no regulator, we get a dummy one, right? What is the voltage will
> > > be? 0?
> > 
> > It will fail with -EINVAL because dummy regulator doesn't have a
> > voltage specified anywhere.
> 
> Okay, and we have exactly a branch to assign 0 to the value with even useful
> debug message which will answer to two questions at once: Do we have it? Yes,

I meant "No" here as well.

> since we see the debug message. Have we got it? No, as it's written in the
> debug message.
> 
> That said, I think the better fix is just to drop the outer conditional.
> 
> > >>  		if (ret > 0) {
> > >>  			vref1_uV = ret;
> > >>  			data->use_vref1 = true;
> > >>  		} else {
> > >> -			vref1_uV = 0;
> > >>  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> > >>  			dev_dbg(dev, "Vref1 is unavailable.\n");
> > >>  		}

-- 
With Best Regards,
Andy Shevchenko


