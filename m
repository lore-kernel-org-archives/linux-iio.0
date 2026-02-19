Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783E330DD00;
	Thu, 19 Feb 2026 20:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533491; cv=none; b=PaLTdodfnGncxjjiMHNhn3NF0oUrQ8eBs9GWryggv5Zi1Lz3kyLtfN/dUiLlniDrDutS+PFuTp3AFSB99fY6sAuRE34wKIB8E/HPjqQofqDFlmATQ/I1KQc/shc6U1XRqnBxz9PmRU8ErVzr3vX+mdWPznY/cuySvjCKGnNSx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533491; c=relaxed/simple;
	bh=IXz/3nmz6M96iroXKAaWCs4xxUDJSrq+3tEvwWKwIfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lt/NoW2i1N4RDe7l5EyUF4y/qj484c0cHTVeTIjCamTC894itAw5dDpZ5j/JARcq4xPu/u2p9lFp1gNGYorNdc8plgsOLagt+VgA0s0Hf8nftWaspI3gcS3U7pcADj3a03jmIFvJKsvlvzyVb2KCKq/CN9KRXlcV1HT+R97f27o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ar5wyWyN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ar5wyWyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771533490; x=1803069490;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IXz/3nmz6M96iroXKAaWCs4xxUDJSrq+3tEvwWKwIfo=;
  b=Ar5wyWyNCNWekILEo0Le+5uPUB/n0lNs1B77UilBA89vCp/AeXRr5oFF
   7CQjnco4QWsWm5CHY5j3/T6BqndW4D1IgY5ksLv4CdPm37LKR6N9ZGS9w
   alWD0fZmV+jxJT6M/8nWPw6Jw8rF2MFEpDWUZ38DpgmK9xpZNfenaiJAg
   1GO9ywhw8yzv0moH3Qiva9wz8UCkRlCotJxdyf1+Uml/bEfzZFxzE/MpG
   y11EMTXzfVZJTgPD17UJhIqojvJklVk1Rh7KZQDo/cGnlAzB5EJcDNUea
   vVLSkD4O5wG4hpgtMP8Yqyec5WIEpOyRezfK387tGnrLFnxdKZSdjfk6h
   g==;
X-CSE-ConnectionGUID: 7w49eQE9SVGinvH7zegYQA==
X-CSE-MsgGUID: kwq/jRjrTNixNyWwTkHb3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="72514791"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="72514791"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:38:09 -0800
X-CSE-ConnectionGUID: NBRb6EcRSvuR17ZqVjUezQ==
X-CSE-MsgGUID: +McCQqf9T/u/tQ3+VkGbIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; 
   d="scan'208";a="212519523"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.114])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 12:38:07 -0800
Date: Thu, 19 Feb 2026 22:38:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: bhargav <rougueprince47@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: frequency: ad9523: avoid multiple line
 dereferences for pdata
Message-ID: <aZd0rBy0yyiLQGvt@smile.fi.intel.com>
References: <aZa_QbwCumULvTf7@smile.fi.intel.com>
 <20260219203215.15566-1-rougueprince47@gmail.com>
 <20260219203215.15566-3-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219203215.15566-3-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 20, 2026 at 02:02:14AM +0530, bhargav wrote:
> Platform data pointer dereferences for pll1_charge_pump_current_nA
> and pll2_charge_pump_current_nA were split across multiple lines.
> Bring the dereference chains onto a single line.
> 
> This resolves the following checkpatch.pl warnings:
> WARNING: Avoid multiple line dereference - prefer 'pdata->pll1_charge_pump_current_nA'
> WARNING: Avoid multiple line dereference - prefer 'pdata->pll2_charge_pump_current_nA'

Despite being longer than 80 I think it's better now.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


