Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B42FE56F;
	Sun, 17 May 2026 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779001472; cv=none; b=YNNR6yVxxbQXMtAcIgtxm+YEg9AblipMlu9qr0qNPsStgae4X8Gi9DMxM0mNHzQrgBkA0fBQPMlauVxpXib8MqgADRHlC70GA3G/CabCeHiZ2zV54TVapiWRwRXPSkwmI40JjPmId3eAwq13P+tiEvXtcSjFzjbxDclm//1H27U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779001472; c=relaxed/simple;
	bh=7VOxLAa/qz/a7zDrOH3v/advkRdTaTcHNjDDSKknc2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e422TrrDsmDaeqNbO92SoT+fQ1H2fkmi8tTbMO1pVEqjxMFuUOaphkOCxTmNi0LIKN/HPy5RoHuZ7K9fsJHhQ63Gj8zhFSNRSBMTkZeakZtc1eRMLFaOP2vhD9jfjYVBtgWMzc3xFwhvwEvQ3unBvojHj6N22VZIQCsbV7ip63U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AMd+Ae8x; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AMd+Ae8x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779001471; x=1810537471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7VOxLAa/qz/a7zDrOH3v/advkRdTaTcHNjDDSKknc2g=;
  b=AMd+Ae8xv/3ygON4YughwpBx9ShofHE52C9NtITIDOAFKBqd0GDnzBoD
   6pAWLYSILpIdzLAYirLc77xC2whbxrDJBCxi3NFYRTpf/tu4KLMPCWvc9
   2pbNNEd0jV6i4KIqfx3z+cOUphbRZqa+U2sXaKJRG8zFp7kHAOcn7q9mr
   xdINRii3bsj63KxScz8JFUtKPmdR3BCJhVndc9ZX3X40Ap3yJFRMFrUWV
   yL7+RwnTcEc5OUhqRDMmlivYOKRMfrRY8zTF96guwNSgkT+y2Rxuc8WGb
   DuuE9S16HWGMF26DIbS7HQZ/iAs+fqjjicAAZtMbCI7TXiAsvQtjnO9KH
   Q==;
X-CSE-ConnectionGUID: g7zu2IVWSnexRjheKEbK1Q==
X-CSE-MsgGUID: 9mNacsKUTa2C/B9FT+XZDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="105348655"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="105348655"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:04:30 -0700
X-CSE-ConnectionGUID: IiRbXxdGQ/mIhCto9mL4ig==
X-CSE-MsgGUID: KP2hF+5YSIavDq7sGSY43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="238986823"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 00:04:27 -0700
Date: Sun, 17 May 2026 10:04:24 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: marius.cristea@microchip.com
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, broonie@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] add support for Microchip PAC194X Power Monitor
Message-ID: <agloeEkyzR65lB12@ashevche-desk.local>
References: <20260515092946.10791-1-marius.cristea@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515092946.10791-1-marius.cristea@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 12:29:44PM +0300, marius.cristea@microchip.com wrote:

> Add support for Microchip PAC194X and PAC195X series of Power Monitor
> with Accumulator chip family. This driver covers the following part
> numbers:
>  - PAC1941, PAC1941-2, PAC1942, PAC1942-2, PAC1943, PAC1944
>  - PAC1951, PAC1951-2, PAC1952, PAC1952-2, PAC1953, PAC1954
> 
> The PAC194X family supports 9V Full-Scale Range and the PAC195X supports
> 32V Full-Scale Range.
> 
> There are two versions of the PAC194X/5X: the PAC194X-1/5X-1 devices are
> for high-side current sensing and the PAC194X/5X-2 devices are for low-side
> current sensing or floating VBUS applications. The PAC194X/5X-1 is named
> shortly PAC194X/5X.

It still has many subtle issues...

I am not able to review in a couple of weeks, so I recommend to read mailing lists
for the previous reviews against other big driver submissions and improve yours
accordingly.

So far, on a very fast glance I have noticed:
- the IWYU principle is not being followed
- the Kconfig help text can be improved to list part numbers for better
  maintainability

-- 
With Best Regards,
Andy Shevchenko


