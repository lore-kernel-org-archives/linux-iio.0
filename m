Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB9364049;
	Tue, 23 Jun 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782207603; cv=none; b=VP5cvOWE3zzSUG0PxUQ7cWp5w1UdTzph7gpc532xKUWvSrTK6qu9+poMA6N/PYr06N/ICCzL2sjzxEk4A100LsRZf/z8L0kxkD0Dj5KsDp6xNccEf7YitlGWaYqURoSHLqdKfdsUWLMRecr+NziwIIjo6CyO+PnKuYmvPUU1lFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782207603; c=relaxed/simple;
	bh=g/Thmy1vvnE00Hi3Mc4Hp+GM4jh2dSNPLnBK7tDhi98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ2AW80O1QhzgarIqUrgorV6BhPCYjkkMZJZ+OCkTsX6XGYhlPbhyt4xKOHLj4MjVB3sV603prLL9SrPzIXn8JkbzdHsg62OHbTlOYXtiKKtwXSKz9SmuRkBoCCpBFR7i1j1LPQeZVrdEoHbUq3UaX8H7kOuSqLEG+UijnFdUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2dfrJMl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2dfrJMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782207602; x=1813743602;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g/Thmy1vvnE00Hi3Mc4Hp+GM4jh2dSNPLnBK7tDhi98=;
  b=F2dfrJMlC8X2KQprVpVNKGs+7R1sVPhDb5rxMvo6gPLFC2Q6RLYzPZb9
   M2gf7WbmdYiBXoDMsUERjLf5m0PzJbALH7bt/Hwujwy9dDcX8EFicrNHh
   3Ugyfj6IuKXDJDqft4VkCDjtkMwbaOFcI9W/SV5hjpGxHawH9UMOhxhWa
   Zzv2Mxx+VQRB3+STo4zTUGavwwHm3zAe8S0J5jjAzcQaFna21dtIAOB1k
   HPGD79FG4HOyHFGQ8GgCkA5htFAik6op1WMaJP4QEIcL0IZW2N8nKmaWu
   N6UWE1eHit5hDgz1H8H9omSPnN+itIp0WemWABU+8PHPwmpYn5qBiHp8H
   Q==;
X-CSE-ConnectionGUID: lWoOZF+wSxi5cYnhJxbbiQ==
X-CSE-MsgGUID: wCguU/EUSGGD/fItMOQYcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="108488968"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="108488968"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:40:01 -0700
X-CSE-ConnectionGUID: j+sGnqWyRUSKuHmwSOmfbQ==
X-CSE-MsgGUID: CPn7FJUsQAGZ/Dw59op9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="254570642"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:39:57 -0700
Date: Tue, 23 Jun 2026 12:39:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	duje@dujemihanovic.xyz, jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com, jorge.marques@analog.com,
	krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
	sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <ajpUa1adlePVuqE1@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
 <ajpO9zaZbIl3x1uC@ashevche-desk.local>
 <20260623112953.000066cc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623112953.000066cc@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 11:29:53AM +0200, Joshua Crofts wrote:
> On Tue, 23 Jun 2026 12:16:39 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > > +	return read_poll_timeout(ads1100_new_data_not_ready, data_ready,
> > > +				 !data_ready, wait_time,
> 
> I'd actually be all for using `data_ready != 0`, to make the condition more
> readable.

I am okay with either. It might be slightly clearer if the comparison is done
for some dynamic counting or so, when 0 is not special.

...

> > > +		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);  
> > 
> > > +  
> > 
> > This blank line is not needed as they are coupled, but I don't know if we have
> > an agreed style in IIO for this.
> 
> I'd be surprised if there was an agreed style, as there aren't any IIO drivers
> that use this specific macro (not in mainline at least). Additionally, might I
> suggest using `PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND` as it is more generic?

We have other PM_ACQUIRE_*() macros in the drivers in IIO, so we have some style,
but I haven't checked what is that.

-- 
With Best Regards,
Andy Shevchenko


