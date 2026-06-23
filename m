Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87453793AC;
	Tue, 23 Jun 2026 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782210467; cv=none; b=oBRU6DrKZJXsWClzFIlDSnlBORt4qky/9bVXdlz47HUIt+0VwfD7esEbZ2UucsgOv4Pvsic/hz9c4s+mKK7SPAG/LI4Low+O6SHNGZE9U21p/4zYIeo2TZO5NTrUxNgAnYl7PJ4drzHVCariztSCUQiP+7raphJtsLY5VhL3E9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782210467; c=relaxed/simple;
	bh=vHvqJcg/E2q6BP1y4YVLBpMV3jKGlMVMhSXGfLPFk3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkMUQXy1tJWNb0PZVOx84382TUFMXZLhSeGYyxkMutf2sleQBX2IH6N8XvtbLysNNc7ILRcdGO8QDwMW/iqCEF1Ab1xS/2xuMoglhivuKTNXDWRGoLDlkPhVrgjbAdIAWoBeFiYdnlCBOB11AnprRxHb8ebQ/ekhQT065ujF+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8nq5Wd4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8nq5Wd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782210466; x=1813746466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vHvqJcg/E2q6BP1y4YVLBpMV3jKGlMVMhSXGfLPFk3Y=;
  b=R8nq5Wd4S17X4cg9ZLrmc4bUEb9hnsJbVBUrwRAsWHxbl5Wmaek9KT+8
   vt5QsNeFn5QUOm7Vymc4zvTCwXDqvTZZN35zj79J6DrK1XKdKnwqWZc+r
   v5wG+S7AKCdRR9eyvffWaypIH55Fzc9eBQZ8ASrhurf+z5eLcdaZTWrui
   uHatSzyfhmzb9CpiZniNjLBfR1rPV41vtoVEGF9hlE0mS2WCmTMbqi+pd
   cINv3HR52sWS62Pu8oWJP+U6/UtF4VmAmEN20tXTq+4il/ZmucPcjfcpF
   j+wCqd6UX27l1B6TWhwIlUKgPs2rkRRfe0vUggElWpuLyFCtVMjIVJou0
   w==;
X-CSE-ConnectionGUID: OanaHJtwT0CL5svtGVRX5Q==
X-CSE-MsgGUID: S16mIpZLQfuXGveFZZ5Jkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82718592"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82718592"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:27:45 -0700
X-CSE-ConnectionGUID: UgTo6Kh4TVC4cXe7Y0krvA==
X-CSE-MsgGUID: QteRkIPSSse7ahlhOnon3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="245342363"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:27:39 -0700
Date: Tue, 23 Jun 2026 13:27:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Frank Li <Frank.li@oss.nxp.com>, nuno.sa@analog.com,
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajpfmQ6JID5rHLMF@ashevche-desk.local>
References: <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
 <ajQkupPzv8-GdEjv@nsa>
 <ajVs3jwoxq7Jhop1@SMW015318>
 <ajWSXeq6h_OjNNqh@lizhi-Precision-Tower-5810>
 <ajj8AhN1YC3uvuLb@nsa>
 <ajlMAijTUHsnOhEQ@SMW015318>
 <ajlR9QiXiBAH4mWH@nsa>
 <ajmAP2nKzi2dPEVx@SMW015318>
 <ajpYvzlHSPiJRvnX@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajpYvzlHSPiJRvnX@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 11:14:51AM +0100, Nuno Sá wrote:
> On Mon, Jun 22, 2026 at 01:34:39PM -0500, Frank Li wrote:
> > On Mon, Jun 22, 2026 at 05:09:10PM +0100, Nuno Sá wrote:
> > > On Mon, Jun 22, 2026 at 09:51:46AM -0500, Frank Li wrote:
> > > > On Mon, Jun 22, 2026 at 10:26:41AM +0100, Nuno Sá wrote:

...

> > If support 4Byte, it native supportted any N*4Byte.
> > 
> > So needn't bit mask to indicate all support bytes.
> 
> > > > each transfer, dma_slave_cfg should set specific bus width requirement.
> > > >
> > > > If memory have requirement for 32bytes, typical cache line length for
> > > > hardwaer coherence transfer, it should use dmaengine_alignment.
> > > >
> > > > So I think only need set min value should be enough if fix pcm_dmaegine.c.
> > >
> > > What fix for pcm_dmaegine.c? Not sure there's anything to be fixed in
> > > there... The code seems to use the dma bus width to match against PCM
> > > formats supported and filter only the ones we can support (per dma cap).
> > 
> > if cap is one byte, it should support 8, 16, 24, 32, 64
> > if cap is two byte, it should support 16, 32, 64
> > if cap is 4 byte,  it only support 32 and 64.
> 
> Well, Now I see your point but not exactly. Because we do have
> 
> DMA_SLAVE_BUSWIDTH_3_BYTES
> 
> and it might be used by the pcm_dmaengine code,
> 
> There are also some controllers that set it. But it looks like all that
> set it also set 1byte.

But this might be not true for all HW in the world. In previous reply I made
a comparison with MMIO accesses where not all HW that needs 1-byte read can
cope with that. If there is some proof that this is the case when 1-byte
DMA bus implies 3-bytes (or other odd number), I would like to see it.

> So your suggestion might still hold and work but I'm not too convinced
> that having the array complicates things that bad when compared with the
> risk of breaking existing code.

> > Needn't mask each bit.

-- 
With Best Regards,
Andy Shevchenko


