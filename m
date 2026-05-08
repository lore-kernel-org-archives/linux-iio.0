Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D79834DCD2;
	Fri,  8 May 2026 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778225482; cv=none; b=GS67zyBx0zast0PIX5gqr4gGXbIVnwRIGOx7aH4hy2LBKaH0rRGmDAIOV8RfC+avsA3q99O0RCSsSEUT+hZ7z1K8y4ED9jv9ML1TfO2k/ncyxyi2rRIPI8u9CRYeCPcqCEQyrTuH8kAt5Q611NlSVhuI+V8dY+8M36K+lV0yIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778225482; c=relaxed/simple;
	bh=J2p4V/hv2o8j07bv/Lp9oGErxsMYT7jT5ZPepSijV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQWxXiyOw5xi2fVxdwMQXCLtRTySjyk2mVxOCuvJFUewlvG/1NvLU5FTYC+eT+tpI1XVkjG7DpLvZD0t4sJ7xTPjrFnBvjw8+djtdVW5VfAXICPXCQmOxDAj27ACHaNBPl/1EDT3dFUmSBQaZQ4Qa/6O1HL0LPctCVanHf1Kixc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KoJhDPmp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KoJhDPmp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778225479; x=1809761479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J2p4V/hv2o8j07bv/Lp9oGErxsMYT7jT5ZPepSijV5Y=;
  b=KoJhDPmpz26FzXrtQP/egW/Y47erHidzbzTrMT1Q8jnPvq86X5vIsNT1
   FOgoZVj6cwbDMuqpd49yJP5EEj71Slve8bsdNR9hluZMhZbA5yrjOnfB+
   v90HaMGygQ0rZJR1OMMW/CB287yEcsrvj2Q6JiJ5kjIyMW8439EjpdCLB
   ImPkf9s/5zAjzMtkmz5GKN8vUvFLz8LtUciOseuxnvbsx42LeNYBUd9On
   Y/PV1ShTzUQtR+1eQHsNXXQEIHyNe44MhC40xXNSTpDz3zAxCUYjEe+2y
   EF3qu1/pAxe0EMgRU62nzVMA7FKQS3kq+JZNki/8ZUnTYW9/FWL9D4M1E
   A==;
X-CSE-ConnectionGUID: Jx6Ix2VISKOgsmKqyJ+Y2Q==
X-CSE-MsgGUID: jmPeA053RE2nZeG/f82ONw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="78914515"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="78914515"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:31:15 -0700
X-CSE-ConnectionGUID: Kb/FtvPnTvGLFhUBj6h3PA==
X-CSE-MsgGUID: uKWD/ba7TO2QNovorQMjyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="234036814"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.237])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2026 00:31:12 -0700
Date: Fri, 8 May 2026 10:31:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <af2RPuqpuMJ1yD2M@ashevche-desk.local>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
 <af2QdVmncMtTS-Yf@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2QdVmncMtTS-Yf@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 08, 2026 at 10:27:54AM +0300, Andy Shevchenko wrote:
> On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote:
> > 
> > We have a request to support multiple devices tied together in a single evaluation
> > board. The goal is to be able to read them simultaneously via the IIO framework,
> > while also controlling them individually. Currently we have two ADC devices that
> > would benefit from this, but there might be more in the future.
> 
> > To summarize, the devices share SPI pins such as SCLK and MOSI, but have individual
> > chip-selects and MOSIs (we can consider individual SPI interfaces). The ideia
> > is to allow users to aggregate these devices so they can be read simultaneously
> > from the user space.
> 
> This paragraph contradicts itself. The they share the bus. The bus is serial
> and can't do at all what you are describing. Try to rephrase, or forget about
> this, it's simply impossible.

Ah, this is semi-shared bus... Interesting how the host controller looks like
for this? It's not a regular SPI.

-- 
With Best Regards,
Andy Shevchenko


