Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31D37DEBF;
	Sat, 12 Sep 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789199881; cv=none; b=UjR2V2rQ8vPWEOiFkMWI8gqO8nTsgT2w7LEM/onihS5RoMhS+GkCMnUmq6I3K0S/9TPWMYVB4vd8LyKt5/RFNw+u71Z3bKlyETM5C6AEuyzzRfQBQS39q1/oAb0sfIwHDK17Y54Ecve+xOLOD1Ez3Ps8eV+th85qJwX+0X1GxyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789199881; c=relaxed/simple;
	bh=vXC/lz8sDS7vIK7kkmOHAKB95vRwZ8MKI1dgipjQ6uY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kCNSmBw6V+voclRDN5Xh5a3hlD+2tRat/jMFoDgDuoONPuHUZZ40dHnMGFZXfDmeZF0BRsEuongK549b6/0IoSADbfvO7kzGpvp/y77NSmdYWvOIKodMag1wpkiEQfmRmpT5agi4v+OpKatVZjM4vtXhbWmyLa7VAKK+SVWgLyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ht9POEgX; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ht9POEgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789199880; x=1820735880;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vXC/lz8sDS7vIK7kkmOHAKB95vRwZ8MKI1dgipjQ6uY=;
  b=ht9POEgXKcHmKZo7I0ktgshOt0zC1r8r/afn9pimGXd/4VFLHmLX+tTy
   GSRIzXIz0brWxjub5auIjcg6MvwmdQkk+4ZH6CG0XwANen6hJGEKURYvj
   U1BUy4ulD8CfZXs8N5qXjHFb0JLNFYiYz9jqxsF7KgquG/5/gikTBKANN
   okueqA13XqqdLFB67J2JKEwQ9fQDft+IDT1848TUlc9toid6fEg1A7HOv
   QYSX4SMTctahvViCIO6IvTJpqAnOgLlu8qrYnugk2yV4FQWtX1KtrMrva
   Wix1vlAspb4NViYLiHqdyQOw2Rb42EVX0FbteRKSrYr52XhrlvuLfUExt
   w==;
X-CSE-ConnectionGUID: w6QEx3CBR3eFAVOujKjVVA==
X-CSE-MsgGUID: d63wBIUCTDia6j95pD3LBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89691825"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="89691825"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 00:57:59 -0700
X-CSE-ConnectionGUID: bR4opzlKQVmHrLrg7T0zlQ==
X-CSE-MsgGUID: wAgTxgzzQDaNadMqh9H5pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="268851514"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.230])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 00:57:54 -0700
Date: Sat, 12 Sep 2026 10:57:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	=?iso-8859-1?Q?Am=E9lie?= Delaunay <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 01/10] dmaengine: Move enum dma_slave_buswidth to a
 new header
Message-ID: <aqUF_8g-DG7GB1pM@ashevche-desk.local>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
 <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-1-72b8fd4cc78e@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 06:25:36PM +0100, Nuno Sá wrote:
> In preparation for the bitmap based bus width capabilities, move
> enum dma_slave_buswidth out of linux/dmaengine.h into a new
> include/linux/dma/engine/types.h.
> 
> linux/dmaengine.h is included nearly everywhere, so growing it with the
> new interface would make every one of its users pay for it. Keeping the
> basic types in a separate header lets the new interface live next to it
> without that cost. linux/dmaengine.h includes the new header, so its
> users are unaffected.
> 
> While at it, add the missing kernel-doc for the enum members. The block
> already opened with /**, so kernel-doc expected every member to be
> described and warned about each one of them. Describe the UNDEFINED case
> in particular, as its meaning depends on where the value is used.
> 
> No functional change intended.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


