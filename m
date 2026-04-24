Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BB37881F
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 08:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017964; cv=none; b=sxkiPTCvduHQpwjcB+irRgrxUlXaYQBAAFuU3/Tbtf8R+Mk4mSqvo4mdmoY1hTOqGhuxGjAGSlOxho8cnvsLSm1S+Hu15Zjrd9xlzj8VLnFZnaXGi/0CLMT5bWDlgJ4iKoX6EaXQiziQ0YK/UlXgbDy9TE5qVFByBVfxe6wntZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017964; c=relaxed/simple;
	bh=ccpoFddfGLxKZcA9Qg/zrF3xjt023vPmVcs37ts8YrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrxklEli3Keu3e2FTHK3V+X2iGkKhZl8JV7Eii+LvAY9sSspz2zaMYp93TxmFBPtRdJBgMkhJvOKWrVjcjTiTkhg3gMqSGN/DgAPzelsmI2wcS8gjD9cj2zUcL3vkCE097vteg/BuV4sUo7dvYbewN/OOFVSocqXeKm1HNNFcUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=drxlznIJ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="drxlznIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777017960; x=1808553960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccpoFddfGLxKZcA9Qg/zrF3xjt023vPmVcs37ts8YrY=;
  b=drxlznIJFvTSLYKnG4kVXToN0Zxh7Y+IYD04XxoVFXWocqryNnuTi5dQ
   QHYwTNdw42wxyuW63Q0Ml5xQnA+uwZN5we7giJw+sOWZsa2c4YuAx2F//
   t4jGcx9DuyRYhtG90OU/wf4LHD9O/O733xoAINezri0h2hkypRsmgrPH1
   JumEaySXPY8vRECat3QbeSKlrrskmohnAlq0dk8cFXx/OLcpIQvCZRJxt
   C+CrUBNlpdJDV+qRqBabRQNrSgad1IrxJifi89YpDZ4m42uPBk2Rc0FTZ
   au5ysaHejgzP+p13M/90nMvkd3AAd+zayqW1zE4jo8R/m09v+xUdMnPZm
   g==;
X-CSE-ConnectionGUID: SsaW0C6eRnan0dLKfSvHBw==
X-CSE-MsgGUID: RXhn+k0gRuOjNbb/qrkECg==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81601306"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="81601306"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:05:54 -0700
X-CSE-ConnectionGUID: VFF2zbzHRIWXsN/b6qe33Q==
X-CSE-MsgGUID: Zfzy6XrcTmGZfr2PHHDZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="233198093"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 01:05:51 -0700
Date: Fri, 24 Apr 2026 11:05:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com, Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: mcp320x: refactor driver to use
 bitfield API
Message-ID: <aeskXSpBCIvWghPu@ashevche-desk.local>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
 <20260422222553.67660-3-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422222553.67660-3-gustavo.pagnotta@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 07:14:13PM -0300, Gustavo Pagnotta Faria wrote:
> Update the mcp320x driver to use the standard Linux
> bitfield API (<linux/bitfield.h>) instead of manual
> bitwise shifts and masks.

> This replaces the hardcoded shift operations in the TX
> data preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
> and replaces the manual masking in the RX data extraction
> (mcp320x_adc_conversion) with FIELD_GET(). Explicit masks using
> GENMASK() and BIT() were also introduced for both transmit
> configurations and receive extractions.

I believe somebody told to you (or to the similar patch *) that this paragraph
is an unneeded detail.

*) I'm already too much lost in the flood of the patches to IIO this spring...
I dunno what's going on, but from last few days when seeing something that does
ring a bell, I suggest contributors to start actually reviewing others' patches
in the mailing list for this (IIO) subsystem and read other reviews to learn
from them. It will save a lot of time for everybody.

...

> +	case mcp3301: {
> +		u16 rx_val = get_unaligned_be16(adc->rx_buf);

This is used in all cases (or almost all), can you make this assignment and
conversion be done outside switch-case?

> +		u16 raw = FIELD_GET(MCP3301_DATA_MASK, rx_val);
> +
> +		*val = sign_extend32(raw, 12);
>  		return 0;
> +		}

-- 
With Best Regards,
Andy Shevchenko


