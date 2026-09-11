Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14BE361DB8;
	Fri, 11 Sep 2026 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142817; cv=none; b=Lzc//4pE51/HwgvPMqy0KdrRAnhJuML1bjS9izh73sv98ZPC3NbQ6DqfNHOxUKaavRvydpKgLAtHnrV2Onbgm8XbApEGEbsIsyCXJ1Vjmek/o24fpkVax0QE8UwXk92o19kHrIGzgXp5/YtzRoCnu/YDlv1BZUdnQvoEjwzyPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142817; c=relaxed/simple;
	bh=4bQugtR3/IuUOZUfBGt3l7BWYRUU3qkM5jZ+MMD++Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKavlm1smT/E+xokq9RqZqKlY7ZQ/WmBCX04GEnaGqoQVsJsF+ZxSUGveIp9OpcTsCnmuEecGm9xKMX/HS1GqwswpJlL1XA/kyaaariPRlmdru+TZbIxPnwi6OHjOJc4gL53NtvFrnKcrFmoS7iSsw4aoftEA2I7IY9QD4BN/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3JHth/i; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3JHth/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789142815; x=1820678815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4bQugtR3/IuUOZUfBGt3l7BWYRUU3qkM5jZ+MMD++Y0=;
  b=l3JHth/iblYdb2OmOk8HpLPY91VVrkXdAVNk2MHxEgGHd/0rCr5RIo/b
   bLvusOItL3tQSq5rNxNikNJS1ESd/4yFdbahn+1qbaVwcLq0Wh5dPejnr
   +SVR1IKTz6/FVoTEYKgKrGdbonVs2uwo6r96Wr9lIjpraeOvTqFYKSHqf
   2AXJ+A6Xc1HIwSdOi1vqtVS/JetB4PGaeV1Xhm31hC8O6cLdWP4A7o8N1
   ktZB0hxdMRallTR82m07jIsMwHeku07HHiJKfx7VYjKEFw0YVEWawgbbb
   000c6Z8jff062/94BFXHxxlcRef36YDjvORbVidczdW8XXgMfuCVJtmAI
   Q==;
X-CSE-ConnectionGUID: lxqTkS+rRQqWoE43V1GweQ==
X-CSE-MsgGUID: JWhiYTWCQPiC9ormUX9o6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89540971"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89540971"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:06:55 -0700
X-CSE-ConnectionGUID: aPAYlHAVRV64t21YPzr70w==
X-CSE-MsgGUID: KT3R59AVSaC+yCckLANsxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="268280469"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:06:49 -0700
Date: Fri, 11 Sep 2026 19:06:47 +0300
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
Subject: Re: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <aqQnF9-Qtc-ZJJWa@ashevche-desk.local>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
 <apWFa4BFoAL2AhG3@ashevche-desk.local>
 <apWjMBvGA6yo_nCZ@nsa>
 <aqQaUx5Ok8uesHu5@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqQaUx5Ok8uesHu5@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 04:14:20PM +0100, Nuno Sá wrote:
> On Mon, Aug 31, 2026 at 04:56:18PM +0100, Nuno Sá wrote:
> > On Mon, Aug 31, 2026 at 04:45:15PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:

...

> > > > +/*
> > > > + * Basic types shared by the DMA engine interfaces.
> > > > + */
> > > > +#ifndef LINUX_DMA_ENGINE_TYPES_H
> > > > +#define LINUX_DMA_ENGINE_TYPES_H
> > > > +
> > > > +#include <linux/bitops.h>
> > > 
> > > Not yet? Perhaps next changes will use it, then they can add it.
> > 
> > Should be dropped!
> 
> In fact, I'll keep the above! DECLARE_BITMAP() needs BITS_TO_LONGS().

I'm not sure I follow.

The DECLARE_BITMAP() comes from types.h. It's the problem of types.h to include
bitops.h for BITS_TO_LONGS() if required.

> Yeah, not great...

-- 
With Best Regards,
Andy Shevchenko


