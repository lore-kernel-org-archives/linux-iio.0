Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79739FCD0;
	Wed, 13 May 2026 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778703384; cv=none; b=XUlt6bJcQjcWJaRXC/eVbbZewMOhjFKNYYOjFnFlrlzxbIyQnYyETCkeXIad4/GsP8hyPeRuoVWpDNROaTPppkZBjxmMLFVL0Ut099EzbRzTXixaYf6z8gwxmKvMqK1kn/kYfeBfyKU1hY94z1FdxVNzGnIL6lceXR1DgXQfkls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778703384; c=relaxed/simple;
	bh=mIQ+1K+1Vc9lN+OORTOgLG1EPzXtmw6+x8IuxCo8fsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueMNPaDWtE7GDVYtfGoc5BpE84kx73qTeIiVRE4RHe+rfNfxw74FY+O5YQmsaNMHnzTSdttDf6fsJAvRUzfYaM5M4OKXGpKe+jnCf2zG2l9SEWJX/yXNFWW4hbZmhJUHA7l7VbyNMcFX/5PLLF8pLY1E+E0Hebkb+NHPR7ZIueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMB8fiAm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMB8fiAm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778703383; x=1810239383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mIQ+1K+1Vc9lN+OORTOgLG1EPzXtmw6+x8IuxCo8fsw=;
  b=IMB8fiAm4nKePIgwGrePsti3B1HE4nRyy4vDIua7fSP9xMjAzwgP62q9
   b5M+lNAC9/DcjwUcIiWLCkK1qVCygrLAtpUKaiKuh9oYNs1BtYcPO4xkx
   FaPnzLcspbH4ASl6Fs7EA7KrtNQ64ceajKKwchxfeKN7L7y9hVi8wz3jo
   PCHf0LEn2ujudmzCoyr3M4eKpcfrusr6tGOBLwl7DQEwjECYRiXCeeEtC
   OrjP+yLqzPh4JXB3Vi0ISIsPylkfL9ws6NlIGN88eO8JzpkNKlqHiLf1O
   a5bad5N+/UZaSG+gFRZ0JHKiTOJur6jhKOPYgTnSDe+HOjgVT2pWSyi71
   Q==;
X-CSE-ConnectionGUID: dVbvjegjS3qpXsPe135Xfg==
X-CSE-MsgGUID: h7mzidD6S4yAfCdVNLJUpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="67172020"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="67172020"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:16:22 -0700
X-CSE-ConnectionGUID: 6/JJXADcRba65k/N30FZZg==
X-CSE-MsgGUID: Mvsw+TwPTt6nTk/svVCyig==
X-ExtLoop1: 1
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:16:18 -0700
Date: Wed, 13 May 2026 23:16:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Greg Ungerer <gerg@linux-m68k.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Steven King <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 08/11] m68k: stmark2: add mcf5441x DAC platform devices
Message-ID: <agTcEECgJvBydhe2@ashevche-desk.local>
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-wip-stmark2-dac-v2-8-fcdae50cf51a@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 11:14:32AM +0200, Angelo Dureghello wrote:

> Add mcf5441x DAC platform devices.

...

> +static struct resource dac0_resource[] = {
> +	DEFINE_RES_MEM(MCFDAC_BASE0, 0x100),
> +};
> +
> +static struct platform_device dac0_device = {
> +	.name = "mcf54415_dac",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(dac0_resource),
> +	.resource = dac0_resource,
> +};

It can be

static struct resource dac0_resource = DEFINE_RES_MEM(MCFDAC_BASE0, 0x100);

static struct platform_device dac0_device = {
	.name = "mcf54415_dac",
	.id = 0,
	.num_resources = 1,
	.resource = &dac0_resource,
};

...

Same for the rest. But I haven't seen the followups and don't know if those
structures are going to be expanded. The commit message doesn't say anything
about that. So I assume my suggestion valid.

-- 
With Best Regards,
Andy Shevchenko


