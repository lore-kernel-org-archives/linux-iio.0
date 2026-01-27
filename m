Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A17835C1B7;
	Tue, 27 Jan 2026 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525792; cv=none; b=mft45Buu5TUJxDPa/lhjIaMWarlefBJkZGl5rd++z7/PvqD/+x0NXmlZp9BQL6wWu0RG1L8k5G2gMk3jqfMr+qNf2wAd7sX6e4g496qGNRyYJFpOEDPbRyTZbjHHJoGhzPSOq1SO0LzbVgbSy94n/zUkad426vjAAA8NSL+wSPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525792; c=relaxed/simple;
	bh=PeRheMNS24d5z3Pyul80a17rmyMjh2FZrk/kxsJ6sMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIXcbd+lrQeDfBMBKBI2t4T9wPmYQ9whU1fSTM1v4Uq0y7ZCqODp+KMbTrp2Rppy15aI0juE1C3VwcHbXgLbces3767Npg1Am6w7ZfVB88DgvoR7H0F1RzzJ+ijraI9+L8a7030UykaVMkfH2XOWB8a6FNZOSZLHtGhRN2O2dk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZIZl5JM; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZIZl5JM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769525791; x=1801061791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PeRheMNS24d5z3Pyul80a17rmyMjh2FZrk/kxsJ6sMo=;
  b=bZIZl5JMS1Ek3qdwwYXCUxpBhQrVV/iFRtWA77MwlSE9R19cJNVsRQJ7
   2sY1T9u4QMrez0yks1Ck4HejnlwudVUpsm/HlJvgwe/YXIbJzfdfAQf6r
   r9IrAnDz2TNJHxEm9Y0gqDsYDFPF8vSpR98mOBmaDUnNBxrLXhvnGDiWT
   BZZtZiSRl9MXWxof/u46B1CxJ1YLiY51JPIC/TY5YRzP4B7ONGncRP/S/
   WlvRzuD1p5Oy+RaEcLVDrV66pbmWvtNODRriM90w6bLIZTqjunixbd8uc
   5PDsiktaxzAr21Z6UoMObwyQ7pO3p15DssI/Ku/JVFOXT6broIBFpeb1V
   g==;
X-CSE-ConnectionGUID: Y0cp743gQLWS/Uqupa0vmA==
X-CSE-MsgGUID: eh6bsagmTJ6VHj32NKNebQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70762973"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70762973"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:56:31 -0800
X-CSE-ConnectionGUID: DZbb2G14QPuH32B6sE9KAQ==
X-CSE-MsgGUID: lDPzgPqNTWO6nQmNov2+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208241690"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:56:28 -0800
Date: Tue, 27 Jan 2026 16:56:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/6] iio: proximity: rfd77402: Align polling timeout
 with datasheet
Message-ID: <aXjSGlttD7qs66Uy@smile.fi.intel.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
 <20260127-b4-rfd77402_v5-v7-2-3e7f2d452da2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-b4-rfd77402_v5-v7-2-3e7f2d452da2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 01:02:16AM +0530, Shrikant Raskar via B4 Relay wrote:

> Update the polling delay to use a 100 ms timeout, as specified
> in the RFD77402 datasheet.

Please, refer at least in the code what is the section and/or table specifies
that...

...

>  		if (ret & RFD77402_ICSR_RESULT)
>  			break;

...here.

Note, it's a requirement to comment all long sleeps (~1ms is considered long),
and some other short sleeps depending on the context.

> -		msleep(20);
> +		msleep(10);
>  	}

-- 
With Best Regards,
Andy Shevchenko


