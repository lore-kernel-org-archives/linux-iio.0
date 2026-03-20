Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7561D3451B3;
	Fri, 20 Mar 2026 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002708; cv=none; b=tFsbXDW2d8Neio4E0QwWJvfvbz8baC3rGKzRuZ8D5Q8XFRsuPDAGnZV6fFltkbrE0V6LIoSkKjjdeobprjvhHqPQRhkoVk4gySENm33bE3JoAY6Zu1q8THM7M+xSpHos8Sh20XkmdtLxIRn3WzJFqINf5K9KucpRQXa7aUU8xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002708; c=relaxed/simple;
	bh=FuyuF6cs3y/UPu3j5OaECQ1GK3ebCt60+TAC0A5pjBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTK7+dAj0sNtH1mAcqA6buM4kSZayimsKTNkmGGZ0BXiDZkt/QQ7oWpLnNBN7ZKko0BiYc15eUZrTmxwzhzkZk7rDPkN+kUKJ3CyFKxAdAb8QZeewYew3O/ILPoNjrBmpwG4jjIT6FfuWPCwxjrWXQgLy5LuswQldEhVEPv3im0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gZUsMpFl; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZUsMpFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774002707; x=1805538707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FuyuF6cs3y/UPu3j5OaECQ1GK3ebCt60+TAC0A5pjBI=;
  b=gZUsMpFlalYMWJja53aHCNm51bUWJgkfp+A4HAqKWOwCk+OlGo+YYEw+
   A4JWhyP0poFvMc1/4CiaWQ+bqE5BMNM4D/DoLnsRJu1Ije4jftR2b+b/q
   oBqXPzvH9Juj8ip3IiL61gRJJtLDacAGsLo2GnCy3LbrZfENF9kHgdalN
   EmFmJmbipd/KB+kZimx7+Vx2iQQNI/nqAYHI0rn2sRBEFZm6wi1iFc1qE
   zW51l48PfYgBWGCvtIq8KRg6M+GFB5fuYDcbmB5HgyIRmNvTn0arBuGbp
   C51zggFIABM0Hjt6Bs8GUMp7Et3jEwXawelarWkapCAic3xC3E98g19ho
   g==;
X-CSE-ConnectionGUID: I+5C5VdxR6+cCkgeN6XAvg==
X-CSE-MsgGUID: YAMQAUjBTkWxjoJnVExxhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74100940"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74100940"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:31:47 -0700
X-CSE-ConnectionGUID: cEr5vsElS/SoNYs1tc2rkw==
X-CSE-MsgGUID: mbnQAE46S0y+yWubfuve9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="218618516"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.40])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 03:31:43 -0700
Date: Fri, 20 Mar 2026 12:31:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	morris_mao@aspeedtech.com
Subject: Re: [PATCH v3 3/4] iio: adc: aspeed: Replace mdelay() with fsleep()
 for ADC stabilization delay
Message-ID: <ab0iDUp6t2LuGlAA@ashevche-desk.local>
References: <20260320-adc-v3-0-bc0eac04ef7c@aspeedtech.com>
 <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320-adc-v3-3-bc0eac04ef7c@aspeedtech.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 20, 2026 at 01:46:37PM +0800, Billy Tsai wrote:
> The ADC stabilization delays in compensation mode and battery sensing
> mode do not require atomic context. Using mdelay() here results in
> unnecessary busy waiting.
> 
> Replace mdelay(1) with fsleep(1000) to allow the scheduler to run other
> tasks while waiting for the ADC to stabilize.
> 
> Also fix a minor typo in the comment ("adc" -> "ADC").

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

I haven't suggested the idea, I only suggested to use fsleep() for the purpose.

-- 
With Best Regards,
Andy Shevchenko


