Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5E93115AF;
	Wed, 15 Apr 2026 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245402; cv=none; b=ostuaQ/XfZs4Ykg/qckMrOrNmPLs7JbYlDSeV+oK+iHD7uKIDv09sEkQCwTGf0JUV+AgSxqkKZnWNd+gKO1vD0OEtIYR0v4zPbfXPCwGwF7zfpAUuYT05JKIf4x4JFp+G+QLTs4LbHsc6r5eSnC/241QqjNMpnGYKnMNHFd9iQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245402; c=relaxed/simple;
	bh=+Pgw1z220/7/7h8v6K2m80V7XMIW0VmoHJH80E99z8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRIXhGNiKeByTZV8I/7pCQGI66HkB8vdaTmpmdg4yJK9PCcKytfqti2hY771QQtZnMEImUn3ig5VwNHcCURefbhFEP1Ez55LjmD1ajBfLgb3vfxKK8gOKDB7HOD82ORoKGK0N+dIgdgOVxvDRC94CeBdodWEl1U+GcmPQiSKwf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ez0CDiLv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ez0CDiLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776245401; x=1807781401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Pgw1z220/7/7h8v6K2m80V7XMIW0VmoHJH80E99z8I=;
  b=Ez0CDiLvD2rg27z6lWh6V+rkdPDGFYxIf2OxYzHBf92IZclstsO/xk1K
   9sbFwti34N2IJNNSujV0/ncuJZnUb2OuDk2Ro9YcbbfOlPfh80ubaT13C
   g++qH5SnmseGziUdNpAF1X9E9jQf6xWheD2bjquJkRDRbx3+tgzzYLMwX
   lo0IdAhTUexq5EISfdlW+URpoBqT9XoESgZBs0alPPzFNjcqOpwv+HJMB
   T3SecDwNdGE6eIuDOgn4MdMCeSaPAepxmydA2k4VhxPiIg9uFRILtf0kv
   y5Rd7uD7qv5kQGt4Shyfuf/V8LnfoCBXvb3mJ3TwC1FEO9JjH+7N00cOd
   w==;
X-CSE-ConnectionGUID: ksKmguN2TnOrRysksTnRLw==
X-CSE-MsgGUID: Ebf3G8f5SfyAyTJiLzQ8Ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="80813878"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="80813878"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:30:01 -0700
X-CSE-ConnectionGUID: 6daCRRo7SBG91s12UqqCRA==
X-CSE-MsgGUID: IQdt5nBfRIa2ow9eV8kozg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229512948"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:29:58 -0700
Date: Wed, 15 Apr 2026 12:29:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/7] iio: ssp_sensors: drop duplicated wdt timer and
 work cleanup
Message-ID: <ad9ak9zVRZXxlEqY@ashevche-desk.local>
References: <20260415050749.3858046-1-sanjayembedded@gmail.com>
 <20260415050749.3858046-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415050749.3858046-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 10:37:46AM +0530, Sanjay Chitroda wrote:

> The SSP remove path cleans up the watchdog timer and associated work
> both via ssp_disable_wdt_timer() and through explicit timer and work
> teardown.
> 
> Remove the duplicated timer_delete_sync() and cancel_work_sync()
> calls and rely on ssp_disable_wdt_timer() as the single cleanup helper
> to simplify the remove path.
> 
> No functional change intended.

...

>  	ssp_enable_mcu(data, false);
> -	ssp_disable_wdt_timer(data);
> -
>  	ssp_clean_pending_list(data);
>  
>  	free_irq(data->spi->irq, data);
>  
> -	timer_delete_sync(&data->wdt_timer);
> -	cancel_work_sync(&data->work_wdt);
> +	ssp_disable_wdt_timer(data);

Hmm... I'm not sure it doesn't change the behaviour. First of all, the
difference is that IRQ handler may be involved in the timer and/or work.

This patch needs much better investigation conducted and commit message
provided with explanation of all possible race conditions and why they
don't happen. Also I am not sure if this dup is a mistake or deliberate
action (again, it's all related to the timings of IRQ handler, timer job,
and work and how they are relies on each other data/flow).


-- 
With Best Regards,
Andy Shevchenko


