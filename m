Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1819D25B0AB;
	Mon, 24 Aug 2026 08:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787559708; cv=none; b=bhn0oH8vDf7e6Yh8KAE1XQrYF7vLCuNL+vz6LnoghcT+jgFBDj8zaHxvCbjmtDb3pWFEQC0D0naX3jgjR47MHqX3kVJS8fiT/ib0iGjIarE67g7SdYrofaC0qZzrcm7A8UVpWwbJ+xsXorRxtLBR6/sNB2U8uutU2sDafJbQgmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787559708; c=relaxed/simple;
	bh=W9uC+BhGExm8dFaDifeqaFlddL2qK+tpEVo8bgE2jkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC8zgcg/tFFZmFq9FLi+In7Lk/wednd/A+v2SCxXSmimbV01i1XRmHEinWlsn3TFWrw9BCxOYJByhtIvfytNmfG31S1NebW4uBtK0zgOTnOT1VgZZiwSuxU3+v/lvUdEMY8X/BkpAG5byEA7h5ONO7iPr2cTDV2X654nEHXcom8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zzb2xxNR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zzb2xxNR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787559706; x=1819095706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9uC+BhGExm8dFaDifeqaFlddL2qK+tpEVo8bgE2jkE=;
  b=Zzb2xxNRGG0s1mkwz/bW2/VsiqC1296hMqJrUG0Lk9HBFJct/AstC1Xx
   a8ETNVvCs6xu9QCrnpIFdZTJki2CIdXjMdQkOChINrvnOqOFp0MuoDhRu
   e5YWQ2BXv15AYh0xsGUjQ3SrOQpolmlc8+VBojCWtrXHW8H/PP8hgNRlp
   yx1n8S/sj2UwfK1nMYJro5VxNEn3dEtORYrLfSEo/fuCd5pYEm1J0xvB6
   fC/QntKybNFK3vWvmZNRv725tJDUHnoOSihH0exIYZyHGF6wAIq+vvyc9
   eaW/jqZPTlkz7xsv2Qsyu2K62e6f2x65npJDXIkQSgNE9iNYObEfeuCYV
   w==;
X-CSE-ConnectionGUID: xfJxprWRTse5jSiAIBOFoA==
X-CSE-MsgGUID: RfET+2qrRmmHx+HE/NPrsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="87769825"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="87769825"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:21:45 -0700
X-CSE-ConnectionGUID: CXL8CaiOQ3WO1iEeAXht0w==
X-CSE-MsgGUID: c9hPF+R0RuaSQi/nTm5rzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264320203"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:21:42 -0700
Date: Mon, 24 Aug 2026 11:21:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Message-ID: <aov_FNNX2-TWheQc@ashevche-desk.local>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
 <8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
 <aoK4FXvkPT45RsIV@ashevche-desk.local>
 <20260822032014.3d4607dd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822032014.3d4607dd@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 22, 2026 at 03:20:14AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Aug 2026 10:28:21 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Aug 13, 2026 at 08:05:07PM -0300, Marcelo Schmitt wrote:
> > > LTC2338-18 is similar to LTC2378-18, differentiating from the already
> > > supported part mainly on the embedment of an internal voltage reference and
> > > addition of a resistor divider network connected to the input signal path.
> > > Extend the device driver, handling the internal reference and input signal
> > > attenuation, enabling it to also support LTC2338-18.  
> > 
> > LGTM now,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Ah. I applied the earlier version fixing up at least comments it seems.
> (Not that I've completely forgotten doing so!)
> 
> Can you please check if there is anything different we can handle
> as a follow on patch?

Hmm... Are you asking me doing this? I would delegate this to Marcelo.
If we forget something, I don't think it would be a big deal. I just have
almost no time for this.

-- 
With Best Regards,
Andy Shevchenko


