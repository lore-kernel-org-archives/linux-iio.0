Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43AC27F75C;
	Wed, 25 Feb 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031746; cv=none; b=tb7kQlR7KS41X6c306AZuTTbpksegY46agZmoirimOCEsRo8l5OdSQgWsAFEpPr+NwGnb9BjLhnWQLLOGAckQXEzlZuxC62SfAUWzkN84AhPSE+O46u/6szNMIK69JktVHKcV4DvA36dIGMBFPyyAD+w2+m4t6+PnJI8s93G69Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031746; c=relaxed/simple;
	bh=bGU7WOzaJaiz7SdPiWL9Gp6lEXmBIAUUO6yhvwwj3jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePJNyBt8PC4RkJwmilx+Dtzt9veBP/0zFbJI8O8dYW9wyFKjOfFHnm2q0HR1/oLZD/agoah+ZGni/7LDp8TpMMmng0KGeCsqcvkUq3gO64YWiZ2lBsTgRAGJ12WgyQYUXE2F+ex21VGvkVXYidI4idY42H4DmiN16rcd3n2T1zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sw+YefFA; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sw+YefFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772031744; x=1803567744;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bGU7WOzaJaiz7SdPiWL9Gp6lEXmBIAUUO6yhvwwj3jQ=;
  b=Sw+YefFAOsjZev0AiDCw2lEDRnp7YrQ17OLBACGRATZSuntNk2BtP9qM
   MX6YD/g1R7knJjOxp8RBGOQe2WI3/4AvlFraKvCPcYhZQ93cTayl3asU/
   z327+9kROG5yCdelNX017zFstOjBY6wPGwv/X0jseDmBnLYvJlt2T01EM
   zKKRd0nR5aquWCOkZFrEeHCI6GySAaoYfbVpNub15PhLLCczFkYFbQZGv
   HkMG7udtXmaamnXaFeT3EZpGExoDgS02XTLSX51kh/Lgx37OVxvUCIQ0v
   doycoCH2TGVL3qKhJZfOmOku/JXFJZ9GWhdKH0V7xWcIO44EFrOjIooQJ
   g==;
X-CSE-ConnectionGUID: G545/SHgT4uhgNpv4VvwwA==
X-CSE-MsgGUID: qI13GI4rREO/74u1sqXBKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73246340"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="73246340"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:02:23 -0800
X-CSE-ConnectionGUID: liPKSrnHSFmlrVLOIokt2Q==
X-CSE-MsgGUID: meGWaG4hTg2/lz5XZmdkjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="215479761"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 07:02:21 -0800
Date: Wed, 25 Feb 2026 17:02:19 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iio: adc: ad4030: fix calibscale read/write unit
 mismatch
Message-ID: <aZ8O-zFh38Woy73q@smile.fi.intel.com>
References: <20260225113102.84568-2-giorgitchankvetadze1997@gmail.com>
 <aZ7iyJ2CdNB3L6ON@debian-BULLSEYE-live-builder-AMD64>
 <CAE7dp2rOa4H5yL9qT5kJj3vF3FkNy_sv87Cma9JkgYXGQ5ERWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7dp2rOa4H5yL9qT5kJj3vF3FkNy_sv87Cma9JkgYXGQ5ERWA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 04:21:53PM +0400, Giorgi Tchankvetadze wrote:
> Hi Marcelo, Thanks for the pointer to your pending series. As for
> keeping NANO precision, the hardware register is 16-bit with a step of
> 1/0x8000 ≈ 30 µ, so NANO doesn't provide any additional precision that
> the hardware can actually represent. MICRO is sufficient.
> 
> Btw, I checked and found that no driver in the entire IIO tree uses
> NANO for calibscale.
> Drivers use either IIO_VAL_INT (raw register value) or IIO_VAL_INT_PLUS_MICRO.
> 
> That said, if your series is already adding write_raw_get_fmt(), I'm
> happy to drop this patch and let yours handle it - as long as the
> mismatch gets fixed either way.

- Please, do not top-post!
- Remove context which is unrelated to the replies.

-- 
With Best Regards,
Andy Shevchenko


