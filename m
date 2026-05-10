Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB523EAA0;
	Sun, 10 May 2026 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396391; cv=none; b=m4Ji6Lf/3a6fpkt0blYlUo2A8zKf59p32OSWSqPjPxZlViYKldh9LLvdnVYawJd3a91PBXdeUdKCk0kfSqnIgdfDva8gPl3ZKo+wxPbJ4Ob4yoTg4k7DP/G40ABkRTLzOdd0MqJAriqJFGBa+dbyIJvvOR5B9nBsbE+yvP6PSMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396391; c=relaxed/simple;
	bh=u/zJk1bSaDMTKI7/Emhq7zr+eREy+gGdWkfhZAK0nHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGZL6/qGAv1GVjRmgIhSNHpAb+vtYV+eKp/gW6f8EK0pNycMWBTOMZrqTs2dFHZK2Ckh3vw6o7r+WS6qOT3r2O5N6WDoCbZV4DB9GRIcIkFuBpfxqcY8yj3NCSOhwiO2IaJnxO58NZ/OHrENp4o5QEjupSrlW76knY0ZW7o9ns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLlEWhOu; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLlEWhOu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778396390; x=1809932390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u/zJk1bSaDMTKI7/Emhq7zr+eREy+gGdWkfhZAK0nHw=;
  b=nLlEWhOuHfxBgNyphTtriOxN97zOTg2hTl72HA0eSkesFqj8oGWcepjv
   H11ma5mIIszuZqAdcnx3LffDRWIDjw/ar0Nc2MXkp4ABCeFRVP7/Qz+xK
   w4NY44XhOBakQzNfDSYza4uSoMHNPstrlw0uAnfzIdgpCu14ZX3uod/Xd
   7fS7dqxbhLPlSU/qdzsNpWt2Bu/h5hh/ARU41KhrfnGoRI1pIBGMqYKA0
   w4mH7XcMhRQJt4By2W1jK/Rfi3gsakgOcoLF52VVFUFS5vAK5z4X5wZgm
   S0kCo+nrVkSdiRwISaLsMUJnwINoNEf2j7EYnYAcIYBUspJvXkoxZPrCH
   A==;
X-CSE-ConnectionGUID: o8WuBZ/8S1eNwzXZH2nxtA==
X-CSE-MsgGUID: UAHJLIieSWmLbLdqukyGBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="66849426"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="66849426"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:59:49 -0700
X-CSE-ConnectionGUID: nU91MFn9QcqQmANcvHbxpw==
X-CSE-MsgGUID: GEt4GagrSDaxk1xrQGbuOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237386727"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:59:47 -0700
Date: Sun, 10 May 2026 09:59:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org,
	mike.looijmans@topic.nl, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: ti-ads1298: Fix incorrect timeout
 comment
Message-ID: <agAs4IqohFKFhbhk@ashevche-desk.local>
References: <20260509151959.3475-1-shofiqtest@gmail.com>
 <20260509151959.3475-3-shofiqtest@gmail.com>
 <f6189816-a157-466d-80bc-3f338c13d69b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6189816-a157-466d-80bc-3f338c13d69b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 03:27:35PM -0500, David Lechner wrote:
> On 5/9/26 10:19 AM, Md Shofiqul Islam wrote:
> > At the lowest supported data rate of 250Hz, one conversion period is
> > 4ms, not 40ms. Fix the comment to correctly reflect the timing.
> > The 50ms timeout value itself is correct as a conservative margin.

...

> > -	/* Cannot take longer than 40ms (250Hz) */
> > +	/* Cannot take longer than 4ms at the lowest rate (250Hz) */
> >  	ret = wait_for_completion_timeout(&priv->completion, msecs_to_jiffies(50));
> 
> I would say "lowest sample rate" so we know which rate it is talking about.
> 
> However, there could be latency in the kernel delaying the interrupt from
> firing. The kernel latency can be much larger (I've seen 100s of ms on old
> single core ARM CPUs). So I think we should mention that in the comment as
> well so that no one is tempted to set it to msecs_to_jiffies(5) (or 4). Even
> if that works most of the time on a fast machine, we may need the longer
> timeout on slower machines.

Actually it's not about fast/slow machine, it's about scheduler and load.
Even on the fast machine under heavy load the completion (if it's thread
based) may take quite a significant time to be delivered. For the hard IRQ
based completions it might be much better case, but nowadays it's more of
a niche.

-- 
With Best Regards,
Andy Shevchenko


