Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933879;
	b=X78UvgUwzbe1FEcJHNKTSo4rsh9JNrGXJ6bjhbKDOBteppYygiD52vtZ7aAQnLrSIEH6
	 k+1oW09Y/1n2rsI2mNmIyHl+uJbRYhKmSneh0zkl3x/+Xp5I5AnW+jZ3+yInSTG0IvaNf
	 axfzXgPlW3SKBGmT6QIBJ+5R0P3t1c7LTY5E9Eua+0GvitpOFLamB/Uqxl+GqgPXGQCZt
	 H0rvYU9Ut+BWQTyELwhQdnwh354qHw71Meyk92S8h5qtRmCkOOQjE0mlH24wNnq2pNKEn
	 DyRSVx/HWMN3md/6iv+X5SgSQI4AoxRBcVNQuat113p4FV1or361HUizm32efWhu8Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933879;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=D4lWNtZpY5yf+w+jF193Q7eCu5UhHFdmIhkqgVri7l8=;
	b=JUvXlrCKV28uBrRkFQBmnxwjPb5zd82VN79C3OHtFhbXOe4R+xp3qUVDpReBnCFmRkfT
	 FXYA155eH5GQbl1RahijhLCuc0HKowh+oyTrtun8bk43BJNKf8yKMzUCR3bHmL8OErgM5
	 REprK0SrdyNFrRfEcKUDRZNJ8MoskIfjfU+ykP/pc9LrESoJskrtxtNzdYK7DwkP7kHfe
	 AnYsbnv5Uzmko3sSuFW6GFfVNOYz4pVOqyauq1dq3jwwXoA6Ur7ql+XiOQZtNXpQ/Z0iO
	 4ZTzCVYPaAxa9kF1gyUSFdU9lPwKSEBFnII+kgJz9ahQyU9XXHlTwknPDpA7BEyp/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dKCyE4Vg;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A10606A32F;
	Tue, 17 Nov 2026 16:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A10606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dKCyE4Vg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794933879; x=1826469879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QOxWIIE+hizNvCqiDlwiHj72tnFkpkIA/gz3CsEwsNs=;
  b=dKCyE4Vgqu+dv2La7m8aqU3LfywgsPUwL1EWyTzzdkNSSjLbizSGsYDA
   R0C0f74/ZWDGb72sM2CAbIeb2Jg9mNS8rLKtyoj0niTVmVCXOEuScj8y9
   cRJGLjPQICouUEZxyQuGosvyLfNoikdRIGlMdKXek8FbKaN0w+dtMlfmx
   kUZiYUb621g+fgy/Dajk/pCm8qlmjN5Gf+IBYiCoucqLOMLuiKSs8gMae
   8METdlac4XwZnG7kyeaWvCQyAfOdrupV6nkOS9T0b96BSIPrGSR/MSVc6
   P01JKr2omTtfT94Mmm9c6UkplEwPbLU0C0+ADJXwbt2DLYi5/eoxceIGE
   w==;
X-CSE-ConnectionGUID: QKVp0BDASs2y9h29VUqEew==
X-CSE-MsgGUID: D7ZCTmWFRQasptKGBSFiIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3755162"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3755162"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:44:38 -0800
X-CSE-ConnectionGUID: cIHBCJjZTHqSCHUntJ9yLA==
X-CSE-MsgGUID: KPEa74UsTrWq5ls7tngLFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10200067"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:44:34 -0800
Date: Tue, 17 Nov 2026 18:44:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com, amin.gattout@gmail.com,
	antoniu.miclaus@analog.com, gregkh@linuxfoundation.org,
	mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: at91_adc: fix NULL pointer dereference
 on trigger remove
Message-ID: <avyEb9La1tqS90Cp@ashevche-desk.local>
References: <20261117140510.391907-1-abdelnasserhussein11@gmail.com>
 <20261117140510.391907-2-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117140510.391907-2-abdelnasserhussein11@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 04:05:08PM +0200, Abdelnasser Hussein wrote:
> When the "atmel,adc-use-external-triggers" property is not set in the
> Device Tree, at91_adc_trigger_init() skips the external trigger slots
> and leaves the corresponding entries in st->trig as NULL.
> 
> In the error rollback path of at91_adc_trigger_init() and in
> at91_adc_trigger_remove(), iio_trigger_unregister() and
> iio_trigger_free() are called on every slot without checking for NULL,
> causing a NULL pointer dereference whenever an external trigger slot
> was skipped, either because of a partial allocation failure or because
> the external triggers are simply not used.
> 
> Skip NULL trigger slots in both teardown loops so that only triggers
> that were actually allocated are unregistered and freed.

...

>  	for (i = 0; i < st->caps->trigger_number; i++) {
> +		if (!st->trig[i])
> +			continue;
>  		iio_trigger_unregister(st->trig[i]);
>  		iio_trigger_free(st->trig[i]);
>  	}

Yes, but no. Please, rather fix the above mentioned IIO trigger APIs to be
NULL-aware.

-- 
With Best Regards,
Andy Shevchenko


