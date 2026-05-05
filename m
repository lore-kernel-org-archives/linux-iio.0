Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92D921018A;
	Tue,  5 May 2026 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969908; cv=none; b=A6ZnAJ62VWELocNn61OmDrSpfDl7yCSzC3HgrcyJQTulA/pKbDvHz9wTDyj/Yenwpxzqzgtqzdf3781SWla0UZrZwCguLEypGFmsYOv0Mv7Y0LgYruzoawgUtBKhIcmlkEz8XCo3Brih1K3tE9rhbzU/T9mOFbSszadBNWObTE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969908; c=relaxed/simple;
	bh=hwDIJ7pMtHCCustNvs0AAaepY8/PftFzyLYey8zGy4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7D4OtWlSaYEyBiRU/L42kNTOA1VxSx/DwGZ1ebGCDR6C0j4zOZTreDB6LVBU925+FfxqaEMm7Te+y4g7EuCQaD/vK9crPQD1lotAE42Y/fE3W2PyGWCczcI8N0zaqP/y98jHXU9RFGNFboFntYNYA6d7RsqQX+x+Py4WUjsCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJMz8Ow8; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJMz8Ow8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777969906; x=1809505906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hwDIJ7pMtHCCustNvs0AAaepY8/PftFzyLYey8zGy4c=;
  b=GJMz8Ow8ooz2GZ2kY31HRSxbM7K4pxRaMSXOTOpAbGd4gt90Buf/z1Lg
   nKYdfWz7DGe26fi/UplxaDr8QOclb/wyUN8qGvOgS5iZzRSUul4JzRUop
   Tssj74EyEnmbPU+qHX2ogeTrvdNUjxedcjzIYrCtlu9EcJ4QinfUIHT3r
   EZrrcrXkAZTuADX9P8ajDftRBHCWwVzCs74ov5r9uneixiC0k/WbKagDp
   /k8rkhw6DRR6qVOvQGQPBM3GkKtLqOVze65dWnerYP4xkfpzkYT6oui8y
   bvqzGsDREeuuGPGlYOs4WyUusASGjmIuM0N6bSrLqYlHNvCSBL1W5sG1S
   g==;
X-CSE-ConnectionGUID: 9TXZU+TLSu+jQCjRtT77og==
X-CSE-MsgGUID: /aPm+/FtTGCvWGOaMkDHdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78933487"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78933487"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:31:45 -0700
X-CSE-ConnectionGUID: tuc2W5dZQyOeHu5cjmszog==
X-CSE-MsgGUID: S21AuqnmTmuWUCuhw4jPkA==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:31:41 -0700
Date: Tue, 5 May 2026 11:31:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <angelo@kernel-space.org>
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
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: Re: [PATCH 08/10] m68k: stmark2: add mcf5441x DAC platform devices
Message-ID: <afmq6-AfomfKtX7c@ashevche-desk.local>
References: <20260504-wip-stmark2-dac-v1-0-874c36a4910d@baylibre.com>
 <20260504-wip-stmark2-dac-v1-8-874c36a4910d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-wip-stmark2-dac-v1-8-874c36a4910d@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 07:16:46PM +0200, Angelo Dureghello wrote:

> Add mcf5441x DAC platform devices.

...

> +static struct resource dspi_dac0_resource[] = {
> +	[0] = {
> +		.start = MCFDAC_BASE0,
> +		.end   = MCFDAC_BASE0 + 0xFF,
> +		.flags = IORESOURCE_MEM,
> +	},
> +};

ioport.h has a lot of DEFINE_RES() macros. Please, choose the best fit in each
case and use them.

-- 
With Best Regards,
Andy Shevchenko


