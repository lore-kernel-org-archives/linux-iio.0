Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C9A1FDA61;
	Fri, 23 Jan 2026 14:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179915; cv=none; b=WORlC28DeUyh+a6eNdoiE/xvlFqKCdFrHdkVNpk/4cfGEYVGNYVaBswW+RkTGS8VJy8Li/ctJtJB1qTTiUFQD+940QqnPFGqa1AY+cqVJ68Z+7nfgvYEMgWILA/tTcnEPSzH/K1Q5Nak6luTCY36gVxCXNhB0TfuiiSBDbxOXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179915; c=relaxed/simple;
	bh=lHS2xbYz4+qwT/8GeGrirgpdJbqglOBVEwonEBFHUSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFKHL9VmaHDf8EuBA4W7oWiAP7JhIsSbcYbycp0CEyG0CqEk+a66TWAmKGdtfk1NIVwtezWJpruxExd4TK9YF68CwhdhMQKE1J6QqmVdSeM5PjjQHh1Y2REtCkz6CCoL5V4Xr2Bpl2RaTeusZ5eUdq4q3ldnYxG0DJvI6u0Odwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXzwWq8F; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXzwWq8F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769179914; x=1800715914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lHS2xbYz4+qwT/8GeGrirgpdJbqglOBVEwonEBFHUSg=;
  b=lXzwWq8FSQD4x8nhP+/czWWgwPM18Da/4xG67lLm+dITDdG8IG+TGTvK
   yGfNXrZFNDdHUCPKYqk+plhjJSDKJRjkpJjhZBJSsHXxU2AVKClQAGg0+
   cbI5OZnmkQguASzYtbo5FeWWhojjtrPlSqFHbhmiZXyqyIJnbg/Vfz/iM
   gAUk6tVBoQYY43u4LXc31Ij80rg9YiPBi8t2IHA1PWy2LEfCdPrwwftJj
   lYxLoUH+2blP2l8N20fkbmA6JSjS5Nv//LSeeQ/v6SYq49/NILw8YWJNi
   g9mQsDT349mO/2+mPeHUANrzQEMgRSNUE3pAABM4u6mWb11BDoqo4eirO
   Q==;
X-CSE-ConnectionGUID: +7iH2AB1TcudRd1x2AATPg==
X-CSE-MsgGUID: 0o9Muj6PRc2U0PBezmVeHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="58005942"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="58005942"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:51:53 -0800
X-CSE-ConnectionGUID: gZhVkLopTee/nOb8PPbWmA==
X-CSE-MsgGUID: 0xXUyXQBTb6Eaj0nkc1qaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="212041936"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:51:50 -0800
Date: Fri, 23 Jan 2026 16:51:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 20/21] iio: magnetometer: Remove IRQF_ONESHOT
Message-ID: <aXOLA9ynWBue_vgH@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-21-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123113708.416727-21-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 12:37:06PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> The force-threading functionality is required on PREEMPT_RT because the
> handler is using locks with can sleep on PREEMPT_RT.
> 
> Remove IRQF_ONESHOT from irqflags.

...

> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-iio@vger.kernel.org

Same comment on the location of Cc list.

-- 
With Best Regards,
Andy Shevchenko


