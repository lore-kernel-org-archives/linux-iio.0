Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4F322B74;
	Thu, 26 Feb 2026 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772111946; cv=none; b=Ed1/Xpm/ZOtchOn8VyM66P1rPi8mcmHlGSTMnjcdbwOd3hfvaNFNSJMajz5L0s/GAQRxc0UeSDB69Vsh9eeieun6hdAuwjf7EVSgHFccRRmuiwrRSt8ghJmBKxIOHkgevE5iNsYuPHbBCQDWzMrIssFsaMCkiz202qopW/oE7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772111946; c=relaxed/simple;
	bh=Kbm0XCMaqDFY78zqhr3imBHALmfVedwbpkHDbVVUqFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCqiUs4A9OryoCOsd4f44CspUzsksP3H63tSpWxFMfC1RDq70m58uuGbvfPa0vz/OC7erqzN0GWhlfg8UgXAygmygtaEhbhDvHXEygh6tyPShA7krbitZz8vFGUCUxzNnEch4x8g+jePqmwsUwGXXH8FM4vKpZBA7ImIFeZt+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUVgDCJh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUVgDCJh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772111945; x=1803647945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kbm0XCMaqDFY78zqhr3imBHALmfVedwbpkHDbVVUqFE=;
  b=EUVgDCJh69Q4do9i6Cq0/x/jSAtHIrH+zvdZ2vrvNmO9d6xwsO9WaQVY
   xNXcPejNWvcbYa06tZmnOpx3iNFSP6sGknxxaC4YQ39LNeWR1tmTokIPY
   BQjlnaSJ39HFsMWnfyydKVGwAcA8FSBQewJn8trJa/sPqyPSYkll2i99v
   WuhZ7dHeFy1UOIDFlv89CxCeLY4kICeLkXdNap20w3TYv9rSv8WK8/54l
   yY9yCaf+nf9vzAHqqW14Na2a3ko00TNCLpw+b93+zAHaN/wpUZtiid4FY
   gtsD57mX0cqEFL4xB5cVAYN72nUf/murBCr+rK0UZotTaCU0s7VAD8LaE
   Q==;
X-CSE-ConnectionGUID: N5xr1QZ4RbSYc+s7KjxoqQ==
X-CSE-MsgGUID: Rbb3GE67RiS3lC9ij+I3Vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84630060"
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="84630060"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:19:05 -0800
X-CSE-ConnectionGUID: jCDG+iJeRQKhehMcRUEPgQ==
X-CSE-MsgGUID: MyT5c1fcT4yREfKSGUO2qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,312,1763452800"; 
   d="scan'208";a="216580124"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 05:19:02 -0800
Date: Thu, 26 Feb 2026 15:18:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: dac: mcp47feb02: Fix mutex used before
 initialization
Message-ID: <aaBIQ2zmMuEflPlN@smile.fi.intel.com>
References: <20260225-mcp47feb02-v2-1-4792dc3942d9@gmail.com>
 <aZ8cXbvj7KcQNvp3@smile.fi.intel.com>
 <CAN4SLj3jw-SqXSV04CA_-d=e=Mu63xaJuzu1rUYzTtt7myqMKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN4SLj3jw-SqXSV04CA_-d=e=Mu63xaJuzu1rUYzTtt7myqMKw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 26, 2026 at 07:16:26PM +0800, Felix Gu wrote:
> > But is it called early enough before anything that may trigger access to
> > 'data'? Exempli gratia, IRQ handler in some cases may be triggered before
> > probe finished (is it the case here?).
> >
> I've checked the implementation, and this driver does not support IRQs.

Thanks for confirming!

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


