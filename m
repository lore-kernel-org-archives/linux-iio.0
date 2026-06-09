Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1638E2E8B98;
	Tue,  9 Jun 2026 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781011600; cv=none; b=QaYAlwtjmRsctwj31nts90EL653xY+cnmLAb4K76CnYjWzqNajKuQ0R4l8UOVP+6t35N6I7f3T53ZSwRINBiZx4HvqfVayaay1omhTbv3nwvLrWSQ3rzljcYIn5uZOZFz9kjtlZcpdQlLa9yP6n8dBHQq2o8XIdESYbjEra8V2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781011600; c=relaxed/simple;
	bh=zqvAnbCL8mHEhufVkeba6vDf+vgzM3h/Zh1dw0Gckhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq3ZgCxAEjfDjohaC0sn4wW+p/mZt+Tze4OmYsPm+p3+7sdMP1+CVmaB4XOls7KAJI1pJ/vf2+oaUrqsDMPySVHj94THIdVm0RfXvqGCbkEobnqlB4lGq1beeCMdOwQEGfeiuCxWvcBSf675qe0P4yoHSFHMoajeGnw5Z62H/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uhl5h0uj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uhl5h0uj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781011599; x=1812547599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zqvAnbCL8mHEhufVkeba6vDf+vgzM3h/Zh1dw0Gckhw=;
  b=Uhl5h0ujCbGOpnAE/udVhJf5H9jsGG9T8a4wsYhGee8KPbc3OahREAGR
   jPAlljTD2H1Qg3suJkBu/+BGjap7Z7trYT/H2qgOTJvJpnLZj+p2gLEHs
   dgsxpc4oD388QwBU5q5ADvnV92VGH878c2Lpc/B3V4PvG8ZR1smqvW8Db
   sc8n69FLU2qos1HpbkHVRJnQ0Ogx748lpkvR+gp0BJvDb+3+8quYrV30o
   mSpzR+yLX9rbsruDRUJ8SlLALjQaleF/OADt+ZoQhMT/aWcuby/oqWOnR
   51IHIsEDABWncFJhTlwh9i6AjAPXGhoG3W37zNGQ66txh6cjlMRHFrYwr
   w==;
X-CSE-ConnectionGUID: FGS7ea0QQaeS9K/n21H0og==
X-CSE-MsgGUID: huMjA8AhQ4yi+lxZkoT1KA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92335385"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="92335385"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:26:38 -0700
X-CSE-ConnectionGUID: 4HI4uIQOSRy3G8bSKTwXPA==
X-CSE-MsgGUID: rDO+gE63QLOZksbWhoVOmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="241414061"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 06:26:35 -0700
Date: Tue, 9 Jun 2026 16:26:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Petar Stepanovic <pstepanovic@axiado.com>
Cc: Akhila Kavi <akavi@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add Axiado SARADC driver
Message-ID: <aigUiF_iX2WhQvOO@ashevche-desk.local>
References: <20260528-axiado-ax3000-ax3005-saradc-v1-0-345dd5f6608a@axiado.com>
 <20260528-axiado-ax3000-ax3005-saradc-v1-2-345dd5f6608a@axiado.com>
 <aiMU2bOFgKT9NrNQ@ashevche-desk.local>
 <1e2f4756-e944-473a-b4d7-a5692f2b609f@axiado.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2f4756-e944-473a-b4d7-a5692f2b609f@axiado.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 09, 2026 at 11:09:32AM +0200, Petar Stepanovic wrote:
> On 6/5/2026 8:26 PM, Andy Shevchenko wrote:

...

> >> +     info->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> > Why no name? It will make harder for the next generations of HW in case they
> > want more than one clock to be used.
> 
> This IP block currently has only one clock input, so I used the unnamed clock.
> Since there is no ambiguity for the current hardware, I would prefer to keep
> the binding simple unless a named clock is required.

Again, it doesn't matter. What matters is the potential future. Hence it's
recommended to use named clocks even for a single case as we don't know if
the next generation will use more clocks or not. In any case, it will be
your decision and up to the maintainers.

Note, I have not checked statistics of how many of those which started with
a NULL clock become more complicated in the future, but for sure there are
more than a single case in the kernel.

-- 
With Best Regards,
Andy Shevchenko


