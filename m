Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EECA3E556D;
	Mon, 17 Aug 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964153; cv=none; b=Q+XnHu8sEQevHlT/yFADKxpn8zFXI312zsuuElmb1A83Eh9VL4PN3pBb2UXZ49yJJ0t7rMJ7dOjy7bUXIVPRKFQbxq6p7w6X3mFka8DOoSJ59Hg3R2dS+RPekfBX8Aq7hY5Ssw+ET0u/rYCNob2UG5CPcgwJ2GtvpFOJysFnN/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964153; c=relaxed/simple;
	bh=pRaOwtxh//hbl86nKUVreySRx8YVynvcprNa08F38XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwjB4RnsJs/TMb+WQBaLKiT43RwDfST3bgIBklt1X/R4p01kh7ZsZHySQM1cSLBrs0K9thgNJquZgV7wXriNH5iwmypydubcmeJajv23INAZA2ySqVElhbRiFz6vP0BwpX9gfWoee2mkOBGCcim03knflSNYmuSGoJHFjh+T04Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YBJMnCyQ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YBJMnCyQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786964149; x=1818500149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pRaOwtxh//hbl86nKUVreySRx8YVynvcprNa08F38XU=;
  b=YBJMnCyQ62Y9SDhgiBPgS3qDRreUh4BoMcvD0h2cGtdZpWUkESD7DUy5
   o2GdG/qCl7mTkMKpbN5fV/RbpyrT5CgnSbL/TdLVcarE4aEazwk9YmSC1
   tXFwRh9d0QAI6zxG+NvV3Jt1SFnHnjqn864q1aYtJT6auNZtZPQ0AfMY4
   ToD9AimTWelbSahGBE7kVWQQr/kzBAJK0OBzpLz2GjwDoabNCMCOhk6/f
   jTSt6k2awUK/6dCdv/6VBUQOqhnALusQSMjB1J7WnVUWr8n1OLDyi+olI
   RoEVOzOqSBKSbDxPW+W50Dlrsdn4kwKqdAd0bgK562ZQ2jkNjnkAjw6UA
   w==;
X-CSE-ConnectionGUID: xD5v9adBQ22j6zLdkgyJ6g==
X-CSE-MsgGUID: uQwvivDbTVa4B40mkS2JHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87197206"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87197206"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 03:55:45 -0700
X-CSE-ConnectionGUID: YgYzeRA9QaS6//s5+Mi/IQ==
X-CSE-MsgGUID: CI3BSBRjS7qnGuyC9UsIUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="262261298"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 03:55:42 -0700
Date: Mon, 17 Aug 2026 13:55:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2 0/2] iio: light: vcnl4000: support shared IRQs
Message-ID: <aoLorPM301oeipKz@ashevche-desk.local>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 14, 2026 at 02:30:41PM +1000, Tsz Shan Chan wrote:
> This series contains two changes for the vcnl4000 driver.
> 
> Patch 1 makes .num_channels match .channels for vcnl4200. vcnl4040 and
> vcnl4000 channel arrays have the same size, so no functional change.
> 
> Patch 2 adds shared IRQ support. It changes the trigger type from
> falling edge to low level and adds IRQF_SHARED. The IRQ handlers return
> IRQ_NONE when the device did not generate the interrupt.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


