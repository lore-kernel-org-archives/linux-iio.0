Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719403ECBD1;
	Tue, 14 Apr 2026 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776184096; cv=none; b=Dc3fQoqcn9vB8RXEnnC/fk+KlIU5/+TE35KaemMyj2TvFml4FaqHKo1QThQruYQUfl6VxF1tkiLYDRcL04RTx7so5iQAL6Z1P1Z3jcc5GaMzIr2Az7Jq6RGMNWzqf5LDcRmImMYMiICTFfJ/VcQfnNzZGP4OVrR8dMyQL2nAiYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776184096; c=relaxed/simple;
	bh=5JbiNt75IePS3Z3GYq7T4ep0yfNN/ZGW2vbuHCwsdiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qU4YPJ0V9U4gbVbm1Kzu/SDxTucMgSGKU5RqrZakBssdHZs2EptpAvmk5x30ZRZO/gE2o99ZglDvOZDPwWTeZD3ngY58/z5HAYnkMFlt/B3WUlCdIBhW/bovV5S6Gctu+kDPql1dCN0bpbWCxRG2iTfbSO2Nq7lqz/qBpIV3tNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D1+pu4aE; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1+pu4aE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776184093; x=1807720093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5JbiNt75IePS3Z3GYq7T4ep0yfNN/ZGW2vbuHCwsdiM=;
  b=D1+pu4aEi3VNDK4d+yoZ+UL3a1QS+MktOeMrIksHwxsvYp4GSdJkWFvC
   +VHin0IwpgN0i18VdpGYeo/RU2x1wy/+RfA9ZL+f3Kqb/faXwq6ImWacK
   IMU0uRgAHByTjpNJKzKCxnumkzB5wRbb5xWo1FQTmGTPUuCabuIK6osbx
   M2kADF24NBhpExhkxAUm51Qy8g+v0wQVy9oBsr6mBoOAdVIsIIrvI8sBK
   RaisFl8vxuzR5o70rUShIdIuQ/M6pkfrr41Abt98VrpKYuefGi1kOu9+I
   X15uJxwuVZbj4nA5sYxmQw9OA0GAzkWhQO+ucn2Db4IGG39/4EbpbsM6z
   A==;
X-CSE-ConnectionGUID: goCaxbJCRS+X8KJi5UC9pg==
X-CSE-MsgGUID: WgXM0WAhTmKg9oplmrap3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77220692"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77220692"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:28:12 -0700
X-CSE-ConnectionGUID: Jvadtf5ITgmUkncCcvSxYQ==
X-CSE-MsgGUID: J+MRpLB9Tfax7mU0tYI9PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="230364902"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.247])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 09:28:08 -0700
Date: Tue, 14 Apr 2026 19:28:07 +0300
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
Message-ID: <ad5rFxKJntrSFWuz@ashevche-desk.local>
References: <20260414-mcp47feb02-fix4-v1-1-9d71badfd25e@microchip.com>
 <bcd23f9f-0754-44ae-b921-e312d0185394@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcd23f9f-0754-44ae-b921-e312d0185394@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 10:32:11AM -0500, David Lechner wrote:
> On 4/14/26 7:33 AM, Ariana Lazar wrote:

...

> > +	vref1_uV = 0;
> >  	if (chip_features->have_ext_vref1) {
> >  		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> 
> I don't think ignoring all errors here is a good idea. For example, what
> if it returned -EPROBE_DEFER? Then we could end up with the wrong reference
> voltage instead of trying again later.
> 
> So probably something like this would be better (also fixes uninitialized
> variable):
> 
> 	if (chip_features->have_ext_vref1 &&
> 	    device_property_present(dev, "vref1")) {
> 		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> 		if (ret < 0)
> 			return ret;
> 
> 		vref1_uV = ret;
> 		data->use_vref1 = true;
> 	} else {
> 		vref1_uV = 0;
> 		dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> 	}

Thanks for the suggestion, I agree also with this alternative.

> >  		if (ret > 0) {
> >  			vref1_uV = ret;
> >  			data->use_vref1 = true;
> >  		} else {
> > -			vref1_uV = 0;
> >  			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> >  			dev_dbg(dev, "Vref1 is unavailable.\n");
> >  		}

-- 
With Best Regards,
Andy Shevchenko


